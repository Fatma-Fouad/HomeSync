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
    public partial class Tasks : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["Home"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            int id = Int16.Parse(Session["user"].ToString());
           // Console.WriteLine(id);

            SqlCommand viewrooms = new SqlCommand("ViewMyTask", conn);
            viewrooms.CommandType = CommandType.StoredProcedure;
            viewrooms.Parameters.Add(new SqlParameter("@user_id", id));

            conn.Open();

            SqlDataReader rdr = viewrooms.ExecuteReader(CommandBehavior.CloseConnection);
            while (rdr.Read())
            {
                int Task_id = rdr.GetInt32(rdr.GetOrdinal("Task_id"));
                String name = rdr.GetString(rdr.GetOrdinal("name"));
                DateTime creation_date = rdr.GetDateTime(rdr.GetOrdinal("creation_date"));
                DateTime due_date = rdr.GetDateTime(rdr.GetOrdinal("due_date"));
                String category = rdr.GetString(rdr.GetOrdinal("category"));
                int creator = rdr.GetInt32(rdr.GetOrdinal("creator"));
                String Status = rdr.GetString(rdr.GetOrdinal("status"));
                DateTime reminder_date = rdr.GetDateTime(rdr.GetOrdinal("reminder_date"));
                int priority = rdr.GetInt32(rdr.GetOrdinal("priority"));

                String task = " id: " + Task_id + " name: " + name + " creation_date: " + creation_date + " due_date: " + due_date + " category: " + category + " creator: " + creator + " status: " + Status + " reminder_date: " + reminder_date + " priority: " + priority;
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

        protected void FinishTask(object sender, EventArgs e)
        {
            String taskname = Name.Text;
            string connStr = WebConfigurationManager.ConnectionStrings["Home"].ToString();

            SqlConnection conn = new SqlConnection(connStr);
            int id = Int16.Parse(Session["user"].ToString());
            Console.WriteLine(id);
            SqlCommand viewrooms = new SqlCommand("SELECT * FROM Task WHERE name = '" + taskname + "'", conn);
            viewrooms.Parameters.Add(new SqlParameter("@user_id", id));
            viewrooms.Parameters.Add(new SqlParameter("@title", taskname));

            conn.Open();
            viewrooms.ExecuteNonQuery();
            conn.Close();

            Response.Write("Done Succesfully");

        }

        protected void TaskStatus(object sender, EventArgs e)
        {
            String taskname = Name.Text;
            string connStr = WebConfigurationManager.ConnectionStrings["Home"].ToString();

            SqlConnection conn = new SqlConnection(connStr);
            int id = Int16.Parse(Session["user"].ToString());
            Console.WriteLine(id);
            SqlCommand viewrooms = new SqlCommand("SELECT * FROM Task WHERE name = '" + taskname + "'", conn);
            viewrooms.Parameters.Add(new SqlParameter("@user_id", id));
            viewrooms.Parameters.Add(new SqlParameter("@title", taskname));

            conn.Open();
            SqlDataReader rdr = viewrooms.ExecuteReader(CommandBehavior.CloseConnection);
            while (rdr.Read())
            {
                int Task_id = rdr.GetInt32(rdr.GetOrdinal("Task_id"));
                String name = rdr.GetString(rdr.GetOrdinal("name"));
                DateTime creation_date = rdr.GetDateTime(rdr.GetOrdinal("creation_date"));
                DateTime due_date = rdr.GetDateTime(rdr.GetOrdinal("due_date"));
                String category = rdr.GetString(rdr.GetOrdinal("category"));
                int creator = rdr.GetInt32(rdr.GetOrdinal("creator"));
                String Status = rdr.GetString(rdr.GetOrdinal("status"));
                DateTime reminder_date = rdr.GetDateTime(rdr.GetOrdinal("reminder_date"));
                int priority = rdr.GetInt32(rdr.GetOrdinal("priority"));

                String task = " id: " + Task_id + " name: " + name + " creation_date: " + creation_date + " due_date: " + due_date + " category: " + category + " creator: " + creator + " status: " + Status + " reminder_date: " + reminder_date + " priority: " + priority;
                //creating a lable to put the names in it 
                Label l = new Label();
                l.Text = task + "\n";
                //add lable to the form of this page
                form1.Controls.Add(l);
                Console.WriteLine(task);
                Console.WriteLine("hello");
            }
            conn.Close();
        }

        protected void AddReminder(object sender, EventArgs e)
        {
           
            string connStr = WebConfigurationManager.ConnectionStrings["Home"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            String taskname = Name.Text;
            int id = Int16.Parse(TaskId.Text);
            DateTime date1 = date.SelectedDate;

            Console.WriteLine(id);
            SqlCommand viewrooms = new SqlCommand("AddReminder", conn);
            viewrooms.CommandType = CommandType.StoredProcedure;
            viewrooms.Parameters.Add(new SqlParameter("@task_id", id));
            viewrooms.Parameters.Add(new SqlParameter("@reminder", date1));


            conn.Open();
            viewrooms.ExecuteNonQuery();
            conn.Close();

            Response.Write("Done Succesfully");

        }

        protected void AddDeadline(object sender, EventArgs e)
        {
            String taskname = Name.Text;
            string connStr = WebConfigurationManager.ConnectionStrings["Home"].ToString();


            SqlConnection conn = new SqlConnection(connStr);
            int id = Int16.Parse(TaskId.Text);
            DateTime date1 = date.SelectedDate;

            Console.WriteLine(id);
            SqlCommand viewrooms = new SqlCommand("UpdateTaskDeadline", conn);
            viewrooms.CommandType = CommandType.StoredProcedure;
            viewrooms.Parameters.Add(new SqlParameter("@task_id", id));
            viewrooms.Parameters.Add(new SqlParameter("@deadline", date1));


            conn.Open();
            viewrooms.ExecuteNonQuery();
            conn.Close();

            Response.Write("Done Succesfully");

        }
    }
}