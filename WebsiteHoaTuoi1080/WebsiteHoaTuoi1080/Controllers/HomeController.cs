using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using WebsiteHoaTuoi1080.Models;

namespace WebsiteHoaTuoi1080.Controllers
{
    public class HomeController : Controller
    {
        //
        // GET: /Home/
        FlowerStoreEntities db = new FlowerStoreEntities();
        public ActionResult Index()
        {
            List<FlowerDetail> listSP = db.FlowerDetails.ToList();
            return View(listSP);
        }

        public ActionResult TimKiemSanPham(string timKiem = "", int trang = 1)
        {
            //Tìm kiếm
            List<FlowerDetail> listSP = db.FlowerDetails.Where(row => row.FlowerName.Contains(timKiem)).ToList();
            ViewBag.TimKiem = timKiem;

            //Phân trang
            int soDongHienThi = 8;
            int soLuongTrang = Convert.ToInt32(Math.Ceiling(Convert.ToDouble(listSP.Count) / Convert.ToDouble(soDongHienThi)));
            int soDongBoQua = (trang - 1) * soDongHienThi;
            ViewBag.Trang = trang;
            ViewBag.SoLuongTrang = soLuongTrang;
            listSP = listSP.Skip(soDongBoQua).Take(soDongHienThi).ToList();

            return View(listSP);
        }

        public ActionResult SanPhamTheoDanhMuc(int maDM, string timKiem = "")
        {
            List<FlowerDetail> listSPTheoLoai = db.FlowerDetails.Where(sp => sp.CategoryID == maDM & sp.FlowerName.Contains(timKiem)).ToList();
            Category ctgr = db.Categories.FirstOrDefault(ct => ct.CategoryID == maDM);
            ViewBag.TenDM = ctgr.CategoryName;
            ViewBag.TimKiemSPTDM = timKiem;
            ViewBag.MaDM = maDM;
            return View(listSPTheoLoai);
        }

        public ActionResult ThongTinSanPham(int maSP)
        {
            FlowerDetail sp = db.FlowerDetails.FirstOrDefault(csp => csp.FlowerID == maSP);
            ViewBag.CategoryID = sp.CategoryID;
            return View(sp);
        }
    }
}
