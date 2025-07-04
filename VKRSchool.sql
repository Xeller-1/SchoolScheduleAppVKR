USE [master]
GO
/****** Object:  Database [SchoolSchedule]    Script Date: 02.07.2025 15:36:01 ******/
CREATE DATABASE [SchoolSchedule]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'SchoolSchedule', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\SchoolSchedule.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'SchoolSchedule_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\SchoolSchedule_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [SchoolSchedule].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [SchoolSchedule] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [SchoolSchedule] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [SchoolSchedule] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [SchoolSchedule] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [SchoolSchedule] SET ARITHABORT OFF 
GO
ALTER DATABASE [SchoolSchedule] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [SchoolSchedule] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [SchoolSchedule] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [SchoolSchedule] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [SchoolSchedule] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [SchoolSchedule] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [SchoolSchedule] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [SchoolSchedule] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [SchoolSchedule] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [SchoolSchedule] SET  ENABLE_BROKER 
GO
ALTER DATABASE [SchoolSchedule] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [SchoolSchedule] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [SchoolSchedule] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [SchoolSchedule] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [SchoolSchedule] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [SchoolSchedule] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [SchoolSchedule] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [SchoolSchedule] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [SchoolSchedule] SET  MULTI_USER 
GO
ALTER DATABASE [SchoolSchedule] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [SchoolSchedule] SET DB_CHAINING OFF 
GO
ALTER DATABASE [SchoolSchedule] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [SchoolSchedule] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [SchoolSchedule] SET DELAYED_DURABILITY = DISABLED 
GO
USE [SchoolSchedule]
GO
/****** Object:  Table [dbo].[Calls]    Script Date: 02.07.2025 15:36:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Calls](
	[CallID] [int] IDENTITY(1,1) NOT NULL,
	[StartTime] [time](7) NOT NULL,
	[EndTime] [time](7) NOT NULL,
	[DayOfWeek] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[CallID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Curriculum]    Script Date: 02.07.2025 15:36:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Curriculum](
	[CurriculumID] [int] IDENTITY(1,1) NOT NULL,
	[GroupID] [int] NOT NULL,
	[SubjectID] [int] NOT NULL,
	[Hours] [int] NOT NULL,
	[Complexity] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[CurriculumID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Groups]    Script Date: 02.07.2025 15:36:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Groups](
	[GroupID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Year] [int] NULL,
	[Specialization] [nvarchar](100) NULL,
 CONSTRAINT [PK__Groups__149AF30A5828ECE7] PRIMARY KEY CLUSTERED 
(
	[GroupID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Rooms]    Script Date: 02.07.2025 15:36:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Rooms](
	[RoomID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Capacity] [int] NOT NULL,
	[Equipment] [nvarchar](255) NULL,
	[IsShared] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[RoomID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Schedule]    Script Date: 02.07.2025 15:36:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Schedule](
	[ScheduleID] [int] IDENTITY(1,1) NOT NULL,
	[WeekID] [int] NULL,
	[GroupID] [int] NOT NULL,
	[SubgroupID] [int] NULL,
	[SubjectID] [int] NOT NULL,
	[TeacherID] [int] NOT NULL,
	[RoomID] [int] NOT NULL,
	[StartTime] [time](7) NOT NULL,
	[EndTime] [time](7) NOT NULL,
	[VersionID] [int] NULL,
	[CallID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ScheduleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ScheduleVersions]    Script Date: 02.07.2025 15:36:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ScheduleVersions](
	[VersionID] [int] IDENTITY(1,1) NOT NULL,
	[GroupID] [int] NOT NULL,
	[CreatedAt] [datetime] NULL,
	[IsActive] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[VersionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Subgroups]    Script Date: 02.07.2025 15:36:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Subgroups](
	[SubgroupID] [int] IDENTITY(1,1) NOT NULL,
	[GroupID] [int] NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[SubgroupID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Subjects]    Script Date: 02.07.2025 15:36:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Subjects](
	[SubjectID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Complexity] [int] NOT NULL,
	[Hours] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[SubjectID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Teacher_Subjects]    Script Date: 02.07.2025 15:36:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Teacher_Subjects](
	[SubjectID] [int] NOT NULL,
	[TeacherID] [int] NOT NULL,
 CONSTRAINT [PK_Teacher_Subjects] PRIMARY KEY CLUSTERED 
(
	[SubjectID] ASC,
	[TeacherID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TeacherRestrictions]    Script Date: 02.07.2025 15:36:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TeacherRestrictions](
	[RestrictionID] [int] IDENTITY(1,1) NOT NULL,
	[TeacherID] [int] NOT NULL,
	[DayOfWeek] [nvarchar](10) NULL,
PRIMARY KEY CLUSTERED 
(
	[RestrictionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Teachers]    Script Date: 02.07.2025 15:36:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Teachers](
	[TeacherID] [int] IDENTITY(1,1) NOT NULL,
	[FullName] [nvarchar](100) NOT NULL,
	[SubjectID] [int] NOT NULL,
	[UserID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[TeacherID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 02.07.2025 15:36:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[UserID] [int] IDENTITY(1,1) NOT NULL,
	[Username] [nvarchar](50) NOT NULL,
	[PasswordHash] [nvarchar](255) NOT NULL,
	[Role] [nvarchar](20) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Weeks]    Script Date: 02.07.2025 15:36:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Weeks](
	[WeekID] [int] IDENTITY(1,1) NOT NULL,
	[StartDate] [date] NOT NULL,
	[EndDate] [date] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[WeekID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Calls] ON 

INSERT [dbo].[Calls] ([CallID], [StartTime], [EndTime], [DayOfWeek]) VALUES (1, CAST(N'09:00:00' AS Time), CAST(N'09:30:00' AS Time), N'Понедельник')
INSERT [dbo].[Calls] ([CallID], [StartTime], [EndTime], [DayOfWeek]) VALUES (2, CAST(N'09:35:00' AS Time), CAST(N'10:15:00' AS Time), N'Понедельник')
INSERT [dbo].[Calls] ([CallID], [StartTime], [EndTime], [DayOfWeek]) VALUES (3, CAST(N'11:15:00' AS Time), CAST(N'11:55:00' AS Time), N'Понедельник')
INSERT [dbo].[Calls] ([CallID], [StartTime], [EndTime], [DayOfWeek]) VALUES (4, CAST(N'12:10:00' AS Time), CAST(N'12:50:00' AS Time), N'Понедельник')
INSERT [dbo].[Calls] ([CallID], [StartTime], [EndTime], [DayOfWeek]) VALUES (5, CAST(N'13:05:00' AS Time), CAST(N'13:45:00' AS Time), N'Понедельник')
INSERT [dbo].[Calls] ([CallID], [StartTime], [EndTime], [DayOfWeek]) VALUES (6, CAST(N'13:50:00' AS Time), CAST(N'14:30:00' AS Time), N'Понедельник')
INSERT [dbo].[Calls] ([CallID], [StartTime], [EndTime], [DayOfWeek]) VALUES (7, CAST(N'14:35:00' AS Time), CAST(N'15:15:00' AS Time), N'Понедельник')
INSERT [dbo].[Calls] ([CallID], [StartTime], [EndTime], [DayOfWeek]) VALUES (8, CAST(N'09:00:00' AS Time), CAST(N'09:40:00' AS Time), N'Вторник')
INSERT [dbo].[Calls] ([CallID], [StartTime], [EndTime], [DayOfWeek]) VALUES (9, CAST(N'09:45:00' AS Time), CAST(N'10:25:00' AS Time), N'Вторник')
INSERT [dbo].[Calls] ([CallID], [StartTime], [EndTime], [DayOfWeek]) VALUES (10, CAST(N'10:40:00' AS Time), CAST(N'11:20:00' AS Time), N'Вторник')
INSERT [dbo].[Calls] ([CallID], [StartTime], [EndTime], [DayOfWeek]) VALUES (11, CAST(N'11:35:00' AS Time), CAST(N'12:15:00' AS Time), N'Вторник')
INSERT [dbo].[Calls] ([CallID], [StartTime], [EndTime], [DayOfWeek]) VALUES (12, CAST(N'12:30:00' AS Time), CAST(N'13:10:00' AS Time), N'Вторник')
INSERT [dbo].[Calls] ([CallID], [StartTime], [EndTime], [DayOfWeek]) VALUES (13, CAST(N'13:15:00' AS Time), CAST(N'13:55:00' AS Time), N'Вторник')
INSERT [dbo].[Calls] ([CallID], [StartTime], [EndTime], [DayOfWeek]) VALUES (14, CAST(N'14:00:00' AS Time), CAST(N'14:40:00' AS Time), N'Вторник')
INSERT [dbo].[Calls] ([CallID], [StartTime], [EndTime], [DayOfWeek]) VALUES (15, CAST(N'09:00:00' AS Time), CAST(N'09:40:00' AS Time), N'Среда')
INSERT [dbo].[Calls] ([CallID], [StartTime], [EndTime], [DayOfWeek]) VALUES (16, CAST(N'09:45:00' AS Time), CAST(N'10:25:00' AS Time), N'Среда')
INSERT [dbo].[Calls] ([CallID], [StartTime], [EndTime], [DayOfWeek]) VALUES (17, CAST(N'10:40:00' AS Time), CAST(N'11:20:00' AS Time), N'Среда')
INSERT [dbo].[Calls] ([CallID], [StartTime], [EndTime], [DayOfWeek]) VALUES (18, CAST(N'11:35:00' AS Time), CAST(N'12:15:00' AS Time), N'Среда')
INSERT [dbo].[Calls] ([CallID], [StartTime], [EndTime], [DayOfWeek]) VALUES (19, CAST(N'12:30:00' AS Time), CAST(N'13:10:00' AS Time), N'Среда')
INSERT [dbo].[Calls] ([CallID], [StartTime], [EndTime], [DayOfWeek]) VALUES (20, CAST(N'13:15:00' AS Time), CAST(N'13:55:00' AS Time), N'Среда')
INSERT [dbo].[Calls] ([CallID], [StartTime], [EndTime], [DayOfWeek]) VALUES (21, CAST(N'14:00:00' AS Time), CAST(N'14:40:00' AS Time), N'Среда')
INSERT [dbo].[Calls] ([CallID], [StartTime], [EndTime], [DayOfWeek]) VALUES (22, CAST(N'09:00:00' AS Time), CAST(N'09:40:00' AS Time), N'Четверг')
INSERT [dbo].[Calls] ([CallID], [StartTime], [EndTime], [DayOfWeek]) VALUES (23, CAST(N'09:45:00' AS Time), CAST(N'10:25:00' AS Time), N'Четверг')
INSERT [dbo].[Calls] ([CallID], [StartTime], [EndTime], [DayOfWeek]) VALUES (24, CAST(N'10:40:00' AS Time), CAST(N'11:20:00' AS Time), N'Четверг')
INSERT [dbo].[Calls] ([CallID], [StartTime], [EndTime], [DayOfWeek]) VALUES (25, CAST(N'11:35:00' AS Time), CAST(N'12:15:00' AS Time), N'Четверг')
INSERT [dbo].[Calls] ([CallID], [StartTime], [EndTime], [DayOfWeek]) VALUES (26, CAST(N'12:30:00' AS Time), CAST(N'13:10:00' AS Time), N'Четверг')
INSERT [dbo].[Calls] ([CallID], [StartTime], [EndTime], [DayOfWeek]) VALUES (27, CAST(N'13:15:00' AS Time), CAST(N'13:55:00' AS Time), N'Четверг')
INSERT [dbo].[Calls] ([CallID], [StartTime], [EndTime], [DayOfWeek]) VALUES (28, CAST(N'14:00:00' AS Time), CAST(N'14:40:00' AS Time), N'Четверг')
INSERT [dbo].[Calls] ([CallID], [StartTime], [EndTime], [DayOfWeek]) VALUES (29, CAST(N'09:00:00' AS Time), CAST(N'09:40:00' AS Time), N'Пятница')
INSERT [dbo].[Calls] ([CallID], [StartTime], [EndTime], [DayOfWeek]) VALUES (30, CAST(N'09:45:00' AS Time), CAST(N'10:25:00' AS Time), N'Пятница')
INSERT [dbo].[Calls] ([CallID], [StartTime], [EndTime], [DayOfWeek]) VALUES (31, CAST(N'10:40:00' AS Time), CAST(N'11:20:00' AS Time), N'Пятница')
INSERT [dbo].[Calls] ([CallID], [StartTime], [EndTime], [DayOfWeek]) VALUES (32, CAST(N'11:35:00' AS Time), CAST(N'12:15:00' AS Time), N'Пятница')
INSERT [dbo].[Calls] ([CallID], [StartTime], [EndTime], [DayOfWeek]) VALUES (33, CAST(N'12:30:00' AS Time), CAST(N'13:10:00' AS Time), N'Пятница')
INSERT [dbo].[Calls] ([CallID], [StartTime], [EndTime], [DayOfWeek]) VALUES (34, CAST(N'13:15:00' AS Time), CAST(N'13:55:00' AS Time), N'Пятница')
INSERT [dbo].[Calls] ([CallID], [StartTime], [EndTime], [DayOfWeek]) VALUES (35, CAST(N'14:00:00' AS Time), CAST(N'14:40:00' AS Time), N'Пятница')
SET IDENTITY_INSERT [dbo].[Calls] OFF
GO
SET IDENTITY_INSERT [dbo].[Curriculum] ON 

INSERT [dbo].[Curriculum] ([CurriculumID], [GroupID], [SubjectID], [Hours], [Complexity]) VALUES (7, 1, 2025, 107, 8)
INSERT [dbo].[Curriculum] ([CurriculumID], [GroupID], [SubjectID], [Hours], [Complexity]) VALUES (8, 1, 2026, 107, 6)
INSERT [dbo].[Curriculum] ([CurriculumID], [GroupID], [SubjectID], [Hours], [Complexity]) VALUES (9, 1, 2027, 109, 10)
INSERT [dbo].[Curriculum] ([CurriculumID], [GroupID], [SubjectID], [Hours], [Complexity]) VALUES (10, 1, 2028, 106, 6)
INSERT [dbo].[Curriculum] ([CurriculumID], [GroupID], [SubjectID], [Hours], [Complexity]) VALUES (11, 1, 2029, 105, 4)
INSERT [dbo].[Curriculum] ([CurriculumID], [GroupID], [SubjectID], [Hours], [Complexity]) VALUES (12, 1, 2030, 86, 2)
INSERT [dbo].[Curriculum] ([CurriculumID], [GroupID], [SubjectID], [Hours], [Complexity]) VALUES (13, 1, 2031, 109, 3)
INSERT [dbo].[Curriculum] ([CurriculumID], [GroupID], [SubjectID], [Hours], [Complexity]) VALUES (14, 1, 2032, 109, 5)
INSERT [dbo].[Curriculum] ([CurriculumID], [GroupID], [SubjectID], [Hours], [Complexity]) VALUES (15, 1, 2033, 105, 5)
INSERT [dbo].[Curriculum] ([CurriculumID], [GroupID], [SubjectID], [Hours], [Complexity]) VALUES (16, 1, 2034, 102, 3)
INSERT [dbo].[Curriculum] ([CurriculumID], [GroupID], [SubjectID], [Hours], [Complexity]) VALUES (17, 1, 2035, 105, 6)
INSERT [dbo].[Curriculum] ([CurriculumID], [GroupID], [SubjectID], [Hours], [Complexity]) VALUES (18, 2, 2025, 107, 8)
INSERT [dbo].[Curriculum] ([CurriculumID], [GroupID], [SubjectID], [Hours], [Complexity]) VALUES (19, 2, 2026, 110, 8)
INSERT [dbo].[Curriculum] ([CurriculumID], [GroupID], [SubjectID], [Hours], [Complexity]) VALUES (20, 2, 2036, 116, 9)
INSERT [dbo].[Curriculum] ([CurriculumID], [GroupID], [SubjectID], [Hours], [Complexity]) VALUES (21, 2, 2037, 106, 6)
INSERT [dbo].[Curriculum] ([CurriculumID], [GroupID], [SubjectID], [Hours], [Complexity]) VALUES (22, 1, 2038, 107, 7)
INSERT [dbo].[Curriculum] ([CurriculumID], [GroupID], [SubjectID], [Hours], [Complexity]) VALUES (23, 2, 2030, 111, 4)
INSERT [dbo].[Curriculum] ([CurriculumID], [GroupID], [SubjectID], [Hours], [Complexity]) VALUES (24, 2, 2034, 117, 6)
INSERT [dbo].[Curriculum] ([CurriculumID], [GroupID], [SubjectID], [Hours], [Complexity]) VALUES (25, 1, 2039, 106, 7)
INSERT [dbo].[Curriculum] ([CurriculumID], [GroupID], [SubjectID], [Hours], [Complexity]) VALUES (26, 1, 2040, 107, 5)
INSERT [dbo].[Curriculum] ([CurriculumID], [GroupID], [SubjectID], [Hours], [Complexity]) VALUES (27, 1, 2041, 107, 5)
INSERT [dbo].[Curriculum] ([CurriculumID], [GroupID], [SubjectID], [Hours], [Complexity]) VALUES (28, 2, 2035, 107, 5)
INSERT [dbo].[Curriculum] ([CurriculumID], [GroupID], [SubjectID], [Hours], [Complexity]) VALUES (29, 2, 2031, 106, 4)
INSERT [dbo].[Curriculum] ([CurriculumID], [GroupID], [SubjectID], [Hours], [Complexity]) VALUES (30, 2, 2028, 113, 8)
INSERT [dbo].[Curriculum] ([CurriculumID], [GroupID], [SubjectID], [Hours], [Complexity]) VALUES (31, 2, 2042, 120, 4)
INSERT [dbo].[Curriculum] ([CurriculumID], [GroupID], [SubjectID], [Hours], [Complexity]) VALUES (32, 2, 2043, 120, 6)
INSERT [dbo].[Curriculum] ([CurriculumID], [GroupID], [SubjectID], [Hours], [Complexity]) VALUES (33, 2, 2044, 113, 6)
INSERT [dbo].[Curriculum] ([CurriculumID], [GroupID], [SubjectID], [Hours], [Complexity]) VALUES (34, 1, 2044, 104, 4)
INSERT [dbo].[Curriculum] ([CurriculumID], [GroupID], [SubjectID], [Hours], [Complexity]) VALUES (35, 2, 2033, 105, 5)
INSERT [dbo].[Curriculum] ([CurriculumID], [GroupID], [SubjectID], [Hours], [Complexity]) VALUES (36, 2, 2045, 120, 5)
INSERT [dbo].[Curriculum] ([CurriculumID], [GroupID], [SubjectID], [Hours], [Complexity]) VALUES (37, 2, 2029, 105, 5)
INSERT [dbo].[Curriculum] ([CurriculumID], [GroupID], [SubjectID], [Hours], [Complexity]) VALUES (38, 1002, 2025, 115, 8)
INSERT [dbo].[Curriculum] ([CurriculumID], [GroupID], [SubjectID], [Hours], [Complexity]) VALUES (39, 1002, 2026, 120, 6)
INSERT [dbo].[Curriculum] ([CurriculumID], [GroupID], [SubjectID], [Hours], [Complexity]) VALUES (40, 1002, 2036, 115, 8)
INSERT [dbo].[Curriculum] ([CurriculumID], [GroupID], [SubjectID], [Hours], [Complexity]) VALUES (41, 1002, 2037, 117, 9)
INSERT [dbo].[Curriculum] ([CurriculumID], [GroupID], [SubjectID], [Hours], [Complexity]) VALUES (42, 1002, 2028, 118, 5)
INSERT [dbo].[Curriculum] ([CurriculumID], [GroupID], [SubjectID], [Hours], [Complexity]) VALUES (43, 1002, 2029, 115, 6)
INSERT [dbo].[Curriculum] ([CurriculumID], [GroupID], [SubjectID], [Hours], [Complexity]) VALUES (44, 1002, 2030, 118, 4)
INSERT [dbo].[Curriculum] ([CurriculumID], [GroupID], [SubjectID], [Hours], [Complexity]) VALUES (45, 1002, 2031, 113, 3)
INSERT [dbo].[Curriculum] ([CurriculumID], [GroupID], [SubjectID], [Hours], [Complexity]) VALUES (46, 1002, 2032, 118, 5)
INSERT [dbo].[Curriculum] ([CurriculumID], [GroupID], [SubjectID], [Hours], [Complexity]) VALUES (47, 1002, 2033, 118, 3)
INSERT [dbo].[Curriculum] ([CurriculumID], [GroupID], [SubjectID], [Hours], [Complexity]) VALUES (48, 1002, 2034, 117, 6)
INSERT [dbo].[Curriculum] ([CurriculumID], [GroupID], [SubjectID], [Hours], [Complexity]) VALUES (49, 1002, 2035, 120, 5)
INSERT [dbo].[Curriculum] ([CurriculumID], [GroupID], [SubjectID], [Hours], [Complexity]) VALUES (50, 1002, 2039, 117, 6)
INSERT [dbo].[Curriculum] ([CurriculumID], [GroupID], [SubjectID], [Hours], [Complexity]) VALUES (51, 1002, 2040, 117, 5)
INSERT [dbo].[Curriculum] ([CurriculumID], [GroupID], [SubjectID], [Hours], [Complexity]) VALUES (52, 1002, 2041, 115, 4)
INSERT [dbo].[Curriculum] ([CurriculumID], [GroupID], [SubjectID], [Hours], [Complexity]) VALUES (53, 1002, 2044, 120, 5)
INSERT [dbo].[Curriculum] ([CurriculumID], [GroupID], [SubjectID], [Hours], [Complexity]) VALUES (54, 1002, 2043, 120, 8)
INSERT [dbo].[Curriculum] ([CurriculumID], [GroupID], [SubjectID], [Hours], [Complexity]) VALUES (55, 1002, 2046, 117, 9)
INSERT [dbo].[Curriculum] ([CurriculumID], [GroupID], [SubjectID], [Hours], [Complexity]) VALUES (56, 1004, 2025, 118, 8)
INSERT [dbo].[Curriculum] ([CurriculumID], [GroupID], [SubjectID], [Hours], [Complexity]) VALUES (57, 1004, 2026, 118, 7)
INSERT [dbo].[Curriculum] ([CurriculumID], [GroupID], [SubjectID], [Hours], [Complexity]) VALUES (58, 1004, 2036, 119, 9)
INSERT [dbo].[Curriculum] ([CurriculumID], [GroupID], [SubjectID], [Hours], [Complexity]) VALUES (59, 1004, 2037, 114, 8)
INSERT [dbo].[Curriculum] ([CurriculumID], [GroupID], [SubjectID], [Hours], [Complexity]) VALUES (60, 1004, 2028, 117, 5)
INSERT [dbo].[Curriculum] ([CurriculumID], [GroupID], [SubjectID], [Hours], [Complexity]) VALUES (61, 1004, 2030, 119, 5)
INSERT [dbo].[Curriculum] ([CurriculumID], [GroupID], [SubjectID], [Hours], [Complexity]) VALUES (62, 1004, 2041, 119, 4)
INSERT [dbo].[Curriculum] ([CurriculumID], [GroupID], [SubjectID], [Hours], [Complexity]) VALUES (63, 1004, 2034, 120, 7)
INSERT [dbo].[Curriculum] ([CurriculumID], [GroupID], [SubjectID], [Hours], [Complexity]) VALUES (64, 1004, 2035, 117, 5)
INSERT [dbo].[Curriculum] ([CurriculumID], [GroupID], [SubjectID], [Hours], [Complexity]) VALUES (65, 1004, 2047, 111, 4)
INSERT [dbo].[Curriculum] ([CurriculumID], [GroupID], [SubjectID], [Hours], [Complexity]) VALUES (66, 1004, 2039, 119, 7)
INSERT [dbo].[Curriculum] ([CurriculumID], [GroupID], [SubjectID], [Hours], [Complexity]) VALUES (67, 1004, 2033, 114, 4)
INSERT [dbo].[Curriculum] ([CurriculumID], [GroupID], [SubjectID], [Hours], [Complexity]) VALUES (68, 1004, 2040, 116, 4)
INSERT [dbo].[Curriculum] ([CurriculumID], [GroupID], [SubjectID], [Hours], [Complexity]) VALUES (69, 1004, 2044, 117, 4)
INSERT [dbo].[Curriculum] ([CurriculumID], [GroupID], [SubjectID], [Hours], [Complexity]) VALUES (70, 1004, 2046, 116, 10)
INSERT [dbo].[Curriculum] ([CurriculumID], [GroupID], [SubjectID], [Hours], [Complexity]) VALUES (71, 1004, 2048, 117, 9)
INSERT [dbo].[Curriculum] ([CurriculumID], [GroupID], [SubjectID], [Hours], [Complexity]) VALUES (72, 1004, 2043, 120, 9)
INSERT [dbo].[Curriculum] ([CurriculumID], [GroupID], [SubjectID], [Hours], [Complexity]) VALUES (73, 1005, 2025, 119, 11)
INSERT [dbo].[Curriculum] ([CurriculumID], [GroupID], [SubjectID], [Hours], [Complexity]) VALUES (74, 1005, 2026, 116, 9)
INSERT [dbo].[Curriculum] ([CurriculumID], [GroupID], [SubjectID], [Hours], [Complexity]) VALUES (75, 1005, 2036, 120, 11)
INSERT [dbo].[Curriculum] ([CurriculumID], [GroupID], [SubjectID], [Hours], [Complexity]) VALUES (76, 1005, 2037, 119, 12)
INSERT [dbo].[Curriculum] ([CurriculumID], [GroupID], [SubjectID], [Hours], [Complexity]) VALUES (77, 1005, 2028, 116, 8)
INSERT [dbo].[Curriculum] ([CurriculumID], [GroupID], [SubjectID], [Hours], [Complexity]) VALUES (78, 1005, 2049, 119, 9)
INSERT [dbo].[Curriculum] ([CurriculumID], [GroupID], [SubjectID], [Hours], [Complexity]) VALUES (79, 1005, 2048, 119, 12)
INSERT [dbo].[Curriculum] ([CurriculumID], [GroupID], [SubjectID], [Hours], [Complexity]) VALUES (80, 1005, 2046, 118, 9)
INSERT [dbo].[Curriculum] ([CurriculumID], [GroupID], [SubjectID], [Hours], [Complexity]) VALUES (81, 1, 2043, 120, 8)
INSERT [dbo].[Curriculum] ([CurriculumID], [GroupID], [SubjectID], [Hours], [Complexity]) VALUES (82, 1005, 2043, 120, 9)
INSERT [dbo].[Curriculum] ([CurriculumID], [GroupID], [SubjectID], [Hours], [Complexity]) VALUES (83, 1005, 2032, 119, 8)
INSERT [dbo].[Curriculum] ([CurriculumID], [GroupID], [SubjectID], [Hours], [Complexity]) VALUES (84, 1005, 2041, 119, 7)
INSERT [dbo].[Curriculum] ([CurriculumID], [GroupID], [SubjectID], [Hours], [Complexity]) VALUES (85, 1005, 2033, 117, 7)
INSERT [dbo].[Curriculum] ([CurriculumID], [GroupID], [SubjectID], [Hours], [Complexity]) VALUES (86, 1005, 2047, 116, 7)
INSERT [dbo].[Curriculum] ([CurriculumID], [GroupID], [SubjectID], [Hours], [Complexity]) VALUES (87, 1005, 2044, 117, 8)
INSERT [dbo].[Curriculum] ([CurriculumID], [GroupID], [SubjectID], [Hours], [Complexity]) VALUES (88, 1005, 2039, 118, 8)
INSERT [dbo].[Curriculum] ([CurriculumID], [GroupID], [SubjectID], [Hours], [Complexity]) VALUES (89, 1005, 2034, 119, 8)
INSERT [dbo].[Curriculum] ([CurriculumID], [GroupID], [SubjectID], [Hours], [Complexity]) VALUES (90, 1005, 2035, 111, 5)
INSERT [dbo].[Curriculum] ([CurriculumID], [GroupID], [SubjectID], [Hours], [Complexity]) VALUES (91, 1, 2050, 10, 15)
SET IDENTITY_INSERT [dbo].[Curriculum] OFF
GO
SET IDENTITY_INSERT [dbo].[Groups] ON 

INSERT [dbo].[Groups] ([GroupID], [Name], [Year], [Specialization]) VALUES (1, N'5 класс', 5, N'')
INSERT [dbo].[Groups] ([GroupID], [Name], [Year], [Specialization]) VALUES (2, N'6 класс', 6, N'')
INSERT [dbo].[Groups] ([GroupID], [Name], [Year], [Specialization]) VALUES (1002, N'7 класс', 7, N'')
INSERT [dbo].[Groups] ([GroupID], [Name], [Year], [Specialization]) VALUES (1004, N'8 класс', 8, N'')
INSERT [dbo].[Groups] ([GroupID], [Name], [Year], [Specialization]) VALUES (1005, N'9 класс', 9, N'')
INSERT [dbo].[Groups] ([GroupID], [Name], [Year], [Specialization]) VALUES (1006, N'1 класс', 0, NULL)
SET IDENTITY_INSERT [dbo].[Groups] OFF
GO
SET IDENTITY_INSERT [dbo].[Rooms] ON 

INSERT [dbo].[Rooms] ([RoomID], [Name], [Capacity], [Equipment], [IsShared]) VALUES (1008, N'Кабинет №101', 25, N'Компьютеры, проектор', 0)
INSERT [dbo].[Rooms] ([RoomID], [Name], [Capacity], [Equipment], [IsShared]) VALUES (1009, N'Кабинет №102', 30, N'Доска, проектор', 0)
INSERT [dbo].[Rooms] ([RoomID], [Name], [Capacity], [Equipment], [IsShared]) VALUES (1010, N'Кабинет №103', 20, N'Микроскопы, лаборатория', 0)
INSERT [dbo].[Rooms] ([RoomID], [Name], [Capacity], [Equipment], [IsShared]) VALUES (1011, N'Кабинет №104', 25, N'Музыкальные инструменты', 1)
INSERT [dbo].[Rooms] ([RoomID], [Name], [Capacity], [Equipment], [IsShared]) VALUES (1012, N'Кабинет №105', 30, N'Карты, глобус', 0)
INSERT [dbo].[Rooms] ([RoomID], [Name], [Capacity], [Equipment], [IsShared]) VALUES (1013, N'Кабинет №106', 30, N'Обычный класс', 1)
INSERT [dbo].[Rooms] ([RoomID], [Name], [Capacity], [Equipment], [IsShared]) VALUES (1014, N'Кабинет №107', 20, N'Интерактивная доска', 0)
INSERT [dbo].[Rooms] ([RoomID], [Name], [Capacity], [Equipment], [IsShared]) VALUES (1015, N'Кабинет №108', 28, N'Проектор', 1)
INSERT [dbo].[Rooms] ([RoomID], [Name], [Capacity], [Equipment], [IsShared]) VALUES (1016, N'Кабинет №109', 25, N'Компьютеры', 0)
INSERT [dbo].[Rooms] ([RoomID], [Name], [Capacity], [Equipment], [IsShared]) VALUES (1017, N'Кабинет №110', 32, N'Лабораторное оборудование', 0)
INSERT [dbo].[Rooms] ([RoomID], [Name], [Capacity], [Equipment], [IsShared]) VALUES (1018, N'Кабинет №111', 30, N'отсутствует', 0)
SET IDENTITY_INSERT [dbo].[Rooms] OFF
GO
SET IDENTITY_INSERT [dbo].[Schedule] ON 

INSERT [dbo].[Schedule] ([ScheduleID], [WeekID], [GroupID], [SubgroupID], [SubjectID], [TeacherID], [RoomID], [StartTime], [EndTime], [VersionID], [CallID]) VALUES (1809, NULL, 1002, NULL, 2039, 2046, 1011, CAST(N'09:00:00' AS Time), CAST(N'09:40:00' AS Time), NULL, 8)
INSERT [dbo].[Schedule] ([ScheduleID], [WeekID], [GroupID], [SubgroupID], [SubjectID], [TeacherID], [RoomID], [StartTime], [EndTime], [VersionID], [CallID]) VALUES (1810, NULL, 1002, NULL, 2031, 2038, 1017, CAST(N'09:45:00' AS Time), CAST(N'10:25:00' AS Time), NULL, 9)
INSERT [dbo].[Schedule] ([ScheduleID], [WeekID], [GroupID], [SubgroupID], [SubjectID], [TeacherID], [RoomID], [StartTime], [EndTime], [VersionID], [CallID]) VALUES (1811, NULL, 1002, NULL, 2032, 2039, 1017, CAST(N'10:40:00' AS Time), CAST(N'11:20:00' AS Time), NULL, 10)
INSERT [dbo].[Schedule] ([ScheduleID], [WeekID], [GroupID], [SubgroupID], [SubjectID], [TeacherID], [RoomID], [StartTime], [EndTime], [VersionID], [CallID]) VALUES (1812, NULL, 1002, NULL, 2025, 2032, 1014, CAST(N'11:35:00' AS Time), CAST(N'12:15:00' AS Time), NULL, 11)
INSERT [dbo].[Schedule] ([ScheduleID], [WeekID], [GroupID], [SubgroupID], [SubjectID], [TeacherID], [RoomID], [StartTime], [EndTime], [VersionID], [CallID]) VALUES (1813, NULL, 1002, NULL, 2034, 2041, 1010, CAST(N'12:30:00' AS Time), CAST(N'13:10:00' AS Time), NULL, 12)
INSERT [dbo].[Schedule] ([ScheduleID], [WeekID], [GroupID], [SubgroupID], [SubjectID], [TeacherID], [RoomID], [StartTime], [EndTime], [VersionID], [CallID]) VALUES (1814, NULL, 1002, NULL, 2039, 2046, 1013, CAST(N'09:00:00' AS Time), CAST(N'09:30:00' AS Time), NULL, 1)
INSERT [dbo].[Schedule] ([ScheduleID], [WeekID], [GroupID], [SubgroupID], [SubjectID], [TeacherID], [RoomID], [StartTime], [EndTime], [VersionID], [CallID]) VALUES (1815, NULL, 1002, NULL, 2036, 2043, 1013, CAST(N'09:35:00' AS Time), CAST(N'10:15:00' AS Time), NULL, 2)
INSERT [dbo].[Schedule] ([ScheduleID], [WeekID], [GroupID], [SubgroupID], [SubjectID], [TeacherID], [RoomID], [StartTime], [EndTime], [VersionID], [CallID]) VALUES (1816, NULL, 1002, NULL, 2040, 2049, 1010, CAST(N'11:15:00' AS Time), CAST(N'11:55:00' AS Time), NULL, 3)
INSERT [dbo].[Schedule] ([ScheduleID], [WeekID], [GroupID], [SubgroupID], [SubjectID], [TeacherID], [RoomID], [StartTime], [EndTime], [VersionID], [CallID]) VALUES (1817, NULL, 1002, NULL, 2031, 2038, 1013, CAST(N'12:10:00' AS Time), CAST(N'12:50:00' AS Time), NULL, 4)
INSERT [dbo].[Schedule] ([ScheduleID], [WeekID], [GroupID], [SubgroupID], [SubjectID], [TeacherID], [RoomID], [StartTime], [EndTime], [VersionID], [CallID]) VALUES (1818, NULL, 1002, NULL, 2029, 2036, 1008, CAST(N'13:05:00' AS Time), CAST(N'13:45:00' AS Time), NULL, 5)
INSERT [dbo].[Schedule] ([ScheduleID], [WeekID], [GroupID], [SubgroupID], [SubjectID], [TeacherID], [RoomID], [StartTime], [EndTime], [VersionID], [CallID]) VALUES (1819, NULL, 1002, NULL, 2041, 2047, 1009, CAST(N'09:00:00' AS Time), CAST(N'09:40:00' AS Time), NULL, 29)
INSERT [dbo].[Schedule] ([ScheduleID], [WeekID], [GroupID], [SubgroupID], [SubjectID], [TeacherID], [RoomID], [StartTime], [EndTime], [VersionID], [CallID]) VALUES (1820, NULL, 1002, NULL, 2029, 2036, 1015, CAST(N'09:45:00' AS Time), CAST(N'10:25:00' AS Time), NULL, 30)
INSERT [dbo].[Schedule] ([ScheduleID], [WeekID], [GroupID], [SubgroupID], [SubjectID], [TeacherID], [RoomID], [StartTime], [EndTime], [VersionID], [CallID]) VALUES (1821, NULL, 1002, NULL, 2046, 2050, 1017, CAST(N'10:40:00' AS Time), CAST(N'11:20:00' AS Time), NULL, 31)
INSERT [dbo].[Schedule] ([ScheduleID], [WeekID], [GroupID], [SubgroupID], [SubjectID], [TeacherID], [RoomID], [StartTime], [EndTime], [VersionID], [CallID]) VALUES (1822, NULL, 1002, NULL, 2028, 2035, 1016, CAST(N'11:35:00' AS Time), CAST(N'12:15:00' AS Time), NULL, 32)
INSERT [dbo].[Schedule] ([ScheduleID], [WeekID], [GroupID], [SubgroupID], [SubjectID], [TeacherID], [RoomID], [StartTime], [EndTime], [VersionID], [CallID]) VALUES (1823, NULL, 1002, NULL, 2031, 2038, 1016, CAST(N'12:30:00' AS Time), CAST(N'13:10:00' AS Time), NULL, 33)
INSERT [dbo].[Schedule] ([ScheduleID], [WeekID], [GroupID], [SubgroupID], [SubjectID], [TeacherID], [RoomID], [StartTime], [EndTime], [VersionID], [CallID]) VALUES (1824, NULL, 1002, NULL, 2033, 2040, 1016, CAST(N'13:15:00' AS Time), CAST(N'13:55:00' AS Time), NULL, 34)
INSERT [dbo].[Schedule] ([ScheduleID], [WeekID], [GroupID], [SubgroupID], [SubjectID], [TeacherID], [RoomID], [StartTime], [EndTime], [VersionID], [CallID]) VALUES (1825, NULL, 1002, NULL, 2036, 2043, 1016, CAST(N'09:00:00' AS Time), CAST(N'09:40:00' AS Time), NULL, 15)
INSERT [dbo].[Schedule] ([ScheduleID], [WeekID], [GroupID], [SubgroupID], [SubjectID], [TeacherID], [RoomID], [StartTime], [EndTime], [VersionID], [CallID]) VALUES (1826, NULL, 1002, NULL, 2041, 2047, 1008, CAST(N'09:45:00' AS Time), CAST(N'10:25:00' AS Time), NULL, 16)
INSERT [dbo].[Schedule] ([ScheduleID], [WeekID], [GroupID], [SubgroupID], [SubjectID], [TeacherID], [RoomID], [StartTime], [EndTime], [VersionID], [CallID]) VALUES (1827, NULL, 1002, NULL, 2034, 2041, 1015, CAST(N'10:40:00' AS Time), CAST(N'11:20:00' AS Time), NULL, 17)
INSERT [dbo].[Schedule] ([ScheduleID], [WeekID], [GroupID], [SubgroupID], [SubjectID], [TeacherID], [RoomID], [StartTime], [EndTime], [VersionID], [CallID]) VALUES (1828, NULL, 1002, NULL, 2033, 2040, 1013, CAST(N'11:35:00' AS Time), CAST(N'12:15:00' AS Time), NULL, 18)
INSERT [dbo].[Schedule] ([ScheduleID], [WeekID], [GroupID], [SubgroupID], [SubjectID], [TeacherID], [RoomID], [StartTime], [EndTime], [VersionID], [CallID]) VALUES (1829, NULL, 1002, NULL, 2041, 2047, 1017, CAST(N'12:30:00' AS Time), CAST(N'13:10:00' AS Time), NULL, 19)
INSERT [dbo].[Schedule] ([ScheduleID], [WeekID], [GroupID], [SubgroupID], [SubjectID], [TeacherID], [RoomID], [StartTime], [EndTime], [VersionID], [CallID]) VALUES (1830, NULL, 1002, NULL, 2028, 2035, 1012, CAST(N'13:15:00' AS Time), CAST(N'13:55:00' AS Time), NULL, 20)
INSERT [dbo].[Schedule] ([ScheduleID], [WeekID], [GroupID], [SubgroupID], [SubjectID], [TeacherID], [RoomID], [StartTime], [EndTime], [VersionID], [CallID]) VALUES (1831, NULL, 1002, NULL, 2029, 2036, 1015, CAST(N'09:00:00' AS Time), CAST(N'09:40:00' AS Time), NULL, 22)
INSERT [dbo].[Schedule] ([ScheduleID], [WeekID], [GroupID], [SubgroupID], [SubjectID], [TeacherID], [RoomID], [StartTime], [EndTime], [VersionID], [CallID]) VALUES (1832, NULL, 1002, NULL, 2041, 2047, 1010, CAST(N'09:45:00' AS Time), CAST(N'10:25:00' AS Time), NULL, 23)
INSERT [dbo].[Schedule] ([ScheduleID], [WeekID], [GroupID], [SubgroupID], [SubjectID], [TeacherID], [RoomID], [StartTime], [EndTime], [VersionID], [CallID]) VALUES (1833, NULL, 1002, NULL, 2037, 2044, 1013, CAST(N'10:40:00' AS Time), CAST(N'11:20:00' AS Time), NULL, 24)
INSERT [dbo].[Schedule] ([ScheduleID], [WeekID], [GroupID], [SubgroupID], [SubjectID], [TeacherID], [RoomID], [StartTime], [EndTime], [VersionID], [CallID]) VALUES (1834, NULL, 1002, NULL, 2046, 2050, 1013, CAST(N'11:35:00' AS Time), CAST(N'12:15:00' AS Time), NULL, 25)
INSERT [dbo].[Schedule] ([ScheduleID], [WeekID], [GroupID], [SubgroupID], [SubjectID], [TeacherID], [RoomID], [StartTime], [EndTime], [VersionID], [CallID]) VALUES (1835, NULL, 1004, NULL, 2037, 2044, 1016, CAST(N'09:00:00' AS Time), CAST(N'09:40:00' AS Time), NULL, 8)
INSERT [dbo].[Schedule] ([ScheduleID], [WeekID], [GroupID], [SubgroupID], [SubjectID], [TeacherID], [RoomID], [StartTime], [EndTime], [VersionID], [CallID]) VALUES (1836, NULL, 1004, NULL, 2046, 2050, 1011, CAST(N'09:45:00' AS Time), CAST(N'10:25:00' AS Time), NULL, 9)
INSERT [dbo].[Schedule] ([ScheduleID], [WeekID], [GroupID], [SubgroupID], [SubjectID], [TeacherID], [RoomID], [StartTime], [EndTime], [VersionID], [CallID]) VALUES (1837, NULL, 1004, NULL, 2026, 2033, 1010, CAST(N'10:40:00' AS Time), CAST(N'11:20:00' AS Time), NULL, 10)
INSERT [dbo].[Schedule] ([ScheduleID], [WeekID], [GroupID], [SubgroupID], [SubjectID], [TeacherID], [RoomID], [StartTime], [EndTime], [VersionID], [CallID]) VALUES (1839, NULL, 1004, NULL, 2040, 2049, 1008, CAST(N'09:00:00' AS Time), CAST(N'09:30:00' AS Time), NULL, 1)
INSERT [dbo].[Schedule] ([ScheduleID], [WeekID], [GroupID], [SubgroupID], [SubjectID], [TeacherID], [RoomID], [StartTime], [EndTime], [VersionID], [CallID]) VALUES (1840, NULL, 1004, NULL, 2033, 2040, 1017, CAST(N'09:35:00' AS Time), CAST(N'10:15:00' AS Time), NULL, 2)
INSERT [dbo].[Schedule] ([ScheduleID], [WeekID], [GroupID], [SubgroupID], [SubjectID], [TeacherID], [RoomID], [StartTime], [EndTime], [VersionID], [CallID]) VALUES (1841, NULL, 1004, NULL, 2046, 2050, 1012, CAST(N'11:15:00' AS Time), CAST(N'11:55:00' AS Time), NULL, 3)
INSERT [dbo].[Schedule] ([ScheduleID], [WeekID], [GroupID], [SubgroupID], [SubjectID], [TeacherID], [RoomID], [StartTime], [EndTime], [VersionID], [CallID]) VALUES (1842, NULL, 1004, NULL, 2033, 2040, 1010, CAST(N'12:10:00' AS Time), CAST(N'12:50:00' AS Time), NULL, 4)
INSERT [dbo].[Schedule] ([ScheduleID], [WeekID], [GroupID], [SubgroupID], [SubjectID], [TeacherID], [RoomID], [StartTime], [EndTime], [VersionID], [CallID]) VALUES (1843, NULL, 1004, NULL, 2047, 2052, 1013, CAST(N'13:05:00' AS Time), CAST(N'13:45:00' AS Time), NULL, 5)
INSERT [dbo].[Schedule] ([ScheduleID], [WeekID], [GroupID], [SubgroupID], [SubjectID], [TeacherID], [RoomID], [StartTime], [EndTime], [VersionID], [CallID]) VALUES (1844, NULL, 1004, NULL, 2041, 2047, 1011, CAST(N'13:50:00' AS Time), CAST(N'14:30:00' AS Time), NULL, 6)
INSERT [dbo].[Schedule] ([ScheduleID], [WeekID], [GroupID], [SubgroupID], [SubjectID], [TeacherID], [RoomID], [StartTime], [EndTime], [VersionID], [CallID]) VALUES (1845, NULL, 1004, NULL, 2044, 2048, 1011, CAST(N'09:00:00' AS Time), CAST(N'09:40:00' AS Time), NULL, 29)
INSERT [dbo].[Schedule] ([ScheduleID], [WeekID], [GroupID], [SubgroupID], [SubjectID], [TeacherID], [RoomID], [StartTime], [EndTime], [VersionID], [CallID]) VALUES (1846, NULL, 1004, NULL, 2033, 2040, 1008, CAST(N'09:45:00' AS Time), CAST(N'10:25:00' AS Time), NULL, 30)
INSERT [dbo].[Schedule] ([ScheduleID], [WeekID], [GroupID], [SubgroupID], [SubjectID], [TeacherID], [RoomID], [StartTime], [EndTime], [VersionID], [CallID]) VALUES (1847, NULL, 1004, NULL, 2030, 2037, 1011, CAST(N'10:40:00' AS Time), CAST(N'11:20:00' AS Time), NULL, 31)
INSERT [dbo].[Schedule] ([ScheduleID], [WeekID], [GroupID], [SubgroupID], [SubjectID], [TeacherID], [RoomID], [StartTime], [EndTime], [VersionID], [CallID]) VALUES (1848, NULL, 1004, NULL, 2026, 2033, 1013, CAST(N'11:35:00' AS Time), CAST(N'12:15:00' AS Time), NULL, 32)
INSERT [dbo].[Schedule] ([ScheduleID], [WeekID], [GroupID], [SubgroupID], [SubjectID], [TeacherID], [RoomID], [StartTime], [EndTime], [VersionID], [CallID]) VALUES (1849, NULL, 1004, NULL, 2048, 2053, 1012, CAST(N'12:30:00' AS Time), CAST(N'13:10:00' AS Time), NULL, 33)
INSERT [dbo].[Schedule] ([ScheduleID], [WeekID], [GroupID], [SubgroupID], [SubjectID], [TeacherID], [RoomID], [StartTime], [EndTime], [VersionID], [CallID]) VALUES (1850, NULL, 1004, NULL, 2033, 2040, 1008, CAST(N'09:00:00' AS Time), CAST(N'09:40:00' AS Time), NULL, 15)
INSERT [dbo].[Schedule] ([ScheduleID], [WeekID], [GroupID], [SubgroupID], [SubjectID], [TeacherID], [RoomID], [StartTime], [EndTime], [VersionID], [CallID]) VALUES (1851, NULL, 1004, NULL, 2040, 2049, 1010, CAST(N'09:45:00' AS Time), CAST(N'10:25:00' AS Time), NULL, 16)
INSERT [dbo].[Schedule] ([ScheduleID], [WeekID], [GroupID], [SubgroupID], [SubjectID], [TeacherID], [RoomID], [StartTime], [EndTime], [VersionID], [CallID]) VALUES (1853, NULL, 1004, NULL, 2035, 2042, 1017, CAST(N'11:35:00' AS Time), CAST(N'12:15:00' AS Time), NULL, 18)
INSERT [dbo].[Schedule] ([ScheduleID], [WeekID], [GroupID], [SubgroupID], [SubjectID], [TeacherID], [RoomID], [StartTime], [EndTime], [VersionID], [CallID]) VALUES (1854, NULL, 1004, NULL, 2033, 2040, 1010, CAST(N'12:30:00' AS Time), CAST(N'13:10:00' AS Time), NULL, 19)
INSERT [dbo].[Schedule] ([ScheduleID], [WeekID], [GroupID], [SubgroupID], [SubjectID], [TeacherID], [RoomID], [StartTime], [EndTime], [VersionID], [CallID]) VALUES (1855, NULL, 1004, NULL, 2025, 2032, 1011, CAST(N'13:15:00' AS Time), CAST(N'13:55:00' AS Time), NULL, 20)
INSERT [dbo].[Schedule] ([ScheduleID], [WeekID], [GroupID], [SubgroupID], [SubjectID], [TeacherID], [RoomID], [StartTime], [EndTime], [VersionID], [CallID]) VALUES (1857, NULL, 1004, NULL, 2036, 2043, 1017, CAST(N'09:45:00' AS Time), CAST(N'10:25:00' AS Time), NULL, 23)
INSERT [dbo].[Schedule] ([ScheduleID], [WeekID], [GroupID], [SubgroupID], [SubjectID], [TeacherID], [RoomID], [StartTime], [EndTime], [VersionID], [CallID]) VALUES (1858, NULL, 1004, NULL, 2047, 2052, 1017, CAST(N'10:40:00' AS Time), CAST(N'11:20:00' AS Time), NULL, 24)
INSERT [dbo].[Schedule] ([ScheduleID], [WeekID], [GroupID], [SubgroupID], [SubjectID], [TeacherID], [RoomID], [StartTime], [EndTime], [VersionID], [CallID]) VALUES (1859, NULL, 1004, NULL, 2028, 2035, 1008, CAST(N'11:35:00' AS Time), CAST(N'12:15:00' AS Time), NULL, 25)
INSERT [dbo].[Schedule] ([ScheduleID], [WeekID], [GroupID], [SubgroupID], [SubjectID], [TeacherID], [RoomID], [StartTime], [EndTime], [VersionID], [CallID]) VALUES (1860, NULL, 1004, NULL, 2037, 2044, 1015, CAST(N'12:30:00' AS Time), CAST(N'13:10:00' AS Time), NULL, 26)
INSERT [dbo].[Schedule] ([ScheduleID], [WeekID], [GroupID], [SubgroupID], [SubjectID], [TeacherID], [RoomID], [StartTime], [EndTime], [VersionID], [CallID]) VALUES (1861, NULL, 1005, NULL, 2039, 2046, 1014, CAST(N'09:00:00' AS Time), CAST(N'09:40:00' AS Time), NULL, 8)
INSERT [dbo].[Schedule] ([ScheduleID], [WeekID], [GroupID], [SubgroupID], [SubjectID], [TeacherID], [RoomID], [StartTime], [EndTime], [VersionID], [CallID]) VALUES (1862, NULL, 1005, NULL, 2046, 2050, 1013, CAST(N'09:45:00' AS Time), CAST(N'10:25:00' AS Time), NULL, 9)
INSERT [dbo].[Schedule] ([ScheduleID], [WeekID], [GroupID], [SubgroupID], [SubjectID], [TeacherID], [RoomID], [StartTime], [EndTime], [VersionID], [CallID]) VALUES (1863, NULL, 1005, NULL, 2032, 2039, 1013, CAST(N'10:40:00' AS Time), CAST(N'11:20:00' AS Time), NULL, 10)
INSERT [dbo].[Schedule] ([ScheduleID], [WeekID], [GroupID], [SubgroupID], [SubjectID], [TeacherID], [RoomID], [StartTime], [EndTime], [VersionID], [CallID]) VALUES (1864, NULL, 1005, NULL, 2035, 2042, 1011, CAST(N'11:35:00' AS Time), CAST(N'12:15:00' AS Time), NULL, 11)
INSERT [dbo].[Schedule] ([ScheduleID], [WeekID], [GroupID], [SubgroupID], [SubjectID], [TeacherID], [RoomID], [StartTime], [EndTime], [VersionID], [CallID]) VALUES (1865, NULL, 1005, NULL, 2047, 2052, 1016, CAST(N'09:00:00' AS Time), CAST(N'09:30:00' AS Time), NULL, 1)
INSERT [dbo].[Schedule] ([ScheduleID], [WeekID], [GroupID], [SubgroupID], [SubjectID], [TeacherID], [RoomID], [StartTime], [EndTime], [VersionID], [CallID]) VALUES (1867, NULL, 1005, NULL, 2028, 2035, 1015, CAST(N'11:15:00' AS Time), CAST(N'11:55:00' AS Time), NULL, 3)
INSERT [dbo].[Schedule] ([ScheduleID], [WeekID], [GroupID], [SubgroupID], [SubjectID], [TeacherID], [RoomID], [StartTime], [EndTime], [VersionID], [CallID]) VALUES (1868, NULL, 1005, NULL, 2035, 2042, 1015, CAST(N'12:10:00' AS Time), CAST(N'12:50:00' AS Time), NULL, 4)
INSERT [dbo].[Schedule] ([ScheduleID], [WeekID], [GroupID], [SubgroupID], [SubjectID], [TeacherID], [RoomID], [StartTime], [EndTime], [VersionID], [CallID]) VALUES (1869, NULL, 1005, NULL, 2034, 2041, 1017, CAST(N'09:00:00' AS Time), CAST(N'09:40:00' AS Time), NULL, 29)
INSERT [dbo].[Schedule] ([ScheduleID], [WeekID], [GroupID], [SubgroupID], [SubjectID], [TeacherID], [RoomID], [StartTime], [EndTime], [VersionID], [CallID]) VALUES (1870, NULL, 1005, NULL, 2026, 2033, 1017, CAST(N'09:45:00' AS Time), CAST(N'10:25:00' AS Time), NULL, 30)
INSERT [dbo].[Schedule] ([ScheduleID], [WeekID], [GroupID], [SubgroupID], [SubjectID], [TeacherID], [RoomID], [StartTime], [EndTime], [VersionID], [CallID]) VALUES (1871, NULL, 1005, NULL, 2033, 2040, 1009, CAST(N'10:40:00' AS Time), CAST(N'11:20:00' AS Time), NULL, 31)
INSERT [dbo].[Schedule] ([ScheduleID], [WeekID], [GroupID], [SubgroupID], [SubjectID], [TeacherID], [RoomID], [StartTime], [EndTime], [VersionID], [CallID]) VALUES (1872, NULL, 1005, NULL, 2035, 2042, 1012, CAST(N'11:35:00' AS Time), CAST(N'12:15:00' AS Time), NULL, 32)
INSERT [dbo].[Schedule] ([ScheduleID], [WeekID], [GroupID], [SubgroupID], [SubjectID], [TeacherID], [RoomID], [StartTime], [EndTime], [VersionID], [CallID]) VALUES (1873, NULL, 1005, NULL, 2035, 2042, 1014, CAST(N'09:00:00' AS Time), CAST(N'09:40:00' AS Time), NULL, 15)
INSERT [dbo].[Schedule] ([ScheduleID], [WeekID], [GroupID], [SubgroupID], [SubjectID], [TeacherID], [RoomID], [StartTime], [EndTime], [VersionID], [CallID]) VALUES (1874, NULL, 1005, NULL, 2028, 2035, 1011, CAST(N'09:45:00' AS Time), CAST(N'10:25:00' AS Time), NULL, 16)
INSERT [dbo].[Schedule] ([ScheduleID], [WeekID], [GroupID], [SubgroupID], [SubjectID], [TeacherID], [RoomID], [StartTime], [EndTime], [VersionID], [CallID]) VALUES (1875, NULL, 1005, NULL, 2044, 2048, 1013, CAST(N'10:40:00' AS Time), CAST(N'11:20:00' AS Time), NULL, 17)
INSERT [dbo].[Schedule] ([ScheduleID], [WeekID], [GroupID], [SubgroupID], [SubjectID], [TeacherID], [RoomID], [StartTime], [EndTime], [VersionID], [CallID]) VALUES (1876, NULL, 1005, NULL, 2033, 2040, 1011, CAST(N'11:35:00' AS Time), CAST(N'12:15:00' AS Time), NULL, 18)
INSERT [dbo].[Schedule] ([ScheduleID], [WeekID], [GroupID], [SubgroupID], [SubjectID], [TeacherID], [RoomID], [StartTime], [EndTime], [VersionID], [CallID]) VALUES (1877, NULL, 1005, NULL, 2047, 2052, 1017, CAST(N'09:00:00' AS Time), CAST(N'09:40:00' AS Time), NULL, 22)
INSERT [dbo].[Schedule] ([ScheduleID], [WeekID], [GroupID], [SubgroupID], [SubjectID], [TeacherID], [RoomID], [StartTime], [EndTime], [VersionID], [CallID]) VALUES (1878, NULL, 1005, NULL, 2028, 2035, 1012, CAST(N'09:45:00' AS Time), CAST(N'10:25:00' AS Time), NULL, 23)
INSERT [dbo].[Schedule] ([ScheduleID], [WeekID], [GroupID], [SubgroupID], [SubjectID], [TeacherID], [RoomID], [StartTime], [EndTime], [VersionID], [CallID]) VALUES (1880, NULL, 1005, NULL, 2028, 2035, 1015, CAST(N'11:35:00' AS Time), CAST(N'12:15:00' AS Time), NULL, 25)
INSERT [dbo].[Schedule] ([ScheduleID], [WeekID], [GroupID], [SubgroupID], [SubjectID], [TeacherID], [RoomID], [StartTime], [EndTime], [VersionID], [CallID]) VALUES (1986, NULL, 2, NULL, 2037, 2044, 1017, CAST(N'09:00:00' AS Time), CAST(N'09:40:00' AS Time), NULL, 8)
INSERT [dbo].[Schedule] ([ScheduleID], [WeekID], [GroupID], [SubgroupID], [SubjectID], [TeacherID], [RoomID], [StartTime], [EndTime], [VersionID], [CallID]) VALUES (1987, NULL, 2, NULL, 2025, 2032, 1016, CAST(N'09:45:00' AS Time), CAST(N'10:25:00' AS Time), NULL, 9)
INSERT [dbo].[Schedule] ([ScheduleID], [WeekID], [GroupID], [SubgroupID], [SubjectID], [TeacherID], [RoomID], [StartTime], [EndTime], [VersionID], [CallID]) VALUES (1988, NULL, 2, NULL, 2035, 2042, 1015, CAST(N'10:40:00' AS Time), CAST(N'11:20:00' AS Time), NULL, 10)
INSERT [dbo].[Schedule] ([ScheduleID], [WeekID], [GroupID], [SubgroupID], [SubjectID], [TeacherID], [RoomID], [StartTime], [EndTime], [VersionID], [CallID]) VALUES (1989, NULL, 2, NULL, 2036, 2043, 1012, CAST(N'11:35:00' AS Time), CAST(N'12:15:00' AS Time), NULL, 11)
INSERT [dbo].[Schedule] ([ScheduleID], [WeekID], [GroupID], [SubgroupID], [SubjectID], [TeacherID], [RoomID], [StartTime], [EndTime], [VersionID], [CallID]) VALUES (1990, NULL, 2, NULL, 2028, 2035, 1009, CAST(N'09:00:00' AS Time), CAST(N'09:30:00' AS Time), NULL, 1)
INSERT [dbo].[Schedule] ([ScheduleID], [WeekID], [GroupID], [SubgroupID], [SubjectID], [TeacherID], [RoomID], [StartTime], [EndTime], [VersionID], [CallID]) VALUES (1991, NULL, 2, NULL, 2029, 2036, 1010, CAST(N'09:35:00' AS Time), CAST(N'10:15:00' AS Time), NULL, 2)
INSERT [dbo].[Schedule] ([ScheduleID], [WeekID], [GroupID], [SubgroupID], [SubjectID], [TeacherID], [RoomID], [StartTime], [EndTime], [VersionID], [CallID]) VALUES (1992, NULL, 2, NULL, 2028, 2035, 1013, CAST(N'11:15:00' AS Time), CAST(N'11:55:00' AS Time), NULL, 3)
INSERT [dbo].[Schedule] ([ScheduleID], [WeekID], [GroupID], [SubgroupID], [SubjectID], [TeacherID], [RoomID], [StartTime], [EndTime], [VersionID], [CallID]) VALUES (1993, NULL, 2, NULL, 2035, 2042, 1011, CAST(N'12:10:00' AS Time), CAST(N'12:50:00' AS Time), NULL, 4)
INSERT [dbo].[Schedule] ([ScheduleID], [WeekID], [GroupID], [SubgroupID], [SubjectID], [TeacherID], [RoomID], [StartTime], [EndTime], [VersionID], [CallID]) VALUES (1994, NULL, 2, NULL, 2031, 2038, 1010, CAST(N'13:05:00' AS Time), CAST(N'13:45:00' AS Time), NULL, 5)
INSERT [dbo].[Schedule] ([ScheduleID], [WeekID], [GroupID], [SubgroupID], [SubjectID], [TeacherID], [RoomID], [StartTime], [EndTime], [VersionID], [CallID]) VALUES (1995, NULL, 2, NULL, 2044, 2048, 1012, CAST(N'09:00:00' AS Time), CAST(N'09:40:00' AS Time), NULL, 29)
INSERT [dbo].[Schedule] ([ScheduleID], [WeekID], [GroupID], [SubgroupID], [SubjectID], [TeacherID], [RoomID], [StartTime], [EndTime], [VersionID], [CallID]) VALUES (1996, NULL, 2, NULL, 2026, 2033, 1016, CAST(N'09:45:00' AS Time), CAST(N'10:25:00' AS Time), NULL, 30)
INSERT [dbo].[Schedule] ([ScheduleID], [WeekID], [GroupID], [SubgroupID], [SubjectID], [TeacherID], [RoomID], [StartTime], [EndTime], [VersionID], [CallID]) VALUES (1997, NULL, 2, NULL, 2029, 2036, 1008, CAST(N'10:40:00' AS Time), CAST(N'11:20:00' AS Time), NULL, 31)
INSERT [dbo].[Schedule] ([ScheduleID], [WeekID], [GroupID], [SubgroupID], [SubjectID], [TeacherID], [RoomID], [StartTime], [EndTime], [VersionID], [CallID]) VALUES (1998, NULL, 2, NULL, 2031, 2038, 1010, CAST(N'11:35:00' AS Time), CAST(N'12:15:00' AS Time), NULL, 32)
INSERT [dbo].[Schedule] ([ScheduleID], [WeekID], [GroupID], [SubgroupID], [SubjectID], [TeacherID], [RoomID], [StartTime], [EndTime], [VersionID], [CallID]) VALUES (1999, NULL, 2, NULL, 2029, 2036, 1017, CAST(N'12:30:00' AS Time), CAST(N'13:10:00' AS Time), NULL, 33)
INSERT [dbo].[Schedule] ([ScheduleID], [WeekID], [GroupID], [SubgroupID], [SubjectID], [TeacherID], [RoomID], [StartTime], [EndTime], [VersionID], [CallID]) VALUES (2000, NULL, 2, NULL, 2044, 2048, 1012, CAST(N'09:00:00' AS Time), CAST(N'09:40:00' AS Time), NULL, 15)
INSERT [dbo].[Schedule] ([ScheduleID], [WeekID], [GroupID], [SubgroupID], [SubjectID], [TeacherID], [RoomID], [StartTime], [EndTime], [VersionID], [CallID]) VALUES (2001, NULL, 2, NULL, 2037, 2044, 1009, CAST(N'09:45:00' AS Time), CAST(N'10:25:00' AS Time), NULL, 16)
INSERT [dbo].[Schedule] ([ScheduleID], [WeekID], [GroupID], [SubgroupID], [SubjectID], [TeacherID], [RoomID], [StartTime], [EndTime], [VersionID], [CallID]) VALUES (2002, NULL, 2, NULL, 2033, 2040, 1011, CAST(N'10:40:00' AS Time), CAST(N'11:20:00' AS Time), NULL, 17)
INSERT [dbo].[Schedule] ([ScheduleID], [WeekID], [GroupID], [SubgroupID], [SubjectID], [TeacherID], [RoomID], [StartTime], [EndTime], [VersionID], [CallID]) VALUES (2003, NULL, 2, NULL, 2029, 2036, 1010, CAST(N'11:35:00' AS Time), CAST(N'12:15:00' AS Time), NULL, 18)
INSERT [dbo].[Schedule] ([ScheduleID], [WeekID], [GroupID], [SubgroupID], [SubjectID], [TeacherID], [RoomID], [StartTime], [EndTime], [VersionID], [CallID]) VALUES (2004, NULL, 2, NULL, 2037, 2044, 1011, CAST(N'12:30:00' AS Time), CAST(N'13:10:00' AS Time), NULL, 19)
INSERT [dbo].[Schedule] ([ScheduleID], [WeekID], [GroupID], [SubgroupID], [SubjectID], [TeacherID], [RoomID], [StartTime], [EndTime], [VersionID], [CallID]) VALUES (2005, NULL, 2, NULL, 2029, 2036, 1009, CAST(N'09:00:00' AS Time), CAST(N'09:40:00' AS Time), NULL, 22)
INSERT [dbo].[Schedule] ([ScheduleID], [WeekID], [GroupID], [SubgroupID], [SubjectID], [TeacherID], [RoomID], [StartTime], [EndTime], [VersionID], [CallID]) VALUES (2006, NULL, 2, NULL, 2044, 2048, 1016, CAST(N'09:45:00' AS Time), CAST(N'10:25:00' AS Time), NULL, 23)
INSERT [dbo].[Schedule] ([ScheduleID], [WeekID], [GroupID], [SubgroupID], [SubjectID], [TeacherID], [RoomID], [StartTime], [EndTime], [VersionID], [CallID]) VALUES (2007, NULL, 2, NULL, 2033, 2040, 1015, CAST(N'10:40:00' AS Time), CAST(N'11:20:00' AS Time), NULL, 24)
INSERT [dbo].[Schedule] ([ScheduleID], [WeekID], [GroupID], [SubgroupID], [SubjectID], [TeacherID], [RoomID], [StartTime], [EndTime], [VersionID], [CallID]) VALUES (2008, NULL, 2, NULL, 2025, 2032, 1010, CAST(N'11:35:00' AS Time), CAST(N'12:15:00' AS Time), NULL, 25)
INSERT [dbo].[Schedule] ([ScheduleID], [WeekID], [GroupID], [SubgroupID], [SubjectID], [TeacherID], [RoomID], [StartTime], [EndTime], [VersionID], [CallID]) VALUES (2009, NULL, 2, NULL, 2037, 2044, 1009, CAST(N'12:30:00' AS Time), CAST(N'13:10:00' AS Time), NULL, 26)
INSERT [dbo].[Schedule] ([ScheduleID], [WeekID], [GroupID], [SubgroupID], [SubjectID], [TeacherID], [RoomID], [StartTime], [EndTime], [VersionID], [CallID]) VALUES (2092, NULL, 1, NULL, 2028, 2035, 1012, CAST(N'09:00:00' AS Time), CAST(N'09:40:00' AS Time), NULL, 8)
INSERT [dbo].[Schedule] ([ScheduleID], [WeekID], [GroupID], [SubgroupID], [SubjectID], [TeacherID], [RoomID], [StartTime], [EndTime], [VersionID], [CallID]) VALUES (2093, NULL, 1, NULL, 2040, 2049, 1010, CAST(N'09:45:00' AS Time), CAST(N'10:25:00' AS Time), NULL, 9)
INSERT [dbo].[Schedule] ([ScheduleID], [WeekID], [GroupID], [SubgroupID], [SubjectID], [TeacherID], [RoomID], [StartTime], [EndTime], [VersionID], [CallID]) VALUES (2094, NULL, 1, NULL, 2031, 2038, 1009, CAST(N'10:40:00' AS Time), CAST(N'11:20:00' AS Time), NULL, 10)
INSERT [dbo].[Schedule] ([ScheduleID], [WeekID], [GroupID], [SubgroupID], [SubjectID], [TeacherID], [RoomID], [StartTime], [EndTime], [VersionID], [CallID]) VALUES (2095, NULL, 1, NULL, 2041, 2047, 1016, CAST(N'11:35:00' AS Time), CAST(N'12:15:00' AS Time), NULL, 11)
INSERT [dbo].[Schedule] ([ScheduleID], [WeekID], [GroupID], [SubgroupID], [SubjectID], [TeacherID], [RoomID], [StartTime], [EndTime], [VersionID], [CallID]) VALUES (2096, NULL, 1, NULL, 2040, 2049, 1014, CAST(N'12:30:00' AS Time), CAST(N'13:10:00' AS Time), NULL, 12)
INSERT [dbo].[Schedule] ([ScheduleID], [WeekID], [GroupID], [SubgroupID], [SubjectID], [TeacherID], [RoomID], [StartTime], [EndTime], [VersionID], [CallID]) VALUES (2097, NULL, 1, NULL, 2030, 2037, 1017, CAST(N'13:15:00' AS Time), CAST(N'13:55:00' AS Time), NULL, 13)
INSERT [dbo].[Schedule] ([ScheduleID], [WeekID], [GroupID], [SubgroupID], [SubjectID], [TeacherID], [RoomID], [StartTime], [EndTime], [VersionID], [CallID]) VALUES (2098, NULL, 1, NULL, 2031, 2038, 1015, CAST(N'09:00:00' AS Time), CAST(N'09:30:00' AS Time), NULL, 1)
INSERT [dbo].[Schedule] ([ScheduleID], [WeekID], [GroupID], [SubgroupID], [SubjectID], [TeacherID], [RoomID], [StartTime], [EndTime], [VersionID], [CallID]) VALUES (2099, NULL, 1, NULL, 2032, 2039, 1015, CAST(N'09:35:00' AS Time), CAST(N'10:15:00' AS Time), NULL, 2)
GO
INSERT [dbo].[Schedule] ([ScheduleID], [WeekID], [GroupID], [SubgroupID], [SubjectID], [TeacherID], [RoomID], [StartTime], [EndTime], [VersionID], [CallID]) VALUES (2100, NULL, 1, NULL, 2029, 2036, 1009, CAST(N'11:15:00' AS Time), CAST(N'11:55:00' AS Time), NULL, 3)
INSERT [dbo].[Schedule] ([ScheduleID], [WeekID], [GroupID], [SubgroupID], [SubjectID], [TeacherID], [RoomID], [StartTime], [EndTime], [VersionID], [CallID]) VALUES (2101, NULL, 1, NULL, 2028, 2035, 1012, CAST(N'12:10:00' AS Time), CAST(N'12:50:00' AS Time), NULL, 4)
INSERT [dbo].[Schedule] ([ScheduleID], [WeekID], [GroupID], [SubgroupID], [SubjectID], [TeacherID], [RoomID], [StartTime], [EndTime], [VersionID], [CallID]) VALUES (2102, NULL, 1, NULL, 2029, 2036, 1018, CAST(N'13:05:00' AS Time), CAST(N'13:45:00' AS Time), NULL, 5)
INSERT [dbo].[Schedule] ([ScheduleID], [WeekID], [GroupID], [SubgroupID], [SubjectID], [TeacherID], [RoomID], [StartTime], [EndTime], [VersionID], [CallID]) VALUES (2103, NULL, 1, NULL, 2033, 2040, 1008, CAST(N'13:50:00' AS Time), CAST(N'14:30:00' AS Time), NULL, 6)
INSERT [dbo].[Schedule] ([ScheduleID], [WeekID], [GroupID], [SubgroupID], [SubjectID], [TeacherID], [RoomID], [StartTime], [EndTime], [VersionID], [CallID]) VALUES (2104, NULL, 1, NULL, 2027, 2034, 1015, CAST(N'09:00:00' AS Time), CAST(N'09:40:00' AS Time), NULL, 29)
INSERT [dbo].[Schedule] ([ScheduleID], [WeekID], [GroupID], [SubgroupID], [SubjectID], [TeacherID], [RoomID], [StartTime], [EndTime], [VersionID], [CallID]) VALUES (2105, NULL, 1, NULL, 2039, 2046, 1013, CAST(N'09:45:00' AS Time), CAST(N'10:25:00' AS Time), NULL, 30)
INSERT [dbo].[Schedule] ([ScheduleID], [WeekID], [GroupID], [SubgroupID], [SubjectID], [TeacherID], [RoomID], [StartTime], [EndTime], [VersionID], [CallID]) VALUES (2106, NULL, 1, NULL, 2032, 2039, 1015, CAST(N'10:40:00' AS Time), CAST(N'11:20:00' AS Time), NULL, 31)
INSERT [dbo].[Schedule] ([ScheduleID], [WeekID], [GroupID], [SubgroupID], [SubjectID], [TeacherID], [RoomID], [StartTime], [EndTime], [VersionID], [CallID]) VALUES (2107, NULL, 1, NULL, 2025, 2032, 1015, CAST(N'11:35:00' AS Time), CAST(N'12:15:00' AS Time), NULL, 32)
INSERT [dbo].[Schedule] ([ScheduleID], [WeekID], [GroupID], [SubgroupID], [SubjectID], [TeacherID], [RoomID], [StartTime], [EndTime], [VersionID], [CallID]) VALUES (2108, NULL, 1, NULL, 2025, 2032, 1015, CAST(N'09:00:00' AS Time), CAST(N'09:40:00' AS Time), NULL, 15)
INSERT [dbo].[Schedule] ([ScheduleID], [WeekID], [GroupID], [SubgroupID], [SubjectID], [TeacherID], [RoomID], [StartTime], [EndTime], [VersionID], [CallID]) VALUES (2109, NULL, 1, NULL, 2029, 2036, 1014, CAST(N'09:45:00' AS Time), CAST(N'10:25:00' AS Time), NULL, 16)
INSERT [dbo].[Schedule] ([ScheduleID], [WeekID], [GroupID], [SubgroupID], [SubjectID], [TeacherID], [RoomID], [StartTime], [EndTime], [VersionID], [CallID]) VALUES (2110, NULL, 1, NULL, 2044, 2048, 1017, CAST(N'10:40:00' AS Time), CAST(N'11:20:00' AS Time), NULL, 17)
INSERT [dbo].[Schedule] ([ScheduleID], [WeekID], [GroupID], [SubgroupID], [SubjectID], [TeacherID], [RoomID], [StartTime], [EndTime], [VersionID], [CallID]) VALUES (2111, NULL, 1, NULL, 2030, 2037, 1015, CAST(N'11:35:00' AS Time), CAST(N'12:15:00' AS Time), NULL, 18)
INSERT [dbo].[Schedule] ([ScheduleID], [WeekID], [GroupID], [SubgroupID], [SubjectID], [TeacherID], [RoomID], [StartTime], [EndTime], [VersionID], [CallID]) VALUES (2112, NULL, 1, NULL, 2039, 2046, 1014, CAST(N'12:30:00' AS Time), CAST(N'13:10:00' AS Time), NULL, 19)
INSERT [dbo].[Schedule] ([ScheduleID], [WeekID], [GroupID], [SubgroupID], [SubjectID], [TeacherID], [RoomID], [StartTime], [EndTime], [VersionID], [CallID]) VALUES (2113, NULL, 1, NULL, 2040, 2049, 1015, CAST(N'13:15:00' AS Time), CAST(N'13:55:00' AS Time), NULL, 20)
INSERT [dbo].[Schedule] ([ScheduleID], [WeekID], [GroupID], [SubgroupID], [SubjectID], [TeacherID], [RoomID], [StartTime], [EndTime], [VersionID], [CallID]) VALUES (2114, NULL, 1, NULL, 2031, 2038, 1012, CAST(N'09:00:00' AS Time), CAST(N'09:40:00' AS Time), NULL, 22)
INSERT [dbo].[Schedule] ([ScheduleID], [WeekID], [GroupID], [SubgroupID], [SubjectID], [TeacherID], [RoomID], [StartTime], [EndTime], [VersionID], [CallID]) VALUES (2115, NULL, 1, NULL, 2029, 2036, 1013, CAST(N'09:45:00' AS Time), CAST(N'10:25:00' AS Time), NULL, 23)
INSERT [dbo].[Schedule] ([ScheduleID], [WeekID], [GroupID], [SubgroupID], [SubjectID], [TeacherID], [RoomID], [StartTime], [EndTime], [VersionID], [CallID]) VALUES (2116, NULL, 1, NULL, 2025, 2032, 1008, CAST(N'10:40:00' AS Time), CAST(N'11:20:00' AS Time), NULL, 24)
INSERT [dbo].[Schedule] ([ScheduleID], [WeekID], [GroupID], [SubgroupID], [SubjectID], [TeacherID], [RoomID], [StartTime], [EndTime], [VersionID], [CallID]) VALUES (2117, NULL, 1, NULL, 2034, 2041, 1011, CAST(N'11:35:00' AS Time), CAST(N'12:15:00' AS Time), NULL, 25)
INSERT [dbo].[Schedule] ([ScheduleID], [WeekID], [GroupID], [SubgroupID], [SubjectID], [TeacherID], [RoomID], [StartTime], [EndTime], [VersionID], [CallID]) VALUES (2118, NULL, 1, NULL, 2044, 2048, 1016, CAST(N'12:30:00' AS Time), CAST(N'13:10:00' AS Time), NULL, 26)
INSERT [dbo].[Schedule] ([ScheduleID], [WeekID], [GroupID], [SubgroupID], [SubjectID], [TeacherID], [RoomID], [StartTime], [EndTime], [VersionID], [CallID]) VALUES (2119, NULL, 1, NULL, 2038, 2045, 1011, CAST(N'13:15:00' AS Time), CAST(N'13:55:00' AS Time), NULL, 27)
SET IDENTITY_INSERT [dbo].[Schedule] OFF
GO
SET IDENTITY_INSERT [dbo].[ScheduleVersions] ON 

INSERT [dbo].[ScheduleVersions] ([VersionID], [GroupID], [CreatedAt], [IsActive]) VALUES (1, 1, CAST(N'2025-05-12T00:00:00.000' AS DateTime), 1)
SET IDENTITY_INSERT [dbo].[ScheduleVersions] OFF
GO
SET IDENTITY_INSERT [dbo].[Subgroups] ON 

INSERT [dbo].[Subgroups] ([SubgroupID], [GroupID], [Name]) VALUES (1, 1, N'1A-1')
INSERT [dbo].[Subgroups] ([SubgroupID], [GroupID], [Name]) VALUES (2, 1, N'1A-2')
SET IDENTITY_INSERT [dbo].[Subgroups] OFF
GO
SET IDENTITY_INSERT [dbo].[Subjects] ON 

INSERT [dbo].[Subjects] ([SubjectID], [Name], [Complexity], [Hours]) VALUES (2025, N'Русский язык', 8, 120)
INSERT [dbo].[Subjects] ([SubjectID], [Name], [Complexity], [Hours]) VALUES (2026, N'Литература', 6, 120)
INSERT [dbo].[Subjects] ([SubjectID], [Name], [Complexity], [Hours]) VALUES (2027, N'Математика', 10, 120)
INSERT [dbo].[Subjects] ([SubjectID], [Name], [Complexity], [Hours]) VALUES (2028, N'История', 6, 120)
INSERT [dbo].[Subjects] ([SubjectID], [Name], [Complexity], [Hours]) VALUES (2029, N'География', 4, 120)
INSERT [dbo].[Subjects] ([SubjectID], [Name], [Complexity], [Hours]) VALUES (2030, N'Музыка', 2, 100)
INSERT [dbo].[Subjects] ([SubjectID], [Name], [Complexity], [Hours]) VALUES (2031, N'ИЗО', 3, 120)
INSERT [dbo].[Subjects] ([SubjectID], [Name], [Complexity], [Hours]) VALUES (2032, N'Физическая культура', 5, 120)
INSERT [dbo].[Subjects] ([SubjectID], [Name], [Complexity], [Hours]) VALUES (2033, N'ОДНКНР', 5, 120)
INSERT [dbo].[Subjects] ([SubjectID], [Name], [Complexity], [Hours]) VALUES (2034, N'Родной русский', 3, 120)
INSERT [dbo].[Subjects] ([SubjectID], [Name], [Complexity], [Hours]) VALUES (2035, N'Родная литература', 6, 120)
INSERT [dbo].[Subjects] ([SubjectID], [Name], [Complexity], [Hours]) VALUES (2036, N'Алгебра', 9, 120)
INSERT [dbo].[Subjects] ([SubjectID], [Name], [Complexity], [Hours]) VALUES (2037, N'Геометрия', 6, 120)
INSERT [dbo].[Subjects] ([SubjectID], [Name], [Complexity], [Hours]) VALUES (2038, N'История России', 7, 120)
INSERT [dbo].[Subjects] ([SubjectID], [Name], [Complexity], [Hours]) VALUES (2039, N'Английский язык', 7, 120)
INSERT [dbo].[Subjects] ([SubjectID], [Name], [Complexity], [Hours]) VALUES (2040, N'Башкирский язык', 5, 120)
INSERT [dbo].[Subjects] ([SubjectID], [Name], [Complexity], [Hours]) VALUES (2041, N'Технология', 5, 120)
INSERT [dbo].[Subjects] ([SubjectID], [Name], [Complexity], [Hours]) VALUES (2042, N'Физическая культура', 4, 120)
INSERT [dbo].[Subjects] ([SubjectID], [Name], [Complexity], [Hours]) VALUES (2043, N'Биология', 6, 120)
INSERT [dbo].[Subjects] ([SubjectID], [Name], [Complexity], [Hours]) VALUES (2044, N'Информатика', 6, 120)
INSERT [dbo].[Subjects] ([SubjectID], [Name], [Complexity], [Hours]) VALUES (2045, N'Башкирский язык', 5, 120)
INSERT [dbo].[Subjects] ([SubjectID], [Name], [Complexity], [Hours]) VALUES (2046, N'Физика', 9, 120)
INSERT [dbo].[Subjects] ([SubjectID], [Name], [Complexity], [Hours]) VALUES (2047, N'ОБЖ', 4, 120)
INSERT [dbo].[Subjects] ([SubjectID], [Name], [Complexity], [Hours]) VALUES (2048, N'Химия', 9, 120)
INSERT [dbo].[Subjects] ([SubjectID], [Name], [Complexity], [Hours]) VALUES (2049, N'Обществознание', 9, 120)
INSERT [dbo].[Subjects] ([SubjectID], [Name], [Complexity], [Hours]) VALUES (2050, N'Этика', 15, 10)
SET IDENTITY_INSERT [dbo].[Subjects] OFF
GO
INSERT [dbo].[Teacher_Subjects] ([SubjectID], [TeacherID]) VALUES (2025, 2032)
INSERT [dbo].[Teacher_Subjects] ([SubjectID], [TeacherID]) VALUES (2026, 2033)
INSERT [dbo].[Teacher_Subjects] ([SubjectID], [TeacherID]) VALUES (2027, 2034)
INSERT [dbo].[Teacher_Subjects] ([SubjectID], [TeacherID]) VALUES (2028, 2035)
INSERT [dbo].[Teacher_Subjects] ([SubjectID], [TeacherID]) VALUES (2029, 2036)
INSERT [dbo].[Teacher_Subjects] ([SubjectID], [TeacherID]) VALUES (2030, 2037)
INSERT [dbo].[Teacher_Subjects] ([SubjectID], [TeacherID]) VALUES (2031, 2038)
INSERT [dbo].[Teacher_Subjects] ([SubjectID], [TeacherID]) VALUES (2032, 2039)
INSERT [dbo].[Teacher_Subjects] ([SubjectID], [TeacherID]) VALUES (2033, 2040)
INSERT [dbo].[Teacher_Subjects] ([SubjectID], [TeacherID]) VALUES (2034, 2041)
INSERT [dbo].[Teacher_Subjects] ([SubjectID], [TeacherID]) VALUES (2035, 2042)
INSERT [dbo].[Teacher_Subjects] ([SubjectID], [TeacherID]) VALUES (2036, 2043)
INSERT [dbo].[Teacher_Subjects] ([SubjectID], [TeacherID]) VALUES (2037, 2044)
INSERT [dbo].[Teacher_Subjects] ([SubjectID], [TeacherID]) VALUES (2038, 2045)
INSERT [dbo].[Teacher_Subjects] ([SubjectID], [TeacherID]) VALUES (2039, 2046)
INSERT [dbo].[Teacher_Subjects] ([SubjectID], [TeacherID]) VALUES (2040, 2049)
INSERT [dbo].[Teacher_Subjects] ([SubjectID], [TeacherID]) VALUES (2041, 2047)
INSERT [dbo].[Teacher_Subjects] ([SubjectID], [TeacherID]) VALUES (2044, 2048)
INSERT [dbo].[Teacher_Subjects] ([SubjectID], [TeacherID]) VALUES (2046, 2050)
INSERT [dbo].[Teacher_Subjects] ([SubjectID], [TeacherID]) VALUES (2047, 2052)
INSERT [dbo].[Teacher_Subjects] ([SubjectID], [TeacherID]) VALUES (2048, 2053)
GO
SET IDENTITY_INSERT [dbo].[Teachers] ON 

INSERT [dbo].[Teachers] ([TeacherID], [FullName], [SubjectID], [UserID]) VALUES (2032, N'Тимербаев Данис Раилевич', 2025, NULL)
INSERT [dbo].[Teachers] ([TeacherID], [FullName], [SubjectID], [UserID]) VALUES (2033, N'Тимербаев Данис Раилевич', 2026, NULL)
INSERT [dbo].[Teachers] ([TeacherID], [FullName], [SubjectID], [UserID]) VALUES (2034, N'Байгузин Егор Евгеньевич', 2027, NULL)
INSERT [dbo].[Teachers] ([TeacherID], [FullName], [SubjectID], [UserID]) VALUES (2035, N'Губайдуллин Артур Маратович', 2028, NULL)
INSERT [dbo].[Teachers] ([TeacherID], [FullName], [SubjectID], [UserID]) VALUES (2036, N'Гильманшин Азамат Шамилевич', 2029, NULL)
INSERT [dbo].[Teachers] ([TeacherID], [FullName], [SubjectID], [UserID]) VALUES (2037, N'Бажутина Ильвира Талгатовна', 2030, NULL)
INSERT [dbo].[Teachers] ([TeacherID], [FullName], [SubjectID], [UserID]) VALUES (2038, N'Хабибуллин Хакимьян Насихович', 2031, NULL)
INSERT [dbo].[Teachers] ([TeacherID], [FullName], [SubjectID], [UserID]) VALUES (2039, N'Тимербаева Рузалия Ришатовна', 2032, NULL)
INSERT [dbo].[Teachers] ([TeacherID], [FullName], [SubjectID], [UserID]) VALUES (2040, N'Андрианов Кирил Тимофеевич', 2033, NULL)
INSERT [dbo].[Teachers] ([TeacherID], [FullName], [SubjectID], [UserID]) VALUES (2041, N'Тимербаев Данис Раилевич', 2034, NULL)
INSERT [dbo].[Teachers] ([TeacherID], [FullName], [SubjectID], [UserID]) VALUES (2042, N'Тимербаев Данис Раилевич', 2035, NULL)
INSERT [dbo].[Teachers] ([TeacherID], [FullName], [SubjectID], [UserID]) VALUES (2043, N'Байгузин Егор Евгеньевич', 2036, NULL)
INSERT [dbo].[Teachers] ([TeacherID], [FullName], [SubjectID], [UserID]) VALUES (2044, N'Байгузин Егор Евгеньевич', 2037, NULL)
INSERT [dbo].[Teachers] ([TeacherID], [FullName], [SubjectID], [UserID]) VALUES (2045, N'Губайдуллин Артур Маратович', 2038, NULL)
INSERT [dbo].[Teachers] ([TeacherID], [FullName], [SubjectID], [UserID]) VALUES (2046, N'Попова Амира Артёмовна', 2039, NULL)
INSERT [dbo].[Teachers] ([TeacherID], [FullName], [SubjectID], [UserID]) VALUES (2047, N'Никулин Михаил Никитич', 2041, NULL)
INSERT [dbo].[Teachers] ([TeacherID], [FullName], [SubjectID], [UserID]) VALUES (2048, N'Золотов Дмитрий Александрович', 2044, NULL)
INSERT [dbo].[Teachers] ([TeacherID], [FullName], [SubjectID], [UserID]) VALUES (2049, N'Давыдов Сергей Артемьевич', 2040, NULL)
INSERT [dbo].[Teachers] ([TeacherID], [FullName], [SubjectID], [UserID]) VALUES (2050, N'Байгузин Егор Евгеньевич', 2046, NULL)
INSERT [dbo].[Teachers] ([TeacherID], [FullName], [SubjectID], [UserID]) VALUES (2052, N'Трофимова Дарина Демидовна', 2047, NULL)
INSERT [dbo].[Teachers] ([TeacherID], [FullName], [SubjectID], [UserID]) VALUES (2053, N'Богданова Мирослава Алиевна', 2048, NULL)
SET IDENTITY_INSERT [dbo].[Teachers] OFF
GO
SET IDENTITY_INSERT [dbo].[Users] ON 

INSERT [dbo].[Users] ([UserID], [Username], [PasswordHash], [Role]) VALUES (1, N'admin', N'$2a$11$HedlO88doPk.VFTCs/T.Ju42cOGSj12tLLI2b8PBwiXkieBBQX39K', N'Admin')
SET IDENTITY_INSERT [dbo].[Users] OFF
GO
SET IDENTITY_INSERT [dbo].[Weeks] ON 

INSERT [dbo].[Weeks] ([WeekID], [StartDate], [EndDate]) VALUES (2, CAST(N'2025-04-07' AS Date), CAST(N'2025-04-07' AS Date))
INSERT [dbo].[Weeks] ([WeekID], [StartDate], [EndDate]) VALUES (1002, CAST(N'2025-04-08' AS Date), CAST(N'2025-04-08' AS Date))
INSERT [dbo].[Weeks] ([WeekID], [StartDate], [EndDate]) VALUES (1003, CAST(N'2025-04-09' AS Date), CAST(N'2025-04-09' AS Date))
INSERT [dbo].[Weeks] ([WeekID], [StartDate], [EndDate]) VALUES (1004, CAST(N'2025-04-10' AS Date), CAST(N'2025-04-10' AS Date))
INSERT [dbo].[Weeks] ([WeekID], [StartDate], [EndDate]) VALUES (1006, CAST(N'2025-04-11' AS Date), CAST(N'2025-04-11' AS Date))
SET IDENTITY_INSERT [dbo].[Weeks] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Users__536C85E43DDDFCF7]    Script Date: 02.07.2025 15:36:01 ******/
ALTER TABLE [dbo].[Users] ADD UNIQUE NONCLUSTERED 
(
	[Username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Rooms] ADD  DEFAULT ((0)) FOR [IsShared]
GO
ALTER TABLE [dbo].[ScheduleVersions] ADD  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[ScheduleVersions] ADD  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[Curriculum]  WITH CHECK ADD  CONSTRAINT [FK__Curriculu__Group__05D8E0BE] FOREIGN KEY([GroupID])
REFERENCES [dbo].[Groups] ([GroupID])
GO
ALTER TABLE [dbo].[Curriculum] CHECK CONSTRAINT [FK__Curriculu__Group__05D8E0BE]
GO
ALTER TABLE [dbo].[Curriculum]  WITH CHECK ADD FOREIGN KEY([SubjectID])
REFERENCES [dbo].[Subjects] ([SubjectID])
GO
ALTER TABLE [dbo].[Schedule]  WITH CHECK ADD  CONSTRAINT [FK__Schedule__GroupI__4E88ABD4] FOREIGN KEY([GroupID])
REFERENCES [dbo].[Groups] ([GroupID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Schedule] CHECK CONSTRAINT [FK__Schedule__GroupI__4E88ABD4]
GO
ALTER TABLE [dbo].[Schedule]  WITH CHECK ADD FOREIGN KEY([RoomID])
REFERENCES [dbo].[Rooms] ([RoomID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Schedule]  WITH CHECK ADD FOREIGN KEY([SubgroupID])
REFERENCES [dbo].[Subgroups] ([SubgroupID])
GO
ALTER TABLE [dbo].[Schedule]  WITH CHECK ADD FOREIGN KEY([SubjectID])
REFERENCES [dbo].[Subjects] ([SubjectID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Schedule]  WITH CHECK ADD FOREIGN KEY([VersionID])
REFERENCES [dbo].[ScheduleVersions] ([VersionID])
GO
ALTER TABLE [dbo].[Schedule]  WITH CHECK ADD FOREIGN KEY([WeekID])
REFERENCES [dbo].[Weeks] ([WeekID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Schedule]  WITH CHECK ADD  CONSTRAINT [FK_Schedule_Calls] FOREIGN KEY([CallID])
REFERENCES [dbo].[Calls] ([CallID])
GO
ALTER TABLE [dbo].[Schedule] CHECK CONSTRAINT [FK_Schedule_Calls]
GO
ALTER TABLE [dbo].[Schedule]  WITH CHECK ADD  CONSTRAINT [FK_Schedule_Teachers] FOREIGN KEY([TeacherID])
REFERENCES [dbo].[Teachers] ([TeacherID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Schedule] CHECK CONSTRAINT [FK_Schedule_Teachers]
GO
ALTER TABLE [dbo].[ScheduleVersions]  WITH CHECK ADD  CONSTRAINT [FK__ScheduleV__Group__5629CD9C] FOREIGN KEY([GroupID])
REFERENCES [dbo].[Groups] ([GroupID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ScheduleVersions] CHECK CONSTRAINT [FK__ScheduleV__Group__5629CD9C]
GO
ALTER TABLE [dbo].[Subgroups]  WITH CHECK ADD  CONSTRAINT [FK__Subgroups__Group__571DF1D5] FOREIGN KEY([GroupID])
REFERENCES [dbo].[Groups] ([GroupID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Subgroups] CHECK CONSTRAINT [FK__Subgroups__Group__571DF1D5]
GO
ALTER TABLE [dbo].[Teacher_Subjects]  WITH CHECK ADD  CONSTRAINT [FK_Teacher_Subjects_Subjects] FOREIGN KEY([SubjectID])
REFERENCES [dbo].[Subjects] ([SubjectID])
GO
ALTER TABLE [dbo].[Teacher_Subjects] CHECK CONSTRAINT [FK_Teacher_Subjects_Subjects]
GO
ALTER TABLE [dbo].[Teacher_Subjects]  WITH CHECK ADD  CONSTRAINT [FK_Teacher_Subjects_Teachers] FOREIGN KEY([TeacherID])
REFERENCES [dbo].[Teachers] ([TeacherID])
GO
ALTER TABLE [dbo].[Teacher_Subjects] CHECK CONSTRAINT [FK_Teacher_Subjects_Teachers]
GO
ALTER TABLE [dbo].[TeacherRestrictions]  WITH CHECK ADD FOREIGN KEY([TeacherID])
REFERENCES [dbo].[Teachers] ([TeacherID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Teachers]  WITH CHECK ADD FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([UserID])
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[Subjects]  WITH CHECK ADD CHECK  (([Complexity]>=(1) AND [Complexity]<=(15)))
GO
ALTER TABLE [dbo].[TeacherRestrictions]  WITH CHECK ADD CHECK  (([DayOfWeek]='Friday' OR [DayOfWeek]='Thursday' OR [DayOfWeek]='Wednesday' OR [DayOfWeek]='Tuesday' OR [DayOfWeek]='Monday'))
GO
ALTER TABLE [dbo].[Users]  WITH CHECK ADD CHECK  (([Role]='Teacher' OR [Role]='Admin'))
GO
USE [master]
GO
ALTER DATABASE [SchoolSchedule] SET  READ_WRITE 
GO
