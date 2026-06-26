using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using Microsoft.AspNetCore.Mvc.Rendering;
//using System;
using System.Data;
using BISP_hrmsDashboard.Models;
using System.Linq;
using System.Collections.Generic;

namespace BISP_hrmsDashboard.Controllers
{
    public class EmployeeController : Controller
    {
        private const string CmdText = @"
        UPDATE tbl_Employee SET
            CNIC=@CNIC, NAME=@NAME, FATHER_NAME=@FATHER_NAME, GENDER=@GENDER, DOB=@DOB,
            MARITAL_STATUS=@MARITAL_STATUS, CHILDREN=@CHILDREN,
            RELIGION=@RELIGION, RELIGION_CAST=@RELIGION_CAST,
            SCALE=@SCALE, DESIGNATION=@DESIGNATION, EDUCATION=@EDUCATION, STATUS=@STATUS,
            PARENT_OFFICE=@PARENT_OFFICE, JOINING_DATE=@JOINING_DATE, CONTRACT_EXPIRY_DATE=@CONTRACT_EXPIRY_DATE,
            RENEWAL_DATE=@RENEWAL_DATE, REPORT_DATE=@REPORT_DATE, EXT_UPTO_DATE=@EXT_UPTO_DATE,
            CONTRACT_DURATION=@CONTRACT_DURATION, EMAIL=@EMAIL, PAYROLL_ID=@PAYROLL_ID,
            MOBILE=@MOBILE, LANDLINE=@LANDLINE, REF_FILE_NO=@REF_FILE_NO, REMARKS=@REMARKS,
            DOMICILE_PROVINCE=@DOM_PROV, DOMICILE_DISTRICT=@DOM_DIST,
            C_PROVINCE=@C_PROV, C_DISTRICT=@C_DIST, C_TEHSIL=@C_TEH, C_ADDRESS=@C_ADDR,
            P_PROVINCE=@P_PROV, P_DISTRICT=@P_DIST, P_TEHSIL=@P_TEH, P_ADDRESS=@P_ADDR
        WHERE EMPLOYEE_ID=@ID;";
        private readonly IConfiguration _config;
        public EmployeeController(IConfiguration config) { _config = config; }

