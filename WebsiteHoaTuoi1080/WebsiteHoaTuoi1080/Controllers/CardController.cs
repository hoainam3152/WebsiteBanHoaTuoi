using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using WebsiteHoaTuoi1080.Models;

namespace WebsiteHoaTuoi1080.Controllers
{
    public class CardController : Controller
    {
        //
        // GET: /Card/
        private CUSTOMER checkAccount()
        {
            CUSTOMER ctm = new CUSTOMER();
            if (Session["user"] != null)
                ctm = Session["user"] as CUSTOMER;
            return ctm;
        }

        private Card layDuLieuGioHang()
        {
            Card card = Session["Card"] as Card;
            CUSTOMER ctm = Session["user"] as CUSTOMER;
            if (card == null || Session["Card"] == null)
            {
                card = new Card();
                Session["Card"] = card;
            }
            return card;
        }

        public ActionResult Index()
        {
            CUSTOMER ctm = checkAccount();
            List<Card> listCard = new List<Card>();
            if (ctm != null)
            {
                listCard = layDuLieuGioHang().getData(ctm.CustomerID);
                ViewBag.TotalPrice = layDuLieuGioHang().sumTotalPrice(ctm.CustomerID);
            }
            return View(listCard);
        }

        public ActionResult ThemVaoGioHang(int maSP, int soLuongMua)
        {
            if (Session["user"] != null)
            {
                CUSTOMER ctm = Session["user"] as CUSTOMER;

                layDuLieuGioHang().addItemCard(ctm.CustomerID, maSP, soLuongMua);
            }
            return RedirectToAction("Index");
        }

        [HttpPost]
        public ActionResult ThemVaoGioHang(int maSP, int soLuongMua, string strUrl, string str)
        {
            if (Session["user"] != null)
            {
                CUSTOMER ctm = Session["user"] as CUSTOMER;

                layDuLieuGioHang().addItemCard(ctm.CustomerID, maSP, soLuongMua);
                return Redirect(strUrl);
            }
            return RedirectToAction("Login", "Account");
        }

        public ActionResult xoaSanPhamGioHang(int maSP)
        {
            if (Session["user"] != null)
            {
                CUSTOMER ctm = Session["user"] as CUSTOMER;

                layDuLieuGioHang().removeItemCard(ctm.CustomerID, maSP);
                return RedirectToAction("Index");
            }
            return RedirectToAction("Index");
        }

        public ActionResult tangSoLuong(int maSP)
        {
            if (Session["user"] != null)
            {
                CUSTOMER ctm = Session["user"] as CUSTOMER;

                layDuLieuGioHang().increasingTheNumber(ctm.CustomerID, maSP);
                return RedirectToAction("Index");
            }
            return RedirectToAction("Index");
        }

        public ActionResult giamSoLuong(int maSP)
        {
            if (Session["user"] != null)
            {
                CUSTOMER ctm = Session["user"] as CUSTOMER;

                layDuLieuGioHang().decreasingTheNumber(ctm.CustomerID, maSP);
                return RedirectToAction("Index");
            }
            return RedirectToAction("Index");
        }

        [HttpPost]
        public ActionResult xacNhanHoaDon(Receiver_sInformation ri)
        {
            if (Session["user"] != null)
            {
                CUSTOMER ctm = Session["user"] as CUSTOMER;

                layDuLieuGioHang().confirmOrdererd(ctm.CustomerID, ri);
                return RedirectToAction("Index");
            }
            return RedirectToAction("Index");
        }
    }
}
