using System.Web;
using System.Web.Mvc;

namespace WebsiteHoaTuoi1080
{
    public class FilterConfig
    {
        public static void RegisterGlobalFilters(GlobalFilterCollection filters)
        {
            filters.Add(new HandleErrorAttribute());
        }
    }
}