        //Search
        [HttpPost]
        [ValidateAntiForgeryToken]
        public IActionResult Update(EmployeeEditVM vm)
        {
            long? cnic = null;
            if (!string.IsNullOrWhiteSpace(vm.CNIC))
            {
                var digits = new string(vm.CNIC.Where(char.IsDigit).ToArray());
                if (digits.Length == 13) cnic = long.Parse(digits);
            }

            using var con = new SqlConnection(_config.GetConnectionString("DefaultConnection")!);
            using var cmd = new SqlCommand(CmdText, con);

            cmd.Parameters.Add("@ID", SqlDbType.Int).Value = vm.EMPLOYEE_ID;
            cmd.Parameters.Add("@CNIC", SqlDbType.BigInt).Value = (object?)cnic ?? DBNull.Value;
            cmd.Parameters.AddWithValue("@NAME", (object?)vm.NAME ?? DBNull.Value);
            cmd.Parameters.AddWithValue("@FATHER_NAME", (object?)vm.FATHER_NAME ?? DBNull.Value);
            cmd.Parameters.AddWithValue("@GENDER", (object?)vm.GENDER ?? DBNull.Value);
            cmd.Parameters.AddWithValue("@DOB", (object?)vm.DOB ?? DBNull.Value);
            cmd.Parameters.AddWithValue("@MARITAL_STATUS", (object?)vm.MARITAL_STATUS ?? DBNull.Value);
            cmd.Parameters.AddWithValue("@CHILDREN", (object?)vm.CHILDREN ?? DBNull.Value);
            cmd.Parameters.AddWithValue("@RELIGION", (object?)vm.RELIGION ?? DBNull.Value);
            cmd.Parameters.AddWithValue("@RELIGION_CAST", (object?)vm.RELIGION_CAST ?? DBNull.Value);
            cmd.Parameters.AddWithValue("@SCALE", (object?)vm.SCALE ?? DBNull.Value);
            cmd.Parameters.AddWithValue("@DESIGNATION", (object?)vm.DESIGNATION ?? DBNull.Value);
            cmd.Parameters.AddWithValue("@EDUCATION", (object?)vm.EDUCATION ?? DBNull.Value);
            cmd.Parameters.AddWithValue("STATUS", (object?)vm.STATUS ?? DBNull.Value);
            cmd.Parameters.AddWithValue("PARENT_OFFICE", (object?)vm.PARENT_OFFICE ?? DBNull.Value);
            cmd.Parameters.AddWithValue("@JOINING_DATE", (object?)vm.JOINING_DATE ?? DBNull.Value);
            cmd.Parameters.AddWithValue("@CONTRACT_EXPIRY_DATE", (object?)vm.CONTRACT_EXPIRY_DATE ?? DBNull.Value);
            cmd.Parameters.AddWithValue("@RENEWAL_DATE", (object?)vm.RENEWAL_DATE ?? DBNull.Value);
            cmd.Parameters.AddWithValue("@REPORT_DATE", (object?)vm.REPORT_DATE ?? DBNull.Value);
            cmd.Parameters.AddWithValue("EXT_UPTO_DATE", (object?)vm.EXT_UPTO_DATE ?? DBNull.Value);
            cmd.Parameters.AddWithValue("@CONTRACT_DURATION", (object?)vm.CONTRACT_DURATION ?? DBNull.Value);
            cmd.Parameters.AddWithValue("@EMAIL", (object?)vm.EMAIL ?? DBNull.Value);
            cmd.Parameters.AddWithValue("@PAYROLL_ID", (object?)vm.PAYROLL_ID ?? DBNull.Value);
            cmd.Parameters.AddWithValue("@MOBILE", (object?)vm.MOBILE ?? DBNull.Value);
            cmd.Parameters.AddWithValue("@LANDLINE", (object?)vm.LANDLINE ?? DBNull.Value);
            cmd.Parameters.AddWithValue("@REF_FILE_NO", (object?)vm.REF_FILE_NO ?? DBNull.Value);
            cmd.Parameters.AddWithValue("@REMARKS", (object?)vm.REMARKS ?? DBNull.Value);
            cmd.Parameters.AddWithValue("@DOM_PROV", (object?)vm.DOMICILE_PROVINCE ?? DBNull.Value);
            cmd.Parameters.AddWithValue("@DOM_DIST", (object?)vm.DOMICILE_DISTRICT ?? DBNull.Value);
            cmd.Parameters.AddWithValue("@C_PROV", (object?)vm.C_PROVINCE ?? DBNull.Value);
            cmd.Parameters.AddWithValue("@C_DIST", (object?)vm.C_DISTRICT ?? DBNull.Value);
            cmd.Parameters.AddWithValue("@C_TEH", (object?)vm.C_TEHSIL ?? DBNull.Value);
            cmd.Parameters.AddWithValue("@C_ADDR", (object?)vm.C_ADDRESS ?? DBNull.Value);
            cmd.Parameters.AddWithValue("@P_PROV", (object?)vm.P_PROVINCE ?? DBNull.Value);
            cmd.Parameters.AddWithValue("@P_DIST", (object?)vm.P_DISTRICT ?? DBNull.Value);
            cmd.Parameters.AddWithValue("@P_TEH", (object?)vm.P_TEHSIL ?? DBNull.Value);
            cmd.Parameters.AddWithValue("@P_ADDR", (object?)vm.P_ADDRESS ?? DBNull.Value);

            con.Open();
            cmd.ExecuteNonQuery();

            // Partial ko HTML message bhej do
            //return Content("<div class='alert alert-success'>✔ Employee updated.</div>", "text/html");
            return RedirectToAction("Search", "Employee");
        }

