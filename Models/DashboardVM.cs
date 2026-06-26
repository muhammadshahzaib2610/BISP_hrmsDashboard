namespace BISP_hrmsDashboard.Models
{
    public class DashboardVM
    {
        // Employee counts
        public int EmpTotal { get; set; }
        public int EmpActive { get; set; }
        public int EmpInactive { get; set; }

        // Position counts
        public int PosTotal { get; set; }
        public int PosFilled { get; set; }
        public int PosVacant { get; set; }
    }
}