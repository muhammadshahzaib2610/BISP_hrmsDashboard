USE [master]
GO
/****** Object:  Database [BISP_hrmsDashboard]    Script Date: 01/09/2025 10:57:19 am ******/
CREATE DATABASE [BISP_hrmsDashboard]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'BISP_hrmsDashboard', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\BISP_hrmsDashboard.mdf' , SIZE = 73728KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'BISP_hrmsDashboard_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\BISP_hrmsDashboard_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [BISP_hrmsDashboard] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [BISP_hrmsDashboard].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [BISP_hrmsDashboard] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [BISP_hrmsDashboard] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [BISP_hrmsDashboard] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [BISP_hrmsDashboard] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [BISP_hrmsDashboard] SET ARITHABORT OFF 
GO
ALTER DATABASE [BISP_hrmsDashboard] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [BISP_hrmsDashboard] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [BISP_hrmsDashboard] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [BISP_hrmsDashboard] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [BISP_hrmsDashboard] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [BISP_hrmsDashboard] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [BISP_hrmsDashboard] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [BISP_hrmsDashboard] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [BISP_hrmsDashboard] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [BISP_hrmsDashboard] SET  DISABLE_BROKER 
GO
ALTER DATABASE [BISP_hrmsDashboard] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [BISP_hrmsDashboard] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [BISP_hrmsDashboard] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [BISP_hrmsDashboard] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [BISP_hrmsDashboard] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [BISP_hrmsDashboard] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [BISP_hrmsDashboard] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [BISP_hrmsDashboard] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [BISP_hrmsDashboard] SET  MULTI_USER 
GO
ALTER DATABASE [BISP_hrmsDashboard] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [BISP_hrmsDashboard] SET DB_CHAINING OFF 
GO
ALTER DATABASE [BISP_hrmsDashboard] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [BISP_hrmsDashboard] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [BISP_hrmsDashboard] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [BISP_hrmsDashboard] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [BISP_hrmsDashboard] SET QUERY_STORE = ON
GO
ALTER DATABASE [BISP_hrmsDashboard] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [BISP_hrmsDashboard]
GO
/****** Object:  Table [dbo].[lib_designation]    Script Date: 01/09/2025 10:57:20 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[lib_designation](
	[DesignationID] [int] IDENTITY(1,1) NOT NULL,
	[DesignationName] [nvarchar](150) NOT NULL,
	[IsActive] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[DesignationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[DesignationName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[lib_district]    Script Date: 01/09/2025 10:57:20 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[lib_district](
	[DistrictCode] [int] NOT NULL,
	[ProvinceCode] [int] NOT NULL,
	[DistrictName] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[DistrictCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ_district_per_province] UNIQUE NONCLUSTERED 
(
	[ProvinceCode] ASC,
	[DistrictName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[lib_education]    Script Date: 01/09/2025 10:57:20 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[lib_education](
	[EducationID] [int] IDENTITY(1,1) NOT NULL,
	[EducationName] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[EducationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[lib_gender]    Script Date: 01/09/2025 10:57:20 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[lib_gender](
	[GenderID] [int] IDENTITY(1,1) NOT NULL,
	[GenderName] [nvarchar](20) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[GenderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[lib_marital_status]    Script Date: 01/09/2025 10:57:20 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[lib_marital_status](
	[marital_status_id] [int] IDENTITY(1,1) NOT NULL,
	[status_name] [nvarchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[marital_status_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[lib_parent_office]    Script Date: 01/09/2025 10:57:20 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[lib_parent_office](
	[ParentOfficeID] [int] IDENTITY(1,1) NOT NULL,
	[OfficeName] [varchar](150) NOT NULL,
	[IsActive] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ParentOfficeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[OfficeName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[lib_province]    Script Date: 01/09/2025 10:57:20 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[lib_province](
	[ProvinceCode] [int] NOT NULL,
	[ProvinceName] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ProvinceCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[ProvinceName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[lib_religion]    Script Date: 01/09/2025 10:57:20 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[lib_religion](
	[ReligionID] [int] IDENTITY(1,1) NOT NULL,
	[ReligionName] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ReligionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[ReligionName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[lib_religion_cast]    Script Date: 01/09/2025 10:57:20 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[lib_religion_cast](
	[CastID] [int] IDENTITY(1,1) NOT NULL,
	[ReligionID] [int] NOT NULL,
	[CastName] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[CastID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ_religion_cast] UNIQUE NONCLUSTERED 
(
	[ReligionID] ASC,
	[CastName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[lib_scale]    Script Date: 01/09/2025 10:57:20 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[lib_scale](
	[ScaleID] [int] NOT NULL,
	[ScaleCode] [varchar](20) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ScaleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[ScaleCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[lib_status]    Script Date: 01/09/2025 10:57:20 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[lib_status](
	[StatusID] [int] IDENTITY(1,1) NOT NULL,
	[StatusName] [varchar](30) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[StatusID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[StatusName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[lib_tehsil]    Script Date: 01/09/2025 10:57:20 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[lib_tehsil](
	[TehsilCode] [int] NOT NULL,
	[DistrictCode] [int] NOT NULL,
	[TehsilName] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[TehsilCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ_tehsil_per_district] UNIQUE NONCLUSTERED 
(
	[DistrictCode] ASC,
	[TehsilName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[login]    Script Date: 01/09/2025 10:57:20 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[login](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[cnic] [char](13) NOT NULL,
	[username] [nvarchar](100) NULL,
	[password] [nvarchar](255) NOT NULL,
	[allowed_ip] [varchar](45) NULL,
	[status] [bit] NOT NULL,
	[created_at] [datetime2](7) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[cnic] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_Employee]    Script Date: 01/09/2025 10:57:20 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Employee](
	[EMPLOYEE_ID] [int] IDENTITY(1,1) NOT NULL,
	[CNIC] [bigint] NULL,
	[NAME] [varchar](100) NULL,
	[FATHER_NAME] [varchar](100) NULL,
	[GENDER] [int] NULL,
	[DOB] [date] NULL,
	[MARITAL_STATUS] [int] NULL,
	[RELIGION] [int] NULL,
	[RELIGION_CAST] [int] NULL,
	[CHILDREN] [int] NULL,
	[DOMICILE_PROVINCE] [int] NULL,
	[DOMICILE_DISTRICT] [int] NULL,
	[DESIGNATION] [int] NULL,
	[SCALE] [int] NULL,
	[REF_FILE_NO] [varchar](100) NULL,
	[C_ADDRESS] [varchar](200) NULL,
	[C_TEHSIL] [int] NULL,
	[C_DISTRICT] [int] NULL,
	[C_PROVINCE] [int] NULL,
	[P_ADDRESS] [varchar](200) NULL,
	[P_TEHSIL] [int] NULL,
	[P_DISTRICT] [int] NULL,
	[P_PROVINCE] [int] NULL,
	[LANDLINE] [varchar](20) NULL,
	[MOBILE] [varchar](20) NULL,
	[JOINING_DATE] [date] NULL,
	[CONTRACT_DURATION] [varchar](50) NULL,
	[CONTRACT_EXPIRY_DATE] [date] NULL,
	[STATUS] [int] NULL,
	[RENEWAL_DATE] [date] NULL,
	[PARENT_OFFICE] [int] NULL,
	[EMAIL] [varchar](254) NULL,
	[REPORT_DATE] [date] NULL,
	[EXT_UPTO_DATE] [date] NULL,
	[REMARKS] [varchar](200) NULL,
	[PAYROLL_ID] [varchar](100) NULL,
	[PICTURE] [varbinary](max) NULL,
	[IDATE] [date] NOT NULL,
	[EDUCATION] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[EMPLOYEE_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[CNIC] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_Employee_History]    Script Date: 01/09/2025 10:57:20 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Employee_History](
	[HISTORY_ID] [int] IDENTITY(1,1) NOT NULL,
	[EMPLOYEE_ID] [int] NULL,
	[CNIC] [bigint] NULL,
	[NAME] [varchar](100) NULL,
	[FATHER_NAME] [varchar](100) NULL,
	[GENDER] [int] NULL,
	[DOB] [date] NULL,
	[EDUCATION] [nvarchar](100) NULL,
	[MARITAL_STATUS] [int] NULL,
	[RELIGION] [int] NULL,
	[RELIGION_CAST] [int] NULL,
	[CHILDREN] [int] NULL,
	[DOMICILE_PROVINCE] [int] NULL,
	[DOMICILE_DISTRICT] [int] NULL,
	[DESIGNATION] [int] NULL,
	[SCALE] [int] NULL,
	[REF_FILE_NO] [varchar](100) NULL,
	[C_ADDRESS] [varchar](200) NULL,
	[C_TEHSIL] [int] NULL,
	[C_DISTRICT] [int] NULL,
	[C_PROVINCE] [int] NULL,
	[P_ADDRESS] [varchar](200) NULL,
	[P_TEHSIL] [int] NULL,
	[P_DISTRICT] [int] NULL,
	[P_PROVINCE] [int] NULL,
	[LANDLINE] [varchar](20) NULL,
	[MOBILE] [varchar](20) NULL,
	[JOINING_DATE] [date] NULL,
	[CONTRACT_DURATION] [varchar](50) NULL,
	[CONTRACT_EXPIRY_DATE] [date] NULL,
	[STATUS] [int] NULL,
	[RENEWAL_DATE] [date] NULL,
	[PARENT_OFFICE] [int] NULL,
	[EMAIL] [varchar](254) NULL,
	[REPORT_DATE] [date] NULL,
	[EXT_UPTO_DATE] [date] NULL,
	[REMARKS] [varchar](200) NULL,
	[PAYROLL_ID] [varchar](100) NULL,
	[PICTURE] [varbinary](max) NULL,
	[IDATE] [date] NULL,
	[USER_CNIC] [bigint] NULL,
	[ACTION] [varchar](20) NOT NULL,
	[HISTORY_DATE] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[HISTORY_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_Position]    Script Date: 01/09/2025 10:57:20 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Position](
	[POST_ID] [int] IDENTITY(1,1) NOT NULL,
	[POST_TITLE] [varchar](100) NULL,
	[POST_SCALE] [varchar](100) NULL,
	[POST_REGION] [varchar](100) NULL,
	[POST_OCCUPANCY] [varchar](100) NULL,
	[POST_STATUS] [varchar](100) NULL,
	[LOCATION_DEPARTMENT] [varchar](100) NULL,
	[DISTRICT_SUB_DEPARTMENT] [varchar](100) NULL,
	[TEHSIL_SECTION] [varchar](100) NULL,
	[REPORTING_TO_POST_ID] [int] NULL,
	[EMPLOYEE_ID] [int] NULL,
	[IDATE] [datetime] NOT NULL,
	[LAST_UPDATE_DATE] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[POST_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_Position_History]    Script Date: 01/09/2025 10:57:20 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Position_History](
	[HISTORY_ID] [int] IDENTITY(1,1) NOT NULL,
	[POST_ID] [int] NOT NULL,
	[POST_TITLE] [varchar](100) NULL,
	[POST_SCALE] [varchar](100) NULL,
	[POST_REGION] [varchar](100) NULL,
	[POST_OCCUPANCY] [varchar](100) NULL,
	[POST_STATUS] [varchar](100) NULL,
	[LOCATION_DEPARTMENT] [varchar](100) NULL,
	[DISTRICT_SUB_DEPARTMENT] [varchar](100) NULL,
	[TEHSIL_SECTION] [varchar](100) NULL,
	[REPORTING_TO_POST_ID] [int] NULL,
	[EMPLOYEE_ID] [int] NULL,
	[IDATE] [datetime] NULL,
	[LAST_UPDATE_DATE] [datetime] NULL,
	[USER_CNIC] [bigint] NULL,
	[HISTORY_DATE] [datetime] NOT NULL,
	[ACTION] [nvarchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[HISTORY_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[lib_designation] ADD  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[lib_parent_office] ADD  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[login] ADD  DEFAULT ((1)) FOR [status]
GO
ALTER TABLE [dbo].[login] ADD  DEFAULT (sysutcdatetime()) FOR [created_at]
GO
ALTER TABLE [dbo].[tbl_Employee] ADD  DEFAULT (CONVERT([date],getdate())) FOR [IDATE]
GO
ALTER TABLE [dbo].[tbl_Employee_History] ADD  DEFAULT (getdate()) FOR [HISTORY_DATE]
GO
ALTER TABLE [dbo].[tbl_Position] ADD  DEFAULT (getdate()) FOR [IDATE]
GO
ALTER TABLE [dbo].[tbl_Position_History] ADD  CONSTRAINT [DF_tbl_Position_History_HISTORY_DATE]  DEFAULT (getdate()) FOR [HISTORY_DATE]
GO
ALTER TABLE [dbo].[lib_district]  WITH CHECK ADD  CONSTRAINT [FK_district_province_code] FOREIGN KEY([ProvinceCode])
REFERENCES [dbo].[lib_province] ([ProvinceCode])
GO
ALTER TABLE [dbo].[lib_district] CHECK CONSTRAINT [FK_district_province_code]
GO
ALTER TABLE [dbo].[lib_religion_cast]  WITH CHECK ADD  CONSTRAINT [FK_cast_religion] FOREIGN KEY([ReligionID])
REFERENCES [dbo].[lib_religion] ([ReligionID])
GO
ALTER TABLE [dbo].[lib_religion_cast] CHECK CONSTRAINT [FK_cast_religion]
GO
ALTER TABLE [dbo].[lib_tehsil]  WITH CHECK ADD  CONSTRAINT [FK_tehsil_district_code] FOREIGN KEY([DistrictCode])
REFERENCES [dbo].[lib_district] ([DistrictCode])
GO
ALTER TABLE [dbo].[lib_tehsil] CHECK CONSTRAINT [FK_tehsil_district_code]
GO
ALTER TABLE [dbo].[tbl_Employee]  WITH CHECK ADD  CONSTRAINT [FK_emp_c_dist] FOREIGN KEY([C_DISTRICT])
REFERENCES [dbo].[lib_district] ([DistrictCode])
GO
ALTER TABLE [dbo].[tbl_Employee] CHECK CONSTRAINT [FK_emp_c_dist]
GO
ALTER TABLE [dbo].[tbl_Employee]  WITH CHECK ADD  CONSTRAINT [FK_emp_c_prov] FOREIGN KEY([C_PROVINCE])
REFERENCES [dbo].[lib_province] ([ProvinceCode])
GO
ALTER TABLE [dbo].[tbl_Employee] CHECK CONSTRAINT [FK_emp_c_prov]
GO
ALTER TABLE [dbo].[tbl_Employee]  WITH CHECK ADD  CONSTRAINT [FK_emp_c_teh] FOREIGN KEY([C_TEHSIL])
REFERENCES [dbo].[lib_tehsil] ([TehsilCode])
GO
ALTER TABLE [dbo].[tbl_Employee] CHECK CONSTRAINT [FK_emp_c_teh]
GO
ALTER TABLE [dbo].[tbl_Employee]  WITH CHECK ADD  CONSTRAINT [FK_emp_designation] FOREIGN KEY([DESIGNATION])
REFERENCES [dbo].[lib_designation] ([DesignationID])
GO
ALTER TABLE [dbo].[tbl_Employee] CHECK CONSTRAINT [FK_emp_designation]
GO
ALTER TABLE [dbo].[tbl_Employee]  WITH CHECK ADD  CONSTRAINT [FK_emp_dom_dist] FOREIGN KEY([DOMICILE_DISTRICT])
REFERENCES [dbo].[lib_district] ([DistrictCode])
GO
ALTER TABLE [dbo].[tbl_Employee] CHECK CONSTRAINT [FK_emp_dom_dist]
GO
ALTER TABLE [dbo].[tbl_Employee]  WITH CHECK ADD  CONSTRAINT [FK_emp_dom_prov] FOREIGN KEY([DOMICILE_PROVINCE])
REFERENCES [dbo].[lib_province] ([ProvinceCode])
GO
ALTER TABLE [dbo].[tbl_Employee] CHECK CONSTRAINT [FK_emp_dom_prov]
GO
ALTER TABLE [dbo].[tbl_Employee]  WITH CHECK ADD  CONSTRAINT [FK_emp_p_dist] FOREIGN KEY([P_DISTRICT])
REFERENCES [dbo].[lib_district] ([DistrictCode])
GO
ALTER TABLE [dbo].[tbl_Employee] CHECK CONSTRAINT [FK_emp_p_dist]
GO
ALTER TABLE [dbo].[tbl_Employee]  WITH CHECK ADD  CONSTRAINT [FK_emp_p_prov] FOREIGN KEY([P_PROVINCE])
REFERENCES [dbo].[lib_province] ([ProvinceCode])
GO
ALTER TABLE [dbo].[tbl_Employee] CHECK CONSTRAINT [FK_emp_p_prov]
GO
ALTER TABLE [dbo].[tbl_Employee]  WITH CHECK ADD  CONSTRAINT [FK_emp_p_teh] FOREIGN KEY([P_TEHSIL])
REFERENCES [dbo].[lib_tehsil] ([TehsilCode])
GO
ALTER TABLE [dbo].[tbl_Employee] CHECK CONSTRAINT [FK_emp_p_teh]
GO
ALTER TABLE [dbo].[tbl_Employee]  WITH CHECK ADD  CONSTRAINT [FK_emp_parent_office] FOREIGN KEY([PARENT_OFFICE])
REFERENCES [dbo].[lib_parent_office] ([ParentOfficeID])
GO
ALTER TABLE [dbo].[tbl_Employee] CHECK CONSTRAINT [FK_emp_parent_office]
GO
ALTER TABLE [dbo].[tbl_Employee]  WITH CHECK ADD  CONSTRAINT [FK_emp_religion] FOREIGN KEY([RELIGION])
REFERENCES [dbo].[lib_religion] ([ReligionID])
GO
ALTER TABLE [dbo].[tbl_Employee] CHECK CONSTRAINT [FK_emp_religion]
GO
ALTER TABLE [dbo].[tbl_Employee]  WITH CHECK ADD  CONSTRAINT [FK_emp_religion_cast] FOREIGN KEY([RELIGION_CAST])
REFERENCES [dbo].[lib_religion_cast] ([CastID])
GO
ALTER TABLE [dbo].[tbl_Employee] CHECK CONSTRAINT [FK_emp_religion_cast]
GO
ALTER TABLE [dbo].[tbl_Employee]  WITH CHECK ADD  CONSTRAINT [FK_emp_scale] FOREIGN KEY([SCALE])
REFERENCES [dbo].[lib_scale] ([ScaleID])
GO
ALTER TABLE [dbo].[tbl_Employee] CHECK CONSTRAINT [FK_emp_scale]
GO
ALTER TABLE [dbo].[tbl_Employee]  WITH CHECK ADD  CONSTRAINT [FK_emp_status] FOREIGN KEY([STATUS])
REFERENCES [dbo].[lib_status] ([StatusID])
GO
ALTER TABLE [dbo].[tbl_Employee] CHECK CONSTRAINT [FK_emp_status]
GO
ALTER TABLE [dbo].[tbl_Employee]  WITH CHECK ADD  CONSTRAINT [FK_tbl_employee_education] FOREIGN KEY([EDUCATION])
REFERENCES [dbo].[lib_education] ([EducationID])
GO
ALTER TABLE [dbo].[tbl_Employee] CHECK CONSTRAINT [FK_tbl_employee_education]
GO
ALTER TABLE [dbo].[tbl_Employee]  WITH CHECK ADD  CONSTRAINT [FK_tbl_employee_Gender] FOREIGN KEY([GENDER])
REFERENCES [dbo].[lib_gender] ([GenderID])
GO
ALTER TABLE [dbo].[tbl_Employee] CHECK CONSTRAINT [FK_tbl_employee_Gender]
GO
ALTER TABLE [dbo].[tbl_Employee]  WITH CHECK ADD  CONSTRAINT [FK_tbl_employee_MaritalStatus] FOREIGN KEY([MARITAL_STATUS])
REFERENCES [dbo].[lib_marital_status] ([marital_status_id])
GO
ALTER TABLE [dbo].[tbl_Employee] CHECK CONSTRAINT [FK_tbl_employee_MaritalStatus]
GO
ALTER TABLE [dbo].[tbl_Position]  WITH CHECK ADD  CONSTRAINT [FK_tbl_Position_tbl_Employee] FOREIGN KEY([EMPLOYEE_ID])
REFERENCES [dbo].[tbl_Employee] ([EMPLOYEE_ID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tbl_Position] CHECK CONSTRAINT [FK_tbl_Position_tbl_Employee]
GO
ALTER TABLE [dbo].[login]  WITH CHECK ADD  CONSTRAINT [CK_login_cnic_digits] CHECK  ((NOT [cnic] like '%[^0-9]%'))
GO
ALTER TABLE [dbo].[login] CHECK CONSTRAINT [CK_login_cnic_digits]
GO
USE [master]
GO
ALTER DATABASE [BISP_hrmsDashboard] SET  READ_WRITE 
GO

USE BISP_hrmsDashboard;
SELECT * FROM dbo.login;



--INSERT QUERIES--
USE [BISP_hrmsDashboard]
GO

-- ============================================
-- 1. lib_designation (30 records)
-- ============================================
SET IDENTITY_INSERT [dbo].[lib_designation] ON 
INSERT [dbo].[lib_designation] ([DesignationID], [DesignationName], [IsActive]) VALUES (1, N'Naib Qasid', 1)
INSERT [dbo].[lib_designation] ([DesignationID], [DesignationName], [IsActive]) VALUES (2, N'Chowkidar', 1)
INSERT [dbo].[lib_designation] ([DesignationID], [DesignationName], [IsActive]) VALUES (3, N'Driver', 1)
INSERT [dbo].[lib_designation] ([DesignationID], [DesignationName], [IsActive]) VALUES (4, N'Lift Operator', 1)
INSERT [dbo].[lib_designation] ([DesignationID], [DesignationName], [IsActive]) VALUES (5, N'Lab Attendant', 1)
INSERT [dbo].[lib_designation] ([DesignationID], [DesignationName], [IsActive]) VALUES (6, N'Junior Clerk (LDC)', 1)
INSERT [dbo].[lib_designation] ([DesignationID], [DesignationName], [IsActive]) VALUES (7, N'Senior Clerk (UDC)', 1)
INSERT [dbo].[lib_designation] ([DesignationID], [DesignationName], [IsActive]) VALUES (8, N'Assistant', 1)
INSERT [dbo].[lib_designation] ([DesignationID], [DesignationName], [IsActive]) VALUES (9, N'Stenotypist', 1)
INSERT [dbo].[lib_designation] ([DesignationID], [DesignationName], [IsActive]) VALUES (10, N'Data Entry Operator', 1)
INSERT [dbo].[lib_designation] ([DesignationID], [DesignationName], [IsActive]) VALUES (11, N'Accountant', 1)
INSERT [dbo].[lib_designation] ([DesignationID], [DesignationName], [IsActive]) VALUES (12, N'Assistant Accounts Officer', 1)
INSERT [dbo].[lib_designation] ([DesignationID], [DesignationName], [IsActive]) VALUES (13, N'Superintendent', 1)
INSERT [dbo].[lib_designation] ([DesignationID], [DesignationName], [IsActive]) VALUES (14, N'Section Officer', 1)
INSERT [dbo].[lib_designation] ([DesignationID], [DesignationName], [IsActive]) VALUES (15, N'Assistant Director', 1)
INSERT [dbo].[lib_designation] ([DesignationID], [DesignationName], [IsActive]) VALUES (16, N'Deputy Director', 1)
INSERT [dbo].[lib_designation] ([DesignationID], [DesignationName], [IsActive]) VALUES (17, N'Director', 1)
INSERT [dbo].[lib_designation] ([DesignationID], [DesignationName], [IsActive]) VALUES (18, N'Additional Director', 1)
INSERT [dbo].[lib_designation] ([DesignationID], [DesignationName], [IsActive]) VALUES (19, N'Joint Director', 1)
INSERT [dbo].[lib_designation] ([DesignationID], [DesignationName], [IsActive]) VALUES (20, N'Director General', 1)
INSERT [dbo].[lib_designation] ([DesignationID], [DesignationName], [IsActive]) VALUES (21, N'Programmer', 1)
INSERT [dbo].[lib_designation] ([DesignationID], [DesignationName], [IsActive]) VALUES (22, N'System Analyst', 1)
INSERT [dbo].[lib_designation] ([DesignationID], [DesignationName], [IsActive]) VALUES (23, N'Network Administrator', 1)
INSERT [dbo].[lib_designation] ([DesignationID], [DesignationName], [IsActive]) VALUES (24, N'Database Administrator', 1)
INSERT [dbo].[lib_designation] ([DesignationID], [DesignationName], [IsActive]) VALUES (25, N'IT Officer', 1)
INSERT [dbo].[lib_designation] ([DesignationID], [DesignationName], [IsActive]) VALUES (26, N'Research Officer', 1)
INSERT [dbo].[lib_designation] ([DesignationID], [DesignationName], [IsActive]) VALUES (27, N'Statistical Officer', 1)
INSERT [dbo].[lib_designation] ([DesignationID], [DesignationName], [IsActive]) VALUES (28, N'Medical Officer', 1)
INSERT [dbo].[lib_designation] ([DesignationID], [DesignationName], [IsActive]) VALUES (29, N'Staff Nurse', 1)
INSERT [dbo].[lib_designation] ([DesignationID], [DesignationName], [IsActive]) VALUES (30, N'Librarian', 1)
SET IDENTITY_INSERT [dbo].[lib_designation] OFF
GO

-- ============================================
-- 2. lib_district (21 records)
-- ============================================
INSERT [dbo].[lib_district] ([DistrictCode], [ProvinceCode], [DistrictName]) VALUES (375, 3, N'Faisalabad')
INSERT [dbo].[lib_district] ([DistrictCode], [ProvinceCode], [DistrictName]) VALUES (372, 3, N'Lahore')
INSERT [dbo].[lib_district] ([DistrictCode], [ProvinceCode], [DistrictName]) VALUES (374, 3, N'Rawalpindi')
INSERT [dbo].[lib_district] ([DistrictCode], [ProvinceCode], [DistrictName]) VALUES (402, 4, N'Hyderabad')
INSERT [dbo].[lib_district] ([DistrictCode], [ProvinceCode], [DistrictName]) VALUES (401, 4, N'Karachi')
INSERT [dbo].[lib_district] ([DistrictCode], [ProvinceCode], [DistrictName]) VALUES (403, 4, N'Sukkur')
INSERT [dbo].[lib_district] ([DistrictCode], [ProvinceCode], [DistrictName]) VALUES (503, 5, N'Abbottabad')
INSERT [dbo].[lib_district] ([DistrictCode], [ProvinceCode], [DistrictName]) VALUES (502, 5, N'Mardan')
INSERT [dbo].[lib_district] ([DistrictCode], [ProvinceCode], [DistrictName]) VALUES (501, 5, N'Peshawar')
INSERT [dbo].[lib_district] ([DistrictCode], [ProvinceCode], [DistrictName]) VALUES (602, 6, N'Gwadar')
INSERT [dbo].[lib_district] ([DistrictCode], [ProvinceCode], [DistrictName]) VALUES (603, 6, N'Khuzdar')
INSERT [dbo].[lib_district] ([DistrictCode], [ProvinceCode], [DistrictName]) VALUES (601, 6, N'Quetta')
INSERT [dbo].[lib_district] ([DistrictCode], [ProvinceCode], [DistrictName]) VALUES (701, 7, N'Islamabad')
INSERT [dbo].[lib_district] ([DistrictCode], [ProvinceCode], [DistrictName]) VALUES (702, 7, N'Islamabad Rural')
INSERT [dbo].[lib_district] ([DistrictCode], [ProvinceCode], [DistrictName]) VALUES (703, 7, N'Islamabad Urban')
INSERT [dbo].[lib_district] ([DistrictCode], [ProvinceCode], [DistrictName]) VALUES (803, 8, N'Diamer')
INSERT [dbo].[lib_district] ([DistrictCode], [ProvinceCode], [DistrictName]) VALUES (801, 8, N'Gilgit')
INSERT [dbo].[lib_district] ([DistrictCode], [ProvinceCode], [DistrictName]) VALUES (802, 8, N'Skardu')
INSERT [dbo].[lib_district] ([DistrictCode], [ProvinceCode], [DistrictName]) VALUES (903, 9, N'Kotli')
INSERT [dbo].[lib_district] ([DistrictCode], [ProvinceCode], [DistrictName]) VALUES (902, 9, N'Mirpur')
INSERT [dbo].[lib_district] ([DistrictCode], [ProvinceCode], [DistrictName]) VALUES (901, 9, N'Muzaffarabad')
GO

-- ============================================
-- 3. lib_education (8 records)
-- ============================================
SET IDENTITY_INSERT [dbo].[lib_education] ON 
INSERT [dbo].[lib_education] ([EducationID], [EducationName]) VALUES (1, N'Primary')
INSERT [dbo].[lib_education] ([EducationID], [EducationName]) VALUES (2, N'Middle')
INSERT [dbo].[lib_education] ([EducationID], [EducationName]) VALUES (3, N'Matric')
INSERT [dbo].[lib_education] ([EducationID], [EducationName]) VALUES (4, N'Intermediate')
INSERT [dbo].[lib_education] ([EducationID], [EducationName]) VALUES (5, N'Bachelor')
INSERT [dbo].[lib_education] ([EducationID], [EducationName]) VALUES (6, N'Master')
INSERT [dbo].[lib_education] ([EducationID], [EducationName]) VALUES (7, N'MPhil')
INSERT [dbo].[lib_education] ([EducationID], [EducationName]) VALUES (8, N'PhD')
SET IDENTITY_INSERT [dbo].[lib_education] OFF
GO

-- ============================================
-- 4. lib_gender (3 records)
-- ============================================
SET IDENTITY_INSERT [dbo].[lib_gender] ON 
INSERT [dbo].[lib_gender] ([GenderID], [GenderName]) VALUES (1, N'Male')
INSERT [dbo].[lib_gender] ([GenderID], [GenderName]) VALUES (2, N'Female')
INSERT [dbo].[lib_gender] ([GenderID], [GenderName]) VALUES (3, N'Transgender')
SET IDENTITY_INSERT [dbo].[lib_gender] OFF
GO

-- ============================================
-- 5. lib_marital_status (4 records)
-- ============================================
SET IDENTITY_INSERT [dbo].[lib_marital_status] ON 
INSERT [dbo].[lib_marital_status] ([marital_status_id], [status_name]) VALUES (1, N'Unmarried')
INSERT [dbo].[lib_marital_status] ([marital_status_id], [status_name]) VALUES (2, N'Married')
INSERT [dbo].[lib_marital_status] ([marital_status_id], [status_name]) VALUES (3, N'Divorced')
INSERT [dbo].[lib_marital_status] ([marital_status_id], [status_name]) VALUES (4, N'Widowed')
SET IDENTITY_INSERT [dbo].[lib_marital_status] OFF
GO

-- ============================================
-- 6. lib_parent_office (1 record)
-- ============================================
SET IDENTITY_INSERT [dbo].[lib_parent_office] ON 
INSERT [dbo].[lib_parent_office] ([ParentOfficeID], [OfficeName], [IsActive]) VALUES (1, N'Head Office', 1)
SET IDENTITY_INSERT [dbo].[lib_parent_office] OFF
GO

-- ============================================
-- 7. lib_province (7 records)
-- ============================================
INSERT [dbo].[lib_province] ([ProvinceCode], [ProvinceName]) VALUES (9, N'Azad Jammu & Kashmir')
INSERT [dbo].[lib_province] ([ProvinceCode], [ProvinceName]) VALUES (6, N'Balochistan')
INSERT [dbo].[lib_province] ([ProvinceCode], [ProvinceName]) VALUES (8, N'Gilgit Baltistan')
INSERT [dbo].[lib_province] ([ProvinceCode], [ProvinceName]) VALUES (7, N'Islamabad')
INSERT [dbo].[lib_province] ([ProvinceCode], [ProvinceName]) VALUES (5, N'Khyber Pakhtunkhwa')
INSERT [dbo].[lib_province] ([ProvinceCode], [ProvinceName]) VALUES (3, N'Punjab')
INSERT [dbo].[lib_province] ([ProvinceCode], [ProvinceName]) VALUES (4, N'Sindh')
GO

-- ============================================
-- 8. lib_religion (4 records)
-- ============================================
SET IDENTITY_INSERT [dbo].[lib_religion] ON 
INSERT [dbo].[lib_religion] ([ReligionID], [ReligionName]) VALUES (3, N'Christianity')
INSERT [dbo].[lib_religion] ([ReligionID], [ReligionName]) VALUES (2, N'Hinduism')
INSERT [dbo].[lib_religion] ([ReligionID], [ReligionName]) VALUES (1, N'Islam')
INSERT [dbo].[lib_religion] ([ReligionID], [ReligionName]) VALUES (4, N'Sikhism')
SET IDENTITY_INSERT [dbo].[lib_religion] OFF
GO

-- ============================================
-- 9. lib_religion_cast (20 records)
-- ============================================
SET IDENTITY_INSERT [dbo].[lib_religion_cast] ON 
INSERT [dbo].[lib_religion_cast] ([CastID], [ReligionID], [CastName]) VALUES (4, 1, N'Berelvi')
INSERT [dbo].[lib_religion_cast] ([CastID], [ReligionID], [CastName]) VALUES (5, 1, N'Deobandi')
INSERT [dbo].[lib_religion_cast] ([CastID], [ReligionID], [CastName]) VALUES (2, 1, N'Shia')
INSERT [dbo].[lib_religion_cast] ([CastID], [ReligionID], [CastName]) VALUES (1, 1, N'Sunni')
INSERT [dbo].[lib_religion_cast] ([CastID], [ReligionID], [CastName]) VALUES (3, 1, N'Whabbi')
INSERT [dbo].[lib_religion_cast] ([CastID], [ReligionID], [CastName]) VALUES (6, 2, N'Brahmin')
INSERT [dbo].[lib_religion_cast] ([CastID], [ReligionID], [CastName]) VALUES (10, 2, N'Jatis')
INSERT [dbo].[lib_religion_cast] ([CastID], [ReligionID], [CastName]) VALUES (7, 2, N'Kshatriya')
INSERT [dbo].[lib_religion_cast] ([CastID], [ReligionID], [CastName]) VALUES (9, 2, N'Shudra')
INSERT [dbo].[lib_religion_cast] ([CastID], [ReligionID], [CastName]) VALUES (8, 2, N'Vaishya')
INSERT [dbo].[lib_religion_cast] ([CastID], [ReligionID], [CastName]) VALUES (15, 3, N'Anglican')
INSERT [dbo].[lib_religion_cast] ([CastID], [ReligionID], [CastName]) VALUES (11, 3, N'Catholic')
INSERT [dbo].[lib_religion_cast] ([CastID], [ReligionID], [CastName]) VALUES (14, 3, N'Oriental Orthodox')
INSERT [dbo].[lib_religion_cast] ([CastID], [ReligionID], [CastName]) VALUES (13, 3, N'Orthodox')
INSERT [dbo].[lib_religion_cast] ([CastID], [ReligionID], [CastName]) VALUES (12, 3, N'Protestant')
INSERT [dbo].[lib_religion_cast] ([CastID], [ReligionID], [CastName]) VALUES (18, 4, N'Arora')
INSERT [dbo].[lib_religion_cast] ([CastID], [ReligionID], [CastName]) VALUES (16, 4, N'Jat')
INSERT [dbo].[lib_religion_cast] ([CastID], [ReligionID], [CastName]) VALUES (17, 4, N'Khatri')
INSERT [dbo].[lib_religion_cast] ([CastID], [ReligionID], [CastName]) VALUES (20, 4, N'Mazhabi')
INSERT [dbo].[lib_religion_cast] ([CastID], [ReligionID], [CastName]) VALUES (19, 4, N'Ramgarhia')
SET IDENTITY_INSERT [dbo].[lib_religion_cast] OFF
GO

-- ============================================
-- 10. lib_scale (22 records)
-- ============================================
INSERT [dbo].[lib_scale] ([ScaleID], [ScaleCode]) VALUES (1, N'SPS-1')
INSERT [dbo].[lib_scale] ([ScaleID], [ScaleCode]) VALUES (2, N'SPS-2')
INSERT [dbo].[lib_scale] ([ScaleID], [ScaleCode]) VALUES (3, N'SPS-3')
INSERT [dbo].[lib_scale] ([ScaleID], [ScaleCode]) VALUES (4, N'SPS-4')
INSERT [dbo].[lib_scale] ([ScaleID], [ScaleCode]) VALUES (5, N'SPS-5')
INSERT [dbo].[lib_scale] ([ScaleID], [ScaleCode]) VALUES (6, N'SPS-6')
INSERT [dbo].[lib_scale] ([ScaleID], [ScaleCode]) VALUES (7, N'SPS-7')
INSERT [dbo].[lib_scale] ([ScaleID], [ScaleCode]) VALUES (8, N'SPS-8')
INSERT [dbo].[lib_scale] ([ScaleID], [ScaleCode]) VALUES (9, N'SPS-9')
INSERT [dbo].[lib_scale] ([ScaleID], [ScaleCode]) VALUES (10, N'SPS-10')
INSERT [dbo].[lib_scale] ([ScaleID], [ScaleCode]) VALUES (11, N'SPS-11')
INSERT [dbo].[lib_scale] ([ScaleID], [ScaleCode]) VALUES (12, N'SPS-12')
INSERT [dbo].[lib_scale] ([ScaleID], [ScaleCode]) VALUES (13, N'SPS-13')
INSERT [dbo].[lib_scale] ([ScaleID], [ScaleCode]) VALUES (14, N'SPS-14')
INSERT [dbo].[lib_scale] ([ScaleID], [ScaleCode]) VALUES (15, N'SPS-15')
INSERT [dbo].[lib_scale] ([ScaleID], [ScaleCode]) VALUES (16, N'SPS-16')
INSERT [dbo].[lib_scale] ([ScaleID], [ScaleCode]) VALUES (17, N'SPS-17')
INSERT [dbo].[lib_scale] ([ScaleID], [ScaleCode]) VALUES (18, N'SPS-18')
INSERT [dbo].[lib_scale] ([ScaleID], [ScaleCode]) VALUES (19, N'SPS-19')
INSERT [dbo].[lib_scale] ([ScaleID], [ScaleCode]) VALUES (20, N'SPS-20')
INSERT [dbo].[lib_scale] ([ScaleID], [ScaleCode]) VALUES (21, N'SPS-21')
INSERT [dbo].[lib_scale] ([ScaleID], [ScaleCode]) VALUES (22, N'SPS-22')
GO

-- ============================================
-- 11. lib_status (2 records)
-- ============================================
SET IDENTITY_INSERT [dbo].[lib_status] ON 
INSERT [dbo].[lib_status] ([StatusID], [StatusName]) VALUES (1, N'Active')
INSERT [dbo].[lib_status] ([StatusID], [StatusName]) VALUES (2, N'Inactive')
SET IDENTITY_INSERT [dbo].[lib_status] OFF
GO

-- ============================================
-- 12. lib_tehsil (77 records)
-- ============================================
INSERT [dbo].[lib_tehsil] ([TehsilCode], [DistrictCode], [TehsilName]) VALUES (3721, 372, N'Lahore City')
INSERT [dbo].[lib_tehsil] ([TehsilCode], [DistrictCode], [TehsilName]) VALUES (3722, 372, N'Model Town')
INSERT [dbo].[lib_tehsil] ([TehsilCode], [DistrictCode], [TehsilName]) VALUES (3723, 372, N'Shashemeen')
INSERT [dbo].[lib_tehsil] ([TehsilCode], [DistrictCode], [TehsilName]) VALUES (3741, 374, N'Rawalpindi City')
INSERT [dbo].[lib_tehsil] ([TehsilCode], [DistrictCode], [TehsilName]) VALUES (3742, 374, N'Taxila')
INSERT [dbo].[lib_tehsil] ([TehsilCode], [DistrictCode], [TehsilName]) VALUES (3743, 374, N'Gujar Khan')
INSERT [dbo].[lib_tehsil] ([TehsilCode], [DistrictCode], [TehsilName]) VALUES (3751, 375, N'Faisalabad City')
INSERT [dbo].[lib_tehsil] ([TehsilCode], [DistrictCode], [TehsilName]) VALUES (3752, 375, N'Jaranwala')
INSERT [dbo].[lib_tehsil] ([TehsilCode], [DistrictCode], [TehsilName]) VALUES (3753, 375, N'Chak Jhumra')
INSERT [dbo].[lib_tehsil] ([TehsilCode], [DistrictCode], [TehsilName]) VALUES (4011, 401, N'Korangi')
INSERT [dbo].[lib_tehsil] ([TehsilCode], [DistrictCode], [TehsilName]) VALUES (4012, 401, N'Gulshan-e-Iqbal')
INSERT [dbo].[lib_tehsil] ([TehsilCode], [DistrictCode], [TehsilName]) VALUES (4013, 401, N'Lyari')
INSERT [dbo].[lib_tehsil] ([TehsilCode], [DistrictCode], [TehsilName]) VALUES (4021, 402, N'Qasimabad')
INSERT [dbo].[lib_tehsil] ([TehsilCode], [DistrictCode], [TehsilName]) VALUES (4022, 402, N'Latifabad')
INSERT [dbo].[lib_tehsil] ([TehsilCode], [DistrictCode], [TehsilName]) VALUES (4023, 402, N'Hyderabad City')
INSERT [dbo].[lib_tehsil] ([TehsilCode], [DistrictCode], [TehsilName]) VALUES (4031, 403, N'Sukkur City')
INSERT [dbo].[lib_tehsil] ([TehsilCode], [DistrictCode], [TehsilName]) VALUES (4032, 403, N'Pano Aqil')
INSERT [dbo].[lib_tehsil] ([TehsilCode], [DistrictCode], [TehsilName]) VALUES (4033, 403, N'Rohri')
INSERT [dbo].[lib_tehsil] ([TehsilCode], [DistrictCode], [TehsilName]) VALUES (5011, 501, N'Peshawar City')
INSERT [dbo].[lib_tehsil] ([TehsilCode], [DistrictCode], [TehsilName]) VALUES (5012, 501, N'Badaber')
INSERT [dbo].[lib_tehsil] ([TehsilCode], [DistrictCode], [TehsilName]) VALUES (5013, 501, N'Mathi')
INSERT [dbo].[lib_tehsil] ([TehsilCode], [DistrictCode], [TehsilName]) VALUES (5021, 502, N'Mardan City')
INSERT [dbo].[lib_tehsil] ([TehsilCode], [DistrictCode], [TehsilName]) VALUES (5022, 502, N'Takht Bhai')
INSERT [dbo].[lib_tehsil] ([TehsilCode], [DistrictCode], [TehsilName]) VALUES (5023, 502, N'Katlang')
INSERT [dbo].[lib_tehsil] ([TehsilCode], [DistrictCode], [TehsilName]) VALUES (5031, 503, N'Abbottabad City')
INSERT [dbo].[lib_tehsil] ([TehsilCode], [DistrictCode], [TehsilName]) VALUES (5032, 503, N'Havelian')
INSERT [dbo].[lib_tehsil] ([TehsilCode], [DistrictCode], [TehsilName]) VALUES (5033, 503, N'Lora')
INSERT [dbo].[lib_tehsil] ([TehsilCode], [DistrictCode], [TehsilName]) VALUES (6011, 601, N'Quetta City')
INSERT [dbo].[lib_tehsil] ([TehsilCode], [DistrictCode], [TehsilName]) VALUES (6012, 601, N'Chiltan')
INSERT [dbo].[lib_tehsil] ([TehsilCode], [DistrictCode], [TehsilName]) VALUES (6013, 601, N'Zarghoon')
INSERT [dbo].[lib_tehsil] ([TehsilCode], [DistrictCode], [TehsilName]) VALUES (6021, 602, N'Gwadar City')
INSERT [dbo].[lib_tehsil] ([TehsilCode], [DistrictCode], [TehsilName]) VALUES (6022, 602, N'Jiwani')
INSERT [dbo].[lib_tehsil] ([TehsilCode], [DistrictCode], [TehsilName]) VALUES (6023, 602, N'Ormara')
INSERT [dbo].[lib_tehsil] ([TehsilCode], [DistrictCode], [TehsilName]) VALUES (6031, 603, N'Khuzdar City')
INSERT [dbo].[lib_tehsil] ([TehsilCode], [DistrictCode], [TehsilName]) VALUES (6032, 603, N'Wadh')
INSERT [dbo].[lib_tehsil] ([TehsilCode], [DistrictCode], [TehsilName]) VALUES (6033, 603, N'Naal')
INSERT [dbo].[lib_tehsil] ([TehsilCode], [DistrictCode], [TehsilName]) VALUES (7011, 701, N'Urban-I')
INSERT [dbo].[lib_tehsil] ([TehsilCode], [DistrictCode], [TehsilName]) VALUES (7012, 701, N'Urban-II')
INSERT [dbo].[lib_tehsil] ([TehsilCode], [DistrictCode], [TehsilName]) VALUES (7013, 701, N'Rural')
INSERT [dbo].[lib_tehsil] ([TehsilCode], [DistrictCode], [TehsilName]) VALUES (7021, 702, N'Bhara Kahu')
INSERT [dbo].[lib_tehsil] ([TehsilCode], [DistrictCode], [TehsilName]) VALUES (7022, 702, N'Tarlai')
INSERT [dbo].[lib_tehsil] ([TehsilCode], [DistrictCode], [TehsilName]) VALUES (7023, 702, N'Koral')
INSERT [dbo].[lib_tehsil] ([TehsilCode], [DistrictCode], [TehsilName]) VALUES (7031, 703, N'F-Subsector')
INSERT [dbo].[lib_tehsil] ([TehsilCode], [DistrictCode], [TehsilName]) VALUES (7032, 703, N'G-Subsector')
INSERT [dbo].[lib_tehsil] ([TehsilCode], [DistrictCode], [TehsilName]) VALUES (7033, 703, N'I-Subsector')
INSERT [dbo].[lib_tehsil] ([TehsilCode], [DistrictCode], [TehsilName]) VALUES (8011, 801, N'Gilgit City')
INSERT [dbo].[lib_tehsil] ([TehsilCode], [DistrictCode], [TehsilName]) VALUES (8012, 801, N'Danyore')
INSERT [dbo].[lib_tehsil] ([TehsilCode], [DistrictCode], [TehsilName]) VALUES (8013, 801, N'Juglot')
INSERT [dbo].[lib_tehsil] ([TehsilCode], [DistrictCode], [TehsilName]) VALUES (8021, 802, N'Skardu City')
INSERT [dbo].[lib_tehsil] ([TehsilCode], [DistrictCode], [TehsilName]) VALUES (8022, 802, N'Shadosh')
INSERT [dbo].[lib_tehsil] ([TehsilCode], [DistrictCode], [TehsilName]) VALUES (8023, 802, N'Kachura')
INSERT [dbo].[lib_tehsil] ([TehsilCode], [DistrictCode], [TehsilName]) VALUES (8031, 803, N'Chilas')
INSERT [dbo].[lib_tehsil] ([TehsilCode], [DistrictCode], [TehsilName]) VALUES (8032, 803, N'Darel')
INSERT [dbo].[lib_tehsil] ([TehsilCode], [DistrictCode], [TehsilName]) VALUES (8033, 803, N'Tangir')
INSERT [dbo].[lib_tehsil] ([TehsilCode], [DistrictCode], [TehsilName]) VALUES (9011, 901, N'Muzaffarabad City')
INSERT [dbo].[lib_tehsil] ([TehsilCode], [DistrictCode], [TehsilName]) VALUES (9012, 901, N'Hattian')
INSERT [dbo].[lib_tehsil] ([TehsilCode], [DistrictCode], [TehsilName]) VALUES (9013, 901, N'Patikka')
INSERT [dbo].[lib_tehsil] ([TehsilCode], [DistrictCode], [TehsilName]) VALUES (9021, 902, N'Mirpur City')
INSERT [dbo].[lib_tehsil] ([TehsilCode], [DistrictCode], [TehsilName]) VALUES (9022, 902, N'Dadyal')
INSERT [dbo].[lib_tehsil] ([TehsilCode], [DistrictCode], [TehsilName]) VALUES (9023, 902, N'Chakswari')
INSERT [dbo].[lib_tehsil] ([TehsilCode], [DistrictCode], [TehsilName]) VALUES (9031, 903, N'Kotli City')
INSERT [dbo].[lib_tehsil] ([TehsilCode], [DistrictCode], [TehsilName]) VALUES (9032, 903, N'Khuiratta')
INSERT [dbo].[lib_tehsil] ([TehsilCode], [DistrictCode], [TehsilName]) VALUES (9033, 903, N'Sehensa')
GO

-- ============================================
-- 13. login (2 records)
-- ============================================
SET IDENTITY_INSERT [dbo].[login] ON 
INSERT [dbo].[login] ([id], [cnic], [username], [password], [allowed_ip], [status], [created_at]) VALUES (1, N'3740527924759', N'Shahzaib', N's26', N'0.0.0.1', 1, CAST(N'2025-08-11T09:28:22.7232483' AS DateTime2))
INSERT [dbo].[login] ([id], [cnic], [username], [password], [allowed_ip], [status], [created_at]) VALUES (2, N'1234567891011', N'Ahsan', N'a10', N'0.0.0.1', 1, CAST(N'2025-08-26T05:21:35.4356303' AS DateTime2))
SET IDENTITY_INSERT [dbo].[login] OFF
GO

-- ============================================
-- 14. tbl_Employee (55+ records)
-- ============================================
SET IDENTITY_INSERT [dbo].[tbl_Employee] ON 
INSERT [dbo].[tbl_Employee] ([EMPLOYEE_ID], [CNIC], [NAME], [FATHER_NAME], [GENDER], [DOB], [MARITAL_STATUS], [RELIGION], [RELIGION_CAST], [CHILDREN], [DOMICILE_PROVINCE], [DOMICILE_DISTRICT], [DESIGNATION], [SCALE], [REF_FILE_NO], [C_ADDRESS], [C_TEHSIL], [C_DISTRICT], [C_PROVINCE], [P_ADDRESS], [P_TEHSIL], [P_DISTRICT], [P_PROVINCE], [LANDLINE], [MOBILE], [JOINING_DATE], [CONTRACT_DURATION], [CONTRACT_EXPIRY_DATE], [STATUS], [RENEWAL_DATE], [PARENT_OFFICE], [EMAIL], [REPORT_DATE], [EXT_UPTO_DATE], [REMARKS], [PAYROLL_ID], [PICTURE], [IDATE], [EDUCATION]) VALUES (1, 1234567891011, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2025-08-11' AS Date), NULL)
INSERT [dbo].[tbl_Employee] ([EMPLOYEE_ID], [CNIC], [NAME], [FATHER_NAME], [GENDER], [DOB], [MARITAL_STATUS], [RELIGION], [RELIGION_CAST], [CHILDREN], [DOMICILE_PROVINCE], [DOMICILE_DISTRICT], [DESIGNATION], [SCALE], [REF_FILE_NO], [C_ADDRESS], [C_TEHSIL], [C_DISTRICT], [C_PROVINCE], [P_ADDRESS], [P_TEHSIL], [P_DISTRICT], [P_PROVINCE], [LANDLINE], [MOBILE], [JOINING_DATE], [CONTRACT_DURATION], [CONTRACT_EXPIRY_DATE], [STATUS], [RENEWAL_DATE], [PARENT_OFFICE], [EMAIL], [REPORT_DATE], [EXT_UPTO_DATE], [REMARKS], [PAYROLL_ID], [PICTURE], [IDATE], [EDUCATION]) VALUES (2, 1110987654321, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2025-08-11' AS Date), NULL)
INSERT [dbo].[tbl_Employee] ([EMPLOYEE_ID], [CNIC], [NAME], [FATHER_NAME], [GENDER], [DOB], [MARITAL_STATUS], [RELIGION], [RELIGION_CAST], [CHILDREN], [DOMICILE_PROVINCE], [DOMICILE_DISTRICT], [DESIGNATION], [SCALE], [REF_FILE_NO], [C_ADDRESS], [C_TEHSIL], [C_DISTRICT], [C_PROVINCE], [P_ADDRESS], [P_TEHSIL], [P_DISTRICT], [P_PROVINCE], [LANDLINE], [MOBILE], [JOINING_DATE], [CONTRACT_DURATION], [CONTRACT_EXPIRY_DATE], [STATUS], [RENEWAL_DATE], [PARENT_OFFICE], [EMAIL], [REPORT_DATE], [EXT_UPTO_DATE], [REMARKS], [PAYROLL_ID], [PICTURE], [IDATE], [EDUCATION]) VALUES (3, 3740527924750, N'Shahzaib', N'Munir Ahmed', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2025-08-11' AS Date), NULL)
INSERT [dbo].[tbl_Employee] ([EMPLOYEE_ID], [CNIC], [NAME], [FATHER_NAME], [GENDER], [DOB], [MARITAL_STATUS], [RELIGION], [RELIGION_CAST], [CHILDREN], [DOMICILE_PROVINCE], [DOMICILE_DISTRICT], [DESIGNATION], [SCALE], [REF_FILE_NO], [C_ADDRESS], [C_TEHSIL], [C_DISTRICT], [C_PROVINCE], [P_ADDRESS], [P_TEHSIL], [P_DISTRICT], [P_PROVINCE], [LANDLINE], [MOBILE], [JOINING_DATE], [CONTRACT_DURATION], [CONTRACT_EXPIRY_DATE], [STATUS], [RENEWAL_DATE], [PARENT_OFFICE], [EMAIL], [REPORT_DATE], [EXT_UPTO_DATE], [REMARKS], [PAYROLL_ID], [PICTURE], [IDATE], [EDUCATION]) VALUES (4, 1357924681011, N'Hashir Ahmed', N'Paracha', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2025-08-11' AS Date), NULL)
INSERT [dbo].[tbl_Employee] ([EMPLOYEE_ID], [CNIC], [NAME], [FATHER_NAME], [GENDER], [DOB], [MARITAL_STATUS], [RELIGION], [RELIGION_CAST], [CHILDREN], [DOMICILE_PROVINCE], [DOMICILE_DISTRICT], [DESIGNATION], [SCALE], [REF_FILE_NO], [C_ADDRESS], [C_TEHSIL], [C_DISTRICT], [C_PROVINCE], [P_ADDRESS], [P_TEHSIL], [P_DISTRICT], [P_PROVINCE], [LANDLINE], [MOBILE], [JOINING_DATE], [CONTRACT_DURATION], [CONTRACT_EXPIRY_DATE], [STATUS], [RENEWAL_DATE], [PARENT_OFFICE], [EMAIL], [REPORT_DATE], [EXT_UPTO_DATE], [REMARKS], [PAYROLL_ID], [PICTURE], [IDATE], [EDUCATION]) VALUES (5, 7676980913012, N'Touheed', N'Shah Bukhari', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2025-08-11' AS Date), NULL)
INSERT [dbo].[tbl_Employee] ([EMPLOYEE_ID], [CNIC], [NAME], [FATHER_NAME], [GENDER], [DOB], [MARITAL_STATUS], [RELIGION], [RELIGION_CAST], [CHILDREN], [DOMICILE_PROVINCE], [DOMICILE_DISTRICT], [DESIGNATION], [SCALE], [REF_FILE_NO], [C_ADDRESS], [C_TEHSIL], [C_DISTRICT], [C_PROVINCE], [P_ADDRESS], [P_TEHSIL], [P_DISTRICT], [P_PROVINCE], [LANDLINE], [MOBILE], [JOINING_DATE], [CONTRACT_DURATION], [CONTRACT_EXPIRY_DATE], [STATUS], [RENEWAL_DATE], [PARENT_OFFICE], [EMAIL], [REPORT_DATE], [EXT_UPTO_DATE], [REMARKS], [PAYROLL_ID], [PICTURE], [IDATE], [EDUCATION]) VALUES (6, 7899099090121, N'hassan', N'ali sadiq', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2025-08-11' AS Date), NULL)
INSERT [dbo].[tbl_Employee] ([EMPLOYEE_ID], [CNIC], [NAME], [FATHER_NAME], [GENDER], [DOB], [MARITAL_STATUS], [RELIGION], [RELIGION_CAST], [CHILDREN], [DOMICILE_PROVINCE], [DOMICILE_DISTRICT], [DESIGNATION], [SCALE], [REF_FILE_NO], [C_ADDRESS], [C_TEHSIL], [C_DISTRICT], [C_PROVINCE], [P_ADDRESS], [P_TEHSIL], [P_DISTRICT], [P_PROVINCE], [LANDLINE], [MOBILE], [JOINING_DATE], [CONTRACT_DURATION], [CONTRACT_EXPIRY_DATE], [STATUS], [RENEWAL_DATE], [PARENT_OFFICE], [EMAIL], [REPORT_DATE], [EXT_UPTO_DATE], [REMARKS], [PAYROLL_ID], [PICTURE], [IDATE], [EDUCATION]) VALUES (7, 9999912313131, N'afnan', N'tariq', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2025-08-11' AS Date), NULL)
INSERT [dbo].[tbl_Employee] ([EMPLOYEE_ID], [CNIC], [NAME], [FATHER_NAME], [GENDER], [DOB], [MARITAL_STATUS], [RELIGION], [RELIGION_CAST], [CHILDREN], [DOMICILE_PROVINCE], [DOMICILE_DISTRICT], [DESIGNATION], [SCALE], [REF_FILE_NO], [C_ADDRESS], [C_TEHSIL], [C_DISTRICT], [C_PROVINCE], [P_ADDRESS], [P_TEHSIL], [P_DISTRICT], [P_PROVINCE], [LANDLINE], [MOBILE], [JOINING_DATE], [CONTRACT_DURATION], [CONTRACT_EXPIRY_DATE], [STATUS], [RENEWAL_DATE], [PARENT_OFFICE], [EMAIL], [REPORT_DATE], [EXT_UPTO_DATE], [REMARKS], [PAYROLL_ID], [PICTURE], [IDATE], [EDUCATION]) VALUES (8, 7765566625162, N'ali', N'hassan', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2025-08-11' AS Date), NULL)
INSERT [dbo].[tbl_Employee] ([EMPLOYEE_ID], [CNIC], [NAME], [FATHER_NAME], [GENDER], [DOB], [MARITAL_STATUS], [RELIGION], [RELIGION_CAST], [CHILDREN], [DOMICILE_PROVINCE], [DOMICILE_DISTRICT], [DESIGNATION], [SCALE], [REF_FILE_NO], [C_ADDRESS], [C_TEHSIL], [C_DISTRICT], [C_PROVINCE], [P_ADDRESS], [P_TEHSIL], [P_DISTRICT], [P_PROVINCE], [LANDLINE], [MOBILE], [JOINING_DATE], [CONTRACT_DURATION], [CONTRACT_EXPIRY_DATE], [STATUS], [RENEWAL_DATE], [PARENT_OFFICE], [EMAIL], [REPORT_DATE], [EXT_UPTO_DATE], [REMARKS], [PAYROLL_ID], [PICTURE], [IDATE], [EDUCATION]) VALUES (9, 2222221391312, N'hassan', N'raza', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2025-08-11' AS Date), NULL)
INSERT [dbo].[tbl_Employee] ([EMPLOYEE_ID], [CNIC], [NAME], [FATHER_NAME], [GENDER], [DOB], [MARITAL_STATUS], [RELIGION], [RELIGION_CAST], [CHILDREN], [DOMICILE_PROVINCE], [DOMICILE_DISTRICT], [DESIGNATION], [SCALE], [REF_FILE_NO], [C_ADDRESS], [C_TEHSIL], [C_DISTRICT], [C_PROVINCE], [P_ADDRESS], [P_TEHSIL], [P_DISTRICT], [P_PROVINCE], [LANDLINE], [MOBILE], [JOINING_DATE], [CONTRACT_DURATION], [CONTRACT_EXPIRY_DATE], [STATUS], [RENEWAL_DATE], [PARENT_OFFICE], [EMAIL], [REPORT_DATE], [EXT_UPTO_DATE], [REMARKS], [PAYROLL_ID], [PICTURE], [IDATE], [EDUCATION]) VALUES (10, 6666666666666, N'RAZA', N'HAMEED', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2025-08-11' AS Date), NULL)
INSERT [dbo].[tbl_Employee] ([EMPLOYEE_ID], [CNIC], [NAME], [FATHER_NAME], [GENDER], [DOB], [MARITAL_STATUS], [RELIGION], [RELIGION_CAST], [CHILDREN], [DOMICILE_PROVINCE], [DOMICILE_DISTRICT], [DESIGNATION], [SCALE], [REF_FILE_NO], [C_ADDRESS], [C_TEHSIL], [C_DISTRICT], [C_PROVINCE], [P_ADDRESS], [P_TEHSIL], [P_DISTRICT], [P_PROVINCE], [LANDLINE], [MOBILE], [JOINING_DATE], [CONTRACT_DURATION], [CONTRACT_EXPIRY_DATE], [STATUS], [RENEWAL_DATE], [PARENT_OFFICE], [EMAIL], [REPORT_DATE], [EXT_UPTO_DATE], [REMARKS], [PAYROLL_ID], [PICTURE], [IDATE], [EDUCATION]) VALUES (11, 3142524242121, N'Ahmed Jahangir', N'Ahmed Jahangir', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2025-08-11' AS Date), NULL)
INSERT [dbo].[tbl_Employee] ([EMPLOYEE_ID], [CNIC], [NAME], [FATHER_NAME], [GENDER], [DOB], [MARITAL_STATUS], [RELIGION], [RELIGION_CAST], [CHILDREN], [DOMICILE_PROVINCE], [DOMICILE_DISTRICT], [DESIGNATION], [SCALE], [REF_FILE_NO], [C_ADDRESS], [C_TEHSIL], [C_DISTRICT], [C_PROVINCE], [P_ADDRESS], [P_TEHSIL], [P_DISTRICT], [P_PROVINCE], [LANDLINE], [MOBILE], [JOINING_DATE], [CONTRACT_DURATION], [CONTRACT_EXPIRY_DATE], [STATUS], [RENEWAL_DATE], [PARENT_OFFICE], [EMAIL], [REPORT_DATE], [EXT_UPTO_DATE], [REMARKS], [PAYROLL_ID], [PICTURE], [IDATE], [EDUCATION]) VALUES (12, 6773732377832, N'Ayesha', N'Raja Rohan Asghar', 2, CAST(N'2002-10-26' AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2025-08-11' AS Date), NULL)
INSERT [dbo].[tbl_Employee] ([EMPLOYEE_ID], [CNIC], [NAME], [FATHER_NAME], [GENDER], [DOB], [MARITAL_STATUS], [RELIGION], [RELIGION_CAST], [CHILDREN], [DOMICILE_PROVINCE], [DOMICILE_DISTRICT], [DESIGNATION], [SCALE], [REF_FILE_NO], [C_ADDRESS], [C_TEHSIL], [C_DISTRICT], [C_PROVINCE], [P_ADDRESS], [P_TEHSIL], [P_DISTRICT], [P_PROVINCE], [LANDLINE], [MOBILE], [JOINING_DATE], [CONTRACT_DURATION], [CONTRACT_EXPIRY_DATE], [STATUS], [RENEWAL_DATE], [PARENT_OFFICE], [EMAIL], [REPORT_DATE], [EXT_UPTO_DATE], [REMARKS], [PAYROLL_ID], [PICTURE], [IDATE], [EDUCATION]) VALUES (13, 2222222222222, N'qeweqw', N'tttttt', 1, CAST(N'2013-02-12' AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2025-08-11' AS Date), NULL)
INSERT [dbo].[tbl_Employee] ([EMPLOYEE_ID], [CNIC], [NAME], [FATHER_NAME], [GENDER], [DOB], [MARITAL_STATUS], [RELIGION], [RELIGION_CAST], [CHILDREN], [DOMICILE_PROVINCE], [DOMICILE_DISTRICT], [DESIGNATION], [SCALE], [REF_FILE_NO], [C_ADDRESS], [C_TEHSIL], [C_DISTRICT], [C_PROVINCE], [P_ADDRESS], [P_TEHSIL], [P_DISTRICT], [P_PROVINCE], [LANDLINE], [MOBILE], [JOINING_DATE], [CONTRACT_DURATION], [CONTRACT_EXPIRY_DATE], [STATUS], [RENEWAL_DATE], [PARENT_OFFICE], [EMAIL], [REPORT_DATE], [EXT_UPTO_DATE], [REMARKS], [PAYROLL_ID], [PICTURE], [IDATE], [EDUCATION]) VALUES (14, 9000000000000, N'munir', N'ahmed', 1, CAST(N'1974-06-28' AS Date), 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2025-08-11' AS Date), NULL)
INSERT [dbo].[tbl_Employee] ([EMPLOYEE_ID], [CNIC], [NAME], [FATHER_NAME], [GENDER], [DOB], [MARITAL_STATUS], [RELIGION], [RELIGION_CAST], [CHILDREN], [DOMICILE_PROVINCE], [DOMICILE_DISTRICT], [DESIGNATION], [SCALE], [REF_FILE_NO], [C_ADDRESS], [C_TEHSIL], [C_DISTRICT], [C_PROVINCE], [P_ADDRESS], [P_TEHSIL], [P_DISTRICT], [P_PROVINCE], [LANDLINE], [MOBILE], [JOINING_DATE], [CONTRACT_DURATION], [CONTRACT_EXPIRY_DATE], [STATUS], [RENEWAL_DATE], [PARENT_OFFICE], [EMAIL], [REPORT_DATE], [EXT_UPTO_DATE], [REMARKS], [PAYROLL_ID], [PICTURE], [IDATE], [EDUCATION]) VALUES (15, 1111111111111, N'dffsf', N'eqwewqe', 3, CAST(N'2025-04-09' AS Date), 4, NULL, NULL, 10, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2025-08-11' AS Date), NULL)
INSERT [dbo].[tbl_Employee] ([EMPLOYEE_ID], [CNIC], [NAME], [FATHER_NAME], [GENDER], [DOB], [MARITAL_STATUS], [RELIGION], [RELIGION_CAST], [CHILDREN], [DOMICILE_PROVINCE], [DOMICILE_DISTRICT], [DESIGNATION], [SCALE], [REF_FILE_NO], [C_ADDRESS], [C_TEHSIL], [C_DISTRICT], [C_PROVINCE], [P_ADDRESS], [P_TEHSIL], [P_DISTRICT], [P_PROVINCE], [LANDLINE], [MOBILE], [JOINING_DATE], [CONTRACT_DURATION], [CONTRACT_EXPIRY_DATE], [STATUS], [RENEWAL_DATE], [PARENT_OFFICE], [EMAIL], [REPORT_DATE], [EXT_UPTO_DATE], [REMARKS], [PAYROLL_ID], [PICTURE], [IDATE], [EDUCATION]) VALUES (16, 2222222223333, N'feewqqqqq', N'rtter', 2, CAST(N'2025-05-08' AS Date), 3, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2025-08-11' AS Date), NULL)
INSERT [dbo].[tbl_Employee] ([EMPLOYEE_ID], [CNIC], [NAME], [FATHER_NAME], [GENDER], [DOB], [MARITAL_STATUS], [RELIGION], [RELIGION_CAST], [CHILDREN], [DOMICILE_PROVINCE], [DOMICILE_DISTRICT], [DESIGNATION], [SCALE], [REF_FILE_NO], [C_ADDRESS], [C_TEHSIL], [C_DISTRICT], [C_PROVINCE], [P_ADDRESS], [P_TEHSIL], [P_DISTRICT], [P_PROVINCE], [LANDLINE], [MOBILE], [JOINING_DATE], [CONTRACT_DURATION], [CONTRACT_EXPIRY_DATE], [STATUS], [RENEWAL_DATE], [PARENT_OFFICE], [EMAIL], [REPORT_DATE], [EXT_UPTO_DATE], [REMARKS], [PAYROLL_ID], [PICTURE], [IDATE], [EDUCATION]) VALUES (17, 5555555555555, N'ifsan', N'tariq ali', 1, CAST(N'2002-07-20' AS Date), 1, 1, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2025-08-11' AS Date), NULL)
INSERT [dbo].[tbl_Employee] ([EMPLOYEE_ID], [CNIC], [NAME], [FATHER_NAME], [GENDER], [DOB], [MARITAL_STATUS], [RELIGION], [RELIGION_CAST], [CHILDREN], [DOMICILE_PROVINCE], [DOMICILE_DISTRICT], [DESIGNATION], [SCALE], [REF_FILE_NO], [C_ADDRESS], [C_TEHSIL], [C_DISTRICT], [C_PROVINCE], [P_ADDRESS], [P_TEHSIL], [P_DISTRICT], [P_PROVINCE], [LANDLINE], [MOBILE], [JOINING_DATE], [CONTRACT_DURATION], [CONTRACT_EXPIRY_DATE], [STATUS], [RENEWAL_DATE], [PARENT_OFFICE], [EMAIL], [REPORT_DATE], [EXT_UPTO_DATE], [REMARKS], [PAYROLL_ID], [PICTURE], [IDATE], [EDUCATION]) VALUES (18, 9999911111111, N'anas', N'hafeez', 1, CAST(N'2011-05-26' AS Date), 3, 2, 10, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2025-08-12' AS Date), NULL)
INSERT [dbo].[tbl_Employee] ([EMPLOYEE_ID], [CNIC], [NAME], [FATHER_NAME], [GENDER], [DOB], [MARITAL_STATUS], [RELIGION], [RELIGION_CAST], [CHILDREN], [DOMICILE_PROVINCE], [DOMICILE_DISTRICT], [DESIGNATION], [SCALE], [REF_FILE_NO], [C_ADDRESS], [C_TEHSIL], [C_DISTRICT], [C_PROVINCE], [P_ADDRESS], [P_TEHSIL], [P_DISTRICT], [P_PROVINCE], [LANDLINE], [MOBILE], [JOINING_DATE], [CONTRACT_DURATION], [CONTRACT_EXPIRY_DATE], [STATUS], [RENEWAL_DATE], [PARENT_OFFICE], [EMAIL], [REPORT_DATE], [EXT_UPTO_DATE], [REMARKS], [PAYROLL_ID], [PICTURE], [IDATE], [EDUCATION]) VALUES (19, 1234567891018, N'sir arif', N'ahmed ejaz', 1, CAST(N'2021-07-28' AS Date), 2, 3, 15, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2025-08-12' AS Date), NULL)
INSERT [dbo].[tbl_Employee] ([EMPLOYEE_ID], [CNIC], [NAME], [FATHER_NAME], [GENDER], [DOB], [MARITAL_STATUS], [RELIGION], [RELIGION_CAST], [CHILDREN], [DOMICILE_PROVINCE], [DOMICILE_DISTRICT], [DESIGNATION], [SCALE], [REF_FILE_NO], [C_ADDRESS], [C_TEHSIL], [C_DISTRICT], [C_PROVINCE], [P_ADDRESS], [P_TEHSIL], [P_DISTRICT], [P_PROVINCE], [LANDLINE], [MOBILE], [JOINING_DATE], [CONTRACT_DURATION], [CONTRACT_EXPIRY_DATE], [STATUS], [RENEWAL_DATE], [PARENT_OFFICE], [EMAIL], [REPORT_DATE], [EXT_UPTO_DATE], [REMARKS], [PAYROLL_ID], [PICTURE], [IDATE], [EDUCATION]) VALUES (20, 7981031231390, N'haider', N'faiz ur rehman', 1, CAST(N'2008-02-27' AS Date), 2, 1, 5, 5, 3, 374, NULL, NULL, NULL, N'house#26, street 1,block a, rawalpindi', 3741, 374, 3, N'house#26, street 1, block a, rawalpindi', 3741, 374, 3, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2025-08-12' AS Date), NULL)
INSERT [dbo].[tbl_Employee] ([EMPLOYEE_ID], [CNIC], [NAME], [FATHER_NAME], [GENDER], [DOB], [MARITAL_STATUS], [RELIGION], [RELIGION_CAST], [CHILDREN], [DOMICILE_PROVINCE], [DOMICILE_DISTRICT], [DESIGNATION], [SCALE], [REF_FILE_NO], [C_ADDRESS], [C_TEHSIL], [C_DISTRICT], [C_PROVINCE], [P_ADDRESS], [P_TEHSIL], [P_DISTRICT], [P_PROVINCE], [LANDLINE], [MOBILE], [JOINING_DATE], [CONTRACT_DURATION], [CONTRACT_EXPIRY_DATE], [STATUS], [RENEWAL_DATE], [PARENT_OFFICE], [EMAIL], [REPORT_DATE], [EXT_UPTO_DATE], [REMARKS], [PAYROLL_ID], [PICTURE], [IDATE], [EDUCATION]) VALUES (21, 7787687123131, N'hamza abbasi', N'raja khurram abbasi', 1, CAST(N'2015-08-05' AS Date), 2, 1, 3, 6, 6, 601, 25, 22, NULL, N'gftfyt', 6011, 601, 6, N'ioiyiu', 6011, 601, 6, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2025-08-12' AS Date), NULL)
INSERT [dbo].[tbl_Employee] ([EMPLOYEE_ID], [CNIC], [NAME], [FATHER_NAME], [GENDER], [DOB], [MARITAL_STATUS], [RELIGION], [RELIGION_CAST], [CHILDREN], [DOMICILE_PROVINCE], [DOMICILE_DISTRICT], [DESIGNATION], [SCALE], [REF_FILE_NO], [C_ADDRESS], [C_TEHSIL], [C_DISTRICT], [C_PROVINCE], [P_ADDRESS], [P_TEHSIL], [P_DISTRICT], [P_PROVINCE], [LANDLINE], [MOBILE], [JOINING_DATE], [CONTRACT_DURATION], [CONTRACT_EXPIRY_DATE], [STATUS], [RENEWAL_DATE], [PARENT_OFFICE], [EMAIL], [REPORT_DATE], [EXT_UPTO_DATE], [REMARKS], [PAYROLL_ID], [PICTURE], [IDATE], [EDUCATION]) VALUES (22, 9088989812122, N'oihiuahsid', N'aduuwnq', 2, CAST(N'2021-06-16' AS Date), 3, 2, 9, 2, 6, 602, 6, 18, N'12d1', N'aojciofiaslabad', 3751, 375, 3, N'jkdauhdbalochistan', 6033, 603, 6, N'113213212', N'12334445515', CAST(N'2025-01-14' AS Date), N'1 year', CAST(N'2025-08-12' AS Date), 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2025-08-12' AS Date), NULL)
INSERT [dbo].[tbl_Employee] ([EMPLOYEE_ID], [CNIC], [NAME], [FATHER_NAME], [GENDER], [DOB], [MARITAL_STATUS], [RELIGION], [RELIGION_CAST], [CHILDREN], [DOMICILE_PROVINCE], [DOMICILE_DISTRICT], [DESIGNATION], [SCALE], [REF_FILE_NO], [C_ADDRESS], [C_TEHSIL], [C_DISTRICT], [C_PROVINCE], [P_ADDRESS], [P_TEHSIL], [P_DISTRICT], [P_PROVINCE], [LANDLINE], [MOBILE], [JOINING_DATE], [CONTRACT_DURATION], [CONTRACT_EXPIRY_DATE], [STATUS], [RENEWAL_DATE], [PARENT_OFFICE], [EMAIL], [REPORT_DATE], [EXT_UPTO_DATE], [REMARKS], [PAYROLL_ID], [PICTURE], [IDATE], [EDUCATION]) VALUES (23, 7372781378131, N'salman farooq', N'muhammad farooq', 1, CAST(N'2023-07-12' AS Date), 2, 1, 1, 4, 7, 703, 16, 16, N'12d1', N'uasduidad', 6013, 601, 6, N'iioioiojajdnmasmd', 7031, 703, 7, N'2131231', N'03335178787', CAST(N'2018-02-14' AS Date), N'1 ywar  6months', CAST(N'2025-08-12' AS Date), 1, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2025-08-12' AS Date), NULL)
INSERT [dbo].[tbl_Employee] ([EMPLOYEE_ID], [CNIC], [NAME], [FATHER_NAME], [GENDER], [DOB], [MARITAL_STATUS], [RELIGION], [RELIGION_CAST], [CHILDREN], [DOMICILE_PROVINCE], [DOMICILE_DISTRICT], [DESIGNATION], [SCALE], [REF_FILE_NO], [C_ADDRESS], [C_TEHSIL], [C_DISTRICT], [C_PROVINCE], [P_ADDRESS], [P_TEHSIL], [P_DISTRICT], [P_PROVINCE], [LANDLINE], [MOBILE], [JOINING_DATE], [CONTRACT_DURATION], [CONTRACT_EXPIRY_DATE], [STATUS], [RENEWAL_DATE], [PARENT_OFFICE], [EMAIL], [REPORT_DATE], [EXT_UPTO_DATE], [REMARKS], [PAYROLL_ID], [PICTURE], [IDATE], [EDUCATION]) VALUES (24, NULL, N'Muhammad Shahzaib Munir', N'Munir Ahmed', 1, CAST(N'2002-10-26' AS Date), 1, 1, 1, 0, 3, 374, 2, 10, NULL, N'house#26, street 1,block a, rawalpindi', NULL, NULL, NULL, N'House #26, Street #1, Block #A, Soan Garden Society, Islamabad', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2025-08-13' AS Date), NULL)
INSERT [dbo].[tbl_Employee] ([EMPLOYEE_ID], [CNIC], [NAME], [FATHER_NAME], [GENDER], [DOB], [MARITAL_STATUS], [RELIGION], [RELIGION_CAST], [CHILDREN], [DOMICILE_PROVINCE], [DOMICILE_DISTRICT], [DESIGNATION], [SCALE], [REF_FILE_NO], [C_ADDRESS], [C_TEHSIL], [C_DISTRICT], [C_PROVINCE], [P_ADDRESS], [P_TEHSIL], [P_DISTRICT], [P_PROVINCE], [LANDLINE], [MOBILE], [JOINING_DATE], [CONTRACT_DURATION], [CONTRACT_EXPIRY_DATE], [STATUS], [RENEWAL_DATE], [PARENT_OFFICE], [EMAIL], [REPORT_DATE], [EXT_UPTO_DATE], [REMARKS], [PAYROLL_ID], [PICTURE], [IDATE], [EDUCATION]) VALUES (25, 1, N'Hassan Ahmed', N'Ahmed Khan', 1, CAST(N'2002-10-26' AS Date), 3, 1, 5, 4, 7, 703, 15, 12, NULL, N'house#26, street 1,block a, rawalpindi', 7033, 703, 7, N'House #26, Street #1, Block #A, Soan Garden Society, Islamabad', 3741, 374, 3, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2025-08-13' AS Date), NULL)
INSERT [dbo].[tbl_Employee] ([EMPLOYEE_ID], [CNIC], [NAME], [FATHER_NAME], [GENDER], [DOB], [MARITAL_STATUS], [RELIGION], [RELIGION_CAST], [CHILDREN], [DOMICILE_PROVINCE], [DOMICILE_DISTRICT], [DESIGNATION], [SCALE], [REF_FILE_NO], [C_ADDRESS], [C_TEHSIL], [C_DISTRICT], [C_PROVINCE], [P_ADDRESS], [P_TEHSIL], [P_DISTRICT], [P_PROVINCE], [LANDLINE], [MOBILE], [JOINING_DATE], [CONTRACT_DURATION], [CONTRACT_EXPIRY_DATE], [STATUS], [RENEWAL_DATE], [PARENT_OFFICE], [EMAIL], [REPORT_DATE], [EXT_UPTO_DATE], [REMARKS], [PAYROLL_ID], [PICTURE], [IDATE], [EDUCATION]) VALUES (26, 9879813899903, N'Hashir Ahmed', N'Munir Ahmed', 1, CAST(N'2025-08-13' AS Date), 2, 1, 2, 2, 8, 801, 15, 4, NULL, N'house#26, street 1,block a, rawalpindi', 5032, 503, 5, N'House #26, Street #1, Block #A, Soan Garden Society, Islamabad', 4012, 401, 4, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2025-08-13' AS Date), NULL)
INSERT [dbo].[tbl_Employee] ([EMPLOYEE_ID], [CNIC], [NAME], [FATHER_NAME], [GENDER], [DOB], [MARITAL_STATUS], [RELIGION], [RELIGION_CAST], [CHILDREN], [DOMICILE_PROVINCE], [DOMICILE_DISTRICT], [DESIGNATION], [SCALE], [REF_FILE_NO], [C_ADDRESS], [C_TEHSIL], [C_DISTRICT], [C_PROVINCE], [P_ADDRESS], [P_TEHSIL], [P_DISTRICT], [P_PROVINCE], [LANDLINE], [MOBILE], [JOINING_DATE], [CONTRACT_DURATION], [CONTRACT_EXPIRY_DATE], [STATUS], [RENEWAL_DATE], [PARENT_OFFICE], [EMAIL], [REPORT_DATE], [EXT_UPTO_DATE], [REMARKS], [PAYROLL_ID], [PICTURE], [IDATE], [EDUCATION]) VALUES (27, 3431231283829, N'hamza', N'abbasi', 1, CAST(N'2025-08-13' AS Date), 1, 1, 1, 5, 5, 502, 3, 12, NULL, N'House #26, Street #1, Block #A, Soan Garden Society, Islamabad', 6012, 601, 6, N'islamabad ghoritown', 3721, 372, 3, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2025-08-13' AS Date), NULL)
INSERT [dbo].[tbl_Employee] ([EMPLOYEE_ID], [CNIC], [NAME], [FATHER_NAME], [GENDER], [DOB], [MARITAL_STATUS], [RELIGION], [RELIGION_CAST], [CHILDREN], [DOMICILE_PROVINCE], [DOMICILE_DISTRICT], [DESIGNATION], [SCALE], [REF_FILE_NO], [C_ADDRESS], [C_TEHSIL], [C_DISTRICT], [C_PROVINCE], [P_ADDRESS], [P_TEHSIL], [P_DISTRICT], [P_PROVINCE], [LANDLINE], [MOBILE], [JOINING_DATE], [CONTRACT_DURATION], [CONTRACT_EXPIRY_DATE], [STATUS], [RENEWAL_DATE], [PARENT_OFFICE], [EMAIL], [REPORT_DATE], [EXT_UPTO_DATE], [REMARKS], [PAYROLL_ID], [PICTURE], [IDATE], [EDUCATION]) VALUES (28, 8879984899193, N'Shahzaib', N'Munir Ahmed', 1, CAST(N'2025-08-13' AS Date), 2, 3, 13, 0, 8, 802, 20, 11, NULL, N'house#26, street 1,block a, rawalpindi', 6033, 603, 6, N'jkdauhdbalochistan', 5023, 502, 5, N'090-9()888', N'90543876531', NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2025-08-13' AS Date), NULL)
INSERT [dbo].[tbl_Employee] ([EMPLOYEE_ID], [CNIC], [NAME], [FATHER_NAME], [GENDER], [DOB], [MARITAL_STATUS], [RELIGION], [RELIGION_CAST], [CHILDREN], [DOMICILE_PROVINCE], [DOMICILE_DISTRICT], [DESIGNATION], [SCALE], [REF_FILE_NO], [C_ADDRESS], [C_TEHSIL], [C_DISTRICT], [C_PROVINCE], [P_ADDRESS], [P_TEHSIL], [P_DISTRICT], [P_PROVINCE], [LANDLINE], [MOBILE], [JOINING_DATE], [CONTRACT_DURATION], [CONTRACT_EXPIRY_DATE], [STATUS], [RENEWAL_DATE], [PARENT_OFFICE], [EMAIL], [REPORT_DATE], [EXT_UPTO_DATE], [REMARKS], [PAYROLL_ID], [PICTURE], [IDATE], [EDUCATION]) VALUES (29, 1319909013290, N'Shahzaib', N'Munir Ahmed', 1, CAST(N'2025-08-13' AS Date), 1, 1, 4, 5, 6, 601, 18, 2, NULL, N'house#26, street 1,block a, rawalpindi', 6033, 603, 6, N'House #26, Street #1, Block #A, Soan Garden Society, Islamabad', 5032, 503, 5, NULL, NULL, NULL, NULL, NULL, 2, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2025-08-13' AS Date), NULL)
INSERT [dbo].[tbl_Employee] ([EMPLOYEE_ID], [CNIC], [NAME], [FATHER_NAME], [GENDER], [DOB], [MARITAL_STATUS], [RELIGION], [RELIGION_CAST], [CHILDREN], [DOMICILE_PROVINCE], [DOMICILE_DISTRICT], [DESIGNATION], [SCALE], [REF_FILE_NO], [C_ADDRESS], [C_TEHSIL], [C_DISTRICT], [C_PROVINCE], [P_ADDRESS], [P_TEHSIL], [P_DISTRICT], [P_PROVINCE], [LANDLINE], [MOBILE], [JOINING_DATE], [CONTRACT_DURATION], [CONTRACT_EXPIRY_DATE], [STATUS], [RENEWAL_DATE], [PARENT_OFFICE], [EMAIL], [REPORT_DATE], [EXT_UPTO_DATE], [REMARKS], [PAYROLL_ID], [PICTURE], [IDATE], [EDUCATION]) VALUES (30, 9044534234435, N'Shahzaib', N'Munir Ahmed', 1, CAST(N'2011-02-15' AS Date), 3, 1, 5, 3, 6, 603, 14, 5, NULL, N'house#26, street 1,block a, rawalpindi', 8022, 802, 8, N'House #26, Street #1, Block #A, Soan Garden Society, Islamabad', 4023, 402, 4, NULL, NULL, CAST(N'2025-08-12' AS Date), NULL, CAST(N'2025-08-12' AS Date), 2, CAST(N'2025-08-13' AS Date), 1, NULL, CAST(N'2025-08-13' AS Date), NULL, NULL, NULL, NULL, CAST(N'2025-08-13' AS Date), NULL)
INSERT [dbo].[tbl_Employee] ([EMPLOYEE_ID], [CNIC], [NAME], [FATHER_NAME], [GENDER], [DOB], [MARITAL_STATUS], [RELIGION], [RELIGION_CAST], [CHILDREN], [DOMICILE_PROVINCE], [DOMICILE_DISTRICT], [DESIGNATION], [SCALE], [REF_FILE_NO], [C_ADDRESS], [C_TEHSIL], [C_DISTRICT], [C_PROVINCE], [P_ADDRESS], [P_TEHSIL], [P_DISTRICT], [P_PROVINCE], [LANDLINE], [MOBILE], [JOINING_DATE], [CONTRACT_DURATION], [CONTRACT_EXPIRY_DATE], [STATUS], [RENEWAL_DATE], [PARENT_OFFICE], [EMAIL], [REPORT_DATE], [EXT_UPTO_DATE], [REMARKS], [PAYROLL_ID], [PICTURE], [IDATE], [EDUCATION]) VALUES (31, 8767543221111, N'hamna', N'aashiq', 1, CAST(N'2025-08-13' AS Date), 4, 3, 11, 1, 7, 701, 7, 19, NULL, N'house#26, street 1,block a, rawalpindi', 3753, 375, 3, N'Ratti Galli Lake', 4022, 402, 4, N'98776655434', N'12345678910', CAST(N'2025-08-12' AS Date), NULL, CAST(N'2025-08-12' AS Date), 2, CAST(N'2025-08-13' AS Date), 1, NULL, CAST(N'2025-08-13' AS Date), NULL, NULL, NULL, NULL, CAST(N'2025-08-13' AS Date), NULL)
INSERT [dbo].[tbl_Employee] ([EMPLOYEE_ID], [CNIC], [NAME], [FATHER_NAME], [GENDER], [DOB], [MARITAL_STATUS], [RELIGION], [RELIGION_CAST], [CHILDREN], [DOMICILE_PROVINCE], [DOMICILE_DISTRICT], [DESIGNATION], [SCALE], [REF_FILE_NO], [C_ADDRESS], [C_TEHSIL], [C_DISTRICT], [C_PROVINCE], [P_ADDRESS], [P_TEHSIL], [P_DISTRICT], [P_PROVINCE], [LANDLINE], [MOBILE], [JOINING_DATE], [CONTRACT_DURATION], [CONTRACT_EXPIRY_DATE], [STATUS], [RENEWAL_DATE], [PARENT_OFFICE], [EMAIL], [REPORT_DATE], [EXT_UPTO_DATE], [REMARKS], [PAYROLL_ID], [PICTURE], [IDATE], [EDUCATION]) VALUES (32, 8191389138123, N'Nawaz Ali', N'Ali Meer', 1, CAST(N'1990-05-10' AS Date), 2, 1, 4, 4, 6, 602, 25, 15, NULL, N'house#26, street 1,block a, rawalpindi', 8011, 801, 8, N'House #26, Street #1, Block #A, Soan Garden Society, Islamabad', 4013, 401, 4, N'987912312', N'03335188622', CAST(N'2025-08-12' AS Date), NULL, CAST(N'2025-08-13' AS Date), 1, CAST(N'2025-08-12' AS Date), 1, N'nawazali@gmail.com', CAST(N'2025-08-13' AS Date), NULL, NULL, N'FH-72781', NULL, CAST(N'2025-08-13' AS Date), NULL)
INSERT [dbo].[tbl_Employee] ([EMPLOYEE_ID], [CNIC], [NAME], [FATHER_NAME], [GENDER], [DOB], [MARITAL_STATUS], [RELIGION], [RELIGION_CAST], [CHILDREN], [DOMICILE_PROVINCE], [DOMICILE_DISTRICT], [DESIGNATION], [SCALE], [REF_FILE_NO], [C_ADDRESS], [C_TEHSIL], [C_DISTRICT], [C_PROVINCE], [P_ADDRESS], [P_TEHSIL], [P_DISTRICT], [P_PROVINCE], [LANDLINE], [MOBILE], [JOINING_DATE], [CONTRACT_DURATION], [CONTRACT_EXPIRY_DATE], [STATUS], [RENEWAL_DATE], [PARENT_OFFICE], [EMAIL], [REPORT_DATE], [EXT_UPTO_DATE], [REMARKS], [PAYROLL_ID], [PICTURE], [IDATE], [EDUCATION]) VALUES (33, 3131313919031, N'Shayan Bin Shahid', N'Shahid', 2, CAST(N'2001-05-10' AS Date), 1, 1, 1, 1, 9, 902, 17, 9, NULL, N'house#26, street 1,block a, rawalpindi', 6012, 601, 6, N'House #26, Street #1, Block #A, Soan Garden Society, Islamabad', 3721, 372, 3, N'009192831', N'09128931312', CAST(N'2025-08-12' AS Date), N'6Months', CAST(N'2025-08-13' AS Date), 1, CAST(N'2025-08-12' AS Date), 1, N'shayan@yahoo.com', CAST(N'2025-08-13' AS Date), CAST(N'2025-08-29' AS Date), NULL, N'213213d', NULL, CAST(N'2025-08-13' AS Date), NULL)
INSERT [dbo].[tbl_Employee] ([EMPLOYEE_ID], [CNIC], [NAME], [FATHER_NAME], [GENDER], [DOB], [MARITAL_STATUS], [RELIGION], [RELIGION_CAST], [CHILDREN], [DOMICILE_PROVINCE], [DOMICILE_DISTRICT], [DESIGNATION], [SCALE], [REF_FILE_NO], [C_ADDRESS], [C_TEHSIL], [C_DISTRICT], [C_PROVINCE], [P_ADDRESS], [P_TEHSIL], [P_DISTRICT], [P_PROVINCE], [LANDLINE], [MOBILE], [JOINING_DATE], [CONTRACT_DURATION], [CONTRACT_EXPIRY_DATE], [STATUS], [RENEWAL_DATE], [PARENT_OFFICE], [EMAIL], [REPORT_DATE], [EXT_UPTO_DATE], [REMARKS], [PAYROLL_ID], [PICTURE], [IDATE], [EDUCATION]) VALUES (34, 9089011231231, N'hassan', N'ali sadiq', 2, CAST(N'1990-06-22' AS Date), 3, 2, 6, 3, 6, 603, 17, 8, NULL, N'House #26, Street #1, Block #A, Soan Garden Society, Islamabad', 9023, 902, 9, N'iioioiojajdnmasmd', 4023, 402, 4, N'23123', N'03335175441', CAST(N'2025-08-12' AS Date), NULL, CAST(N'2025-08-13' AS Date), 2, CAST(N'2025-08-12' AS Date), 1, N'shahzaib@gmail.com', CAST(N'2025-08-13' AS Date), CAST(N'2025-08-29' AS Date), NULL, N'1312321', NULL, CAST(N'2025-08-13' AS Date), NULL)
INSERT [dbo].[tbl_Employee] ([EMPLOYEE_ID], [CNIC], [NAME], [FATHER_NAME], [GENDER], [DOB], [MARITAL_STATUS], [RELIGION], [RELIGION_CAST], [CHILDREN], [DOMICILE_PROVINCE], [DOMICILE_DISTRICT], [DESIGNATION], [SCALE], [REF_FILE_NO], [C_ADDRESS], [C_TEHSIL], [C_DISTRICT], [C_PROVINCE], [P_ADDRESS], [P_TEHSIL], [P_DISTRICT], [P_PROVINCE], [LANDLINE], [MOBILE], [JOINING_DATE], [CONTRACT_DURATION], [CONTRACT_EXPIRY_DATE], [STATUS], [RENEWAL_DATE], [PARENT_OFFICE], [EMAIL], [REPORT_DATE], [EXT_UPTO_DATE], [REMARKS], [PAYROLL_ID], [PICTURE], [IDATE], [EDUCATION]) VALUES (35, 8978912931231, N'Touheed', N'Munir Ahmed', 2, CAST(N'1997-06-15' AS Date), 2, 2, 10, 3, 3, 375, 20, 12, N'213123123', N'house#26, street 1,block a, rawalpindi', 6022, 602, 6, N'House #26, Street #1, Block #A, Soan Garden Society, Islamabad', 3751, 375, 3, N'41231312', N'03123312231', CAST(N'2025-08-12' AS Date), N'12Months', CAST(N'2025-08-13' AS Date), 1, CAST(N'2025-08-12' AS Date), 1, N'touheed@yahoo.com', CAST(N'2025-08-13' AS Date), CAST(N'2025-08-30' AS Date), N'Hello Everyone', N'12313', NULL, CAST(N'2025-08-13' AS Date), NULL)
INSERT [dbo].[tbl_Employee] ([EMPLOYEE_ID], [CNIC], [NAME], [FATHER_NAME], [GENDER], [DOB], [MARITAL_STATUS], [RELIGION], [RELIGION_CAST], [CHILDREN], [DOMICILE_PROVINCE], [DOMICILE_DISTRICT], [DESIGNATION], [SCALE], [REF_FILE_NO], [C_ADDRESS], [C_TEHSIL], [C_DISTRICT], [C_PROVINCE], [P_ADDRESS], [P_TEHSIL], [P_DISTRICT], [P_PROVINCE], [LANDLINE], [MOBILE], [JOINING_DATE], [CONTRACT_DURATION], [CONTRACT_EXPIRY_DATE], [STATUS], [RENEWAL_DATE], [PARENT_OFFICE], [EMAIL], [REPORT_DATE], [EXT_UPTO_DATE], [REMARKS], [PAYROLL_ID], [PICTURE], [IDATE], [EDUCATION]) VALUES (36, 2131280183909, N'Hashir Ahmed', N'Munir Ahmed', 2, CAST(N'2025-08-14' AS Date), 1, 1, 2, NULL, 9, 902, 12, 3, N'106y-f', N'House #26, Street #1, Block #A, Soan Garden Society, Islamabad', 9032, 903, 9, N'house#26, street 1, block a, rawalpindi', 4022, 402, 4, N'05133517747', N'01233123123', CAST(N'2025-08-13' AS Date), N'1year', CAST(N'2025-08-14' AS Date), 2, CAST(N'2025-08-13' AS Date), 1, N'sada@gmail.com', CAST(N'2025-08-14' AS Date), CAST(N'2025-08-23' AS Date), N'Hello', N'13123', NULL, CAST(N'2025-08-14' AS Date), 3)
INSERT [dbo].[tbl_Employee] ([EMPLOYEE_ID], [CNIC], [NAME], [FATHER_NAME], [GENDER], [DOB], [MARITAL_STATUS], [RELIGION], [RELIGION_CAST], [CHILDREN], [DOMICILE_PROVINCE], [DOMICILE_DISTRICT], [DESIGNATION], [SCALE], [REF_FILE_NO], [C_ADDRESS], [C_TEHSIL], [C_DISTRICT], [C_PROVINCE], [P_ADDRESS], [P_TEHSIL], [P_DISTRICT], [P_PROVINCE], [LANDLINE], [MOBILE], [JOINING_DATE], [CONTRACT_DURATION], [CONTRACT_EXPIRY_DATE], [STATUS], [RENEWAL_DATE], [PARENT_OFFICE], [EMAIL], [REPORT_DATE], [EXT_UPTO_DATE], [REMARKS], [PAYROLL_ID], [PICTURE], [IDATE], [EDUCATION]) VALUES (37, 1800123131231, N'Shahzaib', N'ali sadiq', 1, CAST(N'1813-04-13' AS Date), 3, 2, 6, 2, 7, 701, 17, 9, N'12d1', N'uasduidad', 7012, 701, 7, N'House #26, Street #1, Block #A, Soan Garden Society, Islamabad', 5021, 502, 5, N'131313', N'21312312213', CAST(N'2025-08-05' AS Date), N'1 year', CAST(N'2025-08-14' AS Date), 1, CAST(N'2025-08-13' AS Date), 1, N'hello@gmail.com', CAST(N'2025-08-14' AS Date), CAST(N'2025-08-20' AS Date), N'Shahzaib', N'1231232EMP', NULL, CAST(N'2025-08-14' AS Date), 6)
INSERT [dbo].[tbl_Employee] ([EMPLOYEE_ID], [CNIC], [NAME], [FATHER_NAME], [GENDER], [DOB], [MARITAL_STATUS], [RELIGION], [RELIGION_CAST], [CHILDREN], [DOMICILE_PROVINCE], [DOMICILE_DISTRICT], [DESIGNATION], [SCALE], [REF_FILE_NO], [C_ADDRESS], [C_TEHSIL], [C_DISTRICT], [C_PROVINCE], [P_ADDRESS], [P_TEHSIL], [P_DISTRICT], [P_PROVINCE], [LANDLINE], [MOBILE], [JOINING_DATE], [CONTRACT_DURATION], [CONTRACT_EXPIRY_DATE], [STATUS], [RENEWAL_DATE], [PARENT_OFFICE], [EMAIL], [REPORT_DATE], [EXT_UPTO_DATE], [REMARKS], [PAYROLL_ID], [PICTURE], [IDATE], [EDUCATION]) VALUES (38, 3740527924759, N'Muhammad Shahzaib Munir', N'Munir Ahmed', 1, CAST(N'2002-10-26' AS Date), 1, 1, 1, 0, 7, 701, 21, 10, N'HR/123/47', N'house#26, street 1,block a, rawalpindi', 7033, 703, 7, N'House #26, Street #1, Block #A, Soan Garden Society, Islamabad', 3741, 374, 3, N'0514417747', N'03335173752', CAST(N'2025-08-07' AS Date), N'12Months', CAST(N'2025-09-07' AS Date), 1, CAST(N'2025-09-07' AS Date), 1, N'm.shahzaib262002@gmail.com', CAST(N'2025-09-05' AS Date), CAST(N'2025-10-26' AS Date), N'I am Internee in BISP', N'EMP-262002', NULL, CAST(N'2025-08-14' AS Date), 5)
INSERT [dbo].[tbl_Employee] ([EMPLOYEE_ID], [CNIC], [NAME], [FATHER_NAME], [GENDER], [DOB], [MARITAL_STATUS], [RELIGION], [RELIGION_CAST], [CHILDREN], [DOMICILE_PROVINCE], [DOMICILE_DISTRICT], [DESIGNATION], [SCALE], [REF_FILE_NO], [C_ADDRESS], [C_TEHSIL], [C_DISTRICT], [C_PROVINCE], [P_ADDRESS], [P_TEHSIL], [P_DISTRICT], [P_PROVINCE], [LANDLINE], [MOBILE], [JOINING_DATE], [CONTRACT_DURATION], [CONTRACT_EXPIRY_DATE], [STATUS], [RENEWAL_DATE], [PARENT_OFFICE], [EMAIL], [REPORT_DATE], [EXT_UPTO_DATE], [REMARKS], [PAYROLL_ID], [PICTURE], [IDATE], [EDUCATION]) VALUES (39, 3740519887664, N'Jahanzaib', N'Ahmed', 1, CAST(N'1997-04-14' AS Date), 2, 3, 11, 3, 6, 603, 20, 9, N'12d1', N'house#26, street 1,block a, rawalpindi', 8032, 803, 8, N'House #26, Street #1, Block #A, Soan Garden Society, Islamabad', 3751, 375, 3, N'23123', N'03255871275', CAST(N'2001-07-31' AS Date), N'6Weeks', CAST(N'2025-08-20' AS Date), 1, CAST(N'2025-08-14' AS Date), 1, N'jz10@yahoo.com', CAST(N'2025-08-14' AS Date), CAST(N'2025-08-29' AS Date), N'JAHANZAIB HERE', N'EMP-2132', NULL, CAST(N'2025-08-14' AS Date), 4)
INSERT [dbo].[tbl_Employee] ([EMPLOYEE_ID], [CNIC], [NAME], [FATHER_NAME], [GENDER], [DOB], [MARITAL_STATUS], [RELIGION], [RELIGION_CAST], [CHILDREN], [DOMICILE_PROVINCE], [DOMICILE_DISTRICT], [DESIGNATION], [SCALE], [REF_FILE_NO], [C_ADDRESS], [C_TEHSIL], [C_DISTRICT], [C_PROVINCE], [P_ADDRESS], [P_TEHSIL], [P_DISTRICT], [P_PROVINCE], [LANDLINE], [MOBILE], [JOINING_DATE], [CONTRACT_DURATION], [CONTRACT_EXPIRY_DATE], [STATUS], [RENEWAL_DATE], [PARENT_OFFICE], [EMAIL], [REPORT_DATE], [EXT_UPTO_DATE], [REMARKS], [PAYROLL_ID], [PICTURE], [IDATE], [EDUCATION]) VALUES (40, 1230123213123, N'sdfsfsafas', N'sfsfsafwe', 1, CAST(N'2021-01-04' AS Date), 2, 2, 10, 3, 7, 703, 18, 4, N'12d1', N'gftfyt', 7011, 701, 7, N'iioioiojajdnmasmd', 5031, 503, 5, N'23123', N'03335175441', CAST(N'2025-08-04' AS Date), N'6 Weeks', CAST(N'2025-08-14' AS Date), 2, CAST(N'2025-08-14' AS Date), 1, N'name@gmail.com', CAST(N'2025-08-14' AS Date), CAST(N'2025-08-14' AS Date), N'Random', N'EMP-00', NULL, CAST(N'2025-08-14' AS Date), 2)
INSERT [dbo].[tbl_Employee] ([EMPLOYEE_ID], [CNIC], [NAME], [FATHER_NAME], [GENDER], [DOB], [MARITAL_STATUS], [RELIGION], [RELIGION_CAST], [CHILDREN], [DOMICILE_PROVINCE], [DOMICILE_DISTRICT], [DESIGNATION], [SCALE], [REF_FILE_NO], [C_ADDRESS], [C_TEHSIL], [C_DISTRICT], [C_PROVINCE], [P_ADDRESS], [P_TEHSIL], [P_DISTRICT], [P_PROVINCE], [LANDLINE], [MOBILE], [JOINING_DATE], [CONTRACT_DURATION], [CONTRACT_EXPIRY_DATE], [STATUS], [RENEWAL_DATE], [PARENT_OFFICE], [EMAIL], [REPORT_DATE], [EXT_UPTO_DATE], [REMARKS], [PAYROLL_ID], [PICTURE], [IDATE], [EDUCATION]) VALUES (42, 3740519987988, N'hassan', N'ali sadiq', 1, CAST(N'2019-06-04' AS Date), 2, 2, 6, 3, 6, 603, 18, 2, N'106y-f', N'islamabad soan garden', 8032, 803, 8, N'House #26, Street #1, Block #A, Soan Garden Society, Islamabad', 5021, 502, 5, N'23123', N'03335173752', CAST(N'2025-07-17' AS Date), N'6Weeks', CAST(N'2025-11-29' AS Date), 1, CAST(N'2025-08-14' AS Date), 1, N'ajsdjka@yahoo.com', CAST(N'2025-08-10' AS Date), CAST(N'2025-08-21' AS Date), N'hello', N'EMP-21313', NULL, CAST(N'2025-08-14' AS Date), 5)
INSERT [dbo].[tbl_Employee] ([EMPLOYEE_ID], [CNIC], [NAME], [FATHER_NAME], [GENDER], [DOB], [MARITAL_STATUS], [RELIGION], [RELIGION_CAST], [CHILDREN], [DOMICILE_PROVINCE], [DOMICILE_DISTRICT], [DESIGNATION], [SCALE], [REF_FILE_NO], [C_ADDRESS], [C_TEHSIL], [C_DISTRICT], [C_PROVINCE], [P_ADDRESS], [P_TEHSIL], [P_DISTRICT], [P_PROVINCE], [LANDLINE], [MOBILE], [JOINING_DATE], [CONTRACT_DURATION], [CONTRACT_EXPIRY_DATE], [STATUS], [RENEWAL_DATE], [PARENT_OFFICE], [EMAIL], [REPORT_DATE], [EXT_UPTO_DATE], [REMARKS], [PAYROLL_ID], [PICTURE], [IDATE], [EDUCATION]) VALUES (44, 1230987613412, N'Shahzaib', N'Munir Ahmed', 3, CAST(N'1989-10-17' AS Date), 3, 3, 11, 4, 6, 603, 18, 3, N'106y-f', N'house#26, street 1,block a, rawalpindi', 5021, 502, 5, N'House #26, Street #1, Block #A, Soan Garden Society, Islamabad', 3722, 372, 3, N'05133517747', N'03335175441', CAST(N'2025-08-04' AS Date), N'6Weeks', CAST(N'2025-08-19' AS Date), 1, CAST(N'2025-08-19' AS Date), 1, N'sajdk@yahoo.com', CAST(N'2025-08-21' AS Date), CAST(N'2025-08-29' AS Date), N'hello', N'emp-3121', NULL, CAST(N'2025-08-14' AS Date), 3)
INSERT [dbo].[tbl_Employee] ([EMPLOYEE_ID], [CNIC], [NAME], [FATHER_NAME], [GENDER], [DOB], [MARITAL_STATUS], [RELIGION], [RELIGION_CAST], [CHILDREN], [DOMICILE_PROVINCE], [DOMICILE_DISTRICT], [DESIGNATION], [SCALE], [REF_FILE_NO], [C_ADDRESS], [C_TEHSIL], [C_DISTRICT], [C_PROVINCE], [P_ADDRESS], [P_TEHSIL], [P_DISTRICT], [P_PROVINCE], [LANDLINE], [MOBILE], [JOINING_DATE], [CONTRACT_DURATION], [CONTRACT_EXPIRY_DATE], [STATUS], [RENEWAL_DATE], [PARENT_OFFICE], [EMAIL], [REPORT_DATE], [EXT_UPTO_DATE], [REMARKS], [PAYROLL_ID], [PICTURE], [IDATE], [EDUCATION]) VALUES (45, 1240871297328, N'afnan', N'tariq', 1, CAST(N'1998-03-04' AS Date), 3, 3, 15, 2, 5, 502, 3, 12, N'12d1', N'house#26, street 1,block a, rawalpindi', 5031, 503, 5, N'House #26, Street #1, Block #A, Soan Garden Society, Islamabad', 3751, 375, 3, N'23123', N'03335175441', CAST(N'2025-08-04' AS Date), N'6Weeks', CAST(N'2025-08-21' AS Date), 2, CAST(N'2025-08-15' AS Date), 1, N'afnan@yahoo.com', CAST(N'2025-08-12' AS Date), CAST(N'2025-08-30' AS Date), N'sadas', N'emp-123', NULL, CAST(N'2025-08-14' AS Date), 4)
INSERT [dbo].[tbl_Employee] ([EMPLOYEE_ID], [CNIC], [NAME], [FATHER_NAME], [GENDER], [DOB], [MARITAL_STATUS], [RELIGION], [RELIGION_CAST], [CHILDREN], [DOMICILE_PROVINCE], [DOMICILE_DISTRICT], [DESIGNATION], [SCALE], [REF_FILE_NO], [C_ADDRESS], [C_TEHSIL], [C_DISTRICT], [C_PROVINCE], [P_ADDRESS], [P_TEHSIL], [P_DISTRICT], [P_PROVINCE], [LANDLINE], [MOBILE], [JOINING_DATE], [CONTRACT_DURATION], [CONTRACT_EXPIRY_DATE], [STATUS], [RENEWAL_DATE], [PARENT_OFFICE], [EMAIL], [REPORT_DATE], [EXT_UPTO_DATE], [REMARKS], [PAYROLL_ID], [PICTURE], [IDATE], [EDUCATION]) VALUES (46, 3210451791728, N'Shahzaib', N'Munir Ahmed', 2, CAST(N'2003-10-28' AS Date), 3, 3, 11, 3, 5, 502, 18, 3, N'12d1', N'uasduidad', 6021, 602, 6, N'House #26, Street #1, Block #A, Soan Garden Society, Islamabad', 3722, 372, 3, N'05133517747', N'03335178787', CAST(N'2025-08-03' AS Date), N'6 Weeks', CAST(N'2025-08-05' AS Date), 1, CAST(N'2025-08-25' AS Date), 1, N'shahziab@gmail.com', CAST(N'2025-08-15' AS Date), CAST(N'2025-08-28' AS Date), N'hello', N'emp-98', NULL, CAST(N'2025-08-14' AS Date), 7)
INSERT [dbo].[tbl_Employee] ([EMPLOYEE_ID], [CNIC], [NAME], [FATHER_NAME], [GENDER], [DOB], [MARITAL_STATUS], [RELIGION], [RELIGION_CAST], [CHILDREN], [DOMICILE_PROVINCE], [DOMICILE_DISTRICT], [DESIGNATION], [SCALE], [REF_FILE_NO], [C_ADDRESS], [C_TEHSIL], [C_DISTRICT], [C_PROVINCE], [P_ADDRESS], [P_TEHSIL], [P_DISTRICT], [P_PROVINCE], [LANDLINE], [MOBILE], [JOINING_DATE], [CONTRACT_DURATION], [CONTRACT_EXPIRY_DATE], [STATUS], [RENEWAL_DATE], [PARENT_OFFICE], [EMAIL], [REPORT_DATE], [EXT_UPTO_DATE], [REMARKS], [PAYROLL_ID], [PICTURE], [IDATE], [EDUCATION]) VALUES (47, 7660812389719, N'Hashir Ahmed', N'Paracha', 1, CAST(N'1987-09-14' AS Date), 3, 3, 11, 2, 9, 902, 25, 12, N'106y-f', N'house#26, street 1,block a, rawalpindi', 9012, 901, 9, N'House #26, Street #1, Block #A, Soan Garden Society, Islamabad', 4023, 402, 4, N'2131231', N'03335175441', CAST(N'2025-08-01' AS Date), N'6Weeks', CAST(N'2025-08-20' AS Date), 1, CAST(N'2025-08-22' AS Date), 1, N'hello@yahoo.com', CAST(N'2025-08-21' AS Date), CAST(N'2025-08-31' AS Date), N'hello', N'emp-0139', NULL, CAST(N'2025-08-14' AS Date), 7)
INSERT [dbo].[tbl_Employee] ([EMPLOYEE_ID], [CNIC], [NAME], [FATHER_NAME], [GENDER], [DOB], [MARITAL_STATUS], [RELIGION], [RELIGION_CAST], [CHILDREN], [DOMICILE_PROVINCE], [DOMICILE_DISTRICT], [DESIGNATION], [SCALE], [REF_FILE_NO], [C_ADDRESS], [C_TEHSIL], [C_DISTRICT], [C_PROVINCE], [P_ADDRESS], [P_TEHSIL], [P_DISTRICT], [P_PROVINCE], [LANDLINE], [MOBILE], [JOINING_DATE], [CONTRACT_DURATION], [CONTRACT_EXPIRY_DATE], [STATUS], [RENEWAL_DATE], [PARENT_OFFICE], [EMAIL], [REPORT_DATE], [EXT_UPTO_DATE], [REMARKS], [PAYROLL_ID], [PICTURE], [IDATE], [EDUCATION]) VALUES (48, 1230762131312, N'Hashir Ahmed', N'Shah Bukhari', 2, CAST(N'1995-02-10' AS Date), 3, 3, 15, 3, 9, 902, 17, 9, N'12d1', N'house#26, street 1,block a, rawalpindi', 3723, 372, 3, N'House #26, Street #1, Block #A, Soan Garden Society, Islamabad', 5032, 503, 5, N'312', N'03335175441', CAST(N'2025-08-01' AS Date), N'6Weeks', CAST(N'2025-08-20' AS Date), 1, CAST(N'2025-08-27' AS Date), 1, N'sasdas@gmail.com', CAST(N'2025-08-21' AS Date), CAST(N'2025-08-31' AS Date), N'klnmlksa', N'asdd123', NULL, CAST(N'2025-08-14' AS Date), 8)
INSERT [dbo].[tbl_Employee] ([EMPLOYEE_ID], [CNIC], [NAME], [FATHER_NAME], [GENDER], [DOB], [MARITAL_STATUS], [RELIGION], [RELIGION_CAST], [CHILDREN], [DOMICILE_PROVINCE], [DOMICILE_DISTRICT], [DESIGNATION], [SCALE], [REF_FILE_NO], [C_ADDRESS], [C_TEHSIL], [C_DISTRICT], [C_PROVINCE], [P_ADDRESS], [P_TEHSIL], [P_DISTRICT], [P_PROVINCE], [LANDLINE], [MOBILE], [JOINING_DATE], [CONTRACT_DURATION], [CONTRACT_EXPIRY_DATE], [STATUS], [RENEWAL_DATE], [PARENT_OFFICE], [EMAIL], [REPORT_DATE], [EXT_UPTO_DATE], [REMARKS], [PAYROLL_ID], [PICTURE], [IDATE], [EDUCATION]) VALUES (49, 2130131312328, N'javed', N'tariq', 1, CAST(N'1997-08-10' AS Date), 2, 1, 4, NULL, 9, 902, 19, 13, NULL, N'house#26, street 1,block a, rawalpindi', NULL, NULL, NULL, N'ioiyiu', NULL, NULL, NULL, NULL, N'03335175442', CAST(N'2025-08-01' AS Date), NULL, NULL, 2, NULL, 1, N's@gmail.com', NULL, CAST(N'2025-08-31' AS Date), N'HELLO', NULL, NULL, CAST(N'2025-08-14' AS Date), NULL)
INSERT [dbo].[tbl_Employee] ([EMPLOYEE_ID], [CNIC], [NAME], [FATHER_NAME], [GENDER], [DOB], [MARITAL_STATUS], [RELIGION], [RELIGION_CAST], [CHILDREN], [DOMICILE_PROVINCE], [DOMICILE_DISTRICT], [DESIGNATION], [SCALE], [REF_FILE_NO], [C_ADDRESS], [C_TEHSIL], [C_DISTRICT], [C_PROVINCE], [P_ADDRESS], [P_TEHSIL], [P_DISTRICT], [P_PROVINCE], [LANDLINE], [MOBILE], [JOINING_DATE], [CONTRACT_DURATION], [CONTRACT_EXPIRY_DATE], [STATUS], [RENEWAL_DATE], [PARENT_OFFICE], [EMAIL], [REPORT_DATE], [EXT_UPTO_DATE], [REMARKS], [PAYROLL_ID], [PICTURE], [IDATE], [EDUCATION]) VALUES (50, 1920313121239, N'Shahzaib', N'Shah Bukhari', 1, CAST(N'1997-09-09' AS Date), 3, 2, 6, 3, 7, 701, 20, 3, N'106y-f', N'House #26, Street #1, Block #A, Soan Garden Society, Islamabad', 3753, 375, 3, N'iioioiojajdnmasmd', 4012, 401, 4, N'05133517747', N'03335173752', CAST(N'2025-08-01' AS Date), N'6Weeks', CAST(N'2025-08-22' AS Date), 2, CAST(N'2025-08-20' AS Date), 1, N'as@yahoo.com', CAST(N'2025-08-23' AS Date), CAST(N'2025-08-31' AS Date), N'hello', N'sd1231', NULL, CAST(N'2025-08-14' AS Date), 6)
INSERT [dbo].[tbl_Employee] ([EMPLOYEE_ID], [CNIC], [NAME], [FATHER_NAME], [GENDER], [DOB], [MARITAL_STATUS], [RELIGION], [RELIGION_CAST], [CHILDREN], [DOMICILE_PROVINCE], [DOMICILE_DISTRICT], [DESIGNATION], [SCALE], [REF_FILE_NO], [C_ADDRESS], [C_TEHSIL], [C_DISTRICT], [C_PROVINCE], [P_ADDRESS], [P_TEHSIL], [P_DISTRICT], [P_PROVINCE], [LANDLINE], [MOBILE], [JOINING_DATE], [CONTRACT_DURATION], [CONTRACT_EXPIRY_DATE], [STATUS], [RENEWAL_DATE], [PARENT_OFFICE], [EMAIL], [REPORT_DATE], [EXT_UPTO_DATE], [REMARKS], [PAYROLL_ID], [PICTURE], [IDATE], [EDUCATION]) VALUES (51, 3470452123134, N'Shahzaib', N'Adil Rasheed', 1, CAST(N'1970-07-06' AS Date), 3, 1, 5, 4, 9, 601, 25, 3, N'106y-f', NULL, 5031, 503, 5, NULL, 9032, 903, 9, N'05133517747', N'03335175441', CAST(N'2025-08-01' AS Date), N'6Weeks', CAST(N'2025-08-18' AS Date), 1, CAST(N'2025-08-22' AS Date), 1, N'hello@gmail.com', CAST(N'2025-08-26' AS Date), CAST(N'2025-08-31' AS Date), N'hello', N'emp-212', NULL, CAST(N'2025-08-15' AS Date), 7)
INSERT [dbo].[tbl_Employee] ([EMPLOYEE_ID], [CNIC], [NAME], [FATHER_NAME], [GENDER], [DOB], [MARITAL_STATUS], [RELIGION], [RELIGION_CAST], [CHILDREN], [DOMICILE_PROVINCE], [DOMICILE_DISTRICT], [DESIGNATION], [SCALE], [REF_FILE_NO], [C_ADDRESS], [C_TEHSIL], [C_DISTRICT], [C_PROVINCE], [P_ADDRESS], [P_TEHSIL], [P_DISTRICT], [P_PROVINCE], [LANDLINE], [MOBILE], [JOINING_DATE], [CONTRACT_DURATION], [CONTRACT_EXPIRY_DATE], [STATUS], [RENEWAL_DATE], [PARENT_OFFICE], [EMAIL], [REPORT_DATE], [EXT_UPTO_DATE], [REMARKS], [PAYROLL_ID], [PICTURE], [IDATE], [EDUCATION]) VALUES (52, 1230456789102, N'Muhammad Shahzaib Munir', N'Munir Ahmed', 1, CAST(N'2002-10-26' AS Date), 1, 1, 1, 0, 3, 374, 21, 15, NULL, N'House #26, Street #1, Block #A, Soan Garden Society, Islamabad', NULL, NULL, NULL, N'House #26, Street #1, Block #A, Soan Garden Society, Islamabad', NULL, NULL, NULL, NULL, N'03335173752', CAST(N'2025-08-04' AS Date), NULL, NULL, 1, NULL, 1, N'm.shahzaib262002@gmail.com', NULL, CAST(N'2025-09-30' AS Date), N'My name is Shahzaib and I am Internee in BISP for 6 weeks', NULL, NULL, CAST(N'2025-08-18' AS Date), 5)
INSERT [dbo].[tbl_Employee] ([EMPLOYEE_ID], [CNIC], [NAME], [FATHER_NAME], [GENDER], [DOB], [MARITAL_STATUS], [RELIGION], [RELIGION_CAST], [CHILDREN], [DOMICILE_PROVINCE], [DOMICILE_DISTRICT], [DESIGNATION], [SCALE], [REF_FILE_NO], [C_ADDRESS], [C_TEHSIL], [C_DISTRICT], [C_PROVINCE], [P_ADDRESS], [P_TEHSIL], [P_DISTRICT], [P_PROVINCE], [LANDLINE], [MOBILE], [JOINING_DATE], [CONTRACT_DURATION], [CONTRACT_EXPIRY_DATE], [STATUS], [RENEWAL_DATE], [PARENT_OFFICE], [EMAIL], [REPORT_DATE], [EXT_UPTO_DATE], [REMARKS], [PAYROLL_ID], [PICTURE], [IDATE], [EDUCATION]) VALUES (53, 8910983123314, N'IrfanUllah', N'Niazi Khan', 1, CAST(N'1898-03-12' AS Date), 3, 2, 7, 3, 8, 803, 15, 5, N'12d1', N'house#26, street 1,block a, rawalpindi', 8033, 803, 7, N'House #26, Street #1, Block #A, Soan Garden Society, Islamabad', 5021, 502, 5, N'0514417747', N'03123121233', CAST(N'2025-08-01' AS Date), N'6Weeks', CAST(N'2025-08-08' AS Date), 2, CAST(N'2025-08-26' AS Date), 1, N'irfan@yahoo.com', CAST(N'2025-08-29' AS Date), CAST(N'2025-08-31' AS Date), N'afaFDADFSA', N'EMP-1022', NULL, CAST(N'2025-08-18' AS Date), 7)
INSERT [dbo].[tbl_Employee] ([EMPLOYEE_ID], [CNIC], [NAME], [FATHER_NAME], [GENDER], [DOB], [MARITAL_STATUS], [RELIGION], [RELIGION_CAST], [CHILDREN], [DOMICILE_PROVINCE], [DOMICILE_DISTRICT], [DESIGNATION], [SCALE], [REF_FILE_NO], [C_ADDRESS], [C_TEHSIL], [C_DISTRICT], [C_PROVINCE], [P_ADDRESS], [P_TEHSIL], [P_DISTRICT], [P_PROVINCE], [LANDLINE], [MOBILE], [JOINING_DATE], [CONTRACT_DURATION], [CONTRACT_EXPIRY_DATE], [STATUS], [RENEWAL_DATE], [PARENT_OFFICE], [EMAIL], [REPORT_DATE], [EXT_UPTO_DATE], [REMARKS], [PAYROLL_ID], [PICTURE], [IDATE], [EDUCATION]) VALUES (54, 1090826565651, N'Abdullah', N'Abdul Razzaq', 1, CAST(N'2000-08-21' AS Date), 1, 1, 2, 4, 7, 701, 8, 8, N'MIS/2081', N'house#25, street 1,block a, rawalpindi', 7031, 703, 7, N'House #26, Street #1, Block #A, Soan Garden Society, Islamabad', 3741, 374, 3, N'05133517747', N'03335175441', CAST(N'2025-08-01' AS Date), N'6Weeks', CAST(N'2025-08-14' AS Date), 2, CAST(N'2025-09-15' AS Date), 1, N'a.razzaq123@gmail.com', CAST(N'2025-08-14' AS Date), CAST(N'2025-08-31' AS Date), N'My name is Abdullah', N'EMP-1029', NULL, CAST(N'2025-08-20' AS Date), 3)
INSERT [dbo].[tbl_Employee] ([EMPLOYEE_ID], [CNIC], [NAME], [FATHER_NAME], [GENDER], [DOB], [MARITAL_STATUS], [RELIGION], [RELIGION_CAST], [CHILDREN], [DOMICILE_PROVINCE], [DOMICILE_DISTRICT], [DESIGNATION], [SCALE], [REF_FILE_NO], [C_ADDRESS], [C_TEHSIL], [C_DISTRICT], [C_PROVINCE], [P_ADDRESS], [P_TEHSIL], [P_DISTRICT], [P_PROVINCE], [LANDLINE], [MOBILE], [JOINING_DATE], [CONTRACT_DURATION], [CONTRACT_EXPIRY_DATE], [STATUS], [RENEWAL_DATE], [PARENT_OFFICE], [EMAIL], [REPORT_DATE], [EXT_UPTO_DATE], [REMARKS], [PAYROLL_ID], [PICTURE], [IDATE], [EDUCATION]) VALUES (55, 2750987878787, N'Pehlaj Hassan', N'Ch Hassan', 1, CAST(N'1990-06-10' AS Date), 1, 1, 1, 5, 7, 703, 8, 10, N'NSER-CCT/12/10f', N'House #26, Street #1, Block #A, Soan Garden Society, Islamabad', 7013, 701, 7, N'Jinnah Garden', 3741, 374, 3, N'05144889988', N'03872910879', CAST(N'2025-08-01' AS Date), N'6Weeks', CAST(N'2025-09-30' AS Date), 1, CAST(N'2025-09-30' AS Date), 1, N'pehlaaj21@gmail.com', CAST(N'2025-08-20' AS Date), CAST(N'2025-08-31' AS Date), N'No Remarks', N'EMP-1043', NULL, CAST(N'2025-08-27' AS Date), 5)
INSERT [dbo].[tbl_Employee] ([EMPLOYEE_ID], [CNIC], [NAME], [FATHER_NAME], [GENDER], [DOB], [MARITAL_STATUS], [RELIGION], [RELIGION_CAST], [CHILDREN], [DOMICILE_PROVINCE], [DOMICILE_DISTRICT], [DESIGNATION], [SCALE], [REF_FILE_NO], [C_ADDRESS], [C_TEHSIL], [C_DISTRICT], [C_PROVINCE], [P_ADDRESS], [P_TEHSIL], [P_DISTRICT], [P_PROVINCE], [LANDLINE], [MOBILE], [JOINING_DATE], [CONTRACT_DURATION], [CONTRACT_EXPIRY_DATE], [STATUS], [RENEWAL_DATE], [PARENT_OFFICE], [EMAIL], [REPORT_DATE], [EXT_UPTO_DATE], [REMARKS], [PAYROLL_ID], [PICTURE], [IDATE], [EDUCATION]) VALUES (56, 110900000090, N'Zeeshan ali', N'Raja Ali', 1, CAST(N'1995-10-21' AS Date), 2, 3, 11, 3, 8, 803, 25, 2, N'HR/1010/T', N'house#26, street 1,block a, rawalpindi', 7031, 703, 7, N'DHA 2', 4021, 402, 4, N'05100000990', N'03438478191', CAST(N'2025-08-01' AS Date), N'6Weeks', CAST(N'2025-09-30' AS Date), 1, CAST(N'2025-09-30' AS Date), 1, N'zeeshanhaider20@yahoo.com', CAST(N'2025-08-19' AS Date), CAST(N'2025-08-31' AS Date), N'My name is Zeeshan Ali', N'emp-20', NULL, CAST(N'2025-08-27' AS Date), 7)
INSERT [dbo].[tbl_Employee] ([EMPLOYEE_ID], [CNIC], [NAME], [FATHER_NAME], [GENDER], [DOB], [MARITAL_STATUS], [RELIGION], [RELIGION_CAST], [CHILDREN], [DOMICILE_PROVINCE], [DOMICILE_DISTRICT], [DESIGNATION], [SCALE], [REF_FILE_NO], [C_ADDRESS], [C_TEHSIL], [C_DISTRICT], [C_PROVINCE], [P_ADDRESS], [P_TEHSIL], [P_DISTRICT], [P_PROVINCE], [LANDLINE], [MOBILE], [JOINING_DATE], [CONTRACT_DURATION], [CONTRACT_EXPIRY_DATE], [STATUS], [RENEWAL_DATE], [PARENT_OFFICE], [EMAIL], [REPORT_DATE], [EXT_UPTO_DATE], [REMARKS], [PAYROLL_ID], [PICTURE], [IDATE], [EDUCATION]) VALUES (57, 990900000, N'ali', N'raja ali', 1, CAST(N'1887-02-11' AS Date), 2, 1, 5, 3, 6, 603, 8, 10, N'106y-f', N'uasduidad', 3721, 372, 3, N'house#26, street 1, block a, rawalpindi', 4033, 403, 4, N'051789937892', N'03909299910', CAST(N'2025-08-01' AS Date), N'6Weeks', CAST(N'2025-08-31' AS Date), 1, CAST(N'2025-08-29' AS Date), 1, N'ali@yahoo.com', CAST(N'2025-08-25' AS Date), CAST(N'2025-08-30' AS Date), N'no issue', N'EMP-1090', NULL, CAST(N'2025-08-27' AS Date), 3)
INSERT [dbo].[tbl_Employee] ([EMPLOYEE_ID], [CNIC], [NAME], [FATHER_NAME], [GENDER], [DOB], [MARITAL_STATUS], [RELIGION], [RELIGION_CAST], [CHILDREN], [DOMICILE_PROVINCE], [DOMICILE_DISTRICT], [DESIGNATION], [SCALE], [REF_FILE_NO], [C_ADDRESS], [C_TEHSIL], [C_DISTRICT], [C_PROVINCE], [P_ADDRESS], [P_TEHSIL], [P_DISTRICT], [P_PROVINCE], [LANDLINE], [MOBILE], [JOINING_DATE], [CONTRACT_DURATION], [CONTRACT_EXPIRY_DATE], [STATUS], [RENEWAL_DATE], [PARENT_OFFICE], [EMAIL], [REPORT_DATE], [EXT_UPTO_DATE], [REMARKS], [PAYROLL_ID], [PICTURE], [IDATE], [EDUCATION]) VALUES (59, 900999999999, N'adil', N'rashid', 1, CAST(N'1993-08-08' AS Date), 1, 1, 2, 0, 7, 701, 17, 3, N'NSER-CCT/12', N'House #26, Street #1, Block #A, Soan Garden Society, Islamabad', 6033, 603, 6, N'House #26, Street #1, Block #A, Soan Garden Society, Islamabad', 5021, 502, 5, N'04276546788', N'03333333333', CAST(N'2025-08-01' AS Date), N'12Months', CAST(N'2025-09-01' AS Date), 1, CAST(N'2025-08-31' AS Date), 1, N'adil@hotmail.com', CAST(N'2025-08-17' AS Date), CAST(N'2025-09-30' AS Date), N'No remarks', N'emp-11', NULL, CAST(N'2025-08-27' AS Date), 6)
INSERT [dbo].[tbl_Employee] ([EMPLOYEE_ID], [CNIC], [NAME], [FATHER_NAME], [GENDER], [DOB], [MARITAL_STATUS], [RELIGION], [RELIGION_CAST], [CHILDREN], [DOMICILE_PROVINCE], [DOMICILE_DISTRICT], [DESIGNATION], [SCALE], [REF_FILE_NO], [C_ADDRESS], [C_TEHSIL], [C_DISTRICT], [C_PROVINCE], [P_ADDRESS], [P_TEHSIL], [P_DISTRICT], [P_PROVINCE], [LANDLINE], [MOBILE], [JOINING_DATE], [CONTRACT_DURATION], [CONTRACT_EXPIRY_DATE], [STATUS], [RENEWAL_DATE], [PARENT_OFFICE], [EMAIL], [REPORT_DATE], [EXT_UPTO_DATE], [REMARKS], [PAYROLL_ID], [PICTURE], [IDATE], [EDUCATION]) VALUES (60, 1230432112344, N'Khurram Ali', N'Ali Hassan', 1, CAST(N'1989-11-07' AS Date), 2, 1, 1, 4, 7, 701, 8, 10, N'HR/10-G', N'house#26, street 1,block a, rawalpindi', 9021, 902, 9, N'islamabad ghoritown', 5021, 502, 5, N'0514417747', N'03333333333', CAST(N'2025-08-01' AS Date), N'6Weeks', CAST(N'2025-08-24' AS Date), 1, CAST(N'2025-08-26' AS Date), 1, N'khurram@gmail.com', CAST(N'2025-08-15' AS Date), CAST(N'2025-08-31' AS Date), N'My name is Khurram Ali', N'EMP-198', NULL, CAST(N'2025-08-27' AS Date), 5)
INSERT [dbo].[tbl_Employee] ([EMPLOYEE_ID], [CNIC], [NAME], [FATHER_NAME], [GENDER], [DOB], [MARITAL_STATUS], [RELIGION], [RELIGION_CAST], [CHILDREN], [DOMICILE_PROVINCE], [DOMICILE_DISTRICT], [DESIGNATION], [SCALE], [REF_FILE_NO], [C_ADDRESS], [C_TEHSIL], [C_DISTRICT], [C_PROVINCE], [P_ADDRESS], [P_TEHSIL], [P_DISTRICT], [P_PROVINCE], [LANDLINE], [MOBILE], [JOINING_DATE], [CONTRACT_DURATION], [CONTRACT_EXPIRY_DATE], [STATUS], [RENEWAL_DATE], [PARENT_OFFICE], [EMAIL], [REPORT_DATE], [EXT_UPTO_DATE], [REMARKS], [PAYROLL_ID], [PICTURE], [IDATE], [EDUCATION]) VALUES (61, 390898989898, N'Bashir Ahmed', N'Ahmed Bashir', 1, CAST(N'1990-08-20' AS Date), 1, 1, 1, 3, 7, 701, 24, 15, N'MIS/2081', N'Jinnah Garden', 7033, 703, 7, N'River Garden', 3741, 374, 3, N'04267765718198', N'03456787655', CAST(N'2025-08-01' AS Date), N'6Months', CAST(N'2025-09-30' AS Date), 1, CAST(N'2025-08-20' AS Date), 1, N'bashir.ahmed10@gmail.com', CAST(N'2025-08-22' AS Date), CAST(N'2025-08-31' AS Date), N'My name is Bashir Ahmed', N'EMP-190', NULL, CAST(N'2025-08-28' AS Date), 6)
INSERT [dbo].[tbl_Employee] ([EMPLOYEE_ID], [CNIC], [NAME], [FATHER_NAME], [GENDER], [DOB], [MARITAL_STATUS], [RELIGION], [RELIGION_CAST], [CHILDREN], [DOMICILE_PROVINCE], [DOMICILE_DISTRICT], [DESIGNATION], [SCALE], [REF_FILE_NO], [C_ADDRESS], [C_TEHSIL], [C_DISTRICT], [C_PROVINCE], [P_ADDRESS], [P_TEHSIL], [P_DISTRICT], [P_PROVINCE], [LANDLINE], [MOBILE], [JOINING_DATE], [CONTRACT_DURATION], [CONTRACT_EXPIRY_DATE], [STATUS], [RENEWAL_DATE], [PARENT_OFFICE], [EMAIL], [REPORT_DATE], [EXT_UPTO_DATE], [REMARKS], [PAYROLL_ID], [PICTURE], [IDATE], [EDUCATION]) VALUES (62, 7870788713113, N'Mustafa Kiani', N'Kiani Khan', 1, CAST(N'1991-08-07' AS Date), 1, 3, 14, 4, 9, 901, 15, 20, N'IT/9021/T3', N'House#10, Street#5, Block B, DHA-2', 7032, 703, 7, N'Bahria Town Phase 2', 5031, 503, 5, N'065316898765', N'03467542489', CAST(N'2025-08-01' AS Date), N'7Years', CAST(N'2025-09-30' AS Date), 2, CAST(N'2025-09-17' AS Date), 1, N'mustafakiani.80@gmail.com', CAST(N'2025-09-17' AS Date), CAST(N'2025-09-30' AS Date), N'My name is Mustafa Kiani', N'EMP-2021', NULL, CAST(N'2025-09-04' AS Date), 6)
SET IDENTITY_INSERT [dbo].[tbl_Employee] OFF
GO

-- ============================================
-- 15. tbl_Employee_History (4 records)
-- ============================================
SET IDENTITY_INSERT [dbo].[tbl_Employee_History] ON 
INSERT [dbo].[tbl_Employee_History] ([HISTORY_ID], [EMPLOYEE_ID], [CNIC], [NAME], [FATHER_NAME], [GENDER], [DOB], [EDUCATION], [MARITAL_STATUS], [RELIGION], [RELIGION_CAST], [CHILDREN], [DOMICILE_PROVINCE], [DOMICILE_DISTRICT], [DESIGNATION], [SCALE], [REF_FILE_NO], [C_ADDRESS], [C_TEHSIL], [C_DISTRICT], [C_PROVINCE], [P_ADDRESS], [P_TEHSIL], [P_DISTRICT], [P_PROVINCE], [LANDLINE], [MOBILE], [JOINING_DATE], [CONTRACT_DURATION], [CONTRACT_EXPIRY_DATE], [STATUS], [RENEWAL_DATE], [PARENT_OFFICE], [EMAIL], [REPORT_DATE], [EXT_UPTO_DATE], [REMARKS], [PAYROLL_ID], [PICTURE], [IDATE], [USER_CNIC], [ACTION], [HISTORY_DATE]) VALUES (2, 59, 900999999999, N'adil', N'rashid', 1, CAST(N'1993-08-08' AS Date), N'6', 1, 1, 2, 0, 7, 701, 17, 3, N'NSER-CCT/12', N'House #26, Street #1, Block #A, Soan Garden Society, Islamabad', 6033, 603, 6, N'House #26, Street #1, Block #A, Soan Garden Society, Islamabad', 5021, 502, 5, N'04276546788', N'03333333333', CAST(N'2025-08-01' AS Date), N'12Months', CAST(N'2025-09-01' AS Date), 1, CAST(N'2025-08-31' AS Date), 1, N'adil@hotmail.com', CAST(N'2025-08-17' AS Date), CAST(N'2025-09-30' AS Date), N'No remarks', N'emp-11', NULL, CAST(N'2025-08-27' AS Date), 3740527924759, N'INSERT', CAST(N'2025-08-27T09:56:08.940' AS DateTime))
INSERT [dbo].[tbl_Employee_History] ([HISTORY_ID], [EMPLOYEE_ID], [CNIC], [NAME], [FATHER_NAME], [GENDER], [DOB], [EDUCATION], [MARITAL_STATUS], [RELIGION], [RELIGION_CAST], [CHILDREN], [DOMICILE_PROVINCE], [DOMICILE_DISTRICT], [DESIGNATION], [SCALE], [REF_FILE_NO], [C_ADDRESS], [C_TEHSIL], [C_DISTRICT], [C_PROVINCE], [P_ADDRESS], [P_TEHSIL], [P_DISTRICT], [P_PROVINCE], [LANDLINE], [MOBILE], [JOINING_DATE], [CONTRACT_DURATION], [CONTRACT_EXPIRY_DATE], [STATUS], [RENEWAL_DATE], [PARENT_OFFICE], [EMAIL], [REPORT_DATE], [EXT_UPTO_DATE], [REMARKS], [PAYROLL_ID], [PICTURE], [IDATE], [USER_CNIC], [ACTION], [HISTORY_DATE]) VALUES (3, 60, 1230432112344, N'Khurram Ali', N'Ali Hassan', 1, CAST(N'1989-11-07' AS Date), N'5', 2, 1, 1, 4, 7, 701, 8, 10, N'HR/10-G', N'house#26, street 1,block a, rawalpindi', 9021, 902, 9, N'islamabad ghoritown', 5021, 502, 5, N'0514417747', N'03333333333', CAST(N'2025-08-01' AS Date), N'6Weeks', CAST(N'2025-08-24' AS Date), 1, CAST(N'2025-08-26' AS Date), 1, N'khurram@gmail.com', CAST(N'2025-08-15' AS Date), CAST(N'2025-08-31' AS Date), N'My name is Khurram Ali', N'EMP-198', NULL, CAST(N'2025-08-27' AS Date), 3740527924759, N'INSERT', CAST(N'2025-08-27T12:26:21.383' AS DateTime))
INSERT [dbo].[tbl_Employee_History] ([HISTORY_ID], [EMPLOYEE_ID], [CNIC], [NAME], [FATHER_NAME], [GENDER], [DOB], [EDUCATION], [MARITAL_STATUS], [RELIGION], [RELIGION_CAST], [CHILDREN], [DOMICILE_PROVINCE], [DOMICILE_DISTRICT], [DESIGNATION], [SCALE], [REF_FILE_NO], [C_ADDRESS], [C_TEHSIL], [C_DISTRICT], [C_PROVINCE], [P_ADDRESS], [P_TEHSIL], [P_DISTRICT], [P_PROVINCE], [LANDLINE], [MOBILE], [JOINING_DATE], [CONTRACT_DURATION], [CONTRACT_EXPIRY_DATE], [STATUS], [RENEWAL_DATE], [PARENT_OFFICE], [EMAIL], [REPORT_DATE], [EXT_UPTO_DATE], [REMARKS], [PAYROLL_ID], [PICTURE], [IDATE], [USER_CNIC], [ACTION], [HISTORY_DATE]) VALUES (4, 61, 390898989898, N'Bashir Ahmed', N'Ahmed Bashir', 1, CAST(N'1990-08-20' AS Date), N'6', 1, 1, 1, 3, 7, 701, 24, 15, N'MIS/2081', N'Jinnah Garden', 7033, 703, 7, N'River Garden', 3741, 374, 3, N'04267765718198', N'03456787655', CAST(N'2025-08-01' AS Date), N'6Months', CAST(N'2025-09-30' AS Date), 1, CAST(N'2025-08-20' AS Date), 1, N'bashir.ahmed10@gmail.com', CAST(N'2025-08-22' AS Date), CAST(N'2025-08-31' AS Date), N'My name is Bashir Ahmed', N'EMP-190', NULL, CAST(N'2025-08-28' AS Date), 3740527924759, N'INSERT', CAST(N'2025-08-28T10:21:09.537' AS DateTime))
INSERT [dbo].[tbl_Employee_History] ([HISTORY_ID], [EMPLOYEE_ID], [CNIC], [NAME], [FATHER_NAME], [GENDER], [DOB], [EDUCATION], [MARITAL_STATUS], [RELIGION], [RELIGION_CAST], [CHILDREN], [DOMICILE_PROVINCE], [DOMICILE_DISTRICT], [DESIGNATION], [SCALE], [REF_FILE_NO], [C_ADDRESS], [C_TEHSIL], [C_DISTRICT], [C_PROVINCE], [P_ADDRESS], [P_TEHSIL], [P_DISTRICT], [P_PROVINCE], [LANDLINE], [MOBILE], [JOINING_DATE], [CONTRACT_DURATION], [CONTRACT_EXPIRY_DATE], [STATUS], [RENEWAL_DATE], [PARENT_OFFICE], [EMAIL], [REPORT_DATE], [EXT_UPTO_DATE], [REMARKS], [PAYROLL_ID], [PICTURE], [IDATE], [USER_CNIC], [ACTION], [HISTORY_DATE]) VALUES (5, 62, 7870788713113, N'Mustafa Kiani', N'Kiani Khan', 1, CAST(N'1991-08-07' AS Date), N'6', 1, 3, 14, 4, 9, 901, 15, 20, N'IT/9021/T3', N'House#10, Street#5, Block B, DHA-2', 7032, 703, 7, N'Bahria Town Phase 2', 5031, 503, 5, N'065316898765', N'03467542489', CAST(N'2025-08-01' AS Date), N'7Years', CAST(N'2025-09-30' AS Date), 2, CAST(N'2025-09-17' AS Date), 1, N'mustafakiani.80@gmail.com', CAST(N'2025-09-17' AS Date), CAST(N'2025-09-30' AS Date), N'My name is Mustafa Kiani', N'EMP-2021', NULL, CAST(N'2025-09-04' AS Date), 3740527924759, N'INSERT', CAST(N'2025-09-04T11:39:46.597' AS DateTime))
SET IDENTITY_INSERT [dbo].[tbl_Employee_History] OFF
GO

-- ============================================
-- 16. tbl_Position (10 records)
-- ============================================
SET IDENTITY_INSERT [dbo].[tbl_Position] ON 
INSERT [dbo].[tbl_Position] ([POST_ID], [POST_TITLE], [POST_SCALE], [POST_REGION], [POST_OCCUPANCY], [POST_STATUS], [LOCATION_DEPARTMENT], [DISTRICT_SUB_DEPARTMENT], [TEHSIL_SECTION], [REPORTING_TO_POST_ID], [EMPLOYEE_ID], [IDATE], [LAST_UPDATE_DATE]) VALUES (1, N'Assistant Director', N'17', N'Punjab', N'Full-Time', N'1', N'Lahore HQ', N'District Lahore', N'Tehsil City', NULL, NULL, CAST(N'2025-08-26T09:57:42.970' AS DateTime), NULL)
INSERT [dbo].[tbl_Position] ([POST_ID], [POST_TITLE], [POST_SCALE], [POST_REGION], [POST_OCCUPANCY], [POST_STATUS], [LOCATION_DEPARTMENT], [DISTRICT_SUB_DEPARTMENT], [TEHSIL_SECTION], [REPORTING_TO_POST_ID], [EMPLOYEE_ID], [IDATE], [LAST_UPDATE_DATE]) VALUES (2, N'Data Entry Operator', N'11', N'Punjab', N'Full-Time', N'1', N'Rawalpindi Office', N'District Rawalpindi', N'Tehsil Cantt', NULL, NULL, CAST(N'2025-08-26T09:57:42.970' AS DateTime), NULL)
INSERT [dbo].[tbl_Position] ([POST_ID], [POST_TITLE], [POST_SCALE], [POST_REGION], [POST_OCCUPANCY], [POST_STATUS], [LOCATION_DEPARTMENT], [DISTRICT_SUB_DEPARTMENT], [TEHSIL_SECTION], [REPORTING_TO_POST_ID], [EMPLOYEE_ID], [IDATE], [LAST_UPDATE_DATE]) VALUES (3, N'Clerk', N'09', N'Sindh', N'Full-Time', N'1', N'Karachi HQ', N'District Karachi', N'Tehsil South', NULL, NULL, CAST(N'2025-08-26T09:57:42.970' AS DateTime), NULL)
INSERT [dbo].[tbl_Position] ([POST_ID], [POST_TITLE], [POST_SCALE], [POST_REGION], [POST_OCCUPANCY], [POST_STATUS], [LOCATION_DEPARTMENT], [DISTRICT_SUB_DEPARTMENT], [TEHSIL_SECTION], [REPORTING_TO_POST_ID], [EMPLOYEE_ID], [IDATE], [LAST_UPDATE_DATE]) VALUES (4, N'Manager HR', N'18', N'Sindh', N'Full-Time', N'1', N'Hyderabad Office', N'District Hyderabad', N'Tehsil Latifabad', NULL, NULL, CAST(N'2025-08-26T09:57:42.970' AS DateTime), NULL)
INSERT [dbo].[tbl_Position] ([POST_ID], [POST_TITLE], [POST_SCALE], [POST_REGION], [POST_OCCUPANCY], [POST_STATUS], [LOCATION_DEPARTMENT], [DISTRICT_SUB_DEPARTMENT], [TEHSIL_SECTION], [REPORTING_TO_POST_ID], [EMPLOYEE_ID], [IDATE], [LAST_UPDATE_DATE]) VALUES (5, N'IT Officer', N'16', N'KPK', N'Full-Time', N'1', N'Peshawar HQ', N'District Peshawar', N'Tehsil Town-1', NULL, NULL, CAST(N'2025-08-26T09:57:42.970' AS DateTime), NULL)
INSERT [dbo].[tbl_Position] ([POST_ID], [POST_TITLE], [POST_SCALE], [POST_REGION], [POST_OCCUPANCY], [POST_STATUS], [LOCATION_DEPARTMENT], [DISTRICT_SUB_DEPARTMENT], [TEHSIL_SECTION], [REPORTING_TO_POST_ID], [EMPLOYEE_ID], [IDATE], [LAST_UPDATE_DATE]) VALUES (6, N'Accounts Officer', N'16', N'KPK', N'Full-Time', N'1', N'Abbottabad Office', N'District Abbottabad', N'Tehsil Abbottabad', NULL, NULL, CAST(N'2025-08-26T09:57:42.970' AS DateTime), CAST(N'2025-08-26T10:13:25.440' AS DateTime))
INSERT [dbo].[tbl_Position] ([POST_ID], [POST_TITLE], [POST_SCALE], [POST_REGION], [POST_OCCUPANCY], [POST_STATUS], [LOCATION_DEPARTMENT], [DISTRICT_SUB_DEPARTMENT], [TEHSIL_SECTION], [REPORTING_TO_POST_ID], [EMPLOYEE_ID], [IDATE], [LAST_UPDATE_DATE]) VALUES (7, N'Project Manager', N'18', N'Balochistan', N'Full-Time', N'1', N'Quetta HQ', N'District Quetta', N'Tehsil Quetta City', NULL, NULL, CAST(N'2025-08-26T09:57:42.970' AS DateTime), NULL)
INSERT [dbo].[tbl_Position] ([POST_ID], [POST_TITLE], [POST_SCALE], [POST_REGION], [POST_OCCUPANCY], [POST_STATUS], [LOCATION_DEPARTMENT], [DISTRICT_SUB_DEPARTMENT], [TEHSIL_SECTION], [REPORTING_TO_POST_ID], [EMPLOYEE_ID], [IDATE], [LAST_UPDATE_DATE]) VALUES (8, N'Coordinator', N'14', N'Balochistan', N'Full-Time', N'1', N'Gwadar Office', N'District Gwadar', N'Tehsil Gwadar', NULL, NULL, CAST(N'2025-08-26T09:57:42.970' AS DateTime), CAST(N'2025-08-26T10:25:07.193' AS DateTime))
INSERT [dbo].[tbl_Position] ([POST_ID], [POST_TITLE], [POST_SCALE], [POST_REGION], [POST_OCCUPANCY], [POST_STATUS], [LOCATION_DEPARTMENT], [DISTRICT_SUB_DEPARTMENT], [TEHSIL_SECTION], [REPORTING_TO_POST_ID], [EMPLOYEE_ID], [IDATE], [LAST_UPDATE_DATE]) VALUES (9, N'Supervisor', N'15', N'AJK', N'Full-Time', N'1', N'Muzaffarabad HQ', N'District Muzaffarabad', N'Tehsil Muzaffarabad', NULL, NULL, CAST(N'2025-08-26T09:57:42.970' AS DateTime), CAST(N'2025-08-26T11:38:15.850' AS DateTime))
INSERT [dbo].[tbl_Position] ([POST_ID], [POST_TITLE], [POST_SCALE], [POST_REGION], [POST_OCCUPANCY], [POST_STATUS], [LOCATION_DEPARTMENT], [DISTRICT_SUB_DEPARTMENT], [TEHSIL_SECTION], [REPORTING_TO_POST_ID], [EMPLOYEE_ID], [IDATE], [LAST_UPDATE_DATE]) VALUES (10, N'Field Officer', N'12', N'Gilgit Baltistan', N'Full-Time', N'1', N'Gilgit Office', N'District Gilgit', N'Tehsil Gilgit', NULL, NULL, CAST(N'2025-08-26T09:57:42.970' AS DateTime), CAST(N'2025-08-26T11:37:32.137' AS DateTime))
SET IDENTITY_INSERT [dbo].[tbl_Position] OFF
GO

-- ============================================
-- 17. tbl_Position_History (4 records)
-- ============================================
SET IDENTITY_INSERT [dbo].[tbl_Position_History] ON 
INSERT [dbo].[tbl_Position_History] ([HISTORY_ID], [POST_ID], [POST_TITLE], [POST_SCALE], [POST_REGION], [POST_OCCUPANCY], [POST_STATUS], [LOCATION_DEPARTMENT], [DISTRICT_SUB_DEPARTMENT], [TEHSIL_SECTION], [REPORTING_TO_POST_ID], [EMPLOYEE_ID], [IDATE], [LAST_UPDATE_DATE], [USER_CNIC], [HISTORY_DATE], [ACTION]) VALUES (1, 9, N'Supervisor', N'15', N'AJK', N'Full-Time', N'1', N'Muzaffarabad HQ', N'District Muzaffarabad', N'Tehsil Muzaffarabad', NULL, 56, CAST(N'2025-08-26T09:57:42.970' AS DateTime), CAST(N'2025-08-26T11:38:15.850' AS DateTime), 3740527924759, CAST(N'2025-08-27T11:25:36.413' AS DateTime), N'ASSIGN')
INSERT [dbo].[tbl_Position_History] ([HISTORY_ID], [POST_ID], [POST_TITLE], [POST_SCALE], [POST_REGION], [POST_OCCUPANCY], [POST_STATUS], [LOCATION_DEPARTMENT], [DISTRICT_SUB_DEPARTMENT], [TEHSIL_SECTION], [REPORTING_TO_POST_ID], [EMPLOYEE_ID], [IDATE], [LAST_UPDATE_DATE], [USER_CNIC], [HISTORY_DATE], [ACTION]) VALUES (2, 9, N'Supervisor', N'15', N'AJK', N'Full-Time', N'1', N'Muzaffarabad HQ', N'District Muzaffarabad', N'Tehsil Muzaffarabad', NULL, NULL, CAST(N'2025-08-26T09:57:42.970' AS DateTime), CAST(N'2025-08-26T11:38:15.850' AS DateTime), 3740527924759, CAST(N'2025-08-27T11:26:11.593' AS DateTime), N'UNASSIGN')
INSERT [dbo].[tbl_Position_History] ([HISTORY_ID], [POST_ID], [POST_TITLE], [POST_SCALE], [POST_REGION], [POST_OCCUPANCY], [POST_STATUS], [LOCATION_DEPARTMENT], [DISTRICT_SUB_DEPARTMENT], [TEHSIL_SECTION], [REPORTING_TO_POST_ID], [EMPLOYEE_ID], [IDATE], [LAST_UPDATE_DATE], [USER_CNIC], [HISTORY_DATE], [ACTION]) VALUES (3, 9, N'Supervisor', N'15', N'AJK', N'Full-Time', N'1', N'Muzaffarabad HQ', N'District Muzaffarabad', N'Tehsil Muzaffarabad', NULL, 52, CAST(N'2025-08-26T09:57:42.970' AS DateTime), CAST(N'2025-08-26T11:38:15.850' AS DateTime), 3740527924759, CAST(N'2025-08-28T08:18:27.903' AS DateTime), N'ASSIGN')
INSERT [dbo].[tbl_Position_History] ([HISTORY_ID], [POST_ID], [POST_TITLE], [POST_SCALE], [POST_REGION], [POST_OCCUPANCY], [POST_STATUS], [LOCATION_DEPARTMENT], [DISTRICT_SUB_DEPARTMENT], [TEHSIL_SECTION], [REPORTING_TO_POST_ID], [EMPLOYEE_ID], [IDATE], [LAST_UPDATE_DATE], [USER_CNIC], [HISTORY_DATE], [ACTION]) VALUES (4, 9, N'Supervisor', N'15', N'AJK', N'Full-Time', N'1', N'Muzaffarabad HQ', N'District Muzaffarabad', N'Tehsil Muzaffarabad', NULL, NULL, CAST(N'2025-08-26T09:57:42.970' AS DateTime), CAST(N'2025-08-26T11:38:15.850' AS DateTime), 3740527924759, CAST(N'2025-08-28T08:52:21.497' AS DateTime), N'UNASSIGN')
SET IDENTITY_INSERT [dbo].[tbl_Position_History] OFF
GO

-- ============================================
-- Confirm All Data Inserted
-- ============================================
SELECT 'lib_designation' AS TableName, COUNT(*) AS Records FROM dbo.lib_designation
UNION ALL
SELECT 'lib_district', COUNT(*) FROM dbo.lib_district
UNION ALL
SELECT 'lib_education', COUNT(*) FROM dbo.lib_education
UNION ALL
SELECT 'lib_gender', COUNT(*) FROM dbo.lib_gender
UNION ALL
SELECT 'lib_marital_status', COUNT(*) FROM dbo.lib_marital_status
UNION ALL
SELECT 'lib_parent_office', COUNT(*) FROM dbo.lib_parent_office
UNION ALL
SELECT 'lib_province', COUNT(*) FROM dbo.lib_province
UNION ALL
SELECT 'lib_religion', COUNT(*) FROM dbo.lib_religion
UNION ALL
SELECT 'lib_religion_cast', COUNT(*) FROM dbo.lib_religion_cast
UNION ALL
SELECT 'lib_scale', COUNT(*) FROM dbo.lib_scale
UNION ALL
SELECT 'lib_status', COUNT(*) FROM dbo.lib_status
UNION ALL
SELECT 'lib_tehsil', COUNT(*) FROM dbo.lib_tehsil
UNION ALL
SELECT 'login', COUNT(*) FROM dbo.login
UNION ALL
SELECT 'tbl_Employee', COUNT(*) FROM dbo.tbl_Employee
UNION ALL
SELECT 'tbl_Employee_History', COUNT(*) FROM dbo.tbl_Employee_History
UNION ALL
SELECT 'tbl_Position', COUNT(*) FROM dbo.tbl_Position
UNION ALL
SELECT 'tbl_Position_History', COUNT(*) FROM dbo.tbl_Position_History
GO


SELECT * FROM dbo.lib_gender;
SELECT * FROM dbo.tbl_Employee;
SELECT * FROM dbo.login;