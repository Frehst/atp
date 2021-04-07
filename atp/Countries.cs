using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Text;

namespace atp
{
    class Countries
    {
        private string _connectionString;

        public Countries(string connectionString)
        {
            _connectionString = connectionString;
        }

        public IList<Models> AllInfo ()
        {
            List<Models> CountryModels = new List<Models>();
            using (SqlConnection connection = new SqlConnection(_connectionString))
            {
                connection.Open();

                using (SqlCommand command = new SqlCommand("Select CountryID,CountryName FROM Country", connection))
                {
                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        if (reader.HasRows)
                        {
                            while (reader.Read())
                            {
                                Models Country = new Models()
                                {
                                    CountryID= Convert.ToInt32(reader["countryID"]),
                                    CountryName = reader["CountryName"].ToString()
                                };
                                CountryModels.Add(Country);
                            }
                        }
                    }
                }
            }
            return CountryModels;
        }
        public IList<Models> TopPlayers()
        {
            List<Models> CountryModels = new List<Models>();
            using (SqlConnection connection = new SqlConnection(_connectionString))
            {
                connection.Open();

                using (SqlCommand command = new SqlCommand("SELECT Country.CountryName,Count(Country.CountryName) as NumberOfPlayers FROM Player INNER JOIN Country ON Player.CountryID = Country.CountryID GROUP BY Country.CountryName ORDER BY NumberOfPlayers DESC; ", connection))
                {
                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        if (reader.HasRows)
                        {
                            while (reader.Read())
                            {
                                Models Country = new Models()
                                {
                                    CountryName = reader["CountryName"].ToString(),
                                    NumberOfPlayers = Convert.ToInt32(reader["NumberOfPlayers"])

                                };
                                CountryModels.Add(Country);
                            }
                        }
                    }
                }
            }
            return CountryModels;
        }


       
    }
}
