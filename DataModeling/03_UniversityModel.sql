USE [master]
GO
/****** Object:  Database [UniversityModel]    Script Date: 22.8.2014 г. 16:57:18 ******/
CREATE DATABASE [UniversityModel]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'UniversityModel', FILENAME = N'D:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\UniversityModel.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'UniversityModel_log', FILENAME = N'D:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\UniversityModel_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [UniversityModel] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [UniversityModel].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [UniversityModel] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [UniversityModel] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [UniversityModel] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [UniversityModel] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [UniversityModel] SET ARITHABORT OFF 
GO
ALTER DATABASE [UniversityModel] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [UniversityModel] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [UniversityModel] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [UniversityModel] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [UniversityModel] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [UniversityModel] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [UniversityModel] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [UniversityModel] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [UniversityModel] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [UniversityModel] SET  DISABLE_BROKER 
GO
ALTER DATABASE [UniversityModel] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [UniversityModel] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [UniversityModel] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [UniversityModel] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [UniversityModel] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [UniversityModel] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [UniversityModel] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [UniversityModel] SET RECOVERY FULL 
GO
ALTER DATABASE [UniversityModel] SET  MULTI_USER 
GO
ALTER DATABASE [UniversityModel] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [UniversityModel] SET DB_CHAINING OFF 
GO
ALTER DATABASE [UniversityModel] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [UniversityModel] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [UniversityModel] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'UniversityModel', N'ON'
GO
USE [UniversityModel]
GO
/****** Object:  Table [dbo].[Courses]    Script Date: 22.8.2014 г. 16:57:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Courses](
	[CourseId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Courses] PRIMARY KEY CLUSTERED 
(
	[CourseId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[DepartmentCourses]    Script Date: 22.8.2014 г. 16:57:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DepartmentCourses](
	[DepartmentId] [int] NOT NULL,
	[CourseId] [int] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Departments]    Script Date: 22.8.2014 г. 16:57:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Departments](
	[DepartmentId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[FacultyId] [int] NOT NULL,
 CONSTRAINT [PK_Departments] PRIMARY KEY CLUSTERED 
(
	[DepartmentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Faculties]    Script Date: 22.8.2014 г. 16:57:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Faculties](
	[FacultyId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[UniversityId] [int] NOT NULL,
 CONSTRAINT [PK_Faculties] PRIMARY KEY CLUSTERED 
(
	[FacultyId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ProfessorCourses]    Script Date: 22.8.2014 г. 16:57:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProfessorCourses](
	[ProfessorId] [int] NOT NULL,
	[CourseId] [int] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Professors]    Script Date: 22.8.2014 г. 16:57:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Professors](
	[ProfessorId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[DepartmentId] [int] NULL,
 CONSTRAINT [PK_Professors] PRIMARY KEY CLUSTERED 
(
	[ProfessorId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ProfessorTitles]    Script Date: 22.8.2014 г. 16:57:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProfessorTitles](
	[ProfessorId] [int] NOT NULL,
	[TitleId] [int] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Student]    Script Date: 22.8.2014 г. 16:57:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Student](
	[StudentId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[FacultyId] [int] NOT NULL,
 CONSTRAINT [PK_Student] PRIMARY KEY CLUSTERED 
(
	[StudentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[StudentCourses]    Script Date: 22.8.2014 г. 16:57:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StudentCourses](
	[StudentId] [int] NOT NULL,
	[CourseId] [int] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Titles]    Script Date: 22.8.2014 г. 16:57:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Titles](
	[ProfessorTitleId] [int] IDENTITY(1,1) NOT NULL,
	[Title] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Titles] PRIMARY KEY CLUSTERED 
(
	[ProfessorTitleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Universities]    Script Date: 22.8.2014 г. 16:57:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Universities](
	[UniversityId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Universities] PRIMARY KEY CLUSTERED 
(
	[UniversityId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[DepartmentCourses]  WITH CHECK ADD  CONSTRAINT [FK_DepartmentCourses_Courses] FOREIGN KEY([CourseId])
REFERENCES [dbo].[Courses] ([CourseId])
GO
ALTER TABLE [dbo].[DepartmentCourses] CHECK CONSTRAINT [FK_DepartmentCourses_Courses]
GO
ALTER TABLE [dbo].[DepartmentCourses]  WITH CHECK ADD  CONSTRAINT [FK_DepartmentCourses_Departments] FOREIGN KEY([DepartmentId])
REFERENCES [dbo].[Departments] ([DepartmentId])
GO
ALTER TABLE [dbo].[DepartmentCourses] CHECK CONSTRAINT [FK_DepartmentCourses_Departments]
GO
ALTER TABLE [dbo].[Departments]  WITH CHECK ADD  CONSTRAINT [FK_Departments_Faculties] FOREIGN KEY([FacultyId])
REFERENCES [dbo].[Faculties] ([FacultyId])
GO
ALTER TABLE [dbo].[Departments] CHECK CONSTRAINT [FK_Departments_Faculties]
GO
ALTER TABLE [dbo].[Faculties]  WITH CHECK ADD  CONSTRAINT [FK_Faculties_Universities] FOREIGN KEY([UniversityId])
REFERENCES [dbo].[Universities] ([UniversityId])
GO
ALTER TABLE [dbo].[Faculties] CHECK CONSTRAINT [FK_Faculties_Universities]
GO
ALTER TABLE [dbo].[ProfessorCourses]  WITH CHECK ADD  CONSTRAINT [FK_ProfessorCourses_Courses] FOREIGN KEY([CourseId])
REFERENCES [dbo].[Courses] ([CourseId])
GO
ALTER TABLE [dbo].[ProfessorCourses] CHECK CONSTRAINT [FK_ProfessorCourses_Courses]
GO
ALTER TABLE [dbo].[ProfessorCourses]  WITH CHECK ADD  CONSTRAINT [FK_ProfessorCourses_Professors] FOREIGN KEY([ProfessorId])
REFERENCES [dbo].[Professors] ([ProfessorId])
GO
ALTER TABLE [dbo].[ProfessorCourses] CHECK CONSTRAINT [FK_ProfessorCourses_Professors]
GO
ALTER TABLE [dbo].[Professors]  WITH CHECK ADD  CONSTRAINT [FK_Professors_Departments] FOREIGN KEY([DepartmentId])
REFERENCES [dbo].[Departments] ([DepartmentId])
GO
ALTER TABLE [dbo].[Professors] CHECK CONSTRAINT [FK_Professors_Departments]
GO
ALTER TABLE [dbo].[ProfessorTitles]  WITH CHECK ADD  CONSTRAINT [FK_ProfessorTitles_Professors] FOREIGN KEY([ProfessorId])
REFERENCES [dbo].[Professors] ([ProfessorId])
GO
ALTER TABLE [dbo].[ProfessorTitles] CHECK CONSTRAINT [FK_ProfessorTitles_Professors]
GO
ALTER TABLE [dbo].[ProfessorTitles]  WITH CHECK ADD  CONSTRAINT [FK_ProfessorTitles_Titles] FOREIGN KEY([TitleId])
REFERENCES [dbo].[Titles] ([ProfessorTitleId])
GO
ALTER TABLE [dbo].[ProfessorTitles] CHECK CONSTRAINT [FK_ProfessorTitles_Titles]
GO
ALTER TABLE [dbo].[Student]  WITH CHECK ADD  CONSTRAINT [FK_Student_Faculties] FOREIGN KEY([FacultyId])
REFERENCES [dbo].[Faculties] ([FacultyId])
GO
ALTER TABLE [dbo].[Student] CHECK CONSTRAINT [FK_Student_Faculties]
GO
ALTER TABLE [dbo].[StudentCourses]  WITH CHECK ADD  CONSTRAINT [FK_StudentCourses_Courses] FOREIGN KEY([CourseId])
REFERENCES [dbo].[Courses] ([CourseId])
GO
ALTER TABLE [dbo].[StudentCourses] CHECK CONSTRAINT [FK_StudentCourses_Courses]
GO
ALTER TABLE [dbo].[StudentCourses]  WITH CHECK ADD  CONSTRAINT [FK_StudentCourses_Student] FOREIGN KEY([StudentId])
REFERENCES [dbo].[Student] ([StudentId])
GO
ALTER TABLE [dbo].[StudentCourses] CHECK CONSTRAINT [FK_StudentCourses_Student]
GO
USE [master]
GO
ALTER DATABASE [UniversityModel] SET  READ_WRITE 
GO
