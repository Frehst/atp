using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Diagnostics;
using System.Linq;

namespace atp
{
    class Program
    {
        static void Main(string[] args)
        {
            Players players = new Players(@"Data Source=localhost;Initial Catalog=ATPrank;Integrated Security=True");
            Coach coaches = new Coach(@"Data Source=localhost;Initial Catalog=ATPrank;Integrated Security=True");
            Countries countries = new Countries(@"Data Source=localhost;Initial Catalog=ATPrank;Integrated Security=True");
            Surface surface = new Surface(@"Data Source=localhost;Initial Catalog=ATPrank;Integrated Security=True");

            //IList<Models> CoachModels = coaches.FullName();
            //IList<Models> SurfaceModels = surface.Info();
            IList<Models> PlayerModels = players.View();



            List<string> CountryList = new List<string>();
            List<string> Countrylist = new List<string>();

            int decision = 1;

            Console.WriteLine("ATP RANK");
            do
            {
                Console.WriteLine("\n\n\nDecide what you want to do:\n0-quit\n1-Get list all players(name surname)\n2-Get list all coaches(name surname)" +
                                   "\n3-Get list all countries\n4-Insert new Player\n5-View \n6-Rank\n" +
                                   "7-Players without coach\n8-Group by age ASC\n9-Group by age DESC\n" +
                                   "10-Group by Hand(right or left)\n11-Group by Backhand(one-handed double)\n12-Surface info\n13-Top country in the rank"
                                   );
                try
                {
                    decision = Convert.ToInt32(Console.ReadLine());

                    switch (decision)
                    {
                        case 1:
                            foreach (var player in players.GetList())
                            {
                                Console.WriteLine("{0} {1}", player.PlayerName, player.PlayerSurname);
                            }
                            break;

                        case 2:
                            foreach (var coach in coaches.FullName())
                            {
                                Console.WriteLine("{0} {1}", coach.CoachName, coach.CoachSurname);
                            }
                            break;

                        case 3:
                            foreach (var country in countries.AllInfo())
                            {
                                Console.WriteLine("{0} {1}", country.CountryID, country.CountryName);
                            }
                            break;

                        case 4:
                            players.Insert();
                            break;

                        case 5:
                            foreach (var PlayerModel in players.View())
                            {
                                var idLength = 5 - PlayerModel.PlayerID.ToString().Length;
                                var nameLength = 11 - PlayerModel.PlayerName.ToString().Length;
                                var surnameLength = 17 - PlayerModel.PlayerSurname.ToString().Length;
                                var countryLength = 14 - PlayerModel.CountryName.ToString().Length;
                                var handLength = 5 - PlayerModel.Hand.ToString().Length;
                                var backhandLength = 6 - PlayerModel.Backhand.ToString().Length;
                                var surfaceLength = 5 - PlayerModel.SurfaceName.ToString().Length;
                                var coachName = 9 - PlayerModel.CoachName.ToString().Length;
                                var coachSurname = 13 - PlayerModel.CoachSurname.ToString().Length;
                                var pointsLength = 5 - PlayerModel.Points.ToString().Length;


                                Console.WriteLine(String.Format("{0}  ", PlayerModel.PlayerID + new String(' ', idLength) + ("|")
                                                 + (PlayerModel.PlayerName) + new String(' ', nameLength) + "|")
                                                + (PlayerModel.PlayerSurname + new String(' ', surnameLength) + "|")
                                                + (PlayerModel.CountryName + new String(' ', countryLength) + "|")
                                                + (PlayerModel.Hand + new String(' ', handLength + 2) + "|")
                                                + (PlayerModel.Backhand + new String(' ', backhandLength + 2) + "|")
                                                + (PlayerModel.SurfaceName + new String(' ', surfaceLength + 1) + "|")
                                                + (PlayerModel.CoachName + new String(' ', coachName) + "|")
                                                + (PlayerModel.CoachSurname + new String(' ', coachSurname) + "|")
                                                + (PlayerModel.Age + "  |")
                                                + (PlayerModel.Points + new String(' ', pointsLength + 1) + "|")
                                                );

                            }
                            break;
                        case 6:
                            foreach (var Player in players.Rank())
                            {
                                Console.ForegroundColor = ConsoleColor.Green;
                                Console.Write("Points: ");
                                Console.ResetColor();
                                Console.ForegroundColor = ConsoleColor.Red;
                                Console.Write("{0} ", Player.Points);
                                Console.ResetColor();
                                Console.WriteLine("  {0}  {1}", Player.PlayerName, Player.PlayerSurname);

                            }

                            break;
                        case 7:
                            foreach (var Player in players.PlayersWithoutCoach())
                            {
                                Console.WriteLine("{0} {1}", Player.PlayerName, Player.PlayerSurname);
                            }

                            break;
                        case 8:
                            foreach (var Player in players.AgeASC())
                            {
                                Console.WriteLine("Age {0} {1} {2}", Player.Age, Player.PlayerName, Player.PlayerSurname);
                            }
                            break;
                        case 9:
                            foreach (var Player in players.AgeDESC())
                            {
                                Console.WriteLine("Age {0} {1} {2}", Player.Age, Player.PlayerName, Player.PlayerSurname);
                            }
                            break;
                        case 10:
                            foreach (var Player in players.HandPlayers())
                            {
                                Console.WriteLine("{0} {1} ", Player.PlayerName, Player.PlayerSurname);
                            }

                            break;
                        case 11:
                            foreach (var Player in players.BackhandPlayers())
                            {
                                Console.WriteLine("{0} {1}", Player.PlayerName, Player.PlayerSurname);
                            }
                            break;
                        case 12:
                            foreach (var surf in surface.Info())
                            {
                                Console.WriteLine("{0}", surf.SurfaceName);
                            }
                            break;
                        case 13:
                            foreach(var player in countries.TopPlayers())
                            {
                                Console.WriteLine("{0} {1}",player.NumberOfPlayers , player.CountryName);
                            }

                            break;
                    }
                }
                catch (Exception e)
                {
                    Console.WriteLine(e.Message);
                }




            } while (decision != 0);
            Console.WriteLine("Thank you");


















        }
    }
}
