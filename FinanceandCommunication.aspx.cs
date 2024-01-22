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
    public partial class Finance_Communication : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void receive(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["Home"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            int id = Int16.Parse(Session["user"].ToString());
            String type = Type.Text;
            double amt = double.Parse(amount.Text);
            String Status = status.Text;
            DateTime DATE = date.SelectedDate;
            SqlCommand transaction = new SqlCommand("ReceiveMoney", conn); 
            transaction.CommandType = CommandType.StoredProcedure; 
            transaction.Parameters.Add(new SqlParameter("@sender_id", id)); 
            transaction.Parameters.Add(new SqlParameter("@type", type)); 
            transaction.Parameters.Add(new SqlParameter("@amount", amt)); 
            transaction.Parameters.Add(new SqlParameter("@status", Status)); 
            transaction.Parameters.Add(new SqlParameter("@date", DATE));
           
            conn.Open(); 
            transaction.ExecuteNonQuery(); 
            conn.Close();

            Response.Write("Done Succesfully");

        }

        protected void planPayment(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["Home"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            int id = Int16.Parse(Session["user"].ToString()); 
            int rid = Int16.Parse(receiver.Text);
            double amt = double.Parse(amount1.Text);
            String Status = status1.Text;
            DateTime DATE = deadline.SelectedDate;
            SqlCommand transaction = new SqlCommand("PlanPayment", conn);
            transaction.CommandType = CommandType.StoredProcedure;
            transaction.Parameters.Add(new SqlParameter("@sender_id", id)); 
            transaction.Parameters.Add(new SqlParameter("@receiver_id", rid));
            transaction.Parameters.Add(new SqlParameter("@amount", amt)); 
            transaction.Parameters.Add(new SqlParameter("@status", Status));
            transaction.Parameters.Add(new SqlParameter("@deadline", DATE));
            conn.Open(); 
            transaction.ExecuteNonQuery(); 
            conn.Close();
            Response.Write("Done Succesfully");

        }

        protected void send(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["Home"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            int id = Int16.Parse(Session["user"].ToString()); 
            int rid = Int16.Parse(receiver1.Text);
            String tit = titel.Text;
            String cont = content.Text;
            DateTime times = Calendar1.SelectedDate;
            DateTime timer = Calendar2.SelectedDate;
            SqlCommand transaction = new SqlCommand("SendMessage", conn); 
            transaction.CommandType = CommandType.StoredProcedure;
            transaction.Parameters.Add(new SqlParameter("@sender_id", id));
            transaction.Parameters.Add(new SqlParameter("@receiver_id", rid));
            transaction.Parameters.Add(new SqlParameter("@title", tit));
            transaction.Parameters.Add(new SqlParameter("@content", cont));
            transaction.Parameters.Add(new SqlParameter("@timesent", times));
            transaction.Parameters.Add(new SqlParameter("@timereceived", timer));
            conn.Open(); 
            transaction.ExecuteNonQuery(); conn.Close();
        }

        protected void delete(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["Home"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            SqlCommand transaction = new SqlCommand("DeleteMsg", conn); transaction.CommandType = CommandType.StoredProcedure;
            conn.Open();
            transaction.ExecuteNonQuery();
            conn.Close();
        }

        protected void show(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["Home"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            int id = Int16.Parse(Session["user"].ToString());
            int rid = Int16.Parse(receiver2.Text);
            SqlCommand transaction = new SqlCommand("ShowMessages", conn);
            transaction.CommandType = CommandType.StoredProcedure;
            transaction.Parameters.Add(new SqlParameter("@user_id", id));
            transaction.Parameters.Add(new SqlParameter("@sender_id", rid));


            conn.Open();
            SqlDataReader rdr = transaction.ExecuteReader(CommandBehavior.CloseConnection);
            while (rdr.Read())
            {
                int messageid = rdr.GetInt32(rdr.GetOrdinal("message_id")); int senderid = rdr.GetInt32(rdr.GetOrdinal("sender_id")); int receiverid = rdr.GetInt32(rdr.GetOrdinal("receiver_id"));
                String content = rdr.GetString(rdr.GetOrdinal("content"));
                DateTime timesent = rdr.GetDateTime(rdr.GetOrdinal("time_sent")); DateTime timereceived = rdr.GetDateTime(rdr.GetOrdinal("time_received"));
               // DateTime timeread = rdr.GetDateTime(rdr.GetOrdinal("time_read"));
                String title = rdr.GetString(rdr.GetOrdinal("title"));

                String message = " message id: " + messageid + " sender id: " + senderid + " receiver id: " + receiverid + " content: " + content + " time sent: " + timesent + " time received : " + timereceived +  " title: " + title;
            //creating a lable to put the names in it 
            Label l = new Label();
                l.Text = message + "\n";
                //add lable to the form of this page form1.Controls.Add(l); 
                form1.Controls.Add(l);

            }
            conn.Close();
        }
    }
}