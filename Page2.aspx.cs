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
    public partial class Page2 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Unnamed4_TextChanged(object sender, EventArgs e)
        {

        }

        protected void Register(object sender, EventArgs e)
        {

            string connStr = WebConfigurationManager.ConnectionStrings["Home"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            String usertype = "Admin";
            String mail = email.Text;
            String firstname = Firstname.Text;
            String lastname = Lastname.Text;
            DateTime birthdate = Birthdate.SelectedDate;
            String pass = Password.Text;


            SqlCommand useregister = new SqlCommand("UserRegister", conn);
            useregister.CommandType = CommandType.StoredProcedure;
            useregister.Parameters.Add(new SqlParameter("@usertype", usertype));
            useregister.Parameters.Add(new SqlParameter("@email", mail));
            useregister.Parameters.Add(new SqlParameter("@first_name", firstname));
            useregister.Parameters.Add(new SqlParameter("@last_name", lastname));
            useregister.Parameters.Add(new SqlParameter("@birth_date", birthdate));
            useregister.Parameters.Add(new SqlParameter("@password", pass));

            SqlParameter userid = useregister.Parameters.Add("@user_id", SqlDbType.Int);

            userid.Direction = ParameterDirection.Output;

            conn.Open();
            useregister.ExecuteNonQuery();
            conn.Close();
            Session["user"] = userid.Value;

            Response.Redirect("Profile.aspx");

            /*if (usertype == "Admin")
            {
                Response.Redirect("Profile.aspx");
            }
            else
            {
                Response.Redirect("Profileg.aspx");
            }
            */
        }
    }
}