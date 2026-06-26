using System;
using System.Collections.Generic;
using Microsoft.AspNetCore.Mvc.Rendering;

namespace BISP_hrmsDashboard.Models
{
    public class PositionAssignVM
    {
        // Filters
        public string? SelectedRegion { get; set; }
        public string? SelectedLocation { get; set; }
        public string? SelectedPostTitle { get; set; }

        // Dropdowns
        public IEnumerable<SelectListItem> Regions { get; set; } = new List<SelectListItem>();
        public IEnumerable<SelectListItem> Locations { get; set; } = new List<SelectListItem>();
        public IEnumerable<SelectListItem> PostTitles { get; set; } = new List<SelectListItem>();

        // Employee lookup
        public int? EmployeeId { get; set; }
        public string? EmployeeName { get; set; }

        // Grid
        public List<PositionRow> Results { get; set; } = new List<PositionRow>();
        public string? Message { get; set; }
    }
    
}