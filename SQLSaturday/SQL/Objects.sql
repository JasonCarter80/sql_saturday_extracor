IF EXISTS(select 1 from sys.tables where name = 'Events')
	DROP TABLE [dbo].[Events]

IF EXISTS(select 1 from sys.tables where name = 'Sessions')
	DROP TABLE [dbo].[Sessions]

IF EXISTS(select 1 from sys.tables where name = 'Speakers')
	DROP TABLE [dbo].[Speakers]

IF EXISTS(select 1 from sys.tables where name = 'Sponsors')
	DROP TABLE [dbo].[Sponsors]

IF EXISTS(select 1 from sys.tables where name = 'Venues')
	DROP TABLE [dbo].[Venues]


CREATE TABLE [dbo].[Events](
	[id] [smallint] NOT NULL,
	[Name] [varchar](100) NULL,
	[StartDate] [datetime] NULL,
	[TimeZone] [varchar](100) NULL,
	[Description] [varchar](1000) NULL,
	[TwitterHashTag] [varchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]


CREATE TABLE [dbo].[Sessions](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[eventId] [int] NOT NULL,
	[importId] [int] NOT NULL,
	[Track] [varchar](100) NULL,
	[Title] [varchar](100) NULL,
	[Description] [varchar](4000) NULL,
	[startTime] [datetime] NULL,
	[endTime] [datetime] NULL,
	[Location] [varchar](100) NULL,
	[Name] [varchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]


CREATE TABLE [dbo].[Speakers](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[eventId] [smallint] NOT NULL,
	[importId] [int] NOT NULL,
	[Name] [varchar](100) NULL,
	[Label] [varchar](100) NULL,
	[Description] [varchar](1000) NULL,
	[Twitter] [varchar](100) NULL,
	[LinkedIN] [varchar](200) NULL,
	[ContactURL] [varchar](1000) NULL,
	[ImageUrl] [varchar](1000) NULL,
	[ImageWidth] [int] NULL,
	[ImageHeight] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

CREATE TABLE [dbo].[Sponsors](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[eventId] [int] NOT NULL,
	[importId] [int] NOT NULL,
	[Name] [varchar](100) NULL,
	[Level] [varchar](30) NULL,
	[Url] [varchar](200) NULL,
	[imageUrl] [varchar](500) NULL,
	[imageHeight] [smallint] NULL,
	[imageWidth] [smallint] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]


CREATE TABLE [dbo].[Venues](
	[id] [smallint] IDENTITY(1,1) NOT NULL,
	[eventId] [smallint] NOT NULL,
	[Name] [varchar](100) NULL,
	[Street] [varchar](100) NULL,
	[City] [varchar](100) NULL,
	[State] [varchar](100) NULL,
	[ZipCode] [varchar](15) NULL,
 CONSTRAINT [PK__Venue__3213E83FFA7555BA] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]




