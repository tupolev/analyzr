using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace analyzr.Controllers
{
    [HandleError]
    public class HomeController : Controller
    {
        public ActionResult Index()
        {
            return RedirectToAction("Counter", "Home");
        }

        public ActionResult About()
        {
            return RedirectToAction("Counter", "Home");
        }

        [HttpGet]
        public ActionResult Counter()
        {
            
            analyzr.Models.CounterModel m = new analyzr.Models.CounterModel();
            return View(m);
        }

        [HttpPost]
        public ActionResult Counter(analyzr.Models.CounterModel m) {
            m.doMaths();
            ViewData["totalPriceUsingLinesByCRLF"] = m.totalPriceUsingLinesByCRLF;
            ViewData["totalPriceUsingLines"] = m.totalPriceUsingLines;
            ViewData["totalPriceUsingWords"] = m.totalPriceUsingWords;
            ViewData["countedLinesByCRLF"] = m.countedLinesByCRLF;
            ViewData["countedLines"] = m.countedLines;
            ViewData["countedWords"] = m.countedWords;
            System.Diagnostics.Trace.WriteLine(m.countedLines);
            return View(m);
        }
    }
}
