using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace WebsiteHoaTuoi1080.Controllers
{
    public class AdminController : Controller
    {
        //
        // GET: /Admin/
        private bool checkLogin()
        {
            if (Session["admin"] != null)
                return true;
            return false;
        }
        public ActionResult Index()
        {
            if (checkLogin())
                return View();
            else return RedirectToAction("Login", "Account");
        }

        public ActionResult QuanLyDanhMuc()
        {
            if (checkLogin())
                return View();
            else return RedirectToAction("Login", "Account");
        }
    }
}