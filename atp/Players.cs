using System;
using System.Collections.Generic;
using System.Data.SqlClient;

namespace atp
{
    class Players
    {

        private string _connectionString;

        public Players (string connectionString)
        {
            _connectionString = connectionString;
        }

        public IList<Models> GetList()
        {
            List<Models> playerModels = new List<Models>();

            using(SqlConnection connection = new SqlConnection(_connectionString))
            {
                connection.Open();

                using(SqlCommand command = new SqlCommand("Select PlayerName,PlayerSurname FROM Player",connection))
                {
                    using(SqlDataReader reader = command.ExecuteReader())
                    {
                        if(reader.HasRows)
                        {
                            while(reader.Read())
                            {
                                Models player = new Models()
                                {
                                    PlayerName = reader["PlayerName"].ToString(),
                                    PlayerSurname  =reader["PlayerSurname"].ToString()
                                };
                                playerModels.Add(player);
                            }
                        }
                    }
                }
            }
            return playerModels;
        }

        public void Insert()
        {
            List<Models> Coachmodels= new List<Models>();
            List<Models> Surfacemodels = new List<Models>();
            List<Models> Countrymodels = new List<Models>();

            using (SqlConnection connection = new SqlConnection(_connectionString))
            {
                connection.Open();
                Console.WriteLine("Name:");
                var playerName = Console.ReadLine();
                Console.WriteLine("Surname:");
                var playerSurname = Console.ReadLine();
                using (SqlCommand cmd = new SqlCommand("SELECT CoachID, CoachName, CoachSurname FROM Coach",connection))
                {
                    using(SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if(reader.HasRows)
                        {
                            while(reader.Read())
                            {
                                Models coach = new Models()
                                {
                                    CoachID = Convert.ToInt32(reader["CoachID"]),
                                    CoachName = reader["CoachName"].ToString(),
                                    CoachSurname = reader["CoachSurname"].ToString()
                                };
                                Coachmodels.Add(coach);
                            }
                        }
                    }
                }
                foreach(var coach in Coachmodels)
                {
                    Console.WriteLine("{0} {1} {2}",coach.CoachID,coach.CoachName,coach.CoachSurname);
                }
                Console.WriteLine("If you don't have a coach -0");
                var coachID = Convert.ToInt32(Console.ReadLine());
                // przy 89 nie ma imienia i nazwiska , wiec ustawiam na 89 
                if(coachID == 0)
                {
                    coachID = 89;
                }

                Console.WriteLine("Hand: right or left");
                var hand = Console.ReadLine();
                Console.WriteLine("Backhand: one or double");
                var backhand = Console.ReadLine();
                Console.WriteLine("Surface ID:");
                using (SqlCommand command = new SqlCommand("SELECT SurfaceID, SurfaceName FROM Surface",connection))
                {
                    using(SqlDataReader reader = command.ExecuteReader())
                    {
                        if (reader.HasRows)
                        {
                            while(reader.Read())
                            {
                                Models surface = new Models()
                                {
                                    SurfaceID = Convert.ToInt32(reader["SurfaceID"]),
                                    SurfaceName = reader["SurfaceName"].ToString()
                                };
                                Surfacemodels.Add(surface);
                            }
                        }
                    }

                }
                foreach (var surf in Surfacemodels)
                {
                    Console.WriteLine("{0} {1} ",surf.SurfaceID,surf.SurfaceName);
                }
                var SurfaceId = Convert.ToInt32(Console.ReadLine());
                Console.WriteLine("Country:");
                using (SqlCommand command = new SqlCommand("SELECT CountryID, CountryName FROM Country", connection))
                {
                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        if (reader.HasRows)
                        {
                            while (reader.Read())
                            {
                                Models country = new Models()
                                {
                                    CountryID = Convert.ToInt32(reader["CountryID"]),
                                    CountryName= reader["CountryName"].ToString()
                                };
                                Countrymodels.Add(country);
                            }
                        }
                    }

                }
                foreach (var country in Countrymodels)
                {
                    Console.WriteLine("{0} {1} ", country.CountryID,country.CountryName);
                }
                var countryID = Convert.ToInt32(Console.ReadLine());
                Console.WriteLine("Age:");
                var age = Convert.ToInt32(Console.ReadLine());
                Console.WriteLine("Points");
                var points = Convert.ToInt32(Console.ReadLine());


                var cmd1 = String.Format("INSERT INTO Player (PlayerName,PlayerSurname, CountryID,Hand,Backhand,SurfaceID,CoachID,Age,Points) VALUES ('{0}','{1}',{2},'{3}','{4}',{5},{6},{7},{8})", playerName, playerSurname, countryID, hand, backhand, SurfaceId, coachID, age, points);
                SqlCommand final_command = new SqlCommand(cmd1, connection);
                final_command.ExecuteReader();
            }

            
        }

