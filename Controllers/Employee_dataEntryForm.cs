using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using Microsoft.Extensions.Configuration;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.AspNetCore.Http;            // <- for HttpContext.Session
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.RegularExpressions;       // regex

namespace YourNamespace.Controllers
{
    public class Employee_dataEntryFormController : Controller
    {
        private readonly IConfiguration _config;
        public Employee_dataEntryFormController(IConfiguration config) => _config = config;

        // ========== GET ==========
        [HttpGet]
        [ResponseCache(NoStore = true, Location = ResponseCacheLocation.None)]
        public IActionResult Employee_DEF()
        {
            ViewBag.NextEmployeeId = GetNextId();
            ViewBag.Genders = GetGenders();
            ViewBag.MaritalStatuses = GetMaritalStatuses();
            ViewBag.Religions = GetReligions();
            ViewBag.Provinces = GetProvinces();
            ViewBag.Scales = GetScales();
            ViewBag.Designations = GetDesignations();
            ViewBag.Statuses = GetStatuses();
            ViewBag.ParentOffices = GetParentOffices();
            ViewBag.Educations = GetEducations();          // <-- NEW

            if (TempData.ContainsKey("Message"))
            {
                ViewBag.Message = TempData["Message"];
                TempData.Remove("Message");
            }
            return View();
        }

