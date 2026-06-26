using System;

namespace BISP_hrmsDashboard.Models
{
    public class PositionCreateVM
    {
        // All fields nullable by your table design
        public string? POST_TITLE { get; set; }
        public string? POST_SCALE { get; set; }
        public string? POST_REGION { get; set; }
        public string? POST_OCCUPANCY { get; set; }
        public string? POST_STATUS { get; set; }
        public string? LOCATION_DEPARTMENT { get; set; }
        public string? DISTRICT_SUB_DEPARTMENT { get; set; }
        public string? TEHSIL_SECTION { get; set; }

        public int? REPORTING_TO_POST_ID { get; set; }
        public int? EMPLOYEE_ID { get; set; }
    }
}