        public IList<Models> View()
        {
            List<Models> playersView = new List<Models>();

            using (SqlConnection connection = new SqlConnection(_connectionString))
            {
                Console.WriteLine("ID " + " First Name \tLast Name\t  CountryID\t Hand\t backhand favsur CoachName CoachSurname\t Age  Points");
                connection.Open();

                using (SqlCommand command= new SqlCommand("SELECT PlayerID,PlayerName,PlayerSurname,Country.CountryName,Hand,Backhand,Surface.SurfaceName,Coach.CoachName,Coach.CoachSurname,Age,Points FROM Player INNER JOIN Country ON Player.CountryID = Country.CountryID INNER JOIN Coach ON Player.CoachID = Coach.CoachID INNER JOIN Surface ON Player.SurfaceID = Surface.SurfaceId", connection))
                {
                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        if(reader.HasRows)
                        {
                            while(reader.Read())
                            {
                                Models view = new Models()
                                {
                                    PlayerID = Convert.ToInt32(reader["PlayerID"]),
                                    PlayerName = reader["PlayerName"].ToString(),
                                    PlayerSurname = reader["PlayerSurname"].ToString(),
                                    CountryName = reader["CountryName"].ToString(),
                                    Hand = reader["Hand"].ToString(),
                                    Backhand = reader["Backhand"].ToString(),
                                    SurfaceName = reader["SurfaceName"].ToString(),
                                    CoachName = reader["CoachName"].ToString(),
                                    CoachSurname = reader["CoachSurname"].ToString(),
                                    Age = Convert.ToInt32(reader["Age"]),
                                    Points = Convert.ToInt32(reader["Points"])

                                };
                                playersView.Add(view);
                            }
                        }

                    }
                }

                            

            }

