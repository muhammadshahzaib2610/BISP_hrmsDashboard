using System;
using System.Collections.Generic;
using Microsoft.AspNetCore.Mvc.Rendering;

namespace BISP_hrmsDashboard.Models
{
    public class PositionRow
    {
        public int POST_ID { get; set; }
        public string? POST_TITLE { get; set; }
        public string? POST_REGION { get; set; }
        public string? LOCATION_DEPARTMENT { get; set; }
        public string? POST_SCALE { get; set; }
        public string? POST_STATUS { get; set; }   // for display only
        public int? EMPLOYEE_ID { get; set; }
        public DateTime IDATE { get; set; }
        public DateTime? LAST_UPDATE_DATE { get; set; }
    }

    public class PositionSearchVM
    {
        // filters (cascade)
        public string? SelectedRegion { get; set; }
        public string? SelectedLocation { get; set; }
        public string? SelectedPostTitle { get; set; }

        // dropdown data
        public IEnumerable<SelectListItem> Regions { get; set; } = Array.Empty<SelectListItem>();
        public IEnumerable<SelectListItem> Locations { get; set; } = Array.Empty<SelectListItem>();
        public IEnumerable<SelectListItem> PostTitles { get; set; } = Array.Empty<SelectListItem>();

        // employee brief
        public int? EmployeeId { get; set; }
        public string? EmployeeName { get; set; }
        public string? Designation { get; set; }
        public string? EmpStatusText { get; set; }  // "Active"/"Inactive"

        // grid
        public List<PositionRow> Results { get; set; } = new();
        public string? Message { get; set; }
    }
}