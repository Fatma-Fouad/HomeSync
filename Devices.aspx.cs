using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;
using System.Security.Cryptography;

namespace team4
{
    public partial class Devices : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void view(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["Home"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            int did = Int16.Parse(textbox1.Text);


            SqlCommand viewrooms = new SqlCommand("ViewMyDeviceCharge", conn);
            viewrooms.CommandType = CommandType.StoredProcedure;
            viewrooms.Parameters.Add(new SqlParameter("@device_id", did));

            conn.Open();
            SqlDataReader rdr = viewrooms.ExecuteReader(CommandBehavior.CloseConnection);
            while (rdr.Read())
            {
                int batterys = rdr.GetInt32(rdr.GetOrdinal("charge"));
                int roomd = rdr.GetInt32(rdr.GetOrdinal("location"));

                String devicess = batterys + ",\n" + roomd + ",\n";
                Label l = new Label();
                l.Text = devicess + ",\n";
                form1.Controls.Add(l);
            }
        }

        protected void add(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["Home"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            int Did = Int16.Parse(textbox2.Text);
            String dstat = textbox3.Text;
            int dbat = Int16.Parse(textbox4.Text);
            int dloc = Int16.Parse(textbox5.Text);
            String dtype = textbox6.Text;



            SqlCommand viewrooms = new SqlCommand("AddDevice", conn);
            viewrooms.CommandType = CommandType.StoredProcedure;
            viewrooms.Parameters.Add(new SqlParameter("@device_id", Did));
            viewrooms.Parameters.Add(new SqlParameter("@status", dstat));
            viewrooms.Parameters.Add(new SqlParameter("@battery", dbat));
            viewrooms.Parameters.Add(new SqlParameter("@location", dloc));
            viewrooms.Parameters.Add(new SqlParameter("@type", dtype));

            conn.Open();
            viewrooms.ExecuteNonQuery();
            conn.Close();

            Response.Write("Done Succesfully");

        }


        protected void Out(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["Home"].ToString();
            SqlConnection conn = new SqlConnection(connStr);


            SqlCommand viewrooms = new SqlCommand("OutOfBattery", conn);
            viewrooms.CommandType = CommandType.StoredProcedure;

            conn.Open();
            SqlDataReader rdr = viewrooms.ExecuteReader(CommandBehavior.CloseConnection);
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

        protected void sett(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["Home"].ToString();
            SqlConnection conn = new SqlConnection(connStr);


            SqlCommand viewrooms = new SqlCommand("Charging", conn);
            viewrooms.CommandType = CommandType.StoredProcedure;

            conn.Open();
            viewrooms.ExecuteNonQuery();
            conn.Close();

            Response.Write("Done Succesfully");

        }

        protected void loc(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["Home"].ToString();
            SqlConnection conn = new SqlConnection(connStr);


            SqlCommand viewrooms = new SqlCommand("NeedCharge", conn);
            viewrooms.CommandType = CommandType.StoredProcedure;

            conn.Open();
            SqlDataReader rdr = viewrooms.ExecuteReader(CommandBehavior.CloseConnection);
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