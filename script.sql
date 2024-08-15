USE [Company_SD]
GO
/****** Object:  Table [dbo].[Departments]    Script Date: 8/6/2024 8:42:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Departments](
	[Dname] [nvarchar](50) NULL,
	[Dnum] [int] NOT NULL,
	[MGRSSN] [int] NULL,
	[MGRStart Date] [datetime] NULL,
 CONSTRAINT [PK_Departments] PRIMARY KEY CLUSTERED 
(
	[Dnum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Dependent]    Script Date: 8/6/2024 8:42:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dependent](
	[ESSN] [int] NOT NULL,
	[Dependent_name] [nvarchar](255) NOT NULL,
	[Sex] [nvarchar](255) NULL,
	[Bdate] [datetime] NULL,
 CONSTRAINT [PK_Dependent] PRIMARY KEY CLUSTERED 
(
	[ESSN] ASC,
	[Dependent_name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Employee]    Script Date: 8/6/2024 8:42:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Employee](
	[Fname] [nvarchar](50) NULL,
	[Lname] [nvarchar](50) NULL,
	[SSN] [int] NOT NULL,
	[Bdate] [datetime] NULL,
	[Address] [nvarchar](50) NULL,
	[Sex] [nvarchar](50) NULL,
	[Salary] [int] NULL,
	[Superssn] [int] NULL,
	[Dno] [int] NULL,
 CONSTRAINT [PK_Employee] PRIMARY KEY CLUSTERED 
(
	[SSN] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Project]    Script Date: 8/6/2024 8:42:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Project](
	[Pname] [nvarchar](50) NULL,
	[Pnumber] [int] NOT NULL,
	[Plocation] [nvarchar](50) NULL,
	[City] [nvarchar](50) NULL,
	[Dnum] [int] NULL,
 CONSTRAINT [PK_Project] PRIMARY KEY CLUSTERED 
(
	[Pnumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Works_for]    Script Date: 8/6/2024 8:42:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Works_for](
	[ESSn] [int] NOT NULL,
	[Pno] [int] NOT NULL,
	[Hours] [int] NULL,
 CONSTRAINT [PK_Works_for] PRIMARY KEY CLUSTERED 
(
	[ESSn] ASC,
	[Pno] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Departments]  WITH CHECK ADD  CONSTRAINT [FK_Departments_Employee] FOREIGN KEY([MGRSSN])
REFERENCES [dbo].[Employee] ([SSN])
GO
ALTER TABLE [dbo].[Departments] CHECK CONSTRAINT [FK_Departments_Employee]
GO
ALTER TABLE [dbo].[Dependent]  WITH CHECK ADD  CONSTRAINT [FK_Dependent_Employee] FOREIGN KEY([ESSN])
REFERENCES [dbo].[Employee] ([SSN])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Dependent] CHECK CONSTRAINT [FK_Dependent_Employee]
GO
ALTER TABLE [dbo].[Employee]  WITH CHECK ADD  CONSTRAINT [FK_Employee_Departments] FOREIGN KEY([Dno])
REFERENCES [dbo].[Departments] ([Dnum])
GO
ALTER TABLE [dbo].[Employee] CHECK CONSTRAINT [FK_Employee_Departments]
GO
ALTER TABLE [dbo].[Employee]  WITH CHECK ADD  CONSTRAINT [FK_Employee_Employee] FOREIGN KEY([Superssn])
REFERENCES [dbo].[Employee] ([SSN])
GO
ALTER TABLE [dbo].[Employee] CHECK CONSTRAINT [FK_Employee_Employee]
GO
ALTER TABLE [dbo].[Project]  WITH CHECK ADD  CONSTRAINT [FK_Project_Departments] FOREIGN KEY([Dnum])
REFERENCES [dbo].[Departments] ([Dnum])
GO
ALTER TABLE [dbo].[Project] CHECK CONSTRAINT [FK_Project_Departments]
GO
ALTER TABLE [dbo].[Works_for]  WITH CHECK ADD  CONSTRAINT [FK_Works_for_Employee] FOREIGN KEY([ESSn])
REFERENCES [dbo].[Employee] ([SSN])
GO
ALTER TABLE [dbo].[Works_for] CHECK CONSTRAINT [FK_Works_for_Employee]
GO
ALTER TABLE [dbo].[Works_for]  WITH CHECK ADD  CONSTRAINT [FK_Works_for_Project] FOREIGN KEY([Pno])
REFERENCES [dbo].[Project] ([Pnumber])
GO
ALTER TABLE [dbo].[Works_for] CHECK CONSTRAINT [FK_Works_for_Project]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Manager Relation' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Departments', @level2type=N'CONSTRAINT',@level2name=N'FK_Departments_Employee'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Work Relation' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'CONSTRAINT',@level2name=N'FK_Employee_Departments'
GO
