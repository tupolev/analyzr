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
        [AcceptVerbs(HttpVerbs.Post)]
        public ActionResult counter(analyzr.Models.CounterModel m, HttpPostedFileBase uploadFile)
        {
            
            if (m.inputText==null)
            {
                if (uploadFile != null && (uploadFile.ContentLength > 0))
                {
                    string filePath = System.IO.Path.Combine(HttpContext.Server.MapPath("../Uploads"),
                                                   System.IO.Path.GetFileName(uploadFile.FileName));
                    uploadFile.SaveAs(filePath);
                    DocX doc = null;
                    try
                    {
                        doc = DocX.Load(uploadFile.InputStream);

                        m.inputText = doc.Text.ToString();
                        ViewData["file_text"] = doc.Text.ToString();
                        m.doMaths();

                        ViewData["output_generated"] = true;
                        doc.Dispose();
                    }
                    catch (Exception ex)
                    {
                        ModelState.AddModelError("Uploaded file is not valid. Only docx format is supported.", ex);
                    }
                    finally {
                        if (System.IO.File.Exists(filePath)) System.IO.File.Delete(filePath);
                    }
                }
                else
                {
                    ModelState.AddModelError("You must either upload a file or enter an input text", new Exception());
                }
            }
            else 
            {
                m.doMaths();
                ViewData["output_generated"] = true;
            }
            return View(m);
        }
    }
}