        // ========== POST ==========
        [HttpPost]
        public IActionResult Employee_DEF(
            // Core
            string CNIC,
            string? NAME,
            string? FATHER_NAME,
            int? GENDER,
            DateTime? DOB,
            int? MARITAL_STATUS,
            int? CHILDREN,
            int? RELIGION,
            int? RELIGION_CAST,
            // Scale/Designation
            int? SCALE,
            int? DESIGNATION,
            // NEW: Education (FK to lib_education)
            int? EDUCATION,
            // Status + Parent office
            int? STATUS,
            int? PARENT_OFFICE,
            // Location (codes + addresses)
            int? DOMICILE_PROVINCE, int? DOMICILE_DISTRICT,
            int? C_PROVINCE, int? C_DISTRICT, int? C_TEHSIL, string? C_ADDRESS,
            int? P_PROVINCE, int? P_DISTRICT, int? P_TEHSIL, string? P_ADDRESS,
            // Dates
            DateTime? JOINING_DATE,
            DateTime? CONTRACT_EXPIRY_DATE,
            DateTime? RENEWAL_DATE,
            DateTime? REPORT_DATE,
            // Extension & Contract Duration
            DateTime? EXT_UPTO_DATE,
            string? CONTRACT_DURATION,
            // Contact
            string? MOBILE,
            string? LANDLINE,
            // Email + Payroll
            string? EMAIL,
            string? PAYROLL_ID,
            // Ref file & remarks
            string? REF_FILE_NO,
            string? REMARKS
        )
        {
            // ---- Validations (same as before) ----
            if (string.IsNullOrWhiteSpace(CNIC)) return Fail("CNIC is required.");
            CNIC = CNIC.Trim();
            if (CNIC.Length != 13 || !CNIC.All(char.IsDigit)) return Fail("CNIC must be exactly 13 digits.");
            if (CNIC[3] != '0') return Fail("4th digit must be 0.");
            if (ExistsCnic(CNIC)) return Fail("This CNIC already exists.");

            if (string.IsNullOrWhiteSpace(NAME)) return Fail("Name is required.");
            NAME = NAME.Trim();
            if (!Regex.IsMatch(NAME, @"^[A-Za-z ]+$")) return Fail("Name: only letters and spaces are allowed.");

            if (string.IsNullOrWhiteSpace(FATHER_NAME)) return Fail("Father Name is required.");
            FATHER_NAME = FATHER_NAME.Trim();
            if (!Regex.IsMatch(FATHER_NAME, @"^[A-Za-z ]+$")) return Fail("Father Name: only letters and spaces are allowed.");

            if (GENDER is null || !GenderExists(GENDER.Value)) return Fail("Please select a valid gender.");

            if (!DOB.HasValue) ModelState.AddModelError("DOB", "Date of Birth is required.");
            else if (DOB.Value.Date >= DateTime.Today) ModelState.AddModelError("DOB", "Date of Birth must be a past date.");

            if (MARITAL_STATUS == null || MARITAL_STATUS == 0) ModelState.AddModelError("MARITAL_STATUS", "Please select a Marital Status.");

            if (CHILDREN == null) ModelState.AddModelError("CHILDREN", "Number of children is required.");
            else if (CHILDREN < 0 || CHILDREN > 5) ModelState.AddModelError("CHILDREN", "Children must be between 0 and 5.");

            if (RELIGION is null || !ReligionExists(RELIGION.Value)) return Fail("Please select a valid religion.");
            if (RELIGION_CAST is null || !CastExistsForReligion(RELIGION_CAST.Value, RELIGION.Value)) return Fail("Please select a valid religion cast for the selected religion.");

            if (SCALE is null || !ScaleExists(SCALE.Value)) return Fail("Please select a valid SPS Scale (SPS-1 to SPS-22).");
            if (DESIGNATION is null || !DesignationExists(DESIGNATION.Value)) return Fail("Please select a valid Designation.");

            if (EDUCATION is null || !EducationExists(EDUCATION.Value)) return Fail("Please select a valid Education.");

            if (STATUS is null || !StatusExists(STATUS.Value)) return Fail("Please select a valid Status.");
            if (PARENT_OFFICE is null || !ParentOfficeExists(PARENT_OFFICE.Value)) return Fail("Please select a valid Parent Office.");

            if (DOMICILE_PROVINCE is null) return Fail("Select Domicile Province.");
            if (DOMICILE_DISTRICT is null || !DistrictBelongsToProvinceCode(DOMICILE_DISTRICT.Value, DOMICILE_PROVINCE.Value))
                return Fail("Select a valid Domicile District for selected province.");

            if (C_PROVINCE is null) return Fail("Select Current Province.");
            if (C_DISTRICT is null || !DistrictBelongsToProvinceCode(C_DISTRICT.Value, C_PROVINCE.Value))
                return Fail("Select a valid Current District for selected province.");
            if (C_TEHSIL is null || !TehsilBelongsToDistrictCode(C_TEHSIL.Value, C_DISTRICT.Value))
                return Fail("Select a valid Current Tehsil for selected district.");

            if (P_PROVINCE is null) return Fail("Select Permanent Province.");
            if (P_DISTRICT is null || !DistrictBelongsToProvinceCode(P_DISTRICT.Value, P_PROVINCE.Value))
                return Fail("Select a valid Permanent District for selected province.");
            if (P_TEHSIL is null || !TehsilBelongsToDistrictCode(P_TEHSIL.Value, P_DISTRICT.Value))
                return Fail("Select a valid Permanent Tehsil for selected district.");

            if (JOINING_DATE.HasValue && JOINING_DATE.Value.Date > DateTime.Today) return Fail("Joining date cannot be in the future.");
            if (JOINING_DATE.HasValue && CONTRACT_EXPIRY_DATE.HasValue && CONTRACT_EXPIRY_DATE.Value.Date < JOINING_DATE.Value.Date)
                return Fail("Contract expiry date must be on/after joining date.");
            if (JOINING_DATE.HasValue && RENEWAL_DATE.HasValue && RENEWAL_DATE.Value.Date < JOINING_DATE.Value.Date)
                return Fail("Renewal date should be on/after joining date.");
            if (JOINING_DATE.HasValue && REPORT_DATE.HasValue && REPORT_DATE.Value.Date < JOINING_DATE.Value.Date)
                return Fail("Report date should be on/after joining date.");

            if (EXT_UPTO_DATE.HasValue)
            {
                var ext = EXT_UPTO_DATE.Value.Date;
                if (JOINING_DATE.HasValue && ext < JOINING_DATE.Value.Date) return Fail("Extension Upto Date should be on/after Joining Date.");
                if (REPORT_DATE.HasValue && ext < REPORT_DATE.Value.Date) return Fail("Extension Upto Date should be on/after Report Date.");
            }

            if (!string.IsNullOrWhiteSpace(CONTRACT_DURATION))
            {
                CONTRACT_DURATION = CONTRACT_DURATION.Trim();
                if (CONTRACT_DURATION.Length > 20) return Fail("Contract Duration must be ≤ 20 characters.");
                if (!Regex.IsMatch(CONTRACT_DURATION, @"^[A-Za-z0-9 .\/-]{1,20}$"))
                    return Fail("Contract Duration: only letters, digits, space, '-', '/', '.' (max 20).");
            }
            else CONTRACT_DURATION = null;

            if (string.IsNullOrWhiteSpace(MOBILE)) return Fail("Please enter Mobile Number.");
            var digits = new string(MOBILE.Where(char.IsDigit).ToArray());
            if (!System.Text.RegularExpressions.Regex.IsMatch(digits, @"^03\d{9}$"))
                return Fail("Mobile must start with 03 and be 11 digits (e.g., 03001234567).");
            MOBILE = digits;

            if (!string.IsNullOrWhiteSpace(LANDLINE))
            {
                var okLL = Regex.IsMatch(LANDLINE, @"^[0-9()+\- ]{1,20}$");
                if (!okLL) return Fail("Landline: only digits, +, -, space and () allowed (max 20).");
            }
            else LANDLINE = null;

            if (!string.IsNullOrWhiteSpace(EMAIL))
            {
                EMAIL = EMAIL.Trim().ToLowerInvariant();
                if (EMAIL.Length > 254) return Fail("Email must be ≤ 254 characters.");
                if (EMAIL.StartsWith(".") || EMAIL.EndsWith(".") || EMAIL.Contains(" ")) return Fail("Email format is invalid.");
                if (EMAIL.Count(c => c == '@') != 1) return Fail("Email must contain a single '@'.");
                if (EMAIL.Contains("..")) return Fail("Email cannot contain consecutive dots.");
                var emailRe = new Regex(@"^[A-Za-z0-9._%+\-]+@[A-Za-z0-9\-]+(?:\.[A-Za-z0-9\-]+)*\.[A-Za-z]{2,63}$");
                if (!emailRe.IsMatch(EMAIL)) return Fail("Please enter a valid email address.");
            }
            else EMAIL = null;

            if (!string.IsNullOrWhiteSpace(PAYROLL_ID))
            {
                PAYROLL_ID = PAYROLL_ID.Trim();
                if (PAYROLL_ID.Length > 100) return Fail("Payroll ID must be ≤ 100 characters.");
                var payrollRe = new Regex(@"^[A-Za-z0-9][A-Za-z0-9._/\- ]{0,99}$");
                if (!payrollRe.IsMatch(PAYROLL_ID))
                    return Fail("Payroll ID can contain letters, digits, space, '-', '_', '/', '.' and must start with a letter/digit.");
            }
            else PAYROLL_ID = null;

            if (!string.IsNullOrWhiteSpace(REF_FILE_NO))
            {
                REF_FILE_NO = REF_FILE_NO.Trim();
                if (REF_FILE_NO.Length > 100) return Fail("Ref File No must be ≤ 100 characters.");
            }
            else REF_FILE_NO = null;

            if (!string.IsNullOrWhiteSpace(REMARKS))
            {
                REMARKS = REMARKS.Trim();
                if (REMARKS.Length > 200) return Fail("Remarks must be ≤ 200 characters.");
            }
            else REMARKS = null;

            // ---- INSERT + HISTORY (transaction) ----
            string cs = _config.GetConnectionString("DefaultConnection")!;
            using (var con = new SqlConnection(cs))
            {
                con.Open();
                using (var tran = con.BeginTransaction())
                {
                    try
                    {
                        // 1) Insert employee
                        var insertSql = @"
INSERT INTO dbo.tbl_employee
  (CNIC, NAME, FATHER_NAME, GENDER, DOB, MARITAL_STATUS, CHILDREN, RELIGION, RELIGION_CAST,
   SCALE, DESIGNATION, EDUCATION,
   STATUS, PARENT_OFFICE,
   DOMICILE_PROVINCE, DOMICILE_DISTRICT,
   C_PROVINCE, C_DISTRICT, C_TEHSIL, C_ADDRESS,
   P_PROVINCE, P_DISTRICT, P_TEHSIL, P_ADDRESS,
   JOINING_DATE, CONTRACT_EXPIRY_DATE, RENEWAL_DATE, REPORT_DATE,
   EXT_UPTO_DATE, [CONTRACT_DURATION],
   MOBILE, LANDLINE,
   EMAIL, PAYROLL_ID,
   REF_FILE_NO, REMARKS,
   IDATE)
OUTPUT INSERTED.EMPLOYEE_ID
VALUES
  (@CNIC, @NAME, @FATHER_NAME, @GENDER, @DOB, @MARITAL_STATUS, @CHILDREN, @RELIGION, @RELIGION_CAST,
   @SCALE, @DESIGNATION, @EDUCATION,
   @STATUS, @PARENT_OFFICE,
   @DOM_PROV, @DOM_DIST,
   @C_PROV, @C_DIST, @C_TEH, @C_ADDR,
   @P_PROV, @P_DIST, @P_TEH, @P_ADDR,
   @JOINING_DATE, @CONTRACT_EXPIRY_DATE, @RENEWAL_DATE, @REPORT_DATE,
   @EXT_UPTO_DATE, @CONTRACT_DURATION,
   @MOBILE, @LANDLINE,
   @EMAIL, @PAYROLL_ID,
   @REF_FILE_NO, @REMARKS,
   CONVERT(date, GETDATE()));";

                        using var cmd = new SqlCommand(insertSql, con, tran);
                        cmd.Parameters.AddWithValue("@CNIC", CNIC);
                        cmd.Parameters.AddWithValue("@NAME", (object?)NAME ?? DBNull.Value);
                        cmd.Parameters.AddWithValue("@FATHER_NAME", (object?)FATHER_NAME ?? DBNull.Value);
                        cmd.Parameters.AddWithValue("@GENDER", (object?)GENDER ?? DBNull.Value);
                        cmd.Parameters.AddWithValue("@DOB", DOB.HasValue ? DOB.Value.Date : (object)DBNull.Value);
                        cmd.Parameters.AddWithValue("@MARITAL_STATUS", (object?)MARITAL_STATUS ?? DBNull.Value);
                        cmd.Parameters.AddWithValue("@CHILDREN", (object?)CHILDREN ?? DBNull.Value);
                        cmd.Parameters.AddWithValue("@RELIGION", (object?)RELIGION ?? DBNull.Value);
                        cmd.Parameters.AddWithValue("@RELIGION_CAST", (object?)RELIGION_CAST ?? DBNull.Value);

                        cmd.Parameters.AddWithValue("@SCALE", (object?)SCALE ?? DBNull.Value);
                        cmd.Parameters.AddWithValue("@DESIGNATION", (object?)DESIGNATION ?? DBNull.Value);
                        cmd.Parameters.AddWithValue("@EDUCATION", (object?)EDUCATION ?? DBNull.Value);

                        cmd.Parameters.AddWithValue("@STATUS", (object?)STATUS ?? DBNull.Value);
                        cmd.Parameters.AddWithValue("@PARENT_OFFICE", (object?)PARENT_OFFICE ?? DBNull.Value);

                        cmd.Parameters.AddWithValue("@DOM_PROV", (object?)DOMICILE_PROVINCE ?? DBNull.Value);
                        cmd.Parameters.AddWithValue("@DOM_DIST", (object?)DOMICILE_DISTRICT ?? DBNull.Value);

                        cmd.Parameters.AddWithValue("@C_PROV", (object?)C_PROVINCE ?? DBNull.Value);
                        cmd.Parameters.AddWithValue("@C_DIST", (object?)C_DISTRICT ?? DBNull.Value);
                        cmd.Parameters.AddWithValue("@C_TEH", (object?)C_TEHSIL ?? DBNull.Value);
                        cmd.Parameters.AddWithValue("@C_ADDR", string.IsNullOrWhiteSpace(C_ADDRESS) ? (object)DBNull.Value : C_ADDRESS.Trim());

                        cmd.Parameters.AddWithValue("@P_PROV", (object?)P_PROVINCE ?? DBNull.Value);
                        cmd.Parameters.AddWithValue("@P_DIST", (object?)P_DISTRICT ?? DBNull.Value);
                        cmd.Parameters.AddWithValue("@P_TEH", (object?)P_TEHSIL ?? DBNull.Value);
                        cmd.Parameters.AddWithValue("@P_ADDR", string.IsNullOrWhiteSpace(P_ADDRESS) ? (object)DBNull.Value : P_ADDRESS.Trim());

                        cmd.Parameters.AddWithValue("@JOINING_DATE", JOINING_DATE.HasValue ? JOINING_DATE.Value.Date : (object)DBNull.Value);
                        cmd.Parameters.AddWithValue("@CONTRACT_EXPIRY_DATE", CONTRACT_EXPIRY_DATE.HasValue ? CONTRACT_EXPIRY_DATE.Value.Date : (object)DBNull.Value);
                        cmd.Parameters.AddWithValue("@RENEWAL_DATE", RENEWAL_DATE.HasValue ? RENEWAL_DATE.Value.Date : (object)DBNull.Value);
                        cmd.Parameters.AddWithValue("@REPORT_DATE", REPORT_DATE.HasValue ? REPORT_DATE.Value.Date : (object)DBNull.Value);

                        cmd.Parameters.AddWithValue("@EXT_UPTO_DATE", EXT_UPTO_DATE.HasValue ? EXT_UPTO_DATE.Value.Date : (object)DBNull.Value);
                        cmd.Parameters.AddWithValue("@CONTRACT_DURATION", string.IsNullOrWhiteSpace(CONTRACT_DURATION) ? (object)DBNull.Value : CONTRACT_DURATION);

                        cmd.Parameters.AddWithValue("@MOBILE", (object?)MOBILE ?? DBNull.Value);
                        cmd.Parameters.AddWithValue("@LANDLINE", (object?)LANDLINE ?? DBNull.Value);

                        cmd.Parameters.AddWithValue("@EMAIL", (object?)EMAIL ?? DBNull.Value);
                        cmd.Parameters.AddWithValue("@PAYROLL_ID", (object?)PAYROLL_ID ?? DBNull.Value);

                        cmd.Parameters.AddWithValue("@REF_FILE_NO", (object?)REF_FILE_NO ?? DBNull.Value);
                        cmd.Parameters.AddWithValue("@REMARKS", (object?)REMARKS ?? DBNull.Value);

                        int newEmployeeId = (int)cmd.ExecuteScalar();

                        // 2) Insert history (single row) — pick values from tbl_employee to keep mapping solid
                        // NOTE: Adjust the column list below to EXACTLY match your tbl_Employee_History schema.
                        var userCnic = HttpContext.Session.GetString("CNIC");

                        var histSql = @"
INSERT INTO dbo.tbl_Employee_History
(
    EMPLOYEE_ID, CNIC, NAME, FATHER_NAME, GENDER, DOB,
    EDUCATION, MARITAL_STATUS, RELIGION, RELIGION_CAST, CHILDREN,
    DOMICILE_PROVINCE, DOMICILE_DISTRICT,
    DESIGNATION, SCALE, REF_FILE_NO,
    C_ADDRESS, C_TEHSIL, C_DISTRICT, C_PROVINCE,
    P_ADDRESS, P_TEHSIL, P_DISTRICT, P_PROVINCE,
    LANDLINE, MOBILE,
    JOINING_DATE, CONTRACT_DURATION, CONTRACT_EXPIRY_DATE, STATUS,
    RENEWAL_DATE, PARENT_OFFICE, EMAIL, REPORT_DATE, EXT_UPTO_DATE,
    REMARKS, PAYROLL_ID, IDATE,
    USER_CNIC,           -- who created (from session)
    ACTION
    -- HISTORY_DATE has default GETDATE()
)
SELECT 
    e.EMPLOYEE_ID, e.CNIC, e.NAME, e.FATHER_NAME, e.GENDER, e.DOB,
    e.EDUCATION, e.MARITAL_STATUS, e.RELIGION, e.RELIGION_CAST, e.CHILDREN,
    e.DOMICILE_PROVINCE, e.DOMICILE_DISTRICT,
    e.DESIGNATION, e.SCALE, e.REF_FILE_NO,
    e.C_ADDRESS, e.C_TEHSIL, e.C_DISTRICT, e.C_PROVINCE,
    e.P_ADDRESS, e.P_TEHSIL, e.P_DISTRICT, e.P_PROVINCE,
    e.LANDLINE, e.MOBILE,
    e.JOINING_DATE, e.CONTRACT_DURATION, e.CONTRACT_EXPIRY_DATE, e.STATUS,
    e.RENEWAL_DATE, e.PARENT_OFFICE, e.EMAIL, e.REPORT_DATE, e.EXT_UPTO_DATE,
    e.REMARKS, e.PAYROLL_ID, e.IDATE,
    @userCnic,
    @action
FROM dbo.tbl_employee e
WHERE e.EMPLOYEE_ID = @id;";

                        using (var h = new SqlCommand(histSql, con, tran))
                        {
                            h.Parameters.AddWithValue("@id", newEmployeeId);
                            h.Parameters.AddWithValue("@userCnic", (object?)userCnic ?? DBNull.Value);
                            h.Parameters.AddWithValue("@action", "INSERT");
                            h.ExecuteNonQuery();
                        }

                        tran.Commit();

                        TempData["Message"] = $"✅ Form submitted successfully! Employee ID: {newEmployeeId}";
                        return RedirectToAction("Index", "Home", new { employeeId = newEmployeeId });
                    }
                    catch (Exception ex)
                    {
                        try { tran.Rollback(); } catch { /* ignore */ }
                        return Fail("Save failed: " + ex.Message);
                    }
                }
            }

            // ----- repopulate on error -----
            IActionResult Fail(string msg)
            {
                ViewBag.NextEmployeeId = GetNextId();
                ViewBag.Genders = GetGenders();
                ViewBag.MaritalStatuses = GetMaritalStatuses();
                ViewBag.Religions = GetReligions();
                ViewBag.Provinces = GetProvinces();
                ViewBag.Scales = GetScales();
                ViewBag.Designations = GetDesignations();
                ViewBag.Statuses = GetStatuses();
                ViewBag.ParentOffices = GetParentOffices();
                ViewBag.Educations = GetEducations();   // <-- NEW
                ViewBag.Message = msg;
                return View();
            }
        }

