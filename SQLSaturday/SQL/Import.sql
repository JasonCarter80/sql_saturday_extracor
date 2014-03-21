/**  EVENTS  **/

MERGE INTO Events T
USING (
select 
	EventId = @EventId,
	Name = evt.value('name[1]', 'varchar(100)'),
	StartDate = evt.value('startDate[1]', 'datetime'),
	TimeZone = evt.value('timezone[1]', 'varchar(100)'),
	Description = evt.value('description[1]', 'varchar(200)'),
	TwitterHashtag = evt.value('twitterHashtag[1]', 'varchar(100)')
from @x.nodes('GuidebookXML/guide') AS x(evt)
) as S on T.id=S.EventId
WHEN MATCHED THEN UPDATE
	SET Name = ISNULL(S.Name, T.Name),
	StartDate = ISNULL(S.StartDate, T.StartDate),
	TimeZone = ISNULL(S.TimeZone, T.TimeZone),
	Description = ISNULL(S.Description, T.Description),
	TwitterHashTag = ISNULL(S.TwitterHashTag, T.TwitterHashTag)
WHEN NOT MATCHED THEN INSERT (Id, Name, StartDate, TimeZone, Description, TwitterHashTag)
values(S.EventId, S.Name, S.StartDate, S.TimeZone, S.Description, S.TwitterHashTag);

/*** Venues ***/

MERGE INTO Venues T
USING (
select 
	EventId = @EventId,
	Name = evt.value('name[1]', 'varchar(100)'),
	Street = evt.value('street[1]', 'varchar(100)'),
	City = evt.value('city[1]', 'varchar(100)'),
	State = evt.value('state[1]', 'varchar(100)'),
	ZipCode = evt.value('zipcode[1]', 'varchar(15)')
from @x.nodes('GuidebookXML/guide/venue') AS x(evt)
) as S on T.EventId=S.EventId
WHEN MATCHED THEN UPDATE
	SET Name = ISNULL(S.Name, T.Name),
	Street = ISNULL(S.Street, T.Street),
	City = ISNULL(S.City, T.City),
	State = ISNULL(S.State, T.State),
	ZipCode = ISNULL(S.ZipCode, T.ZipCode)
WHEN NOT MATCHED THEN INSERT (EventId, Name, Street, City, State, ZipCode)
Values (S.EventId, S.Name, S.Street, S.City, S.State, S.ZipCode);


/**  Sponsors  **/
MERGE INTO Sponsors T
USING (
select 
	EventId = @EventId,
	Name = evt.value('name[1]', 'varchar(100)'),
	importId = evt.value('importID[1]', 'int'),
	Level = evt.value('label[1]', 'varchar(30)'),
	Url = evt.value('url[1]', 'varchar(200)'),
	ImageUrl = evt.value('imageURL[1]', 'varchar(500)'),
	ImageHeight = evt.value('imageHeight[1]', 'smallint'),
	ImageWidth = evt.value('imageWidth[1]', 'smallint')
from @x.nodes('GuidebookXML/sponsors/sponsor') AS x(evt)
) as S on T.EventId=S.EventId and T.ImportId=S.ImportId
WHEN MATCHED THEN UPDATE
	Set Name = ISNULL(S.Name, T.Name),
	Level = ISNULL(S.Level, T.Level),
	Url = ISNULL(S.Url, T.Url),
	ImageUrl = ISNULL(S.Url, T.Url),
	ImageHeight = ISNULL(S.ImageHeight, T.ImageHeight),
	ImageWidth = ISNULL(S.ImageWidth, T.ImageWidth)
WHEN NOT MATCHED THEN INSERT (EventId, Name, ImportId, Level, Url, ImageUrl, ImageHeight, ImageWidth)
values(S.EventId, S.Name, S.ImportId, S.Level, S.Url, S.ImageUrl, S.ImageHeight, S.ImageWidth);

/*** SPEAKERS ***/
MERGE INTO SPEAKERS T
USING (
select 
	EventId = @EventId,
	Name = evt.value('name[1]', 'varchar(100)'),
	importId = evt.value('importID[1]', 'int'),
	Label = evt.value('label[1]', 'varchar(100)'),
	Description = evt.value('description[1]', 'varchar(1000)'),
	Twitter = evt.value('twitter[1]','varchar(100)'),
	LinkedIn = evt.value('linkedin[1]', 'varchar(200)'),
	contactUrl = evt.value('contactURL[1]', 'varchar(1000)'),
	ImageUrl = evt.value('imageURL[1]', 'varchar(1000)'),
	ImageHeight = evt.value('imageHeight[1]', 'smallint'),
	ImageWidth = evt.value('imageWidth[1]', 'smallint')
from @x.nodes('GuidebookXML/speakers/speaker') AS x(evt)
) as S on T.EventId=S.EventId and T.ImportId=S.ImportId
WHEN MATCHED THEN UPDATE
	SET Name = ISNULL(S.Name, T.Name),
	Label = ISNULL(S.Label, T.Label),
	Description = ISNULL(S.Description, T.Description),
	Twitter = ISNULL(S.Twitter, T.Twitter),
	LinkedIn = ISNULL(S.LinkedIn, T.LinkedIn),
	ContactUrl = ISNULL(S.ContactUrl, T.ContactUrl),
	ImageUrl = ISNULL(S.ImageUrl, T.ImageUrl),
	ImageWidth = ISNULL(S.ImageWidth, T.ImageWidth),
	ImageHeight = ISNULL(S.ImageHeight, T.ImageHeight)

WHEN NOT MATCHED THEN INSERT (EventId, Name, ImportId, Label, Description, Twitter, LinkedIn, ContactUrl, ImageUrl, ImageHeight, ImageWidth)
values(S.EventId, S.Name, S.ImportId, S.Label, S.Description, S.Twitter, S.LinkedIn, S.ContactUrl, S.ImageUrl, S.ImageHeight, S.ImageWidth);

/***  Sessions ***/
MERGE INTO Sessions T
USING (
select 
	EventId = @EventId,
	importId = evt.value('importID[1]', 'int'),
	Name = evt.value('(speakers/speaker/name)[1]', 'varchar(100)'),
	Track = evt.value('track[1]', 'varchar(100)'),
	Location = evt.value('(location/name)[1]','varchar(100)'),
	Title = evt.value('title[1]', 'varchar(200)'),
	Description = evt.value('description[1]', 'varchar(1000)'),
	StartTime = evt.value('startTime[1]','datetime'),
	EndTime = evt.value('endTime[1]', 'datetime')
from @x.nodes('GuidebookXML/events/event') AS x(evt)
) as S on S.EventId=T.EventId and S.ImportId=T.ImportId and S.Location=T.Location and S.StartTime = T.StartTime
WHEN MATCHED THEN UPDATE
SET	Name = ISNULL(S.Name, T.Name),
	Track = ISNULL(S.Track, T.Track),
	Location = ISNULL(S.Location, T.Location),
	Title = ISNULL(S.Title, T.Title),
	Description = ISNULL(S.Description, T.Description),
	StartTime = ISNULL(S.StartTime, T.StartTime),
	EndTime = ISNULL(S.EndTime, T.EndTime)
WHEN NOT MATCHED THEN INSERT (EventId, ImportId, Name, Track, Location, Title, Description, StartTime, EndTime)
values (S.EventId, S.ImportId, S.Name, S.Track, S.Location, S.Title, S.Description, S.StartTime, S.EndTime);
