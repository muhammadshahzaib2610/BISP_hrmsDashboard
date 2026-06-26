using System.ComponentModel.DataAnnotations;

namespace BISP_hrmsDashboard.Models
{
    public class LoginViewModel
    {
        [Required(ErrorMessage = "CNIC required")]
        [StringLength(13, MinimumLength = 13, ErrorMessage = "CNIC 13 digits ka hona chahiye")]
        [RegularExpression(@"^\d{13}$", ErrorMessage = "Sirf digits allow hain")]
        public string CNIC { get; set; } = string.Empty;   // init to avoid null

        [Required(ErrorMessage = "Password required")]
        public string Password { get; set; } = string.Empty; // init to avoid null
    }
}
