using System.Diagnostics;
using BISP_hrmsDashboard.Models;
using Microsoft.AspNetCore.Mvc;

namespace BISP_hrmsDashboard.Controllers
{
    public class HomeController : Controller
    {
        private readonly ILogger<HomeController> _logger;

        public HomeController(ILogger<HomeController> logger)
        {
            _logger = logger;
        }

        public IActionResult Index(int? employeeId)
        {
            if (employeeId.HasValue)
            {
                ViewBag.NewEmployeeId = employeeId.Value;
            }
            return View();
        }

        public IActionResult Privacy()
        {
            return View();
        }

        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }





    }
}
