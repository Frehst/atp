USE [master]
GO
/****** Object:  Database [ATPrank]    Script Date: 13.02.2021 16:37:30 ******/
CREATE DATABASE [ATPrank]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'ATPrank', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\ATPrank.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'ATPrank_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\ATPrank_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [ATPrank] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [ATPrank].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [ATPrank] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [ATPrank] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [ATPrank] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [ATPrank] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [ATPrank] SET ARITHABORT OFF 
GO
ALTER DATABASE [ATPrank] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [ATPrank] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [ATPrank] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [ATPrank] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [ATPrank] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [ATPrank] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [ATPrank] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [ATPrank] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [ATPrank] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [ATPrank] SET  ENABLE_BROKER 
GO
ALTER DATABASE [ATPrank] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [ATPrank] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [ATPrank] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [ATPrank] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [ATPrank] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [ATPrank] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [ATPrank] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [ATPrank] SET RECOVERY FULL 
GO
ALTER DATABASE [ATPrank] SET  MULTI_USER 
GO
ALTER DATABASE [ATPrank] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [ATPrank] SET DB_CHAINING OFF 
GO
ALTER DATABASE [ATPrank] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [ATPrank] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [ATPrank] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [ATPrank] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'ATPrank', N'ON'
GO
ALTER DATABASE [ATPrank] SET QUERY_STORE = OFF
GO
USE [ATPrank]
GO
/****** Object:  Table [dbo].[Surface]    Script Date: 13.02.2021 16:37:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Surface](
	[SurfaceId] [int] IDENTITY(1,1) NOT NULL,
	[SurfaceName] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[SurfaceId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Coach]    Script Date: 13.02.2021 16:37:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Coach](
	[CoachID] [int] IDENTITY(1,1) NOT NULL,
	[CoachName] [varchar](50) NOT NULL,
	[CoachSurname] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[CoachID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Country]    Script Date: 13.02.2021 16:37:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Country](
	[CountryID] [int] IDENTITY(1,1) NOT NULL,
	[CountryName] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[CountryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Player]    Script Date: 13.02.2021 16:37:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Player](
	[PlayerID] [int] IDENTITY(1,1) NOT NULL,
	[PlayerName] [varchar](50) NOT NULL,
	[PlayerSurname] [varchar](50) NOT NULL,
	[CountryID] [int] NOT NULL,
	[Hand] [varchar](20) NOT NULL,
	[Backhand] [varchar](20) NOT NULL,
	[SurfaceID] [int] NOT NULL,
	[CoachID] [int] NOT NULL,
	[Age] [int] NOT NULL,
	[Points] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[PlayerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[ATPRankDetail]    Script Date: 13.02.2021 16:37:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[ATPRankDetail] AS
	SELECT 
	t1.PlayerID,
	t1.PlayerName,
	t1.PlayerSurname,
	t2.CountryName,
	t3.CoachName,
	t3.CoachSurname,
	t1.Points,
	t1.Age,
	t4.SurfaceName,
	t1.Hand,
	t1.Backhand
	FROM 
	Player t1
	INNER JOIN 
	Country t2 ON t2.CountryID = t1.CountryID
	INNER JOIN
	Coach t3 ON t3.CoachID  = t1.CoachID
	INNER JOIN
	Surface t4 ON t4.SurfaceId = t1.SurfaceID
GO
SET IDENTITY_INSERT [dbo].[Coach] ON 
GO
INSERT [dbo].[Coach] ([CoachID], [CoachName], [CoachSurname]) VALUES (1, N'Marian', N'Vajda')
GO
INSERT [dbo].[Coach] ([CoachID], [CoachName], [CoachSurname]) VALUES (2, N'Carlos', N'Moya')
GO
INSERT [dbo].[Coach] ([CoachID], [CoachName], [CoachSurname]) VALUES (3, N'Nicolas', N'Massu')
GO
INSERT [dbo].[Coach] ([CoachID], [CoachName], [CoachSurname]) VALUES (4, N'Gilles', N'Cervara')
GO
INSERT [dbo].[Coach] ([CoachID], [CoachName], [CoachSurname]) VALUES (5, N'Ivan', N'Ljubicic')
GO
INSERT [dbo].[Coach] ([CoachID], [CoachName], [CoachSurname]) VALUES (6, N'Apostolos', N'Tsitsipas')
GO
INSERT [dbo].[Coach] ([CoachID], [CoachName], [CoachSurname]) VALUES (7, N'Alexander', N'Zverev Sr.')
GO
INSERT [dbo].[Coach] ([CoachID], [CoachName], [CoachSurname]) VALUES (8, N'Fernando', N'Vincente')
GO
INSERT [dbo].[Coach] ([CoachID], [CoachName], [CoachSurname]) VALUES (9, N'Leonardo', N'Olguin')
GO
INSERT [dbo].[Coach] ([CoachID], [CoachName], [CoachSurname]) VALUES (10, N'Umberto', N'Riana')
GO
INSERT [dbo].[Coach] ([CoachID], [CoachName], [CoachSurname]) VALUES (11, N'Liam', N'Smith')
GO
INSERT [dbo].[Coach] ([CoachID], [CoachName], [CoachSurname]) VALUES (12, N'Mikhail', N'Youzhny')
GO
INSERT [dbo].[Coach] ([CoachID], [CoachName], [CoachSurname]) VALUES (13, N'Pepe', N'Vendrell')
GO
INSERT [dbo].[Coach] ([CoachID], [CoachName], [CoachSurname]) VALUES (14, N'Germain', N'Gigouon')
GO
INSERT [dbo].[Coach] ([CoachID], [CoachName], [CoachSurname]) VALUES (15, N'Mario', N'Tudo')
GO
INSERT [dbo].[Coach] ([CoachID], [CoachName], [CoachSurname]) VALUES (16, N'Samuel', N'Lopez')
GO
INSERT [dbo].[Coach] ([CoachID], [CoachName], [CoachSurname]) VALUES (17, N'Alberto', N'Mancini')
GO
INSERT [dbo].[Coach] ([CoachID], [CoachName], [CoachSurname]) VALUES (18, N'Daniel', N'Vallverdu')
GO
INSERT [dbo].[Coach] ([CoachID], [CoachName], [CoachSurname]) VALUES (19, N'Dante', N'Bottini')
GO
INSERT [dbo].[Coach] ([CoachID], [CoachName], [CoachSurname]) VALUES (20, N'Fredrik', N'Rosengren')
GO
INSERT [dbo].[Coach] ([CoachID], [CoachName], [CoachSurname]) VALUES (21, N'Fredric', N'Fontang')
GO
INSERT [dbo].[Coach] ([CoachID], [CoachName], [CoachSurname]) VALUES (22, N'Franco', N'Davin')
GO
INSERT [dbo].[Coach] ([CoachID], [CoachName], [CoachSurname]) VALUES (23, N'Adolfo', N'Gutierrez')
GO
INSERT [dbo].[Coach] ([CoachID], [CoachName], [CoachSurname]) VALUES (24, N'David', N'Macpherson')
GO
INSERT [dbo].[Coach] ([CoachID], [CoachName], [CoachSurname]) VALUES (25, N'Martin', N'Stepanek')
GO
INSERT [dbo].[Coach] ([CoachID], [CoachName], [CoachSurname]) VALUES (26, N'Jose', N'Perlas')
GO
INSERT [dbo].[Coach] ([CoachID], [CoachName], [CoachSurname]) VALUES (27, N'Christian', N'Ruud')
GO
INSERT [dbo].[Coach] ([CoachID], [CoachName], [CoachSurname]) VALUES (28, N'David', N'Guez')
GO
INSERT [dbo].[Coach] ([CoachID], [CoachName], [CoachSurname]) VALUES (29, N'Craig', N'Boynton')
GO
INSERT [dbo].[Coach] ([CoachID], [CoachName], [CoachSurname]) VALUES (30, N'Paul', N'Annacone')
GO
INSERT [dbo].[Coach] ([CoachID], [CoachName], [CoachSurname]) VALUES (31, N'Janko', N'Tipsarevic')
GO
INSERT [dbo].[Coach] ([CoachID], [CoachName], [CoachSurname]) VALUES (32, N'Nicolas', N'Copin')
GO
INSERT [dbo].[Coach] ([CoachID], [CoachName], [CoachSurname]) VALUES (33, N'David', N'Felgate')
GO
INSERT [dbo].[Coach] ([CoachID], [CoachName], [CoachSurname]) VALUES (34, N'Gipo', N'Arbino')
GO
INSERT [dbo].[Coach] ([CoachID], [CoachName], [CoachSurname]) VALUES (35, N'Ervan', N'Tortuyaux ')
GO
INSERT [dbo].[Coach] ([CoachID], [CoachName], [CoachSurname]) VALUES (36, N'Ricardo', N'Piatti')
GO
INSERT [dbo].[Coach] ([CoachID], [CoachName], [CoachSurname]) VALUES (37, N'Carsten', N'Arriens')
GO
INSERT [dbo].[Coach] ([CoachID], [CoachName], [CoachSurname]) VALUES (38, N'-', N'-')
GO
INSERT [dbo].[Coach] ([CoachID], [CoachName], [CoachSurname]) VALUES (39, N'Jan', N'De Wit')
GO
INSERT [dbo].[Coach] ([CoachID], [CoachName], [CoachSurname]) VALUES (40, N'Jay', N'Berger')
GO
INSERT [dbo].[Coach] ([CoachID], [CoachName], [CoachSurname]) VALUES (41, N'Michael', N'Chang')
GO
INSERT [dbo].[Coach] ([CoachID], [CoachName], [CoachSurname]) VALUES (42, N'Miro', N'Hrvatin')
GO
INSERT [dbo].[Coach] ([CoachID], [CoachName], [CoachSurname]) VALUES (43, N'Vedran', N'Martic')
GO
INSERT [dbo].[Coach] ([CoachID], [CoachName], [CoachSurname]) VALUES (44, N'Jose', N'Acacuso')
GO
INSERT [dbo].[Coach] ([CoachID], [CoachName], [CoachSurname]) VALUES (45, N'Stanislav', N'Bublik')
GO
INSERT [dbo].[Coach] ([CoachID], [CoachName], [CoachSurname]) VALUES (46, N'Noe', N'Losmozos')
GO
INSERT [dbo].[Coach] ([CoachID], [CoachName], [CoachSurname]) VALUES (47, N'-', N'-')
GO
INSERT [dbo].[Coach] ([CoachID], [CoachName], [CoachSurname]) VALUES (48, N'Julien', N'Casaigne')
GO
INSERT [dbo].[Coach] ([CoachID], [CoachName], [CoachSurname]) VALUES (49, N'Colin', N'Beecher')
GO
INSERT [dbo].[Coach] ([CoachID], [CoachName], [CoachSurname]) VALUES (50, N'Michael', N'Russel')
GO
INSERT [dbo].[Coach] ([CoachID], [CoachName], [CoachSurname]) VALUES (51, N'Peter', N'Smith')
GO
INSERT [dbo].[Coach] ([CoachID], [CoachName], [CoachSurname]) VALUES (52, N'Jaymon', N'Crabb')
GO
INSERT [dbo].[Coach] ([CoachID], [CoachName], [CoachSurname]) VALUES (53, N'Brad', N'Stine')
GO
INSERT [dbo].[Coach] ([CoachID], [CoachName], [CoachSurname]) VALUES (54, N'Jorge', N'Aguirre')
GO
INSERT [dbo].[Coach] ([CoachID], [CoachName], [CoachSurname]) VALUES (55, N'Zoltan', N'Nagy')
GO
INSERT [dbo].[Coach] ([CoachID], [CoachName], [CoachSurname]) VALUES (56, N'Eduardo', N'Infantiono')
GO
INSERT [dbo].[Coach] ([CoachID], [CoachName], [CoachSurname]) VALUES (57, N'Mitsuru', N'Takda')
GO
INSERT [dbo].[Coach] ([CoachID], [CoachName], [CoachSurname]) VALUES (58, N'Markus', N'Wislsperger')
GO
INSERT [dbo].[Coach] ([CoachID], [CoachName], [CoachSurname]) VALUES (59, N'Carlos', N'Rodriguez')
GO
INSERT [dbo].[Coach] ([CoachID], [CoachName], [CoachSurname]) VALUES (60, N'Thierry', N'Ascione')
GO
INSERT [dbo].[Coach] ([CoachID], [CoachName], [CoachSurname]) VALUES (61, N'Frank', N'Dancevic')
GO
INSERT [dbo].[Coach] ([CoachID], [CoachName], [CoachSurname]) VALUES (62, N'Wayne', N'Ferreira')
GO
INSERT [dbo].[Coach] ([CoachID], [CoachName], [CoachSurname]) VALUES (63, N'-', N'-')
GO
INSERT [dbo].[Coach] ([CoachID], [CoachName], [CoachSurname]) VALUES (64, N'Etienne', N'Lafourge')
GO
INSERT [dbo].[Coach] ([CoachID], [CoachName], [CoachSurname]) VALUES (65, N'Diego', N'Dinomo')
GO
INSERT [dbo].[Coach] ([CoachID], [CoachName], [CoachSurname]) VALUES (66, N'James', N'Davidson')
GO
INSERT [dbo].[Coach] ([CoachID], [CoachName], [CoachSurname]) VALUES (67, N'Facunod', N'Lugones')
GO
INSERT [dbo].[Coach] ([CoachID], [CoachName], [CoachSurname]) VALUES (68, N'Rhyne', N'Williams')
GO
INSERT [dbo].[Coach] ([CoachID], [CoachName], [CoachSurname]) VALUES (69, N'Jaroslav', N'Navratil')
GO
INSERT [dbo].[Coach] ([CoachID], [CoachName], [CoachSurname]) VALUES (70, N'Facundo', N'Savio')
GO
INSERT [dbo].[Coach] ([CoachID], [CoachName], [CoachSurname]) VALUES (71, N'Simone', N'Vagnozzi')
GO
INSERT [dbo].[Coach] ([CoachID], [CoachName], [CoachSurname]) VALUES (72, N'Dirk', N'Hordorff')
GO
INSERT [dbo].[Coach] ([CoachID], [CoachName], [CoachSurname]) VALUES (73, N'Evan', N'Lee')
GO
INSERT [dbo].[Coach] ([CoachID], [CoachName], [CoachSurname]) VALUES (74, N'Nicolas', N'Renavand')
GO
INSERT [dbo].[Coach] ([CoachID], [CoachName], [CoachSurname]) VALUES (75, N'Peter', N'Smith')
GO
INSERT [dbo].[Coach] ([CoachID], [CoachName], [CoachSurname]) VALUES (76, N'Paolo', N'Cannova')
GO
INSERT [dbo].[Coach] ([CoachID], [CoachName], [CoachSurname]) VALUES (77, N'Mariano', N'Monachesi')
GO
INSERT [dbo].[Coach] ([CoachID], [CoachName], [CoachSurname]) VALUES (78, N'Arturs', N'Kazijevs')
GO
INSERT [dbo].[Coach] ([CoachID], [CoachName], [CoachSurname]) VALUES (79, N'Massimo', N'Sartori')
GO
INSERT [dbo].[Coach] ([CoachID], [CoachName], [CoachSurname]) VALUES (80, N'Laurent', N'Raymond')
GO
INSERT [dbo].[Coach] ([CoachID], [CoachName], [CoachSurname]) VALUES (81, N'Sebastian', N'Prieto')
GO
INSERT [dbo].[Coach] ([CoachID], [CoachName], [CoachSurname]) VALUES (82, N'Diego', N'Moyano')
GO
INSERT [dbo].[Coach] ([CoachID], [CoachName], [CoachSurname]) VALUES (83, N'Fabian', N'Blengino')
GO
INSERT [dbo].[Coach] ([CoachID], [CoachName], [CoachSurname]) VALUES (84, N'Benjamin', N'Ballert')
GO
INSERT [dbo].[Coach] ([CoachID], [CoachName], [CoachSurname]) VALUES (85, N'Magnus', N'Tideman')
GO
INSERT [dbo].[Coach] ([CoachID], [CoachName], [CoachSurname]) VALUES (86, N'Federico', N'Ricci')
GO
INSERT [dbo].[Coach] ([CoachID], [CoachName], [CoachSurname]) VALUES (87, N'Daniel', N'Gimeno-Traver')
GO
INSERT [dbo].[Coach] ([CoachID], [CoachName], [CoachSurname]) VALUES (88, N'Tibor', N'Toth')
GO
INSERT [dbo].[Coach] ([CoachID], [CoachName], [CoachSurname]) VALUES (89, N'-', N'-')
GO
INSERT [dbo].[Coach] ([CoachID], [CoachName], [CoachSurname]) VALUES (90, N'Anthony', N'Harris')
GO
INSERT [dbo].[Coach] ([CoachID], [CoachName], [CoachSurname]) VALUES (91, N'Andres', N'Schneiter')
GO
INSERT [dbo].[Coach] ([CoachID], [CoachName], [CoachSurname]) VALUES (92, N'Frederico', N'Marques')
GO
INSERT [dbo].[Coach] ([CoachID], [CoachName], [CoachSurname]) VALUES (93, N'Daniel', N'Szendrei')
GO
INSERT [dbo].[Coach] ([CoachID], [CoachName], [CoachSurname]) VALUES (94, N'Fredrik', N'Nielsen')
GO
INSERT [dbo].[Coach] ([CoachID], [CoachName], [CoachSurname]) VALUES (95, N'Matteo', N'Civarolo')
GO
INSERT [dbo].[Coach] ([CoachID], [CoachName], [CoachSurname]) VALUES (96, N'Daniel', N'Yoo')
GO
INSERT [dbo].[Coach] ([CoachID], [CoachName], [CoachSurname]) VALUES (97, N'Pere', N'Riba')
GO
INSERT [dbo].[Coach] ([CoachID], [CoachName], [CoachSurname]) VALUES (98, N'Markus', N'Hipfl')
GO
INSERT [dbo].[Coach] ([CoachID], [CoachName], [CoachSurname]) VALUES (99, N'Wolfgang', N'Thiem')
GO
INSERT [dbo].[Coach] ([CoachID], [CoachName], [CoachSurname]) VALUES (100, N'Lukas', N'Wolff')
GO
SET IDENTITY_INSERT [dbo].[Coach] OFF
GO
SET IDENTITY_INSERT [dbo].[Country] ON 
GO
INSERT [dbo].[Country] ([CountryID], [CountryName]) VALUES (1, N'Spain')
GO
INSERT [dbo].[Country] ([CountryID], [CountryName]) VALUES (2, N'France')
GO
INSERT [dbo].[Country] ([CountryID], [CountryName]) VALUES (3, N'Brazil')
GO
INSERT [dbo].[Country] ([CountryID], [CountryName]) VALUES (4, N'Germany')
GO
INSERT [dbo].[Country] ([CountryID], [CountryName]) VALUES (5, N'Poland')
GO
INSERT [dbo].[Country] ([CountryID], [CountryName]) VALUES (6, N'Russia')
GO
INSERT [dbo].[Country] ([CountryID], [CountryName]) VALUES (7, N'Ukraine')
GO
INSERT [dbo].[Country] ([CountryID], [CountryName]) VALUES (8, N'Belgium')
GO
INSERT [dbo].[Country] ([CountryID], [CountryName]) VALUES (9, N'Belarus')
GO
INSERT [dbo].[Country] ([CountryID], [CountryName]) VALUES (10, N'Czech Republic')
GO
INSERT [dbo].[Country] ([CountryID], [CountryName]) VALUES (11, N'Argentina')
GO
INSERT [dbo].[Country] ([CountryID], [CountryName]) VALUES (12, N'Mexico')
GO
INSERT [dbo].[Country] ([CountryID], [CountryName]) VALUES (13, N'USA')
GO
INSERT [dbo].[Country] ([CountryID], [CountryName]) VALUES (14, N'Latvia')
GO
INSERT [dbo].[Country] ([CountryID], [CountryName]) VALUES (15, N'Portugal')
GO
INSERT [dbo].[Country] ([CountryID], [CountryName]) VALUES (16, N'Norway')
GO
INSERT [dbo].[Country] ([CountryID], [CountryName]) VALUES (17, N'Finland')
GO
INSERT [dbo].[Country] ([CountryID], [CountryName]) VALUES (18, N'Denmark')
GO
INSERT [dbo].[Country] ([CountryID], [CountryName]) VALUES (19, N'Greece')
GO
INSERT [dbo].[Country] ([CountryID], [CountryName]) VALUES (20, N'Switzerland')
GO
INSERT [dbo].[Country] ([CountryID], [CountryName]) VALUES (21, N'Sweeden')
GO
INSERT [dbo].[Country] ([CountryID], [CountryName]) VALUES (22, N'Italy')
GO
INSERT [dbo].[Country] ([CountryID], [CountryName]) VALUES (23, N'Canada')
GO
INSERT [dbo].[Country] ([CountryID], [CountryName]) VALUES (24, N'Bulgaria')
GO
INSERT [dbo].[Country] ([CountryID], [CountryName]) VALUES (25, N'Chile')
GO
INSERT [dbo].[Country] ([CountryID], [CountryName]) VALUES (26, N'Australia')
GO
INSERT [dbo].[Country] ([CountryID], [CountryName]) VALUES (27, N'Croatia')
GO
INSERT [dbo].[Country] ([CountryID], [CountryName]) VALUES (28, N'Serbia')
GO
INSERT [dbo].[Country] ([CountryID], [CountryName]) VALUES (29, N'Great Britain')
GO
INSERT [dbo].[Country] ([CountryID], [CountryName]) VALUES (30, N'Georgia')
GO
INSERT [dbo].[Country] ([CountryID], [CountryName]) VALUES (31, N'Japan')
GO
INSERT [dbo].[Country] ([CountryID], [CountryName]) VALUES (32, N'Kazakhstan')
GO
INSERT [dbo].[Country] ([CountryID], [CountryName]) VALUES (33, N'Hungary')
GO
INSERT [dbo].[Country] ([CountryID], [CountryName]) VALUES (34, N'Slovenia')
GO
INSERT [dbo].[Country] ([CountryID], [CountryName]) VALUES (35, N'Slovakia')
GO
INSERT [dbo].[Country] ([CountryID], [CountryName]) VALUES (36, N'Austria')
GO
INSERT [dbo].[Country] ([CountryID], [CountryName]) VALUES (37, N'Uruguay')
GO
INSERT [dbo].[Country] ([CountryID], [CountryName]) VALUES (38, N'Lithuania')
GO
INSERT [dbo].[Country] ([CountryID], [CountryName]) VALUES (39, N'RSA')
GO
INSERT [dbo].[Country] ([CountryID], [CountryName]) VALUES (40, N'Moldova')
GO
SET IDENTITY_INSERT [dbo].[Country] OFF
GO
SET IDENTITY_INSERT [dbo].[Player] ON 
GO
INSERT [dbo].[Player] ([PlayerID], [PlayerName], [PlayerSurname], [CountryID], [Hand], [Backhand], [SurfaceID], [CoachID], [Age], [Points]) VALUES (1, N'Novak', N'Djokovic', 28, N'right', N'double', 2, 1, 33, 12030)
GO
INSERT [dbo].[Player] ([PlayerID], [PlayerName], [PlayerSurname], [CountryID], [Hand], [Backhand], [SurfaceID], [CoachID], [Age], [Points]) VALUES (2, N'Rafael', N'Nadal', 1, N'left', N'double', 3, 2, 34, 9850)
GO
INSERT [dbo].[Player] ([PlayerID], [PlayerName], [PlayerSurname], [CountryID], [Hand], [Backhand], [SurfaceID], [CoachID], [Age], [Points]) VALUES (3, N'Dominic', N'Thiem', 36, N'right', N'one', 3, 3, 27, 9125)
GO
INSERT [dbo].[Player] ([PlayerID], [PlayerName], [PlayerSurname], [CountryID], [Hand], [Backhand], [SurfaceID], [CoachID], [Age], [Points]) VALUES (4, N'Danil', N'Medvedev', 6, N'right', N'double', 2, 4, 24, 8470)
GO
INSERT [dbo].[Player] ([PlayerID], [PlayerName], [PlayerSurname], [CountryID], [Hand], [Backhand], [SurfaceID], [CoachID], [Age], [Points]) VALUES (5, N'Roger', N'Federer', 20, N'right', N'one', 1, 5, 39, 6630)
GO
INSERT [dbo].[Player] ([PlayerID], [PlayerName], [PlayerSurname], [CountryID], [Hand], [Backhand], [SurfaceID], [CoachID], [Age], [Points]) VALUES (6, N'Stefanos', N'Tsitsipas', 19, N'right', N'one', 3, 6, 22, 5940)
GO
INSERT [dbo].[Player] ([PlayerID], [PlayerName], [PlayerSurname], [CountryID], [Hand], [Backhand], [SurfaceID], [CoachID], [Age], [Points]) VALUES (7, N'Alexander', N'Zverev', 4, N'right', N'double', 2, 7, 23, 5615)
GO
INSERT [dbo].[Player] ([PlayerID], [PlayerName], [PlayerSurname], [CountryID], [Hand], [Backhand], [SurfaceID], [CoachID], [Age], [Points]) VALUES (8, N'Andrey', N'Rublev', 6, N'right', N'double', 2, 8, 23, 4164)
GO
INSERT [dbo].[Player] ([PlayerID], [PlayerName], [PlayerSurname], [CountryID], [Hand], [Backhand], [SurfaceID], [CoachID], [Age], [Points]) VALUES (9, N'Diego', N'Schwarzmann', 11, N'right', N'double', 3, 9, 28, 3455)
GO
INSERT [dbo].[Player] ([PlayerID], [PlayerName], [PlayerSurname], [CountryID], [Hand], [Backhand], [SurfaceID], [CoachID], [Age], [Points]) VALUES (10, N'Matteo', N'Berettini', 22, N'right', N'double', 3, 10, 24, 3120)
GO
INSERT [dbo].[Player] ([PlayerID], [PlayerName], [PlayerSurname], [CountryID], [Hand], [Backhand], [SurfaceID], [CoachID], [Age], [Points]) VALUES (11, N'Gael', N'Monfils', 2, N'right', N'double', 2, 11, 34, 2860)
GO
INSERT [dbo].[Player] ([PlayerID], [PlayerName], [PlayerSurname], [CountryID], [Hand], [Backhand], [SurfaceID], [CoachID], [Age], [Points]) VALUES (12, N'Denis', N'Shapovalov', 23, N'left', N'one', 1, 12, 21, 2830)
GO
INSERT [dbo].[Player] ([PlayerID], [PlayerName], [PlayerSurname], [CountryID], [Hand], [Backhand], [SurfaceID], [CoachID], [Age], [Points]) VALUES (13, N'Roberto', N'Bautisa Agut', 1, N'right', N'double', 2, 13, 29, 2710)
GO
INSERT [dbo].[Player] ([PlayerID], [PlayerName], [PlayerSurname], [CountryID], [Hand], [Backhand], [SurfaceID], [CoachID], [Age], [Points]) VALUES (14, N'David', N'Goffin', 8, N'right', N'double', 2, 14, 30, 2600)
GO
INSERT [dbo].[Player] ([PlayerID], [PlayerName], [PlayerSurname], [CountryID], [Hand], [Backhand], [SurfaceID], [CoachID], [Age], [Points]) VALUES (15, N'Milos', N'Raonic', 23, N'right', N'double', 2, 15, 30, 2580)
GO
INSERT [dbo].[Player] ([PlayerID], [PlayerName], [PlayerSurname], [CountryID], [Hand], [Backhand], [SurfaceID], [CoachID], [Age], [Points]) VALUES (16, N'Pablo', N'Carreno Busta', 1, N'right', N'double', 3, 16, 29, 2580)
GO
INSERT [dbo].[Player] ([PlayerID], [PlayerName], [PlayerSurname], [CountryID], [Hand], [Backhand], [SurfaceID], [CoachID], [Age], [Points]) VALUES (17, N'Fabio', N'Fognini', 22, N'right', N'double', 3, 17, 33, 2420)
GO
INSERT [dbo].[Player] ([PlayerID], [PlayerName], [PlayerSurname], [CountryID], [Hand], [Backhand], [SurfaceID], [CoachID], [Age], [Points]) VALUES (18, N'Stan', N'Wawrinka', 20, N'right', N'one', 2, 18, 35, 2365)
GO
INSERT [dbo].[Player] ([PlayerID], [PlayerName], [PlayerSurname], [CountryID], [Hand], [Backhand], [SurfaceID], [CoachID], [Age], [Points]) VALUES (19, N'Grigor', N'Dimitrov', 24, N'right', N'one', 2, 19, 29, 2260)
GO
INSERT [dbo].[Player] ([PlayerID], [PlayerName], [PlayerSurname], [CountryID], [Hand], [Backhand], [SurfaceID], [CoachID], [Age], [Points]) VALUES (20, N'Karen', N'Khachanov', 6, N'right', N'double', 2, 20, 24, 2245)
GO
INSERT [dbo].[Player] ([PlayerID], [PlayerName], [PlayerSurname], [CountryID], [Hand], [Backhand], [SurfaceID], [CoachID], [Age], [Points]) VALUES (21, N'Felix', N'Auger Aliassime', 23, N'right', N'double', 3, 21, 20, 2241)
GO
INSERT [dbo].[Player] ([PlayerID], [PlayerName], [PlayerSurname], [CountryID], [Hand], [Backhand], [SurfaceID], [CoachID], [Age], [Points]) VALUES (22, N'Cristian', N'Garin', 25, N'right', N'double', 3, 22, 24, 2180)
GO
INSERT [dbo].[Player] ([PlayerID], [PlayerName], [PlayerSurname], [CountryID], [Hand], [Backhand], [SurfaceID], [CoachID], [Age], [Points]) VALUES (23, N'Alex', N'De Minaur', 26, N'right', N'double', 2, 23, 21, 2065)
GO
INSERT [dbo].[Player] ([PlayerID], [PlayerName], [PlayerSurname], [CountryID], [Hand], [Backhand], [SurfaceID], [CoachID], [Age], [Points]) VALUES (24, N'John', N'Isner', 13, N'right', N'double', 2, 24, 35, 1895)
GO
INSERT [dbo].[Player] ([PlayerID], [PlayerName], [PlayerSurname], [CountryID], [Hand], [Backhand], [SurfaceID], [CoachID], [Age], [Points]) VALUES (25, N'Borna', N'Coric', 27, N'right', N'double', 3, 25, 24, 1885)
GO
INSERT [dbo].[Player] ([PlayerID], [PlayerName], [PlayerSurname], [CountryID], [Hand], [Backhand], [SurfaceID], [CoachID], [Age], [Points]) VALUES (26, N'Dusan', N'Lajovic', 28, N'right', N'one', 1, 26, 30, 1785)
GO
INSERT [dbo].[Player] ([PlayerID], [PlayerName], [PlayerSurname], [CountryID], [Hand], [Backhand], [SurfaceID], [CoachID], [Age], [Points]) VALUES (27, N'Casper', N'Ruud', 16, N'right', N'double', 3, 27, 22, 1739)
GO
INSERT [dbo].[Player] ([PlayerID], [PlayerName], [PlayerSurname], [CountryID], [Hand], [Backhand], [SurfaceID], [CoachID], [Age], [Points]) VALUES (28, N'Benoit', N'Paire', 2, N'right', N'double', 2, 28, 31, 1738)
GO
INSERT [dbo].[Player] ([PlayerID], [PlayerName], [PlayerSurname], [CountryID], [Hand], [Backhand], [SurfaceID], [CoachID], [Age], [Points]) VALUES (29, N'Hubert', N'Hurkacz', 5, N'right', N'double', 2, 29, 23, 1735)
GO
INSERT [dbo].[Player] ([PlayerID], [PlayerName], [PlayerSurname], [CountryID], [Hand], [Backhand], [SurfaceID], [CoachID], [Age], [Points]) VALUES (30, N'Taylor', N'Fritz', 13, N'right', N'double', 2, 30, 23, 1695)
GO
INSERT [dbo].[Player] ([PlayerID], [PlayerName], [PlayerSurname], [CountryID], [Hand], [Backhand], [SurfaceID], [CoachID], [Age], [Points]) VALUES (31, N'Filip', N'Krajinovic', 28, N'right', N'double', 2, 31, 28, 1673)
GO
INSERT [dbo].[Player] ([PlayerID], [PlayerName], [PlayerSurname], [CountryID], [Hand], [Backhand], [SurfaceID], [CoachID], [Age], [Points]) VALUES (32, N'Ugo', N'Humbert', 2, N'left', N'double', 2, 32, 22, 1671)
GO
INSERT [dbo].[Player] ([PlayerID], [PlayerName], [PlayerSurname], [CountryID], [Hand], [Backhand], [SurfaceID], [CoachID], [Age], [Points]) VALUES (33, N'Daniel', N'Evans', 29, N'right', N'double', 1, 33, 30, 1589)
GO
INSERT [dbo].[Player] ([PlayerID], [PlayerName], [PlayerSurname], [CountryID], [Hand], [Backhand], [SurfaceID], [CoachID], [Age], [Points]) VALUES (34, N'Lorenzo', N'Sonego', 22, N'right', N'double', 3, 34, 25, 1588)
GO
INSERT [dbo].[Player] ([PlayerID], [PlayerName], [PlayerSurname], [CountryID], [Hand], [Backhand], [SurfaceID], [CoachID], [Age], [Points]) VALUES (35, N'Adrian', N'Mannarino', 2, N'left', N'double', 3, 35, 34, 1561)
GO
INSERT [dbo].[Player] ([PlayerID], [PlayerName], [PlayerSurname], [CountryID], [Hand], [Backhand], [SurfaceID], [CoachID], [Age], [Points]) VALUES (36, N'Jannik', N'Sinner', 22, N'right', N'double', 2, 36, 19, 1464)
GO
INSERT [dbo].[Player] ([PlayerID], [PlayerName], [PlayerSurname], [CountryID], [Hand], [Backhand], [SurfaceID], [CoachID], [Age], [Points]) VALUES (37, N'Jan-Lennard', N'Struff', 4, N'right', N'double', 3, 37, 30, 1450)
GO
INSERT [dbo].[Player] ([PlayerID], [PlayerName], [PlayerSurname], [CountryID], [Hand], [Backhand], [SurfaceID], [CoachID], [Age], [Points]) VALUES (38, N'John', N'Millman', 26, N'right', N'double', 2, 38, 31, 1421)
GO
INSERT [dbo].[Player] ([PlayerID], [PlayerName], [PlayerSurname], [CountryID], [Hand], [Backhand], [SurfaceID], [CoachID], [Age], [Points]) VALUES (39, N'Nikolaz', N'Basilashvili', 30, N'right', N'double', 2, 39, 28, 1405)
GO
INSERT [dbo].[Player] ([PlayerID], [PlayerName], [PlayerSurname], [CountryID], [Hand], [Backhand], [SurfaceID], [CoachID], [Age], [Points]) VALUES (40, N'Reilly', N'Opelka', 13, N'right', N'double', 2, 40, 23, 1402)
GO
INSERT [dbo].[Player] ([PlayerID], [PlayerName], [PlayerSurname], [CountryID], [Hand], [Backhand], [SurfaceID], [CoachID], [Age], [Points]) VALUES (41, N'Kei', N'Nishikori', 31, N'right', N'double', 2, 41, 31, 1345)
GO
INSERT [dbo].[Player] ([PlayerID], [PlayerName], [PlayerSurname], [CountryID], [Hand], [Backhand], [SurfaceID], [CoachID], [Age], [Points]) VALUES (42, N'Miomir', N'Kecmanovic', 28, N'right', N'double', 2, 42, 21, 1328)
GO
INSERT [dbo].[Player] ([PlayerID], [PlayerName], [PlayerSurname], [CountryID], [Hand], [Backhand], [SurfaceID], [CoachID], [Age], [Points]) VALUES (43, N'Marin', N'Cilic', 27, N'right', N'double', 2, 43, 32, 1325)
GO
INSERT [dbo].[Player] ([PlayerID], [PlayerName], [PlayerSurname], [CountryID], [Hand], [Backhand], [SurfaceID], [CoachID], [Age], [Points]) VALUES (44, N'Guido', N'Pella', 22, N'left', N'double', 3, 44, 30, 1310)
GO
INSERT [dbo].[Player] ([PlayerID], [PlayerName], [PlayerSurname], [CountryID], [Hand], [Backhand], [SurfaceID], [CoachID], [Age], [Points]) VALUES (45, N'Alexander', N'Bublik', 32, N'right', N'double', 2, 45, 23, 1220)
GO
INSERT [dbo].[Player] ([PlayerID], [PlayerName], [PlayerSurname], [CountryID], [Hand], [Backhand], [SurfaceID], [CoachID], [Age], [Points]) VALUES (46, N'Albert', N'Ramos-Vinolas', 1, N'left', N'double', 3, 46, 33, 1210)
GO
INSERT [dbo].[Player] ([PlayerID], [PlayerName], [PlayerSurname], [CountryID], [Hand], [Backhand], [SurfaceID], [CoachID], [Age], [Points]) VALUES (47, N'Nick', N'Kyrgios', 26, N'right', N'double', 2, 47, 25, 1170)
GO
INSERT [dbo].[Player] ([PlayerID], [PlayerName], [PlayerSurname], [CountryID], [Hand], [Backhand], [SurfaceID], [CoachID], [Age], [Points]) VALUES (48, N'Richard', N'Gasquet', 2, N'right', N'one', 3, 48, 34, 1115)
GO
INSERT [dbo].[Player] ([PlayerID], [PlayerName], [PlayerSurname], [CountryID], [Hand], [Backhand], [SurfaceID], [CoachID], [Age], [Points]) VALUES (49, N'Kyle', N'Edmund', 29, N'right', N'double', 1, 49, 26, 1095)
GO
INSERT [dbo].[Player] ([PlayerID], [PlayerName], [PlayerSurname], [CountryID], [Hand], [Backhand], [SurfaceID], [CoachID], [Age], [Points]) VALUES (50, N'Tennys', N'Sandgren', 13, N'right', N'double', 2, 50, 29, 1088)
GO
INSERT [dbo].[Player] ([PlayerID], [PlayerName], [PlayerSurname], [CountryID], [Hand], [Backhand], [SurfaceID], [CoachID], [Age], [Points]) VALUES (51, N'Sam', N'Querrey', 13, N'right', N'double', 2, 51, 33, 1085)
GO
INSERT [dbo].[Player] ([PlayerID], [PlayerName], [PlayerSurname], [CountryID], [Hand], [Backhand], [SurfaceID], [CoachID], [Age], [Points]) VALUES (52, N'Jordan', N'Thompson', 26, N'right', N'double', 2, 52, 26, 1084)
GO
INSERT [dbo].[Player] ([PlayerID], [PlayerName], [PlayerSurname], [CountryID], [Hand], [Backhand], [SurfaceID], [CoachID], [Age], [Points]) VALUES (53, N'Tommy', N'Paul', 13, N'right', N'double', 2, 53, 23, 1080)
GO
INSERT [dbo].[Player] ([PlayerID], [PlayerName], [PlayerSurname], [CountryID], [Hand], [Backhand], [SurfaceID], [CoachID], [Age], [Points]) VALUES (54, N'Alejandro', N'Davidovich Fokina', 1, N'right', N'double', 3, 54, 21, 1078)
GO
INSERT [dbo].[Player] ([PlayerID], [PlayerName], [PlayerSurname], [CountryID], [Hand], [Backhand], [SurfaceID], [CoachID], [Age], [Points]) VALUES (55, N'Laslo', N'Djere', 28, N'right', N'double', 3, 55, 29, 1068)
GO
INSERT [dbo].[Player] ([PlayerID], [PlayerName], [PlayerSurname], [CountryID], [Hand], [Backhand], [SurfaceID], [CoachID], [Age], [Points]) VALUES (56, N'Yoshito', N'Nishioka', 31, N'left', N'double', 3, 56, 25, 1062)
GO
INSERT [dbo].[Player] ([PlayerID], [PlayerName], [PlayerSurname], [CountryID], [Hand], [Backhand], [SurfaceID], [CoachID], [Age], [Points]) VALUES (57, N'Aljaz', N'Bedene', 34, N'right', N'double', 2, 57, 31, 1055)
GO
INSERT [dbo].[Player] ([PlayerID], [PlayerName], [PlayerSurname], [CountryID], [Hand], [Backhand], [SurfaceID], [CoachID], [Age], [Points]) VALUES (58, N'Tennys', N'Sandgren', 13, N'right', N'double', 2, 58, 29, 1044)
GO
INSERT [dbo].[Player] ([PlayerID], [PlayerName], [PlayerSurname], [CountryID], [Hand], [Backhand], [SurfaceID], [CoachID], [Age], [Points]) VALUES (59, N'Pablo', N'Andujar', 1, N'right', N'double', 3, 59, 34, 1088)
GO
INSERT [dbo].[Player] ([PlayerID], [PlayerName], [PlayerSurname], [CountryID], [Hand], [Backhand], [SurfaceID], [CoachID], [Age], [Points]) VALUES (60, N'Jo-Wilfried', N'Tsonga', 2, N'right', N'double', 2, 60, 35, 1015)
GO
INSERT [dbo].[Player] ([PlayerID], [PlayerName], [PlayerSurname], [CountryID], [Hand], [Backhand], [SurfaceID], [CoachID], [Age], [Points]) VALUES (61, N'Vasek', N'Pospisil', 23, N'right', N'double', 1, 61, 30, 1013)
GO
INSERT [dbo].[Player] ([PlayerID], [PlayerName], [PlayerSurname], [CountryID], [Hand], [Backhand], [SurfaceID], [CoachID], [Age], [Points]) VALUES (62, N'Frances', N'Tiafoe', 13, N'right', N'double', 2, 62, 22, 1005)
GO
INSERT [dbo].[Player] ([PlayerID], [PlayerName], [PlayerSurname], [CountryID], [Hand], [Backhand], [SurfaceID], [CoachID], [Age], [Points]) VALUES (63, N'Feliciano', N'Lopez', 1, N'left', N'one', 1, 63, 39, 998)
GO
INSERT [dbo].[Player] ([PlayerID], [PlayerName], [PlayerSurname], [CountryID], [Hand], [Backhand], [SurfaceID], [CoachID], [Age], [Points]) VALUES (64, N'Giles', N'Simon', 2, N'right', N'double', 2, 64, 36, 995)
GO
INSERT [dbo].[Player] ([PlayerID], [PlayerName], [PlayerSurname], [CountryID], [Hand], [Backhand], [SurfaceID], [CoachID], [Age], [Points]) VALUES (65, N'Fernando', N'Verdasco', 1, N'left', N'double', 3, 65, 37, 985)
GO
INSERT [dbo].[Player] ([PlayerID], [PlayerName], [PlayerSurname], [CountryID], [Hand], [Backhand], [SurfaceID], [CoachID], [Age], [Points]) VALUES (66, N'Jeremy', N'Chardy', 2, N'right', N'double', 2, 66, 33, 950)
GO
INSERT [dbo].[Player] ([PlayerID], [PlayerName], [PlayerSurname], [CountryID], [Hand], [Backhand], [SurfaceID], [CoachID], [Age], [Points]) VALUES (67, N'Cameroon', N'Norie', 29, N'left', N'double', 3, 67, 25, 935)
GO
INSERT [dbo].[Player] ([PlayerID], [PlayerName], [PlayerSurname], [CountryID], [Hand], [Backhand], [SurfaceID], [CoachID], [Age], [Points]) VALUES (68, N'Dominik', N'Koepfr', 4, N'left', N'double', 3, 68, 26, 931)
GO
INSERT [dbo].[Player] ([PlayerID], [PlayerName], [PlayerSurname], [CountryID], [Hand], [Backhand], [SurfaceID], [CoachID], [Age], [Points]) VALUES (69, N'Jiri', N'Vesely', 10, N'left', N'double', 2, 69, 27, 928)
GO
INSERT [dbo].[Player] ([PlayerID], [PlayerName], [PlayerSurname], [CountryID], [Hand], [Backhand], [SurfaceID], [CoachID], [Age], [Points]) VALUES (70, N'Pablo', N'Cuevas', 37, N'right', N'one', 3, 70, 35, 927)
GO
INSERT [dbo].[Player] ([PlayerID], [PlayerName], [PlayerSurname], [CountryID], [Hand], [Backhand], [SurfaceID], [CoachID], [Age], [Points]) VALUES (71, N'Stefano', N'Travaglia', 22, N'right', N'double', 3, 71, 29, 894)
GO
INSERT [dbo].[Player] ([PlayerID], [PlayerName], [PlayerSurname], [CountryID], [Hand], [Backhand], [SurfaceID], [CoachID], [Age], [Points]) VALUES (72, N'Ricardas', N'Berankins', 38, N'right', N'double', 2, 72, 30, 889)
GO
INSERT [dbo].[Player] ([PlayerID], [PlayerName], [PlayerSurname], [CountryID], [Hand], [Backhand], [SurfaceID], [CoachID], [Age], [Points]) VALUES (73, N'Marcos', N'Giron', 13, N'right', N'one', 2, 73, 27, 884)
GO
INSERT [dbo].[Player] ([PlayerID], [PlayerName], [PlayerSurname], [CountryID], [Hand], [Backhand], [SurfaceID], [CoachID], [Age], [Points]) VALUES (74, N'Lucas', N'Pouille', 2, N'right', N'double', 2, 74, 26, 880)
GO
INSERT [dbo].[Player] ([PlayerID], [PlayerName], [PlayerSurname], [CountryID], [Hand], [Backhand], [SurfaceID], [CoachID], [Age], [Points]) VALUES (75, N'Steve', N'Johnson', 13, N'right', N'double', 2, 75, 31, 880)
GO
INSERT [dbo].[Player] ([PlayerID], [PlayerName], [PlayerSurname], [CountryID], [Hand], [Backhand], [SurfaceID], [CoachID], [Age], [Points]) VALUES (76, N'Salvatore', N'Caruso', 22, N'right', N'double', 3, 76, 28, 858)
GO
INSERT [dbo].[Player] ([PlayerID], [PlayerName], [PlayerSurname], [CountryID], [Hand], [Backhand], [SurfaceID], [CoachID], [Age], [Points]) VALUES (77, N'Federico', N'Delbonis', 11, N'left', N'double', 3, 77, 30, 851)
GO
INSERT [dbo].[Player] ([PlayerID], [PlayerName], [PlayerSurname], [CountryID], [Hand], [Backhand], [SurfaceID], [CoachID], [Age], [Points]) VALUES (78, N'Egor', N'Gerasimov', 9, N'right', N'double', 2, 78, 28, 840)
GO
INSERT [dbo].[Player] ([PlayerID], [PlayerName], [PlayerSurname], [CountryID], [Hand], [Backhand], [SurfaceID], [CoachID], [Age], [Points]) VALUES (79, N'Marco', N'Cechinatto', 22, N'right', N'one', 3, 79, 28, 838)
GO
INSERT [dbo].[Player] ([PlayerID], [PlayerName], [PlayerSurname], [CountryID], [Hand], [Backhand], [SurfaceID], [CoachID], [Age], [Points]) VALUES (80, N'Corentin', N'Moutet', 2, N'left', N'double', 3, 80, 21, 830)
GO
INSERT [dbo].[Player] ([PlayerID], [PlayerName], [PlayerSurname], [CountryID], [Hand], [Backhand], [SurfaceID], [CoachID], [Age], [Points]) VALUES (81, N'Juan', N'Ignacio Londero', 11, N'right', N'one', 3, 81, 27, 832)
GO
INSERT [dbo].[Player] ([PlayerID], [PlayerName], [PlayerSurname], [CountryID], [Hand], [Backhand], [SurfaceID], [CoachID], [Age], [Points]) VALUES (82, N'Kevin', N'Anderson', 39, N'right', N'double', 2, 82, 34, 825)
GO
INSERT [dbo].[Player] ([PlayerID], [PlayerName], [PlayerSurname], [CountryID], [Hand], [Backhand], [SurfaceID], [CoachID], [Age], [Points]) VALUES (83, N'Thiago', N'Monteiro', 3, N'left', N'double', 3, 83, 26, 824)
GO
INSERT [dbo].[Player] ([PlayerID], [PlayerName], [PlayerSurname], [CountryID], [Hand], [Backhand], [SurfaceID], [CoachID], [Age], [Points]) VALUES (84, N'Pierre', N'Huges-Herbert', 2, N'right', N'double', 3, 84, 29, 822)
GO
INSERT [dbo].[Player] ([PlayerID], [PlayerName], [PlayerSurname], [CountryID], [Hand], [Backhand], [SurfaceID], [CoachID], [Age], [Points]) VALUES (85, N'Radu', N'Albot', 40, N'right', N'double', 2, 85, 31, 817)
GO
INSERT [dbo].[Player] ([PlayerID], [PlayerName], [PlayerSurname], [CountryID], [Hand], [Backhand], [SurfaceID], [CoachID], [Age], [Points]) VALUES (86, N'Emil', N'Ruusuvuori', 17, N'right', N'double', 2, 86, 21, 816)
GO
INSERT [dbo].[Player] ([PlayerID], [PlayerName], [PlayerSurname], [CountryID], [Hand], [Backhand], [SurfaceID], [CoachID], [Age], [Points]) VALUES (87, N'Norbert', N'Gombos', 35, N'right', N'double', 2, 87, 30, 797)
GO
INSERT [dbo].[Player] ([PlayerID], [PlayerName], [PlayerSurname], [CountryID], [Hand], [Backhand], [SurfaceID], [CoachID], [Age], [Points]) VALUES (88, N'Konrad', N'Slowik', 5, N'right', N'double', 2, 38, 23, 150)
GO
INSERT [dbo].[Player] ([PlayerID], [PlayerName], [PlayerSurname], [CountryID], [Hand], [Backhand], [SurfaceID], [CoachID], [Age], [Points]) VALUES (1091, N'Piotr', N'Nowak', 32, N'right', N'one', 2, 81, 20, 200)
GO
SET IDENTITY_INSERT [dbo].[Player] OFF
GO
SET IDENTITY_INSERT [dbo].[Surface] ON 
GO
INSERT [dbo].[Surface] ([SurfaceId], [SurfaceName]) VALUES (1, N'grass')
GO
INSERT [dbo].[Surface] ([SurfaceId], [SurfaceName]) VALUES (2, N'hard')
GO
INSERT [dbo].[Surface] ([SurfaceId], [SurfaceName]) VALUES (3, N'clay')
GO
SET IDENTITY_INSERT [dbo].[Surface] OFF
GO
ALTER TABLE [dbo].[Player]  WITH CHECK ADD FOREIGN KEY([CoachID])
REFERENCES [dbo].[Coach] ([CoachID])
GO
ALTER TABLE [dbo].[Player]  WITH CHECK ADD FOREIGN KEY([CountryID])
REFERENCES [dbo].[Country] ([CountryID])
GO
ALTER TABLE [dbo].[Player]  WITH CHECK ADD FOREIGN KEY([SurfaceID])
REFERENCES [dbo].[Surface] ([SurfaceId])
GO
USE [master]
GO
ALTER DATABASE [ATPrank] SET  READ_WRITE 
GO
