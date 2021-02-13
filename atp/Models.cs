using System;
using System.Collections.Generic;
using System.Text;

namespace atp
{
    class Models
    {
        public int PlayerID { get; set; }

        public string PlayerName { get; set; }

        public string PlayerSurname { get; set; }

        public int CountryID { get; set; }

        public string CountryName { get; set; }

        public string Hand { get; set; }

        public string Backhand { get; set; }

        public int SurfaceID { get; set; }

        public string SurfaceName { get; set; }

        public int CoachID { get; set; }

        public int Age { get; set; }

        public int Points { get; set; }

        public string CoachName { get; set; }

        public string CoachSurname { get; set; }


        public int NumberOfPlayers { get; internal set; }
    }
}