        // ===== AJAX =====
        [HttpGet]
        public JsonResult CheckUnique(string field, string value)
        {
            if (!string.Equals(field, "CNIC", StringComparison.OrdinalIgnoreCase) || string.IsNullOrWhiteSpace(value))
                return Json(new { ok = false, exists = false });
            return Json(new { ok = true, exists = ExistsCnic(value) });
        }

        [HttpGet]
        public JsonResult GetCastsByReligion(int religionId)
        {
            var rows = new List<object>();
            string cs = _config.GetConnectionString("DefaultConnection")!;
            using var con = new SqlConnection(cs);
            using var cmd = new SqlCommand(@"
                SELECT CastID, CastName
                FROM dbo.lib_religion_cast
                WHERE ReligionID = @rid
                ORDER BY CastName;", con);
            cmd.Parameters.AddWithValue("@rid", religionId);
            con.Open();
            using var r = cmd.ExecuteReader();
            while (r.Read()) rows.Add(new { id = r.GetInt32(0), name = r.GetString(1) });
            return Json(rows);
        }

        [HttpGet]
        public JsonResult GetDistrictsByProvinceCode(int provinceCode)
        {
            var rows = new List<object>();
            string cs = _config.GetConnectionString("DefaultConnection")!;
            using var con = new SqlConnection(cs);
            using var cmd = new SqlCommand(@"
                SELECT DistrictCode, DistrictName
                FROM dbo.lib_district
                WHERE ProvinceCode=@p
                ORDER BY DistrictName;", con);
            cmd.Parameters.AddWithValue("@p", provinceCode);
            con.Open();
            using var r = cmd.ExecuteReader();
            while (r.Read()) rows.Add(new { code = r.GetInt32(0), name = r.GetString(1) });
            return Json(rows);
        }

        [HttpGet]
        public JsonResult GetTehsilsByDistrictCode(int districtCode)
        {
            var rows = new List<object>();
            string cs = _config.GetConnectionString("DefaultConnection")!;
            using var con = new SqlConnection(cs);
            using var cmd = new SqlCommand(@"
                SELECT TehsilCode, TehsilName
                FROM dbo.lib_tehsil
                WHERE DistrictCode=@d
                ORDER BY TehsilName;", con);
            cmd.Parameters.AddWithValue("@d", districtCode);
            con.Open();
            using var r = cmd.ExecuteReader();
            while (r.Read()) rows.Add(new { code = r.GetInt32(0), name = r.GetString(1) });
            return Json(rows);
        }

        // ===== Helpers =====
        private int GetNextId()
        {
            string cs = _config.GetConnectionString("DefaultConnection")!;
            using var con = new SqlConnection(cs);
            using var cmd = new SqlCommand("SELECT ISNULL(MAX(EMPLOYEE_ID),0)+1 FROM dbo.tbl_employee", con);
            con.Open();
            return (int)cmd.ExecuteScalar();
        }

        private bool ExistsCnic(string cnic)
        {
            string cs = _config.GetConnectionString("DefaultConnection")!;
            using var con = new SqlConnection(cs);
            using var cmd = new SqlCommand("SELECT COUNT(*) FROM dbo.tbl_employee WHERE CNIC=@v", con);
            cmd.Parameters.AddWithValue("@v", cnic);
            con.Open();
            return (int)cmd.ExecuteScalar() > 0;
        }

        private IEnumerable<SelectListItem> GetGenders()
        {
            var list = new List<SelectListItem>();
            string cs = _config.GetConnectionString("DefaultConnection")!;
            using var con = new SqlConnection(cs);
            using var cmd = new SqlCommand("SELECT GenderID, GenderName FROM dbo.lib_gender ORDER BY GenderName", con);
            con.Open();
            using var r = cmd.ExecuteReader();
            while (r.Read())
                list.Add(new SelectListItem { Value = r.GetInt32(0).ToString(), Text = r.GetString(1) });
            return list;
        }

        private IEnumerable<SelectListItem> GetMaritalStatuses()
        {
            var list = new List<SelectListItem>();
            string cs = _config.GetConnectionString("DefaultConnection")!;
            using var con = new SqlConnection(cs);
            using var cmd = new SqlCommand("SELECT marital_status_id, status_name FROM dbo.lib_marital_status ORDER BY status_name", con);
            con.Open();
            using var r = cmd.ExecuteReader();
            while (r.Read())
                list.Add(new SelectListItem { Value = r.GetInt32(0).ToString(), Text = r.GetString(1) });
            return list;
        }

        private IEnumerable<SelectListItem> GetReligions()
        {
            var list = new List<SelectListItem>();
            string cs = _config.GetConnectionString("DefaultConnection")!;
            using var con = new SqlConnection(cs);
            using var cmd = new SqlCommand("SELECT ReligionID, ReligionName FROM dbo.lib_religion ORDER BY ReligionName", con);
            con.Open();
            using var r = cmd.ExecuteReader();
            while (r.Read())
                list.Add(new SelectListItem { Value = r.GetInt32(0).ToString(), Text = r.GetString(1) });
            return list;
        }

        private IEnumerable<SelectListItem> GetProvinces()
        {
            var list = new List<SelectListItem>();
            string cs = _config.GetConnectionString("DefaultConnection")!;
            using var con = new SqlConnection(cs);
            using var cmd = new SqlCommand("SELECT ProvinceCode, ProvinceName FROM dbo.lib_province ORDER BY ProvinceName", con);
            con.Open();
            using var r = cmd.ExecuteReader();
            while (r.Read())
                list.Add(new SelectListItem { Value = r.GetInt32(0).ToString(), Text = r.GetString(1) });
            return list;
        }

        private IEnumerable<SelectListItem> GetScales()
        {
            var list = new List<SelectListItem>();
            string cs = _config.GetConnectionString("DefaultConnection")!;
            using var con = new SqlConnection(cs);
            using var cmd = new SqlCommand("SELECT ScaleID, ScaleCode FROM dbo.lib_scale ORDER BY ScaleID", con);
            con.Open();
            using var r = cmd.ExecuteReader();
            while (r.Read())
                list.Add(new SelectListItem { Value = r.GetInt32(0).ToString(), Text = r.GetString(1) });
            return list;
        }

        private IEnumerable<SelectListItem> GetDesignations()
        {
            var list = new List<SelectListItem>();
            string cs = _config.GetConnectionString("DefaultConnection")!;
            using var con = new SqlConnection(cs);
            using var cmd = new SqlCommand("SELECT DesignationID, DesignationName FROM dbo.lib_designation WHERE IsActive=1 ORDER BY DesignationName", con);
            con.Open();
            using var r = cmd.ExecuteReader();
            while (r.Read())
                list.Add(new SelectListItem { Value = r.GetInt32(0).ToString(), Text = r.GetString(1) });
            return list;
        }

        private IEnumerable<SelectListItem> GetStatuses()
        {
            var list = new List<SelectListItem>();
            string cs = _config.GetConnectionString("DefaultConnection")!;
            using var con = new SqlConnection(cs);
            using var cmd = new SqlCommand("SELECT StatusID, StatusName FROM dbo.lib_status ORDER BY StatusName", con);
            con.Open();
            using var r = cmd.ExecuteReader();
            while (r.Read())
                list.Add(new SelectListItem { Value = r.GetInt32(0).ToString(), Text = r.GetString(1) });
            return list;
        }

        private IEnumerable<SelectListItem> GetParentOffices()
        {
            var list = new List<SelectListItem>();
            string cs = _config.GetConnectionString("DefaultConnection")!;
            using var con = new SqlConnection(cs);
            using var cmd = new SqlCommand("SELECT ParentOfficeID, OfficeName FROM dbo.lib_parent_office WHERE IsActive=1 ORDER BY OfficeName", con);
            con.Open();
            using var r = cmd.ExecuteReader();
            while (r.Read())
                list.Add(new SelectListItem { Value = r.GetInt32(0).ToString(), Text = r.GetString(1) });
            return list;
        }

        private IEnumerable<SelectListItem> GetEducations()            // NEW
        {
            var list = new List<SelectListItem>();
            string cs = _config.GetConnectionString("DefaultConnection")!;
            using var con = new SqlConnection(cs);
            using var cmd = new SqlCommand("SELECT EducationID, EducationName FROM dbo.lib_education ORDER BY EducationName", con);
            con.Open();
            using var r = cmd.ExecuteReader();
            while (r.Read())
                list.Add(new SelectListItem { Value = r.GetInt32(0).ToString(), Text = r.GetString(1) });
            return list;
        }

        // ===== Validators =====
        private bool StatusExists(int id)
        {
            string cs = _config.GetConnectionString("DefaultConnection")!;
            using var con = new SqlConnection(cs);
            using var cmd = new SqlCommand("SELECT COUNT(*) FROM dbo.lib_status WHERE StatusID=@id", con);
            cmd.Parameters.AddWithValue("@id", id);
            con.Open();
            return (int)cmd.ExecuteScalar() > 0;
        }

        private bool ParentOfficeExists(int id)
        {
            string cs = _config.GetConnectionString("DefaultConnection")!;
            using var con = new SqlConnection(cs);
            using var cmd = new SqlCommand("SELECT COUNT(*) FROM dbo.lib_parent_office WHERE ParentOfficeID=@id AND IsActive=1", con);
            cmd.Parameters.AddWithValue("@id", id);
            con.Open();
            return (int)cmd.ExecuteScalar() > 0;
        }

        private bool GenderExists(int id)
        {
            string cs = _config.GetConnectionString("DefaultConnection")!;
            using var con = new SqlConnection(cs);
            using var cmd = new SqlCommand("SELECT COUNT(*) FROM dbo.lib_gender WHERE GenderID=@id", con);
            cmd.Parameters.AddWithValue("@id", id);
            con.Open();
            return (int)cmd.ExecuteScalar() > 0;
        }

        private bool MaritalStatusExists(int id)
        {
            string cs = _config.GetConnectionString("DefaultConnection")!;
            using var con = new SqlConnection(cs);
            using var cmd = new SqlCommand("SELECT COUNT(*) FROM dbo.lib_marital_status WHERE marital_status_id=@id", con);
            cmd.Parameters.AddWithValue("@id", id);
            con.Open();
            return (int)cmd.ExecuteScalar() > 0;
        }

        private bool ReligionExists(int id)
        {
            string cs = _config.GetConnectionString("DefaultConnection")!;
            using var con = new SqlConnection(cs);
            using var cmd = new SqlCommand("SELECT COUNT(*) FROM dbo.lib_religion WHERE ReligionID=@id", con);
            cmd.Parameters.AddWithValue("@id", id);
            con.Open();
            return (int)cmd.ExecuteScalar() > 0;
        }

        private bool CastExistsForReligion(int castId, int religionId)
        {
            string cs = _config.GetConnectionString("DefaultConnection")!;
            using var con = new SqlConnection(cs);
            using var cmd = new SqlCommand("SELECT COUNT(*) FROM dbo.lib_religion_cast WHERE CastID=@cid AND ReligionID=@rid", con);
            cmd.Parameters.AddWithValue("@cid", castId);
            cmd.Parameters.AddWithValue("@rid", religionId);
            con.Open();
            return (int)cmd.ExecuteScalar() > 0;
        }

        private bool ScaleExists(int scaleId)
        {
            string cs = _config.GetConnectionString("DefaultConnection")!;
            using var con = new SqlConnection(cs);
            using var cmd = new SqlCommand("SELECT COUNT(*) FROM dbo.lib_scale WHERE ScaleID=@id", con);
            cmd.Parameters.AddWithValue("@id", scaleId);
            con.Open();
            return (int)cmd.ExecuteScalar() > 0;
        }

        private bool DesignationExists(int desigId)
        {
            string cs = _config.GetConnectionString("DefaultConnection")!;
            using var con = new SqlConnection(cs);
            using var cmd = new SqlCommand("SELECT COUNT(*) FROM dbo.lib_designation WHERE DesignationID=@id AND IsActive=1", con);
            cmd.Parameters.AddWithValue("@id", desigId);
            con.Open();
            return (int)cmd.ExecuteScalar() > 0;
        }

        private bool EducationExists(int id)                             // NEW
        {
            string cs = _config.GetConnectionString("DefaultConnection")!;
            using var con = new SqlConnection(cs);
            using var cmd = new SqlCommand("SELECT COUNT(*) FROM dbo.lib_education WHERE EducationID=@id", con);
            cmd.Parameters.AddWithValue("@id", id);
            con.Open();
            return (int)cmd.ExecuteScalar() > 0;
        }

        private bool DistrictBelongsToProvinceCode(int districtCode, int provinceCode)
        {
            string cs = _config.GetConnectionString("DefaultConnection")!;
            using var con = new SqlConnection(cs);
            using var cmd = new SqlCommand("SELECT COUNT(*) FROM dbo.lib_district WHERE DistrictCode=@d AND ProvinceCode=@p", con);
            cmd.Parameters.AddWithValue("@d", districtCode);
            cmd.Parameters.AddWithValue("@p", provinceCode);
            con.Open();
            return (int)cmd.ExecuteScalar() > 0;
        }

        private bool TehsilBelongsToDistrictCode(int tehsilCode, int districtCode)
        {
            string cs = _config.GetConnectionString("DefaultConnection")!;
            using var con = new SqlConnection(cs);
            using var cmd = new SqlCommand("SELECT COUNT(*) FROM dbo.lib_tehsil WHERE TehsilCode=@t AND DistrictCode=@d", con);
            cmd.Parameters.AddWithValue("@t", tehsilCode);
            cmd.Parameters.AddWithValue("@d", districtCode);
            con.Open();
            return (int)cmd.ExecuteScalar() > 0;
        }
    }
}