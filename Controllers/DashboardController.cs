using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using BISP_hrmsDashboard.Models;

namespace BISP_hrmsDashboard.Controllers
{
    // =====================================================================
    // DashboardController
    // Purpose:
    //  - Yeh controller HRMS Dashboard ko data provide karta hai.
    //  - Employee aur Position related summary counts (Total, Active, Inactive etc.)
    //    database se nikal kar DashboardVM model me inject karta hai.
    //
    // Linked with:
    //  - Model: DashboardVM.cs
    //  - View:  Dashboard.cshtml
    // =====================================================================
    public class DashboardController : Controller
    {
        private readonly IConfiguration _config; // DB connection string ke liye config injection
        public DashboardController(IConfiguration config) => _config = config;

        // -----------------------------------------------------------------
        // GET: /Dashboard/Index
        // Is action se Dashboard page render hota hai
        // Process:
        //  1. DashboardVM banaya jata hai
        //  2. DB se employees aur positions ka summary data fetch hota hai
        //  3. Ye data DashboardVM me assign hota hai
        //  4. Finally "Dashboard.cshtml" view ko return karta hai
        // -----------------------------------------------------------------
        public IActionResult Index()
        {
            var vm = new DashboardVM(); // ViewModel to pass data to view

            string cs = _config.GetConnectionString("DefaultConnection")!;
            using var con = new SqlConnection(cs);
            con.Open();

            // --------------------------------------------------------------
            // Employee Statistics
            // Query: tbl_employee se counts
            // - Total Employees
            // - Active Employees (STATUS = 1)
            // - Inactive Employees (STATUS = 2)
            // --------------------------------------------------------------
            using (var cmd = new SqlCommand(@"
                SELECT 
                  COUNT(*) Total,
                  SUM(CASE WHEN STATUS=1 THEN 1 ELSE 0 END) Active,
                  SUM(CASE WHEN STATUS=2 THEN 1 ELSE 0 END) Inactive
                FROM dbo.tbl_employee;", con))
            using (var r = cmd.ExecuteReader())
            {
                if (r.Read())
                {
                    vm.EmpTotal = r.GetInt32(0);                // Total employees
                    vm.EmpActive = r.IsDBNull(1) ? 0 : r.GetInt32(1);   // Active employees
                    vm.EmpInactive = r.IsDBNull(2) ? 0 : r.GetInt32(2); // Inactive employees
                }
            }

            // --------------------------------------------------------------
            // Position Statistics
            // Query: tbl_position se counts
            // - Total Positions
            // - Filled Positions (EMPLOYEE_ID NOT NULL)
            // - Vacant Positions (EMPLOYEE_ID NULL)
            // --------------------------------------------------------------
            using (var cmd = new SqlCommand(@"
                SELECT 
                  COUNT(*) Total,
                  SUM(CASE WHEN EMPLOYEE_ID IS NOT NULL THEN 1 ELSE 0 END) Filled,
                  SUM(CASE WHEN EMPLOYEE_ID IS NULL THEN 1 ELSE 0 END) Vacant
                FROM dbo.tbl_position;", con))
            using (var r = cmd.ExecuteReader())
            {
                if (r.Read())
                {
                    vm.PosTotal = r.GetInt32(0);   // Total posts
                    vm.PosFilled = r.GetInt32(1);  // Filled posts
                    vm.PosVacant = r.GetInt32(2);  // Vacant posts
                }
            }

            // --------------------------------------------------------------
            // View return
            // "Dashboard.cshtml" ko render karega aur saath me DashboardVM bhejega
            // --------------------------------------------------------------
            return View("Dashboard", vm);
        }
    }
}