            return playersView; 

        }

        public IList<Models> Rank()
        {
            List<Models> playersRank = new List<Models>();
            using (SqlConnection connection = new SqlConnection(_connectionString))
            {
                connection.Open();
                using (SqlCommand command = new SqlCommand("SELECT PlayerName,PlayerSurname,Points FROM Player ORDER BY POINTS DESC", connection))
                {
                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        if(reader.HasRows)
                        {
                            while(reader.Read())
                            {
                                Models playerRank = new Models()
                                {
                                    PlayerName = reader["PlayerName"].ToString(),
                                    PlayerSurname = reader["PlayerSurname"].ToString(),
                                    Points = Convert.ToInt32(reader["Points"])
                                };
                                playersRank.Add(playerRank);
                            }
                        }
                    }
                }
            }



            return playersRank;
        }
        public IList<Models> PlayersWithoutCoach()
        {
            List<Models> playersWithoutCoach = new List<Models>();
            using(SqlConnection connection = new SqlConnection(_connectionString))
            {
                connection.Open();
                {
                    using (SqlCommand command = new SqlCommand("SELECT PlayerName, PlayerSurname FROM PLAYER INNER JOIN Coach ON Player.CoachID = Coach.CoachID WHERE CoachName = '-'", connection))
                    {
                        using (SqlDataReader reader = command.ExecuteReader())
                        {
                            if (reader.HasRows)
                                while(reader.Read())
                                {
                                    Models playerWithoutCoach = new Models()
                                    {
                                        PlayerName = reader["PlayerName"].ToString(),
                                        PlayerSurname = reader["PlayerSurname"].ToString()
                                    };
                                    playersWithoutCoach.Add(playerWithoutCoach);
                                }

                        }
                    }
                }
            }


            return playersWithoutCoach;
        }
        public IList<Models> AgeASC()
        {
            List<Models> playersAges = new List<Models>();
            using (SqlConnection connection = new SqlConnection(_connectionString))
            {
                connection.Open();
                {
                    using (SqlCommand command = new SqlCommand("SELECT Age,PlayerName, PlayerSurname FROM PLAYER ORDER BY AGE ", connection))
                    {
                        using (SqlDataReader reader = command.ExecuteReader())
                        {
                            if (reader.HasRows)
                                while (reader.Read())
                                {
                                    Models playerAge = new Models()
                                    {
                                        Age = Convert.ToInt32(reader["Age"]),
                                        PlayerName = reader["PlayerName"].ToString(),
                                        PlayerSurname = reader["PlayerSurname"].ToString()
                                    };
                                    playersAges.Add(playerAge);
                                }

                        }
                    }
                }
            }



            return playersAges;
        }
        public IList<Models> AgeDESC()
        {
            List<Models> playersAges = new List<Models>();
            using (SqlConnection connection = new SqlConnection(_connectionString))
            {
                connection.Open();
                {
                    using (SqlCommand command = new SqlCommand("SELECT Age,PlayerName, PlayerSurname FROM PLAYER ORDER BY AGE DESC", connection))
                    {
                        using (SqlDataReader reader = command.ExecuteReader())
                        {
                            if (reader.HasRows)
                                while (reader.Read())
                                {
                                    Models playerAge = new Models()
                                    {
                                        Age = Convert.ToInt32(reader["Age"]),
                                        PlayerName = reader["PlayerName"].ToString(),
                                        PlayerSurname = reader["PlayerSurname"].ToString()
                                    };
                                    playersAges.Add(playerAge);
                                }

                        }
                    }
                }
            }



            return playersAges;
        }
        public IList<Models> HandPlayers()
        {
            List<Models> playersHand = new List<Models>();
            Console.WriteLine("Decide\n1-right hand\n2-left hand");
            //var decide = Convert.ToInt32(Console.ReadLine());
            try
            {
                var decide = Convert.ToInt32(Console.ReadLine());
                if (decide == 1)
                {
                    Console.WriteLine("Right handed players:");
                    using (SqlConnection connection = new SqlConnection(_connectionString))
                    {
                        connection.Open();
                        using (SqlCommand command = new SqlCommand("SELECT PlayerName, PlayerSurname FROM Player WHERE hand = 'right'", connection))
                        {
                            using (SqlDataReader reader = command.ExecuteReader())
                            {
                                if (reader.HasRows)
                                    while (reader.Read())
                                    {
                                        Models playerHand = new Models()
                                        {
                                            PlayerName = reader["PlayerName"].ToString(),
                                            PlayerSurname = reader["PlayerSurname"].ToString()

                                        };
                                        playersHand.Add(playerHand);
                                    }
                            }
                        }

                }   }
                else if(decide == 2)
                {
                    Console.WriteLine("Left handed players:");
                    using (SqlConnection connection = new SqlConnection(_connectionString))
                    {
                        connection.Open();
                        using (SqlCommand command = new SqlCommand("SELECT PlayerName, PlayerSurname FROM Player WHERE hand = 'left'", connection))
                        {
                            using (SqlDataReader reader = command.ExecuteReader())
                            {
                                if (reader.HasRows)
                                    while (reader.Read())
                                    {
                                        Models playerHand = new Models()
                                        {
                                            PlayerName = reader["PlayerName"].ToString(),
                                            PlayerSurname = reader["PlayerSurname"].ToString()

                                        };
                                        playersHand.Add(playerHand);
                                    }
                            }
                        }

                    }
                }
                else if (decide <1 || decide >2)
                {
                    Console.WriteLine("Wrong number");
                }



            }
            
            catch (Exception e)
            {
                Console.WriteLine(e.Message);
                
            }



            return playersHand;
        }



        public IList<Models> BackhandPlayers()
        {
            List<Models> playersBackhand = new List<Models>();
            Console.WriteLine("Decide\n1-two handed backhand\n2-one handed backhand");
            //var decide = Convert.ToInt32(Console.ReadLine());
            try
            {
                var decide = Convert.ToInt32(Console.ReadLine());
                if (decide == 1)
                {
                    Console.WriteLine("Players with two-handed backhands:");
                    using (SqlConnection connection = new SqlConnection(_connectionString))
                    {
                        connection.Open();
                        using (SqlCommand command = new SqlCommand("SELECT PlayerName, PlayerSurname FROM Player WHERE backhand = 'double'", connection))
                        {
                            using (SqlDataReader reader = command.ExecuteReader())
                            {
                                if (reader.HasRows)
                                    while (reader.Read())
                                    {
                                        Models playerBackhand = new Models()
                                        {
                                            PlayerName = reader["PlayerName"].ToString(),
                                            PlayerSurname = reader["PlayerSurname"].ToString()

                                        };
                                        playersBackhand.Add(playerBackhand);
                                    }
                            }
                        }

                    }
                }
                else if (decide == 2)
                {
                    Console.WriteLine("Players with one-handed backhands:");
                    using (SqlConnection connection = new SqlConnection(_connectionString))
                    {
                        connection.Open();
                        using (SqlCommand command = new SqlCommand("SELECT PlayerName, PlayerSurname FROM Player WHERE backhand = 'one'", connection))
                        {
                            using (SqlDataReader reader = command.ExecuteReader())
                            {
                                if (reader.HasRows)
                                    while (reader.Read())
                                    {
                                        Models playerBackhand = new Models()
                                        {
                                            PlayerName = reader["PlayerName"].ToString(),
                                            PlayerSurname = reader["PlayerSurname"].ToString()

                                        };
                                        playersBackhand.Add(playerBackhand);
                                    }
                            }
                        }

                    }
                }
                else if (decide < 1 || decide > 2)
                {
                    Console.WriteLine("Wrong number");
                }



            }

            catch (Exception e)
            {
                Console.WriteLine(e.Message);

            }



            return playersBackhand;
        }

    }
}
