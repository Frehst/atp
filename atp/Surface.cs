using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Text;

namespace atp
{
    class Surface
    {
        private string _connectionString;

        public Surface(string connectionString)
        {
            _connectionString = connectionString;
        }
        public IList<Models> Info()
        {
            List<Models> SurfaceInfo = new List<Models>();
            using(SqlConnection connection = new SqlConnection(_connectionString))
            {
                connection.Open();
                {
                    using(SqlCommand command  = new SqlCommand("SELECT SurfaceID,SurfaceName FROM Surface",connection))
                    {
                        using (SqlDataReader reader = command.ExecuteReader())
                        {
                            if(reader.HasRows)
                            {
                                while(reader.Read())
                                {
                                    Models surfaceInfo = new Models()
                                    {
                                        SurfaceID = Convert.ToInt32(reader["SurfaceID"]),
                                        SurfaceName = reader["SurfaceName"].ToString()

                                    };
                                    SurfaceInfo.Add(surfaceInfo);
                                }
                            }
                        }
                    }
                }
            }
            return SurfaceInfo;

        }

    }
}
