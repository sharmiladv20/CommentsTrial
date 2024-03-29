USE [master]
GO
/****** Object:  Database [CommentSystem]    Script Date: 11/28/2019 12:02:39 AM ******/
CREATE DATABASE [CommentSystem]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'CommentSystem', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\CommentSystem.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'CommentSystem_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\CommentSystem_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [CommentSystem] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [CommentSystem].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [CommentSystem] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [CommentSystem] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [CommentSystem] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [CommentSystem] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [CommentSystem] SET ARITHABORT OFF 
GO
ALTER DATABASE [CommentSystem] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [CommentSystem] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [CommentSystem] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [CommentSystem] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [CommentSystem] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [CommentSystem] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [CommentSystem] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [CommentSystem] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [CommentSystem] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [CommentSystem] SET  ENABLE_BROKER 
GO
ALTER DATABASE [CommentSystem] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [CommentSystem] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [CommentSystem] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [CommentSystem] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [CommentSystem] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [CommentSystem] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [CommentSystem] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [CommentSystem] SET RECOVERY FULL 
GO
ALTER DATABASE [CommentSystem] SET  MULTI_USER 
GO
ALTER DATABASE [CommentSystem] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [CommentSystem] SET DB_CHAINING OFF 
GO
ALTER DATABASE [CommentSystem] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [CommentSystem] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [CommentSystem] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'CommentSystem', N'ON'
GO
ALTER DATABASE [CommentSystem] SET QUERY_STORE = OFF
GO
USE [CommentSystem]
GO
/****** Object:  Table [dbo].[tblChildComment]    Script Date: 11/28/2019 12:02:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblChildComment](
	[CommentID] [int] IDENTITY(1,1) NOT NULL,
	[Username] [varchar](50) NULL,
	[CommentMessage] [varchar](300) NULL,
	[CommentDate] [date] NULL,
	[ParentCommentID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[CommentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblParentComment]    Script Date: 11/28/2019 12:02:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblParentComment](
	[CommentID] [int] IDENTITY(1,1) NOT NULL,
	[Username] [varchar](50) NULL,
	[CommentMessage] [varchar](300) NULL,
	[CommentDate] [date] NULL,
	[PostID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[CommentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblPosts]    Script Date: 11/28/2019 12:02:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblPosts](
	[PostID] [int] IDENTITY(1,1) NOT NULL,
	[Message] [varchar](50) NULL,
	[PostedDate] [datetime] NULL,
 CONSTRAINT [PK_Posts] PRIMARY KEY CLUSTERED 
(
	[PostID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblUser]    Script Date: 11/28/2019 12:02:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblUser](
	[Username] [varchar](50) NOT NULL,
	[Password] [varchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[Username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tblChildComment]  WITH CHECK ADD FOREIGN KEY([ParentCommentID])
REFERENCES [dbo].[tblParentComment] ([CommentID])
GO
ALTER TABLE [dbo].[tblChildComment]  WITH CHECK ADD FOREIGN KEY([Username])
REFERENCES [dbo].[tblUser] ([Username])
GO
ALTER TABLE [dbo].[tblParentComment]  WITH CHECK ADD FOREIGN KEY([Username])
REFERENCES [dbo].[tblUser] ([Username])
GO
ALTER TABLE [dbo].[tblParentComment]  WITH CHECK ADD  CONSTRAINT [FK_tblParentComment_tblPosts] FOREIGN KEY([PostID])
REFERENCES [dbo].[tblPosts] ([PostID])
GO
ALTER TABLE [dbo].[tblParentComment] CHECK CONSTRAINT [FK_tblParentComment_tblPosts]
GO
ALTER TABLE [dbo].[tblPosts]  WITH CHECK ADD  CONSTRAINT [FK_tblPosts_tblPosts] FOREIGN KEY([PostID])
REFERENCES [dbo].[tblPosts] ([PostID])
GO
ALTER TABLE [dbo].[tblPosts] CHECK CONSTRAINT [FK_tblPosts_tblPosts]
GO
/****** Object:  StoredProcedure [dbo].[spCheckUserCredentials]    Script Date: 11/28/2019 12:02:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[spCheckUserCredentials](@Username varchar(50), @Password varchar(20))
As
Begin 
select * from tblUser where Username = @Username and Password = @Password
End
GO
/****** Object:  StoredProcedure [dbo].[spCommentInsert]    Script Date: 11/28/2019 12:02:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[spCommentInsert](@Username varchar(50), @CommentMessage varchar(300))
As
Begin 
Insert into tblParentComment (Username, CommentMessage, CommentDate) values (@Username, @CommentMessage, GETDATE())
End
GO
/****** Object:  StoredProcedure [dbo].[spCommentUpdate]    Script Date: 11/28/2019 12:02:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[spCommentUpdate](@CommentID int, @Username varchar(50), @CommentMessage varchar(300))
As
Begin 
Update tblParentComment set @CommentMessage= @CommentMessage where CommentID= @CommentID and Username = @Username
End
GO
/****** Object:  StoredProcedure [dbo].[spGetChildCommentByParentCommentID]    Script Date: 11/28/2019 12:02:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[spGetChildCommentByParentCommentID](@ParentCommentID int)
As
Begin
select * from tblChildComment where ParentCommentID= @ParentCommentID
End
GO
/****** Object:  StoredProcedure [dbo].[spGetParentComment]    Script Date: 11/28/2019 12:02:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[spGetParentComment]
As
Begin
select * from tblParentComment
End
GO
/****** Object:  StoredProcedure [dbo].[spGetParentCommentByUserName]    Script Date: 11/28/2019 12:02:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[spGetParentCommentByUserName](@Username varchar(50))
As
Begin
select * from tblParentComment where Username= @Username
End
GO
/****** Object:  StoredProcedure [dbo].[spReplyInsert]    Script Date: 11/28/2019 12:02:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[spReplyInsert]( @Username varchar(50), @CommentMessage varchar(300), @ParentCommentID int)
As
Begin 
Insert into tblChildComment ( Username, CommentMessage, CommentDate, ParentCommentID) 
values (@Username , @CommentMessage, GETDATE(), @ParentCommentID)
End
GO
USE [master]
GO
ALTER DATABASE [CommentSystem] SET  READ_WRITE 
GO
