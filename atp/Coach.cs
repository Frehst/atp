using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Text;
using System.Linq;

namespace atp
{
    class Coach
    {
        private string _connectionString;

        public Coach(string connectionString)
        {
            _connectionString = connectionString;
        }
        
        public IList<Models> FullName()
        {
            List<Models> CoachModels = new List<Models>();
            using (SqlConnection connection = new SqlConnection(_connectionString))
            {
                connection.Open();

                using (SqlCommand command = new SqlCommand("Select Coach.CoachName,Coach.CoachSurname FROM Coach INNER JOIN Player ON Coach.CoachID = Player.CoachID", connection))
                {
                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        if (reader.HasRows)
                        {
                            while (reader.Read())
                            {
                                Models coach = new Models()
                                {
                                    CoachName = reader["CoachName"].ToString(),
                                    CoachSurname = reader["CoachSurname"].ToString()
                                };
                                CoachModels.Add(coach);
                            }
                        }
                    }
                }
            }
            return CoachModels;
        }
    }
}
