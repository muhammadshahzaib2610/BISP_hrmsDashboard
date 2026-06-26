using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using Microsoft.Data.SqlClient;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.AspNetCore.Http; // Session.GetString
using System;
using System.Collections.Generic;
using System.Data;
using BISP_hrmsDashboard.Models;

namespace BISP_hrmsDashboard.Controllers
{
    public class PositionController : Controller
    {
        private readonly IConfiguration _config;
        public PositionController(IConfiguration config) => _config = config;

        // ================= CREATE (unchanged) =================
        [HttpGet] public IActionResult Create() => View(new PositionCreateVM());

        [HttpPost]
        [ValidateAntiForgeryToken]
        public IActionResult Create(PositionCreateVM vm)
        {
            vm.POST_TITLE = vm.POST_TITLE?.Trim();
            vm.POST_SCALE = vm.POST_SCALE?.Trim();
            vm.POST_REGION = vm.POST_REGION?.Trim();
            vm.POST_OCCUPANCY = vm.POST_OCCUPANCY?.Trim();
            vm.POST_STATUS = vm.POST_STATUS?.Trim();
            vm.LOCATION_DEPARTMENT = vm.LOCATION_DEPARTMENT?.Trim();
            vm.DISTRICT_SUB_DEPARTMENT = vm.DISTRICT_SUB_DEPARTMENT?.Trim();
            vm.TEHSIL_SECTION = vm.TEHSIL_SECTION?.Trim();

            using var con = new SqlConnection(_config.GetConnectionString("DefaultConnection")!);
            using var cmd = new SqlCommand(@"
                INSERT INTO tbl_Position
                (POST_TITLE, POST_SCALE, POST_REGION, POST_OCCUPANCY, POST_STATUS,
                 LOCATION_DEPARTMENT, DISTRICT_SUB_DEPARTMENT, TEHSIL_SECTION,
                 REPORTING_TO_POST_ID, EMPLOYEE_ID)
                VALUES
                (@POST_TITLE, @POST_SCALE, @POST_REGION, @POST_OCCUPANCY, @POST_STATUS,
                 @LOCATION_DEPARTMENT, @DISTRICT_SUB_DEPARTMENT, @TEHSIL_SECTION,
                 @REPORTING_TO_POST_ID, @EMPLOYEE_ID);", con);

            cmd.Parameters.AddWithValue("@POST_TITLE", (object?)vm.POST_TITLE ?? DBNull.Value);
            cmd.Parameters.AddWithValue("@POST_SCALE", (object?)vm.POST_SCALE ?? DBNull.Value);
            cmd.Parameters.AddWithValue("@POST_REGION", (object?)vm.POST_REGION ?? DBNull.Value);
            cmd.Parameters.AddWithValue("@POST_OCCUPANCY", (object?)vm.POST_OCCUPANCY ?? DBNull.Value);
            cmd.Parameters.AddWithValue("@POST_STATUS", (object?)vm.POST_STATUS ?? DBNull.Value);
            cmd.Parameters.AddWithValue("@LOCATION_DEPARTMENT", (object?)vm.LOCATION_DEPARTMENT ?? DBNull.Value);
            cmd.Parameters.AddWithValue("@DISTRICT_SUB_DEPARTMENT", (object?)vm.DISTRICT_SUB_DEPARTMENT ?? DBNull.Value);
            cmd.Parameters.AddWithValue("@TEHSIL_SECTION", (object?)vm.TEHSIL_SECTION ?? DBNull.Value);
            cmd.Parameters.Add("@REPORTING_TO_POST_ID", SqlDbType.Int).Value = (object?)vm.REPORTING_TO_POST_ID ?? DBNull.Value;
            cmd.Parameters.Add("@EMPLOYEE_ID", SqlDbType.Int).Value = (object?)vm.EMPLOYEE_ID ?? DBNull.Value;

            con.Open();
            cmd.ExecuteNonQuery();
            TempData["msg"] = "✅ Position saved to tbl_Position.";
            return RedirectToAction(nameof(Create));
        }

        // ================= Helpers =================

        /// <summary>
        /// Is SQL connection par SESSION_CONTEXT('user_cnic') set karta hai
        /// taa-ke history me USER_CNIC save ho sake.
        /// </summary>
        private void SetUserCnicOnThisSqlSession(SqlConnection con)
        {
            var cnic = HttpContext.Session.GetString("CNIC"); // may be null
            using var set = new SqlCommand(
                "EXEC sys.sp_set_session_context @key=N'user_cnic', @value=@v;", con);
            set.Parameters.AddWithValue("@v", (object?)cnic ?? DBNull.Value);
            set.ExecuteNonQuery();
        }

        /// <summary>
        /// Ek hi history-row insert karta hai (ASSIGN/UNASSIGN) — POST snapshot k saath.
        /// NOTE: Isay call karne se pehle SetUserCnicOnThisSqlSession(con) zaroor call ho.
        /// </summary>
        private void InsertHistory(SqlConnection con, int postId, string action)
        {
            using var log = new SqlCommand(@"
INSERT INTO dbo.tbl_Position_History
(POST_ID, POST_TITLE, POST_SCALE, POST_REGION, POST_OCCUPANCY, POST_STATUS,
 LOCATION_DEPARTMENT, DISTRICT_SUB_DEPARTMENT, TEHSIL_SECTION,
 REPORTING_TO_POST_ID, EMPLOYEE_ID, IDATE, LAST_UPDATE_DATE, USER_CNIC, HISTORY_DATE, ACTION)
SELECT p.POST_ID, p.POST_TITLE, p.POST_SCALE, p.POST_REGION, p.POST_OCCUPANCY, p.POST_STATUS,
       p.LOCATION_DEPARTMENT, p.DISTRICT_SUB_DEPARTMENT, p.TEHSIL_SECTION,
       p.REPORTING_TO_POST_ID, p.EMPLOYEE_ID, p.IDATE, p.LAST_UPDATE_DATE,
       TRY_CONVERT(BIGINT, SESSION_CONTEXT(N'user_cnic')), GETDATE(), @action
FROM dbo.tbl_Position p
WHERE p.POST_ID=@pid;", con);
            log.Parameters.AddWithValue("@pid", postId);
            log.Parameters.AddWithValue("@action", action);
            log.ExecuteNonQuery();
        }

        private IEnumerable<SelectListItem> Q(string sql, params SqlParameter[] ps)
        {
            var list = new List<SelectListItem>();
            using var con = new SqlConnection(_config.GetConnectionString("DefaultConnection")!);
            using var cmd = new SqlCommand(sql, con);
            if (ps?.Length > 0) cmd.Parameters.AddRange(ps);
            con.Open();
            using var r = cmd.ExecuteReader();
            while (r.Read())
            {
                var v = r.IsDBNull(0) ? null : Convert.ToString(r.GetValue(0));
                if (!string.IsNullOrWhiteSpace(v))
                    list.Add(new SelectListItem { Value = v!, Text = v! });
            }
            return list;
        }

        private void FillDropdowns(PositionSearchVM vm, string? region = null, string? location = null)
        {
            vm.Regions = Q(@"
                SELECT DISTINCT POST_REGION
                FROM tbl_Position
                WHERE POST_REGION IS NOT NULL
                ORDER BY POST_REGION");

            if (!string.IsNullOrWhiteSpace(region))
            {
                vm.Locations = Q(@"
                    SELECT DISTINCT LOCATION_DEPARTMENT
                    FROM tbl_Position
                    WHERE POST_REGION=@r AND LOCATION_DEPARTMENT IS NOT NULL
                    ORDER BY LOCATION_DEPARTMENT",
                    new SqlParameter("@r", region!));
            }
            else
            {
                vm.Locations = Array.Empty<SelectListItem>();
            }

            // sirf Active + Vacant titles
            var sql = @"
                SELECT DISTINCT POST_TITLE
                FROM tbl_Position
                WHERE POST_TITLE IS NOT NULL
                  AND (TRY_CONVERT(int, POST_STATUS)=1 OR UPPER(LTRIM(RTRIM(POST_STATUS)))='ACTIVE')
                  AND EMPLOYEE_ID IS NULL";
            var ps = new List<SqlParameter>();
            if (!string.IsNullOrWhiteSpace(region))
            {
                sql += " AND POST_REGION=@rg";
                ps.Add(new SqlParameter("@rg", region!));
            }
            if (!string.IsNullOrWhiteSpace(location))
            {
                sql += " AND LOCATION_DEPARTMENT=@lc";
                ps.Add(new SqlParameter("@lc", location!));
            }
            sql += " ORDER BY POST_TITLE";
            vm.PostTitles = Q(sql, ps.ToArray());
        }

        // Active employee brief: Name + Designation + Status text
        private (string? name, string? desg, string? statusText) GetEmployeeBriefInternal(int id)
        {
            using var con = new SqlConnection(_config.GetConnectionString("DefaultConnection")!);
            using var cmd = new SqlCommand(@"
                SELECT TOP 1 e.NAME,
                       d.DesignationName,
                       CASE WHEN e.STATUS = 1 THEN 'Active' ELSE 'Inactive' END AS EmpStatus
                FROM tbl_Employee e
                LEFT JOIN lib_designation d ON d.DesignationID = e.DESIGNATION
                WHERE e.EMPLOYEE_ID=@id;", con);
            cmd.Parameters.AddWithValue("@id", id);
            con.Open();
            using var r = cmd.ExecuteReader();
            if (!r.Read()) return (null, null, null);
            var name = r.IsDBNull(0) ? null : r.GetString(0);
            var desg = r.IsDBNull(1) ? null : r.GetString(1);
            var status = r.IsDBNull(2) ? null : r.GetString(2);
            return (name, desg, status);
        }

        // ============== AJAX ==============
        [HttpGet]
        public JsonResult GetLocationsByRegion(string region)
        {
            var list = new List<string>();
            using var con = new SqlConnection(_config.GetConnectionString("DefaultConnection")!);
            using var cmd = new SqlCommand(@"
                SELECT DISTINCT LOCATION_DEPARTMENT
                FROM tbl_Position
                WHERE POST_REGION=@r AND LOCATION_DEPARTMENT IS NOT NULL
                ORDER BY LOCATION_DEPARTMENT;", con);
            cmd.Parameters.AddWithValue("@r", region ?? (object)DBNull.Value);
            con.Open();
            using var r = cmd.ExecuteReader();
            while (r.Read()) if (!r.IsDBNull(0)) list.Add(r.GetString(0));
            return Json(list);
        }

        [HttpGet]
        public JsonResult GetVacantPostTitles(string region, string location)
        {
            var list = new List<string>();
            using var con = new SqlConnection(_config.GetConnectionString("DefaultConnection")!);
            using var cmd = new SqlCommand(@"
                SELECT DISTINCT POST_TITLE
                FROM tbl_Position
                WHERE (TRY_CONVERT(int, POST_STATUS)=1 OR UPPER(LTRIM(RTRIM(POST_STATUS)))='ACTIVE')
                  AND EMPLOYEE_ID IS NULL
                  AND (@rg='' OR POST_REGION=@rg)
                  AND (@lc='' OR LOCATION_DEPARTMENT=@lc)
                ORDER BY POST_TITLE;", con);
            cmd.Parameters.AddWithValue("@rg", region ?? "");
            cmd.Parameters.AddWithValue("@lc", location ?? "");
            con.Open();
            using var r = cmd.ExecuteReader();
            while (r.Read()) if (!r.IsDBNull(0)) list.Add(r.GetString(0));
            return Json(list);
        }

        // AJAX: EmployeeId -> Name + Designation + Status (+ already assigned msg)
        [HttpGet]
        public JsonResult GetEmployeeBrief(int id)
        {
            var (name, desg, statusText) = GetEmployeeBriefInternal(id);

            if (string.IsNullOrWhiteSpace(name))
                return Json(new { ok = false });   // Not found

            string whereText = "";
            bool isAssigned = false;

            using (var con = new SqlConnection(_config.GetConnectionString("DefaultConnection")!))
            using (var cmd = new SqlCommand(@"
                SELECT TOP 1 POST_TITLE, POST_REGION, LOCATION_DEPARTMENT
                FROM tbl_Position
                WHERE EMPLOYEE_ID = @id;", con))
            {
                cmd.Parameters.AddWithValue("@id", id);
                con.Open();
                using var r = cmd.ExecuteReader();
                if (r.Read())
                {
                    var t = r.IsDBNull(0) ? "-" : r.GetString(0);
                    var rg = r.IsDBNull(1) ? "-" : r.GetString(1);
                    var lc = r.IsDBNull(2) ? "-" : r.GetString(2);

                    whereText = $"REGION: {rg}, LOCATION: {lc}, POST TITLE: {t}";
                    isAssigned = true;
                }
            }

            return Json(new
            {
                ok = true,
                name = name ?? "",
                designation = desg ?? "",
                status = statusText ?? "",
                assigned = isAssigned,
                where = whereText
            });
        }

        // ============== SEARCH (same page) ==============
        [HttpGet]
        public IActionResult Search(string? selectedRegion = null,
                                    string? selectedLocation = null,
                                    string? selectedPostTitle = null,
                                    int? employeeId = null)
        {
            var vm = new PositionSearchVM
            {
                SelectedRegion = selectedRegion,
                SelectedLocation = selectedLocation,
                SelectedPostTitle = selectedPostTitle,
                EmployeeId = employeeId
            };

            if (employeeId.HasValue)
            {
                var (nm, dg, st) = GetEmployeeBriefInternal(employeeId.Value);
                vm.EmployeeName = nm;
                vm.Designation = dg;
                vm.EmpStatusText = st;
            }

            FillDropdowns(vm, vm.SelectedRegion, vm.SelectedLocation);
            return View(vm);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public IActionResult Search(PositionSearchVM vm)
        {
            if (vm.EmployeeId.HasValue)
            {
                var (nm, dg, st) = GetEmployeeBriefInternal(vm.EmployeeId.Value);
                vm.EmployeeName = nm;
                vm.Designation = dg;
                vm.EmpStatusText = st;
            }

            var sql = @"
                SELECT POST_ID, POST_TITLE, POST_REGION, LOCATION_DEPARTMENT,
                       POST_SCALE, POST_STATUS, EMPLOYEE_ID, IDATE, LAST_UPDATE_DATE
                FROM tbl_Position
                WHERE (TRY_CONVERT(int, POST_STATUS)=1 OR UPPER(LTRIM(RTRIM(POST_STATUS)))='ACTIVE')
                  AND EMPLOYEE_ID IS NULL";
            var ps = new List<SqlParameter>();

            if (!string.IsNullOrWhiteSpace(vm.SelectedRegion))
            {
                sql += " AND POST_REGION=@rg";
                ps.Add(new SqlParameter("@rg", vm.SelectedRegion!));
            }
            if (!string.IsNullOrWhiteSpace(vm.SelectedLocation))
            {
                sql += " AND LOCATION_DEPARTMENT=@lc";
                ps.Add(new SqlParameter("@lc", vm.SelectedLocation!));
            }
            if (!string.IsNullOrWhiteSpace(vm.SelectedPostTitle))
            {
                sql += " AND POST_TITLE=@pt";
                ps.Add(new SqlParameter("@pt", vm.SelectedPostTitle!));
            }

            sql += " ORDER BY POST_REGION, LOCATION_DEPARTMENT, POST_TITLE";

            using var con = new SqlConnection(_config.GetConnectionString("DefaultConnection")!);
            using var cmd = new SqlCommand(sql, con);
            if (ps.Count > 0) cmd.Parameters.AddRange(ps.ToArray());

            con.Open();
            using var r = cmd.ExecuteReader();
            vm.Results.Clear();
            while (r.Read())
            {
                vm.Results.Add(new PositionRow
                {
                    POST_ID = r.GetInt32(0),
                    POST_TITLE = r.IsDBNull(1) ? null : r.GetString(1),
                    POST_REGION = r.IsDBNull(2) ? null : r.GetString(2),
                    LOCATION_DEPARTMENT = r.IsDBNull(3) ? null : r.GetString(3),
                    POST_SCALE = r.IsDBNull(4) ? null : r.GetString(4),
                    POST_STATUS = r.IsDBNull(5) ? null : r.GetString(5),
                    EMPLOYEE_ID = r.IsDBNull(6) ? (int?)null : r.GetInt32(6),
                    IDATE = r.IsDBNull(7) ? DateTime.MinValue : r.GetDateTime(7),
                    LAST_UPDATE_DATE = r.IsDBNull(8) ? (DateTime?)null : r.GetDateTime(8)
                });
            }

            vm.Message = vm.Results.Count == 0 ? "No vacant post found." : $"{vm.Results.Count} record(s) found.";
            FillDropdowns(vm, vm.SelectedRegion, vm.SelectedLocation);
            return View(vm);
        }

        // ============== ASSIGN (guards + single history row) ==============
        [HttpPost]
        [ValidateAntiForgeryToken]
        public IActionResult AssignToPost(
            int postId,
            int employeeId,
            int? searchedEmployeeId,
            string? selectedRegion,
            string? selectedLocation,
            string? selectedPostTitle)
        {
            // (0) Emp ID mismatch guard
            if (searchedEmployeeId.HasValue && searchedEmployeeId.Value != employeeId)
            {
                TempData["msg"] =
                    $"❌ Mismatch: you searched Employee #{searchedEmployeeId.Value} but entered #{employeeId} in the row.";
                return RedirectToAction(nameof(Search), new
                {
                    selectedRegion,
                    selectedLocation,
                    selectedPostTitle,
                    employeeId = searchedEmployeeId
                });
            }

            using var con = new SqlConnection(_config.GetConnectionString("DefaultConnection")!);
            con.Open();

            // Set session user CNIC once for this SQL connection
            SetUserCnicOnThisSqlSession(con);

            // (1) Employee must be ACTIVE
            using (var chkEmp = new SqlCommand(
                "SELECT COUNT(*) FROM tbl_Employee WHERE EMPLOYEE_ID=@eid AND STATUS=1;", con))
            {
                chkEmp.Parameters.AddWithValue("@eid", employeeId);
                if ((int)chkEmp.ExecuteScalar() == 0)
                {
                    TempData["msg"] = "❌ Employee is not active.";
                    return RedirectToAction(nameof(Search));
                }
            }

            // (2) Already assigned somewhere?
            using (var already = new SqlCommand(@"
                SELECT TOP 1 POST_TITLE, POST_REGION, LOCATION_DEPARTMENT
                FROM tbl_Position
                WHERE EMPLOYEE_ID=@eid;", con))
            {
                already.Parameters.AddWithValue("@eid", employeeId);
                using var rr = already.ExecuteReader();
                if (rr.Read())
                {
                    var t = rr.IsDBNull(0) ? "-" : rr.GetString(0);
                    var rg = rr.IsDBNull(1) ? "-" : rr.GetString(1);
                    var lc = rr.IsDBNull(2) ? "-" : rr.GetString(2);
                    TempData["msg"] = $"❌ Already assigned → REGION: {rg}, LOCATION: {lc}, POST TITLE: {t}.";
                    return RedirectToAction(nameof(Search));
                }
            }

            // (3) Target post must be ACTIVE & VACANT
            using (var chkPost = new SqlCommand(@"
                SELECT COUNT(*) FROM tbl_Position 
                WHERE POST_ID=@id 
                  AND (TRY_CONVERT(int, POST_STATUS)=1 OR UPPER(LTRIM(RTRIM(POST_STATUS)))='ACTIVE')
                  AND EMPLOYEE_ID IS NULL;", con))
            {
                chkPost.Parameters.AddWithValue("@id", postId);
                if ((int)chkPost.ExecuteScalar() == 0)
                {
                    TempData["msg"] = "❌ Post is not vacant or inactive.";
                    return RedirectToAction(nameof(Search));
                }
            }

            // (4) Assign
            using (var upd = new SqlCommand(
                "UPDATE tbl_Position SET EMPLOYEE_ID=@emp WHERE POST_ID=@id;", con))
            {
                upd.Parameters.AddWithValue("@emp", employeeId);
                upd.Parameters.AddWithValue("@id", postId);
                upd.ExecuteNonQuery();
            }

            // (5) Single history row → ASSIGN
            InsertHistory(con, postId, "ASSIGN");

            TempData["msg"] = $"✅ Assigned post #{postId} to employee #{employeeId}.";
            return RedirectToAction(nameof(Search)); // fresh reset
        }

        // ================= UNASSIGN PAGE =================

        [HttpGet]
        public IActionResult Unassign(int? employeeId = null)
        {
            var vm = new PositionUnassignVM { EmployeeId = employeeId };

            if (employeeId.HasValue)
            {
                using var con = new SqlConnection(_config.GetConnectionString("DefaultConnection")!);
                using var cmd = new SqlCommand(@"
            SELECT TOP 1 
                e.NAME,
                d.DesignationName,
                CASE WHEN e.STATUS = 1 THEN 'Active' ELSE 'Inactive' END
            FROM tbl_Employee e
            LEFT JOIN lib_designation d ON d.DesignationID = e.DESIGNATION
            WHERE e.EMPLOYEE_ID=@id;", con);
                cmd.Parameters.AddWithValue("@id", employeeId.Value);
                con.Open();

                using var r = cmd.ExecuteReader();
                if (r.Read())
                {
                    vm.EmployeeName = r.IsDBNull(0) ? null : r.GetString(0);
                    vm.Designation = r.IsDBNull(1) ? null : r.GetString(1);
                    vm.EmpStatusText = r.IsDBNull(2) ? null : r.GetString(2);
                }
                else
                {
                    vm.Message = "❌ Employee ID not found.";
                }
            }

            return View(vm);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public IActionResult Unassign(PositionUnassignVM vm)
        {
            if (vm.EmployeeId.HasValue)
            {
                // brief
                using (var con = new SqlConnection(_config.GetConnectionString("DefaultConnection")!))
                using (var cmd = new SqlCommand(@"
            SELECT TOP 1 
                e.NAME,
                d.DesignationName,
                CASE WHEN e.STATUS = 1 THEN 'Active' ELSE 'Inactive' END
            FROM tbl_Employee e
            LEFT JOIN lib_designation d ON d.DesignationID = e.DESIGNATION
            WHERE e.EMPLOYEE_ID=@id;", con))
                {
                    cmd.Parameters.AddWithValue("@id", vm.EmployeeId.Value);
                    con.Open();
                    using var r = cmd.ExecuteReader();
                    if (r.Read())
                    {
                        vm.EmployeeName = r.IsDBNull(0) ? null : r.GetString(0);
                        vm.Designation = r.IsDBNull(1) ? null : r.GetString(1);
                        vm.EmpStatusText = r.IsDBNull(2) ? null : r.GetString(2);
                    }
                    else
                    {
                        vm.Message = "❌ Employee ID not found.";
                        return View(vm);
                    }
                }

                // grid
                using (var con = new SqlConnection(_config.GetConnectionString("DefaultConnection")!))
                using (var cmd = new SqlCommand(@"
            SELECT POST_ID, POST_TITLE, POST_REGION, LOCATION_DEPARTMENT,
                   POST_SCALE, POST_STATUS, EMPLOYEE_ID, IDATE, LAST_UPDATE_DATE
            FROM tbl_Position
            WHERE EMPLOYEE_ID=@eid
            ORDER BY POST_REGION, LOCATION_DEPARTMENT, POST_TITLE;", con))
                {
                    cmd.Parameters.AddWithValue("@eid", vm.EmployeeId.Value);
                    con.Open();
                    using var r = cmd.ExecuteReader();
                    vm.Results.Clear();
                    while (r.Read())
                    {
                        vm.Results.Add(new PositionRow
                        {
                            POST_ID = r.GetInt32(0),
                            POST_TITLE = r.IsDBNull(1) ? null : r.GetString(1),
                            POST_REGION = r.IsDBNull(2) ? null : r.GetString(2),
                            LOCATION_DEPARTMENT = r.IsDBNull(3) ? null : r.GetString(3),
                            POST_SCALE = r.IsDBNull(4) ? null : r.GetString(4),
                            POST_STATUS = r.IsDBNull(5) ? null : r.GetString(5),
                            EMPLOYEE_ID = r.IsDBNull(6) ? (int?)null : r.GetInt32(6),
                            IDATE = r.IsDBNull(7) ? DateTime.MinValue : r.GetDateTime(7),
                            LAST_UPDATE_DATE = r.IsDBNull(8) ? (DateTime?)null : r.GetDateTime(8)
                        });
                    }
                }

                vm.Message = vm.Results.Count == 0
                    ? "ℹ No post is currently assigned to this employee."
                    : $"{vm.Results.Count} post(s) assigned to this employee.";
            }
            else
            {
                vm.Message = "Please enter Employee ID.";
            }

            return View(vm);
        }

        // ============== UNASSIGN (single history row) ==============
        [HttpPost]
        [ValidateAntiForgeryToken]
        public IActionResult UnassignPost(int postId, int employeeId)
        {
            using var con = new SqlConnection(_config.GetConnectionString("DefaultConnection")!);
            con.Open();

            // session CNIC set once
            SetUserCnicOnThisSqlSession(con);

            // ensure mapping matches, then unassign
            int rows;
            using (var upd = new SqlCommand(@"
        UPDATE tbl_Position
        SET EMPLOYEE_ID = NULL
        WHERE POST_ID = @pid AND EMPLOYEE_ID = @eid;", con))
            {
                upd.Parameters.AddWithValue("@pid", postId);
                upd.Parameters.AddWithValue("@eid", employeeId);
                rows = upd.ExecuteNonQuery();
            }

            if (rows == 0)
            {
                TempData["msg"] = "❌ No change: Either the post is already vacant or assigned to another employee.";
            }
            else
            {
                // single history row → UNASSIGN
                InsertHistory(con, postId, "UNASSIGN");
                TempData["msg"] = $"✅ Post #{postId} unassigned from Employee #{employeeId}.";
            }

            return RedirectToAction(nameof(Unassign), new { employeeId });
        }
    }
}