using System.Collections.Generic;

namespace BISP_hrmsDashboard.Models
{
    public class EmployeeRow
    {
        public int EMPLOYEE_ID { get; set; }
        public string CNIC { get; set; } = "";
        public string NAME { get; set; } = "";
        public string DesignationName { get; set; } = "";
        public string ParentOffice { get; set; } = "";
        public string Status { get; set; } = "";
    }

    public class EmployeeSearchVM
    {
        // "EmpId" | "Cnic"
        public string SearchBy { get; set; } = "EmpId";
        // user ki single input text
        public string? QueryText { get; set; }

        public List<EmployeeRow> Results { get; set; } = new();
        public string? Message { get; set; }
    }
}