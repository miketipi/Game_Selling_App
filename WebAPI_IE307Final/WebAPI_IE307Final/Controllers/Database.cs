using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using WebAPI_IE307Final.Models;
namespace WebAPI_IE307Final.Controllers
{
    public class Database
    {
        public static DataTable Read_Table(string StoredProcedureName, Dictionary<string, object> dic_param = null)
        {
            string SQLconnectionString = ConfigurationManager.ConnectionStrings["QLGAMEConnectionString"].ConnectionString;
            DataTable result = new DataTable("table1");
            using (SqlConnection conn = new SqlConnection(SQLconnectionString))
            {
                conn.Open();
                SqlCommand cmd = conn.CreateCommand();
                cmd.Connection = conn;
                cmd.CommandText = StoredProcedureName;
                cmd.CommandType = CommandType.StoredProcedure;
                if (dic_param != null)
                {
                    foreach (KeyValuePair<string, object> data in dic_param)
                    {
                        if (data.Value == null)
                        {
                            cmd.Parameters.AddWithValue("@" + data.Key, DBNull.Value);
                        }
                        else
                        {
                            cmd.Parameters.AddWithValue("@" + data.Key, data.Value);
                        }
                    }
                }
                try
                {
                    SqlDataAdapter da = new SqlDataAdapter();
                    da.SelectCommand = cmd;
                    da.Fill(result);

                }
                catch (Exception ex)
                {

                }
            }
            return result;
        }
        public static object Exec_Command(string StoredProcedureName, Dictionary<string, object> dic_param = null)
        {
            string SQLconnectionString = ConfigurationManager.ConnectionStrings["QLGAMEConnectionString"].ConnectionString;
            object result = null;
            using (SqlConnection conn = new SqlConnection(SQLconnectionString))
            {
                conn.Open();
                SqlCommand cmd = conn.CreateCommand();

                // Start a local transaction.

                cmd.Connection = conn;
                cmd.CommandText = StoredProcedureName;
                cmd.CommandType = CommandType.StoredProcedure;

                if (dic_param != null)
                {
                    foreach (KeyValuePair<string, object> data in dic_param)
                    {
                        if (data.Value == null)
                        {
                            cmd.Parameters.AddWithValue("@" + data.Key, DBNull.Value);
                        }
                        else
                        {
                            cmd.Parameters.AddWithValue("@" + data.Key, data.Value);
                        }
                    }
                }
                cmd.Parameters.Add("@CurrentID", SqlDbType.Int).Direction = ParameterDirection.Output;
                try
                {
                    cmd.ExecuteNonQuery();
                    result = cmd.Parameters["@CurrentID"].Value;
                    // Attempt to commit the transaction.

                }
                catch (Exception ex)
                {

                    result = null;
                }

            }
            return result;
        }
        public static DataTable GameList()
        {
            return Read_Table("GameList");
        }
        public static DataTable LoadGame()
        {
            return Read_Table("LoadGame");
        }
        public static DataTable LayGameTheoLoai(int maloai)
        {
            Dictionary<string, object> param = new Dictionary<string, object>();
            param.Add("maloai", maloai);
            return Read_Table("LayGameTheoLoai", param);
        }
        public static Account Login(string username, string password)
        {
            Dictionary<string, object> param = new Dictionary<string, object>();
            param.Add("usrname", username);
            param.Add("pwd", password);
            DataTable tb = Read_Table("Login", param);
            Account kq = new Account();
            if (tb.Rows.Count > 0)
            {
                kq.UserID = int.Parse(tb.Rows[0]["UserID"].ToString());
                kq.RealName = tb.Rows[0]["RealName"].ToString();
                kq.UserName = tb.Rows[0]["UserName"].ToString();
                kq.Email = tb.Rows[0]["Email"].ToString();
                kq.PWD = tb.Rows[0]["PWD"].ToString();
            }
            else
                kq.UserID = 0; //Neu ko tim ra user thi ma user = 0 va se ko cho dang nhap o ung dung
            return kq;
        }
    }
}