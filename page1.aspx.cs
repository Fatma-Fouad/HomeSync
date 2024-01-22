using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace team4
{
    public partial class page1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Signin(object sender, EventArgs e)
        {
            //take connection string from configurations
            string connStr = WebConfigurationManager.ConnectionStrings["Home"].ToString();
            //create a new connection
            SqlConnection conn = new SqlConnection(connStr);

            String mail = email.Text;
            String pass = password.Text;


            SqlCommand loginproc = new SqlCommand("UserLogin", conn);
            loginproc.CommandType = CommandType.StoredProcedure;
            loginproc.Parameters.Add(new SqlParameter("@email", mail));
            loginproc.Parameters.Add(new SqlParameter("@password", pass));

            SqlParameter success = loginproc.Parameters.Add("@success", SqlDbType.Int);
            SqlParameter userid = loginproc.Parameters.Add("@user_id", SqlDbType.Int);

            success.Direction = ParameterDirection.Output;
            userid.Direction = ParameterDirection.Output;

            conn.Open();
            loginproc.ExecuteNonQuery();
            conn.Close();

            if (success.Value.ToString() == "1")
            {
                Session["user"] = userid.Value;
                Console.WriteLine(userid.Value);
                Console.WriteLine(userid);
                Response.Redirect("Profile.aspx");
            }
            else
            {
                Response.Write("invalid email or password");
            }

        }
    }
}