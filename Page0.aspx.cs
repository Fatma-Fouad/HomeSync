using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace team4
{
    public partial class Page0 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Signin1(object sender, EventArgs e)
        {
            Response.Redirect("Page1.aspx");
        }

        protected void Register(object sender, EventArgs e)
        {
            Response.Redirect("Page2.aspx");
        }
    }
}