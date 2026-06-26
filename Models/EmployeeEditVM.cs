using System;
using System.Collections.Generic;
using Microsoft.AspNetCore.Mvc.Rendering;

namespace BISP_hrmsDashboard.Models
{
    public class EmployeeEditVM
    {
        public int EMPLOYEE_ID { get; set; }
        public string CNIC { get; set; } = "";   // DB BIGINT -> UI string

        public string? NAME { get; set; }
        public string? FATHER_NAME { get; set; }
        public int? GENDER { get; set; }
        public DateTime? DOB { get; set; }
        public int? MARITAL_STATUS { get; set; }
        public int? CHILDREN { get; set; }
        public int? RELIGION { get; set; }
        public int? RELIGION_CAST { get; set; }
        public int? SCALE { get; set; }
        public int? DESIGNATION { get; set; }

        public int? EDUCATION { get; set; }

        public int? STATUS { get; set; }

        public int? PARENT_OFFICE { get; set; }
        public int? DOMICILE_PROVINCE { get; set; }
        public int? DOMICILE_DISTRICT { get; set; }
        public int? C_PROVINCE { get; set; }
        public int? C_DISTRICT { get; set; }
        public int? C_TEHSIL { get; set; }
        public string? C_ADDRESS { get; set; }
        public int? P_PROVINCE { get; set; }
        public int? P_DISTRICT { get; set; }
        public int? P_TEHSIL { get; set; }
        public string? P_ADDRESS { get; set; }
        public string? LANDLINE { get; set; }
        public string? MOBILE { get; set; }
        public string? REF_FILE_NO { get; set; }
        public DateTime? JOINING_DATE { get; set; }
        public string? CONTRACT_DURATION { get; set; }
        public DateTime? CONTRACT_EXPIRY_DATE { get; set; }
        public DateTime? RENEWAL_DATE { get; set; }
        public DateTime? REPORT_DATE { get; set; }
        public DateTime? EXT_UPTO_DATE { get; set; }
        public string? EMAIL { get; set; }
        public string? REMARKS { get; set; }
        public string? PAYROLL_ID { get; set; }

        // dropdowns
        public IEnumerable<SelectListItem> Genders { get; set; } = Array.Empty<SelectListItem>();
        public IEnumerable<SelectListItem> MaritalStatuses { get; set; } = Array.Empty<SelectListItem>();
        public IEnumerable<SelectListItem> Religions { get; set; } = Array.Empty<SelectListItem>();
        public IEnumerable<SelectListItem> DomicileProvinces { get; set; } = Array.Empty<SelectListItem>();
        public IEnumerable<SelectListItem> DomicileDistricts { get; set; } = Array.Empty<SelectListItem>();
        public IEnumerable<SelectListItem> Scales { get; set; } = Array.Empty<SelectListItem>();
        public IEnumerable<SelectListItem> Designations { get; set; } = Array.Empty<SelectListItem>();
        public IEnumerable<SelectListItem> Status { get; set; } = Array.Empty<SelectListItem>();
        public IEnumerable<SelectListItem> ParentOffice { get; set; } = Array.Empty<SelectListItem>();
        public IEnumerable<SelectListItem> Education { get; set; } = Array.Empty<SelectListItem>();
        public IEnumerable<SelectListItem> Casts { get; set; } = Array.Empty<SelectListItem>();
        public IEnumerable<SelectListItem> CProvinces { get; set; } = Array.Empty<SelectListItem>();
        public IEnumerable<SelectListItem> CDistricts { get; set; } = Array.Empty<SelectListItem>();
        public IEnumerable<SelectListItem> CTehsils { get; set; } = Array.Empty<SelectListItem>();
        public IEnumerable<SelectListItem> PProvinces { get; set; } = Array.Empty<SelectListItem>();
        public IEnumerable<SelectListItem> PDistricts { get; set; } = Array.Empty<SelectListItem>();
        public IEnumerable<SelectListItem> PTehsils { get; set; } = Array.Empty<SelectListItem>();

    }
}