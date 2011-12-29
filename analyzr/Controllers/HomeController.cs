using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Novacode;

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
            ViewData["output_generated"] = true;
            return View(m);
        }

        [HttpPost]
        [AcceptVerbs(HttpVerbs.Post)]
        public ActionResult counter_backend(analyzr.Models.CounterModel m, HttpPostedFileBase uploadFile)
        {
            if (uploadFile != null && (uploadFile.ContentLength > 0))
            {
                string filePath = System.IO.Path.Combine(HttpContext.Server.MapPath("../Uploads"),
                                               System.IO.Path.GetFileName(uploadFile.FileName));
                uploadFile.SaveAs(filePath);
                DocX doc = DocX.Load(uploadFile.InputStream);
                m.inputText = doc.Text.ToString();
            }
            m.doMaths();
            ViewData["output_generated"] = true;
            return Json(m);
        }
    }
}
