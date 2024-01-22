using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace team4
{
    public partial class setguests : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }

        protected void ok(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["Home"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            int id = Int16.Parse(Session["user"].ToString());
            int no = Int16.Parse(okk.Text);

            SqlCommand allowed = new SqlCommand("GuestsAllowed", conn);
            allowed.CommandType = CommandType.StoredProcedure;
            allowed.Parameters.Add(new SqlParameter("@admin_id", id));
            allowed.Parameters.Add(new SqlParameter("@number_of_guests", no));

            conn.Open();
            allowed.ExecuteNonQuery();
            conn.Close();
            Response.Write("Done Succesfully");

        }
    }
}