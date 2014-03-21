using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.SqlClient;
using System.IO;
using System.Net;
using System.Xml.Linq;
using System.Xml;
using System.Reflection;
using System.Data;
using System.Data.SqlTypes;

namespace SQLSaturday
{
    class Processor
    {
        private string _connectionString = "";
        private SqlConnection _con;
        private string _location = "";
        public Processor(Options options) {
            var asm = Assembly.GetExecutingAssembly();
            _location = Path.GetDirectoryName(asm.Location);
            if (options.UserName == null || options.password == null)
            {
                _connectionString = string.Format("Server={0};Database={1};Trusted_Connection=True", options.Server, options.Database);
            }
            else
            {
                _connectionString = string.Format("Server={0};Database={1};User Id={2};Password={3}", options.Server, options.Database,options.UserName,options.password);
            }
        }

        private string readSQL(string file)
        {

            var path = string.Format(@"{0}\SQL\{1}", _location, file);

            using (StreamReader sr = new StreamReader(path))
            {
                return sr.ReadToEnd();
            }
        }

        public bool ConnectionValid()
        {
            var ret = false;
            using (SqlConnection con = new SqlConnection(_connectionString))
            {
                con.Open();
                using (SqlCommand command = new SqlCommand("select 1 from sys.objects where type in ('U') and name in ('Events','Sessions','Speakers','Sponsors','Venue')", con))
                using (SqlDataReader reader = command.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        ret = true;
                    }
                }
            }
            
            return ret;

        }

        public bool LoadData(List<int> eventRange) {
            var badCount = 0;
            
            foreach (var s in eventRange)
            {

                var path = string.Format(@"{0}\{1}.xml", Path.GetTempPath(), s);
                using (WebClient client = new WebClient())
                {

                    var url = string.Format("http://sqlsaturday.com/eventxml.aspx?sat={0}", s);
                    Console.WriteLine("Retrieving " + url);
                    client.DownloadFile(url, path);

                }
                XDocument doc = null;
                try
                {
                    doc = XDocument.Load(path);
                }
                catch (XmlException e)
                {
                    Console.WriteLine(string.Format("Bad Download: SQL Saturday #{0}", s));
                }

                var elementCount = doc != null ? doc.Descendants("GuidebookXML").Descendants().Count() : 0;
                if (elementCount > 0)
                {
                    badCount = 0;
                    MergeData(path, s);
                }
                else
                {
                    badCount++;
                    Console.WriteLine(string.Format("SQLSaturday #{0} is nonexistent", s));
                    if (badCount == 2) break;
                }
                File.Delete(path);

            }
            return true;
        }

        private bool MergeData(string path, int eventId)
        {
            var ret = false;
            XmlDocument xmlToSave = new XmlDocument();
            xmlToSave.Load(path);


            using (SqlConnection con = new SqlConnection(_connectionString))
            {
                con.Open();
                var sql =  readSQL("Import.sql");
                using (SqlCommand command = new SqlCommand(sql, con)) {
                    command.Parameters.Add(
                          new SqlParameter("@x", SqlDbType.Xml)
                          {
                              Value = new SqlXml(new XmlTextReader(xmlToSave.InnerXml
                                         , XmlNodeType.Document, null))
                          });


                    command.Parameters.AddWithValue("@EventId", eventId);              
                    var c = command.ExecuteNonQuery();
                }
                
            }

            return ret;

        }


        public void CreateObjects() {
            Console.WriteLine("Dropping and Recreating Tables");
            using (SqlConnection con = new SqlConnection(_connectionString))
       	    {
	            con.Open();
                var sql = readSQL("Objects.sql");
                using (SqlCommand command = new SqlCommand(sql, con))
                {
                    command.ExecuteNonQuery();
                }
	               
	        }
        }
    }
}
