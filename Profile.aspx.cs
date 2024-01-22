using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;

namespace team4
{
    public partial class Profile : System.Web.UI.Page
    {
        private object command;

        protected void Page_Load(object sender, EventArgs e)
        {

             string connStr = WebConfigurationManager.ConnectionStrings["Home"].ToString();
             SqlConnection conn = new SqlConnection(connStr);

            int id = Int16.Parse(Session["user"].ToString());

             SqlCommand viewprofile = new SqlCommand("ViewProfile", conn);
             viewprofile.CommandType = CommandType.StoredProcedure;
             viewprofile.Parameters.Add(new SqlParameter("@user_id", id));

             conn.Open();

             SqlDataReader rdr = viewprofile.ExecuteReader(CommandBehavior.CloseConnection);
             while (rdr.Read())
             {
                int ID = rdr.GetInt32(rdr.GetOrdinal("id"));
                String fname = rdr.GetString(rdr.GetOrdinal("f_Name"));
                String lname = rdr.GetString(rdr.GetOrdinal("l_Name"));
                String pass = rdr.GetString(rdr.GetOrdinal("password"));
                String email = rdr.GetString(rdr.GetOrdinal("email"));
               // String pref = rdr.GetString(rdr.GetOrdinal("preference"));
                //int room = rdr.GetInt32(rdr.GetOrdinal("room"));
                String type = rdr.GetString(rdr.GetOrdinal("type"));
                DateTime birthdate = rdr.GetDateTime(rdr.GetOrdinal("birthdate"));
                int age = rdr.GetInt32(rdr.GetOrdinal("age"));


                String profile = " id: " + ID + " First name: " + fname +
                    " Last name: " + lname + " Password: " + pass +
                    " Email: " + email + " Type: " + type + 
                    " Birthdate: " + birthdate + " Age: " + age;
                
                Label l = new Label();
                l.Text = profile + "\n";
                
                form1.Controls.Add(l);
            }
             Response.Write(Session["user"]= id);

        }

        protected void noofguests(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["Home"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            int id = Int16.Parse(Session["user"].ToString());

            SqlCommand viewprofile = new SqlCommand("GuestNumber", conn);
            viewprofile.CommandType = CommandType.StoredProcedure;
            viewprofile.Parameters.Add(new SqlParameter("@admin_id", id));

            conn.Open();
            SqlDataReader rdr = viewprofile.ExecuteReader(CommandBehavior.CloseConnection);
            while (rdr.Read())
            {
                int no = rdr.GetInt32(rdr.GetOrdinal("no"));

                String task = " no: " +  no;
                //creating a lable to put the names in it 
                Label l = new Label();
                l.Text = task + "\n";
                //add lable to the form of this page
                form1.Controls.Add(l);
                Console.WriteLine(task);
                Console.WriteLine("hello");
            }
            Response.Write(Session["user"] = id);
        }


    

        protected void set(object sender, EventArgs e)
        {
            Response.Redirect("setguests.aspx");
        }


        protected void room(object sender, EventArgs e)
        {
            Response.Redirect("assignroom.aspx");
        }

        protected void task(object sender, EventArgs e)
        {
            Response.Redirect("Tasks.aspx");
        }

        protected void device(object sender, EventArgs e)
        {
            Response.Redirect("Devices.aspx");
        }

        protected void fandc(object sender, EventArgs e)
        {
            Response.Redirect("FinanceandCommunication.aspx");
        }

        protected void remove1(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["Home"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            int id = Int16.Parse(Session["user"].ToString());
            int gid = Int16.Parse(remove.Text);

            SqlCommand viewrooms = new SqlCommand("GuestRemove", conn);
            viewrooms.CommandType = CommandType.StoredProcedure;
            viewrooms.Parameters.Add(new SqlParameter("@guest_id", gid));
            viewrooms.Parameters.Add(new SqlParameter("@admin_id", id));

            SqlParameter allowed = viewrooms.Parameters.Add("@number_of_allowed_guests", SqlDbType.Int);

            allowed.Direction = ParameterDirection.Output;
            conn.Open();
            viewrooms.ExecuteNonQuery();
            conn.Close();
            Response.Write("Done Succesfully");

        }
    }
}