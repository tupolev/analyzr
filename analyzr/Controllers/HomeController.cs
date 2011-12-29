﻿using System;
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
            return RedirectToAction("counter", "home");
        }

        [HttpGet]
        public ActionResult counter()
        {
            ViewData["output_generated"] = false;
            analyzr.Models.CounterModel m = new analyzr.Models.CounterModel();
            return View(m);
        }

        [HttpPost]
        public ActionResult counter(analyzr.Models.CounterModel m) {
            m.doMaths();
            System.Diagnostics.Trace.WriteLine(m.countedLines);
            ViewData["output_generated"]= true;
            return View(m);
        }

        [HttpPost]
        public ActionResult counter_backend(analyzr.Models.CounterModel m)
        {
            m.doMaths();
            System.Diagnostics.Trace.WriteLine(m.countedLines);
            ViewData["output_generated"] = true;
            return Json(m);
        }   
    }
}
