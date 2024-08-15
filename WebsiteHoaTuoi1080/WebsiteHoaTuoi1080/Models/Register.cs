using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.Entity.Validation;
using System.IO;

namespace WebsiteHoaTuoi1080.Models
{
    public class Register
    {
        FlowerStoreEntities db = new FlowerStoreEntities();
        public string Name { get; set; }
        public string Email { get; set; }
        public string Phone { get; set; }
        public string Password { get; set; }
        //public string ConfirmPassword { get; set; }

        //0: duplicate phone
        //1: success
        //2: duplicate email
        public int checkAccount(Register rgt)
        {
            List<CUSTOMER> listLG = db.CUSTOMERs.ToList();
            CUSTOMER checkPhone = listLG.Find(f => f.CustomerNumber == rgt.Phone);
            if (checkPhone == null)
            {
                CUSTOMER checkEmail = listLG.Find(f => f.CustomerEmail == rgt.Email);
                if (checkEmail == null)
                {
                        Login newLG = createLogin(rgt);
                        db.Logins.Add(newLG);
                        db.SaveChanges();

                        CUSTOMER newCT = createCUSTOMER(rgt);
                        db.CUSTOMERs.Add(newCT);
                        db.SaveChanges();
                        return 1;
                }
                else return 2;
            }
            return 0;
        }

        public Login createLogin(Register rgt)
        {
            Login newLG = new Login();
            newLG.UserName = rgt.Phone;
            newLG.Password = rgt.Password;
            newLG.Roles = "user";

            return newLG;
        }

        public CUSTOMER createCUSTOMER(Register rgt)
        {
            CUSTOMER newCT = new CUSTOMER();
            newCT.CustomerName = rgt.Name;
            newCT.CustomerEmail = rgt.Email;
            newCT.CustomerNumber = rgt.Phone;

            List<Login> listLG = db.Logins.ToList();
            Login checkID = listLG.Find(f => f.UserName == rgt.Phone);

            newCT.UserId = checkID.UserId;

            return newCT;
        }
    }
}