using System;
using System.Collections.Generic;

namespace BISP_hrmsDashboard.Models
{
    // NOTE: PositionRow aapke project me pehle se use ho raha hai.
    // Yahi class list ke liye reuse ho rahi hai (Results).
    // Agar PositionRow aapke project me already exist hai to yahan dobara NA banayein.

    public class PositionUnassignVM
    {
        public int? EmployeeId { get; set; }
        public string? EmployeeName { get; set; }
        public string? Designation { get; set; }
        public string? EmpStatusText { get; set; }

        public List<PositionRow> Results { get; set; } = new();
        public string? Message { get; set; }
    }
}