        //Edit
        [HttpGet]
        public IActionResult Edit(int id)
        {
            var cs = _config.GetConnectionString("DefaultConnection")!;
            var vm = new EmployeeEditVM();

            using var con = new SqlConnection(cs);
            using var cmd = new SqlCommand(@"
        SELECT EMPLOYEE_ID, CNIC, NAME, FATHER_NAME, GENDER, DOB, MARITAL_STATUS, CHILDREN,
               RELIGION, RELIGION_CAST, SCALE, DESIGNATION, EDUCATION, STATUS, PARENT_OFFICE, 
               JOINING_DATE, CONTRACT_EXPIRY_DATE, RENEWAL_DATE, REPORT_DATE, EXT_UPTO_DATE,
               CONTRACT_DURATION, EMAIL, PAYROLL_ID, MOBILE, LANDLINE, REF_FILE_NO, REMARKS,
               DOMICILE_PROVINCE, DOMICILE_DISTRICT,
               C_PROVINCE, C_DISTRICT, C_TEHSIL, C_ADDRESS,
               P_PROVINCE, P_DISTRICT, P_TEHSIL, P_ADDRESS
        FROM tbl_employee WHERE EMPLOYEE_ID=@id;", con);
            cmd.Parameters.Add("@id", SqlDbType.Int).Value = id;

            con.Open();
            using var r = cmd.ExecuteReader();
            if (!r.Read()) return Content("<div class='alert alert-danger'>Employee not found.</div>", "text/html");

            vm.EMPLOYEE_ID = r.GetInt32(0);
            vm.CNIC = r.IsDBNull(1) ? "" : r.GetInt64(1).ToString();
            vm.NAME = r.IsDBNull(2) ? null : r.GetString(2);
            vm.FATHER_NAME = r.IsDBNull(3) ? null : r.GetString(3);
            vm.GENDER = r.IsDBNull(4) ? null : r.GetInt32(4);
            vm.DOB = r.IsDBNull(5) ? null : r.GetDateTime(5);
            vm.MARITAL_STATUS = r.IsDBNull(6) ? null : r.GetInt32(6);
            vm.CHILDREN = r.IsDBNull(7) ? null : r.GetInt32(7);
            vm.RELIGION = r.IsDBNull(8) ? null : r.GetInt32(8);
            vm.RELIGION_CAST = r.IsDBNull(9) ? null : r.GetInt32(9);
            vm.SCALE = r.IsDBNull(10) ? null : r.GetInt32(10);
            vm.DESIGNATION = r.IsDBNull(11) ? null : r.GetInt32(11);
            vm.EDUCATION = r.IsDBNull(12) ? null : r.GetInt32(12);
            vm.STATUS = r.IsDBNull(13) ? null : r.GetInt32(13);
            vm.PARENT_OFFICE = r.IsDBNull(14) ? null : r.GetInt32(14);
            vm.JOINING_DATE = r.IsDBNull(15) ? null : r.GetDateTime(15);
            vm.CONTRACT_EXPIRY_DATE = r.IsDBNull(16) ? null : r.GetDateTime(16);
            vm.RENEWAL_DATE = r.IsDBNull(17) ? null : r.GetDateTime(17);
            vm.REPORT_DATE = r.IsDBNull(18) ? null : r.GetDateTime(18);
            vm.EXT_UPTO_DATE = r.IsDBNull(19) ? null : r.GetDateTime(19);
            vm.CONTRACT_DURATION = r.IsDBNull(20) ? null : r.GetString(20);
            vm.EMAIL = r.IsDBNull(21) ? null : r.GetString(21);
            vm.PAYROLL_ID = r.IsDBNull(22) ? null : r.GetString(22);
            vm.MOBILE = r.IsDBNull(23) ? null : r.GetString(23);
            vm.LANDLINE = r.IsDBNull(24) ? null : r.GetString(24);
            vm.REF_FILE_NO = r.IsDBNull(25) ? null : r.GetString(25);
            vm.REMARKS = r.IsDBNull(26) ? null : r.GetString(26);
            vm.DOMICILE_PROVINCE = r.IsDBNull(27) ? null : r.GetInt32(27);
            vm.DOMICILE_DISTRICT = r.IsDBNull(28) ? null : r.GetInt32(28);
            vm.C_PROVINCE = r.IsDBNull(29) ? null : r.GetInt32(29);
            vm.C_DISTRICT = r.IsDBNull(30) ? null : r.GetInt32(30);
            vm.C_TEHSIL = r.IsDBNull(31) ? null : r.GetInt32(31);
            vm.C_ADDRESS = r.IsDBNull(32) ? null : r.GetString(32);
            vm.P_PROVINCE = r.IsDBNull(33) ? null : r.GetInt32(33);
            vm.P_DISTRICT = r.IsDBNull(34) ? null : r.GetInt32(34);
            vm.P_TEHSIL = r.IsDBNull(35) ? null : r.GetInt32(35);
            vm.P_ADDRESS = r.IsDBNull(36) ? null : r.GetString(36);


            // helper: dropdowns
            IEnumerable<SelectListItem> Q(string sql, params SqlParameter[] p)
            {
                var list = new List<SelectListItem>();
                using var c2 = new SqlConnection(cs);
                using var m2 = new SqlCommand(sql, c2);
                if (p?.Length > 0) m2.Parameters.AddRange(p);
                c2.Open();
                using var rr = m2.ExecuteReader();
                while (rr.Read())
                    list.Add(new SelectListItem { Value = rr[0].ToString(), Text = rr[1].ToString() });
                return list;
            }

            // ===== simple master lists =====
            vm.Genders = Q("SELECT GenderID, GenderName FROM lib_gender ORDER BY GenderName");
            vm.MaritalStatuses = Q("SELECT marital_status_id, status_name FROM lib_marital_status ORDER BY status_name");
            vm.Religions = Q("SELECT ReligionID, ReligionName FROM lib_religion ORDER BY ReligionName");
            vm.Scales = Q("SELECT ScaleID, ScaleCode FROM lib_scale ORDER BY ScaleID");
            vm.Designations = Q("SELECT DesignationID, DesignationName FROM lib_designation ORDER BY DesignationName");
            vm.Status = Q("SELECT StatusID, StatusName FROM lib_status ORDER BY StatusName");
            vm.ParentOffice = Q("SELECT ParentOfficeID, OfficeName FROM lib_parent_office ORDER BY OfficeName");
            vm.Education = Q("SELECT EducationID, EducationName FROM lib_education ORDER BY EducationName");

            // Provinces (same list teen jagah chahiye)
            var provinces = Q("SELECT ProvinceCode, ProvinceName FROM lib_province ORDER BY ProvinceName");
            vm.DomicileProvinces = provinces;
            vm.CProvinces = provinces;
            vm.PProvinces = provinces;

            // Casts (religion based)
            if (vm.RELIGION.HasValue)
                vm.Casts = Q(@"SELECT CastID, CastName 
                   FROM lib_religion_cast 
                   WHERE ReligionID=@p ORDER BY CastName",
                             new SqlParameter("@p", vm.RELIGION.Value));

            // ===== dependent lists pre-populate (selected values ke mutabiq) =====

            // Domicile Districts
            if (vm.DOMICILE_PROVINCE.HasValue)
                vm.DomicileDistricts = Q(@"SELECT DistrictCode, DistrictName 
                               FROM lib_district 
                               WHERE ProvinceCode=@p ORDER BY DistrictName",
                                         new SqlParameter("@p", vm.DOMICILE_PROVINCE.Value));

            // Current Districts/Tehsils
            if (vm.C_PROVINCE.HasValue)
                vm.CDistricts = Q(@"SELECT DistrictCode, DistrictName 
                        FROM lib_district 
                        WHERE ProvinceCode=@p ORDER BY DistrictName",
                                  new SqlParameter("@p", vm.C_PROVINCE.Value));

            if (vm.C_DISTRICT.HasValue)
                vm.CTehsils = Q(@"SELECT TehsilCode, TehsilName 
                      FROM lib_tehsil 
                      WHERE DistrictCode=@d ORDER BY TehsilName",
                                new SqlParameter("@d", vm.C_DISTRICT.Value));

            // Permanent Districts/Tehsils
            if (vm.P_PROVINCE.HasValue)
                vm.PDistricts = Q(@"SELECT DistrictCode, DistrictName 
                        FROM lib_district 
                        WHERE ProvinceCode=@p ORDER BY DistrictName",
                                  new SqlParameter("@p", vm.P_PROVINCE.Value));

            if (vm.P_DISTRICT.HasValue)
                vm.PTehsils = Q(@"SELECT TehsilCode, TehsilName 
                      FROM lib_tehsil 
                      WHERE DistrictCode=@d ORDER BY TehsilName",
                                new SqlParameter("@d", vm.P_DISTRICT.Value));

            // finally
            return PartialView("_EmployeeEditor", vm);
        }


        [HttpGet]
        public IActionResult Search() => View(new EmployeeSearchVM { SearchBy = "EmpId" });

        [HttpPost]
        [ValidateAntiForgeryToken]
        public IActionResult Search(EmployeeSearchVM vm)
        {
            vm.Results.Clear();

            // Validate selection + input
            if (string.IsNullOrWhiteSpace(vm.SearchBy))
                vm.SearchBy = "EmpId";

            var q = (vm.QueryText ?? "").Trim();

            int? empId = null;
            string? cnic = null;

            if (vm.SearchBy == "EmpId")
            {
                var digits = new string(q.Where(char.IsDigit).ToArray());
                if (string.IsNullOrEmpty(digits))
                {
                    vm.Message = "Please enter Employee ID.";
                    return View(vm);
                }
                if (!int.TryParse(digits, out var id))
                {
                    vm.Message = "Employee ID must be numeric.";
                    return View(vm);
                }
                empId = id;
            }
            else // CNIC
            {
                var digits = new string(q.Where(char.IsDigit).ToArray());
                if (digits.Length != 13)
                {
                    vm.Message = "CNIC must be exactly 13 digits.";
                    return View(vm);
                }
                cnic = digits;
            }

            // Query
            string cs = _config.GetConnectionString("DefaultConnection")!;
            using var con = new SqlConnection(cs);
            using var cmd = new SqlCommand(@"
            SELECT 
                e.EMPLOYEE_ID,
                e.CNIC,
                e.NAME,
                ISNULL(d.DesignationName,'') AS DesignationName,
                ISNULL(o.OfficeName,'')      AS ParentOffice,     -- 👈 NEW

                CASE 
                 WHEN e.STATUS = 1 THEN 'Active'
                 WHEN e.STATUS = 2 THEN 'Inactive'
                ELSE 'Unknown'
                END AS Status

            FROM tbl_employee e
            LEFT JOIN lib_designation d ON d.DesignationID = e.DESIGNATION
            LEFT JOIN lib_parent_office      o ON o.ParentOfficeID      = e.PARENT_OFFICE   -- 👈 adjust if needed
            WHERE (@id   IS NULL OR e.EMPLOYEE_ID = @id)
              AND (@cnic IS NULL OR e.CNIC = @cnic)
            ORDER BY e.EMPLOYEE_ID;", con);

            cmd.Parameters.Add("@id", SqlDbType.Int).Value = (object?)empId ?? DBNull.Value;
            cmd.Parameters.Add("@cnic", SqlDbType.NVarChar, 13).Value = (object?)cnic ?? DBNull.Value;

            con.Open();
            using var r = cmd.ExecuteReader();
            while (r.Read())
            {
                vm.Results.Add(new EmployeeRow
                {
                    EMPLOYEE_ID = r.IsDBNull(0) ? 0 : r.GetInt32(0),
                    CNIC = r.IsDBNull(1) ? "" : r.GetInt64(1).ToString(),
                    NAME = r.IsDBNull(2) ? "" : r.GetString(2),
                    DesignationName = r.IsDBNull(3) ? "" : r.GetString(3),
                    ParentOffice = r.IsDBNull(4) ? "" : r.GetString(4),
                    Status = r.IsDBNull(5) ? "" : r.GetString(5)
                });
            }

            if (vm.Results.Count == 0) vm.Message = "No record found.";
            return View(vm);
        }

        // --- AJAX: districts by province ---
        [HttpGet]
        public JsonResult GetDistricts(int provinceCode)
        {
            var list = new List<object>();
            using var con = new SqlConnection(_config.GetConnectionString("DefaultConnection")!);
            using var cmd = new SqlCommand(@"
        SELECT DistrictCode, DistrictName
        FROM lib_district
        WHERE ProvinceCode=@p
        ORDER BY DistrictName;", con);
            cmd.Parameters.AddWithValue("@p", provinceCode);
            con.Open();
            using var r = cmd.ExecuteReader();
            while (r.Read()) list.Add(new { code = r.GetInt32(0), name = r.GetString(1) });
            return Json(list);
        }

        // --- AJAX: tehsils by district ---
        [HttpGet]
        public JsonResult GetTehsils(int districtCode)
        {
            var list = new List<object>();
            using var con = new SqlConnection(_config.GetConnectionString("DefaultConnection")!);
            using var cmd = new SqlCommand(@"
        SELECT TehsilCode, TehsilName
        FROM lib_tehsil
        WHERE DistrictCode=@d
        ORDER BY TehsilName;", con);
            cmd.Parameters.AddWithValue("@d", districtCode);
            con.Open();
            using var r = cmd.ExecuteReader();
            while (r.Read()) list.Add(new { code = r.GetInt32(0), name = r.GetString(1) });
            return Json(list);
        }

    }
}