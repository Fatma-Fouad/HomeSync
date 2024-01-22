using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Globalization;

namespace team4
{
    public partial class assignroom : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["Home"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            int id = Int16.Parse(Session["user"].ToString());

            SqlCommand room1 = new SqlCommand("ViewRooms", conn);
            room1.CommandType = CommandType.StoredProcedure;
            room1.Parameters.Add(new SqlParameter("@user_id", id));

            conn.Open();

            SqlDataReader rdr = room1.ExecuteReader(CommandBehavior.CloseConnection);
            while (rdr.Read())
            {
                int Roomid = rdr.GetInt32(rdr.GetOrdinal("room_id"));
                String Type = rdr.GetString(rdr.GetOrdinal("type"));
                int Floor = rdr.GetInt32(rdr.GetOrdinal("floor"));
                String Status = rdr.GetString(rdr.GetOrdinal("status"));

                String roomName = Roomid + ",\n" + Type + ",\n" + Floor + ",\n" + Status + ",\n";
                //creating a lable to put the names in it 
                Label l = new Label();
                l.Text = roomName + ",\n";
                //add lable to the form of this page
                form1.Controls.Add(l);
            }
            Response.Write(Session["user"] = id);
        }

        protected void book(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["Home"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
             
            int id = Int16.Parse(Session["user"].ToString());
            int no = Int16.Parse(books.Text.ToString());

            SqlCommand room2 = new SqlCommand("AssignRoom", conn);
            room2.CommandType = CommandType.StoredProcedure;
            room2.Parameters.Add(new SqlParameter("@user_id", id));
            room2.Parameters.Add(new SqlParameter("@room_id", no));

            conn.Open();
            room2.ExecuteNonQuery();
            conn.Close();

            Response.Write("Done Succesfully");

        }

        protected void create(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["Home"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            int id = Int16.Parse(Session["user"].ToString());
            int rid = Int16.Parse(TextBox1.Text.ToString());
            DateTime start = calender1.SelectedDate;
            DateTime end = calender2.SelectedDate;
            String actions = TextBox2.Text;


            SqlCommand room3 = new SqlCommand("CreateSchedule", conn);
            room3.CommandType = CommandType.StoredProcedure;
            room3.Parameters.Add(new SqlParameter("@creator_id", id));
            room3.Parameters.Add(new SqlParameter("@room_id", rid));
            room3.Parameters.Add(new SqlParameter("@start_time", start));
            room3.Parameters.Add(new SqlParameter("@end_time", end));
            room3.Parameters.Add(new SqlParameter("@action", actions));

            conn.Open();
            room3.ExecuteNonQuery();
            conn.Close();

            Response.Write("Done Succesfully");

        }

        protected void change(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["Home"].ToString();
            SqlConnection conn = new SqlConnection(connStr);


            int loc = Int16.Parse(TextBox3.Text.ToString());
            String stat = TextBox4.Text;


            SqlCommand room4 = new SqlCommand("RoomAvailability", conn);
            room4.CommandType = CommandType.StoredProcedure;
            room4.Parameters.Add(new SqlParameter("@location", loc));
            room4.Parameters.Add(new SqlParameter("@status", stat));
           
            conn.Open();
            room4.ExecuteNonQuery();
            conn.Close();

            Response.Write("Done Succesfully");

        }

        protected void view(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["Home"].ToString();
            SqlConnection conn = new SqlConnection(connStr);


            SqlCommand room5 = new SqlCommand("ViewRoom", conn);
            room5.CommandType = CommandType.StoredProcedure;

            conn.Open();

            SqlDataReader rdr = room5.ExecuteReader(CommandBehavior.CloseConnection);
            while (rdr.Read())
            {
                int Roomid = rdr.GetInt32(rdr.GetOrdinal("room_id"));
                String Type = rdr.GetString(rdr.GetOrdinal("type"));
                int Floor = rdr.GetInt32(rdr.GetOrdinal("floor"));
                String Status = rdr.GetString(rdr.GetOrdinal("status"));

                String roomName = Roomid + ",\n" + Type + ",\n" + Floor + ",\n" + Status + ",\n";
                //creating a lable to put the names in it 
                Label l = new Label();
                l.Text = roomName + ",\n";
                //add lable to the form of this page
                form1.Controls.Add(l);
            }
        }
    }
}