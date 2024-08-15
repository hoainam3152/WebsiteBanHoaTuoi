using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using WebsiteHoaTuoi1080.Models;
using System.Web.Security;

namespace WebsiteHoaTuoi1080.Controllers
{
    public class AccountController : Controller
    {
        //
        // GET: /Account/
        FlowerStoreEntities db = new FlowerStoreEntities();
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult Login()
        {
            return View();
        }

        [HttpPost]
        public ActionResult Login(string userName, string password)
        {
            Login tk = new Login().checkAccount(userName, password);
            if (tk != null)
            {
                if (tk.Roles == "admin")
                {
                    //Session["admin"] = "admin";
                    Session["admin"] = db.EMPLOYEES.FirstOrDefault(f => f.UserId == tk.UserId);
                    return RedirectToAction("Index", "Admin");
                }
                else
                {
                    Session["user"] = db.CUSTOMERs.FirstOrDefault(f => f.UserId == tk.UserId);
                    return RedirectToAction("Index", "Home");
                }
            }
            ModelState.AddModelError("myError", "Tài khoản hoặc mật khẩu không khả dụng");
            return View();
        }

        public ActionResult Logout()
        {
            Session.Remove("user");
            FormsAuthentication.SignOut();
            return RedirectToAction("Index","Home");
        }

        public ActionResult Register()
        {
            Register r = new Register();
            return View(r);
        }

        [HttpPost]
        public ActionResult Register(Register rgt)
        {
            Register r = new Register();
            int check = r.checkAccount(rgt);
            if (check == 0)
            {
                ViewBag.TrungSDT = 1;
                ViewBag.TrungEmail = 0;
            }
            else if (check == 1)
            {
                return Login(rgt.Phone, rgt.Password);
            }
            else
            {
                ViewBag.TrungSDT = 0;
                ViewBag.TrungEmail = 1;
            }
            return View(rgt);
        }
    }
}
