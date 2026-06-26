using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;                  // SQL client for database connections
using Microsoft.Extensions.Configuration;        // For reading app settings (connection string)
using Microsoft.AspNetCore.Http;                 // For Session handling
using System.Linq;
using BISP_hrmsDashboard.Models;                 // LoginViewModel (used in Login POST)

// =======================================================================
// AuthenticationController
// Handles Login + Logout functionality for HRMS Dashboard
// Linked with: LoginViewModel (Model) and Login.cshtml (View)
// =======================================================================
namespace BISP_hrmsDashboard.Controllers
{
    public class AuthenticationController : Controller
    {
        private readonly IConfiguration _config; // Used for DB connection string
        public AuthenticationController(IConfiguration config) => _config = config;

        // -------------------------------------------------------------------
        // Helper: Get client IP address (proxy/load-balancer safe)
        // Used for IP-based login restrictions
        // -------------------------------------------------------------------
        private string GetClientIp()
        {
            var xff = HttpContext.Request.Headers["X-Forwarded-For"].FirstOrDefault(); // proxy IP
            if (!string.IsNullOrWhiteSpace(xff))
            {
                var first = xff.Split(',')[0].Trim();
                if (!string.IsNullOrWhiteSpace(first)) return first;
            }

            var ip = HttpContext.Connection.RemoteIpAddress; // direct client IP
            if (ip != null)
            {
                var v4 = ip.MapToIPv4().ToString();
                if (v4 != "0.0.0.0") return v4;
            }
            return "127.0.0.1"; // fallback localhost
        }

        // -------------------------------------------------------------------
        // GET: Login Page
        // Simply returns Login.cshtml view
        // ViewBag.HideNav -> hides navigation bar in login page
        // -------------------------------------------------------------------
        [HttpGet]
        public IActionResult Login()
        {
            ViewBag.HideNav = true;
            ViewBag.ClientIp = GetClientIp(); // show client IP on UI (footer)
            ViewBag.AllowedIp = null;         // db ip initially empty
            return View();
        }

        // -------------------------------------------------------------------
        // POST: Login Form Submission
        // Validates CNIC + Password + IP + Status
        // If success -> redirect to Home/Index with Session saved
        // If fail -> return back to Login view with error message
        // -------------------------------------------------------------------
        [HttpPost]
        [ValidateAntiForgeryToken] // CSRF protection
        public IActionResult Login(LoginViewModel model)
        {
            var clientIp = GetClientIp();
            ViewBag.ClientIp = clientIp;
            ViewBag.AllowedIp = null;

            // If model validation fails -> back to login
            if (!ModelState.IsValid)
                return View(model);

            try
            {
                // Open SQL connection
                var cs = _config.GetConnectionString("DefaultConnection");
                using var con = new SqlConnection(cs);
                con.Open();

                // Step 1: Fetch Allowed IP (even if wrong password entered)
                string? dbIp = null;
                const string sqlIp = "SELECT TOP 1 allowed_ip FROM dbo.[login] WHERE cnic=@c;";
                using (var cmdIp = new SqlCommand(sqlIp, con))
                {
                    cmdIp.Parameters.AddWithValue("@c", model.CNIC);
                    var ipObj = cmdIp.ExecuteScalar();
                    if (ipObj != null && ipObj != DBNull.Value) dbIp = ipObj.ToString();
                }
                ViewBag.AllowedIp = dbIp; // show DB IP on UI footer

                // Step 2: Validate CNIC + Password
                const string sql = @"
                    SELECT TOP 1 id, username, allowed_ip, [status]
                    FROM dbo.[login]
                    WHERE cnic=@c AND [password]=@p;";

                using var cmd = new SqlCommand(sql, con);
                cmd.Parameters.AddWithValue("@c", model.CNIC);
                cmd.Parameters.AddWithValue("@p", model.Password);

                using var r = cmd.ExecuteReader();
                if (!r.Read())
                {
                    // Wrong CNIC or Password
                    ModelState.AddModelError(string.Empty, "Invalid CNIC or Password.");
                    ViewBag.HideNav = true;
                    return View(model);
                }

                // Extract data from login table
                var username = r.IsDBNull(1) ? model.CNIC : r.GetString(1); // fallback CNIC if username empty
                var allowedIp = r.IsDBNull(2) ? "" : r.GetString(2);
                var isActive = r.GetBoolean(3); // status column: active/inactive

                // Show Allowed IP in footer (priority: dbIp > login record)
                ViewBag.AllowedIp = string.IsNullOrWhiteSpace(dbIp) ? allowedIp : dbIp;

                // Check if account is active
                if (!isActive)
                {
                    ModelState.AddModelError(string.Empty, "Account inactive.");
                    return View(model);
                }

                // Check IP restriction
                if (string.IsNullOrWhiteSpace(allowedIp) ||
                    !string.Equals(allowedIp, clientIp, System.StringComparison.OrdinalIgnoreCase))
                {
                    ModelState.AddModelError(string.Empty, "IP not allowed.");
                    return View(model);
                }

                // ------------------------------
                // SUCCESS: Save CNIC + Username in Session
                // Session values are later used in:
                // - Employee insert/update logs
                // - Position History audit
                // ------------------------------
                HttpContext.Session.SetString("CNIC", model.CNIC);
                HttpContext.Session.SetString("USERNAME", username);

                // TempData for showing "Welcome <username>" message
                TempData["Welcome"] = username;

                // Redirect user to Home/Index (main landing page after login)
                return RedirectToAction("Index", "Home");
            }
            catch
            {
                // If DB connection or query fails
                ModelState.AddModelError(string.Empty, "Login failed. Please try again.");
                return View(model);
            }
        }

        // -------------------------------------------------------------------
        // GET: Logout
        // Clears session + tempdata and redirects back to Login
        // -------------------------------------------------------------------
        [HttpGet]
        public IActionResult Logout()
        {
            HttpContext.Session.Clear();    // clear session values (CNIC, USERNAME etc.)
            TempData.Clear();               // clear temporary data
            return RedirectToAction("Login");
        }
    }
}