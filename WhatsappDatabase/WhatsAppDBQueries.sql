/*Status Table*/
DROP TABLE  IF EXISTS WhatsAppD.dbo.Status
CREATE TABLE Status
(
Status_ID int  IDENTITY (1,1) PRIMARY KEY,
Status_Content  text NULL,
);

INSERT INTO Status (Status_Content) VALUES( 'This life is beautiful'),
( 'May the soles of our feet be blessed today,Amen!'),
( 'The seeds of beauty are in humility.'),
('Everything has beauty, but not everyone sees it'),
('Beauty begins the moment you decide to be yourself. Coco Chanel'),
('It’s just a bad day. Not a bad life.'),
('Whenever you are creating beauty around you, you are restoring your own soul. Alice Walker');
SELECT * FROM Status;

/*Users Table*/
DROP TABLE  IF EXISTS WhatsappD.dbo.Users
CREATE TABLE Users
(
UserID int IDENTITY(1,1) PRIMARY KEY,
UserName varchar(50) NULL,
Phone varchar(50) NULL,
Picture image,
About text NULL,
Status_ID int NOT NULL,
CONSTRAINT FK_Users_Status FOREIGN KEY (Status_ID)
REFERENCES Status (Status_ID)
ON DELETE CASCADE
ON UPDATE CASCADE

);


INSERT INTO Users (UserName,Phone,Picture,About,Status_ID) VALUES('BlackHeart','070-321-345-12','you.jpg','Life Goes On','2'),
('Manizo','070-301-340-12','a.jpg','Life in a year','2'),('Alice','080-901-340-11','b.jpg','This is a wonderful day','3'),
('Charlie','080-801-340-18','c.jpg','The roots of beauty are love and kindness','4'),
('Chuks','080-801-240-68','d.jpg','Smile, breathe and go slowly','4'),
('Promise','080-801-240-68','e.jpg','If you see someone without a smile give them one of yours','5'),
('Peter','080-601-640-60','f.jpg','If you see someone without a smile give them one of yours','6');

SELECT * FROM Users;



/*Group Table*/

DROP TABLE  IF EXISTS WhatsappD.dbo.Groups
CREATE TABLE Groups
(
GroupID int IDENTITY(1,1) PRIMARY KEY,
GroupName varchar(50) NOT NULL,
NoOfUsers int  NULL,
Description text NULL,
Created date NULL,
MessageID int NOT NULL,

);
/* To avoid conflict problems, you can insert your data first,before adding your foreign keys ie MessageID, unless the the table that has message has problem key already exist
and has been populated*/
ALTER TABLE Groups
ADD CONSTRAINT FK_Groups_Messages FOREIGN KEY (MessageID)
REFERENCES Messages (MessageID)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

INSERT INTO Groups (GroupName,NoOfUsers,Description,Created,MessageID) VALUES('Family&Friends','12','This is a  whatsapp group that is solely for family and friends,here we share one another"s problems, and till catch fun.','01-01-2023','1');
INSERT INTO Groups (GroupName,NoOfUsers,Description,Created,MessageID) VALUES('HealthyLifeStyle','30','This is a  whatsapp group that gives good information on how to live a healthy life style.','01-20-2023','2');
SELECT * FROM Groups;

/*Users_Group Table*/

DROP TABLE  IF EXISTS WhatsappD.dbo.Users_group
CREATE TABLE Users_group
(
ID int  IDENTITY(1,1) PRIMARY KEY NOT NULL,
userID int  NOT NULL,
GroupID int NOT NULL
CONSTRAINT FK_Users_group_Users FOREIGN KEY  (userID)
REFERENCES Users (UserID)
ON DELETE CASCADE
ON UPDATE CASCADE,
CONSTRAINT FK_Users_group_Group FOREIGN KEY  (GroupID)
REFERENCES Groups (GroupID)
ON DELETE CASCADE
ON UPDATE CASCADE
);

INSERT INTO Users_group(userID,GroupID) VALUES (1,1);
INSERT INTO Users_group(userID,GroupID) VALUES (2,1);
INSERT INTO Users_group(userID,GroupID) VALUES (2,2);
INSERT INTO Users_group(userID,GroupID) VALUES (3,2);
INSERT INTO Users_group(userID,GroupID) VALUES (4,2);
INSERT INTO Users_group(userID,GroupID) VALUES (5,1);
INSERT INTO Users_group(userID,GroupID) VALUES (6,2);
INSERT INTO Users_group(userID,GroupID) VALUES (7,1);
INSERT INTO Users_group(userID,GroupID) VALUES (5,2);
SELECT * FROM Users_group;


/*Chats Table*/
DROP TABLE  IF EXISTS WhatsappD.dbo.Chats
CREATE TABLE Chats
(
ID int  PRIMARY KEY NOT NULL,
MessageID int NOT NULL,

);
ALTER TABLE Chats
ADD CONSTRAINT FK_Chats_Messages FOREIGN KEY  (MessageID)
REFERENCES Messages (MessageID)
ON DELETE NO ACTION
ON UPDATE NO ACTION
ALTER TABLE Chats
Drop Constraint FK_Chats_Messages
/*DELETE FROM Chats WHERE MessageID = 18*/
INSERT INTO Chats(ID,MessageID) VALUES (1,1);
INSERT INTO Chats(ID,MessageID) VALUES (2,2);
INSERT INTO Chats(ID,MessageID) VALUES (3,2);
INSERT INTO Chats(ID,MessageID) VALUES (4,2);
INSERT INTO Chats(ID,MessageID) VALUES (5,4);
INSERT INTO Chats(ID,MessageID) VALUES (6,5);
INSERT INTO Chats(ID,MessageID) VALUES (7,2);
INSERT INTO Chats(ID,MessageID) VALUES (8,4);
INSERT INTO Chats(ID,MessageID) VALUES (9,7);

SELECT * FROM Chats;

/*Users_Chats Table*/

DROP TABLE  IF EXISTS WhatsappD.dbo.Users_Chats
CREATE TABLE Users_Chats
(
ID int IDENTITY(1,1) PRIMARY KEY,
OwnerID INT NOT NULL,
ChatID int NOT NULL,
CONSTRAINT FK_Users_Chats_Chats FOREIGN KEY (ChatID)
REFERENCES Chats (ID)
ON DELETE NO ACTION
ON UPDATE NO ACTION,

CONSTRAINT FK_Users_Chat_Users FOREIGN KEY (OwnerID)
REFERENCES Users (UserID)
ON DELETE NO ACTION
ON UPDATE NO ACTION
);

INSERT INTO Users_Chats(OwnerID,ChatID) VALUES (1,1);
INSERT INTO Users_Chats(OwnerID,ChatID) VALUES (2,1);
INSERT INTO Users_Chats(OwnerID,ChatID) VALUES (3,1);
INSERT INTO Users_Chats(OwnerID,ChatID) VALUES (4,1);
INSERT INTO Users_Chats(OwnerID,ChatID) VALUES (5,1);
INSERT INTO Users_Chats(OwnerID,ChatID) VALUES (6,1);
INSERT INTO Users_Chats(OwnerID,ChatID) VALUES (7,1);


SELECT * FROM Users_Chats;



/*Messages Table*/

DROP TABLE  IF EXISTS WhatsappD.dbo.Messages
CREATE TABLE Messages
(
MessageID  INT IDENTITY(1,1) PRIMARY KEY NOT NULL ,
GroupID int NOT NULL,
Created_At  DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
Content text NOT NULL,
UserID int NOT NULL,
ChatID int NOT NULL,
CONSTRAINT FK_Messages_Users FOREIGN KEY  (UserID)
REFERENCES Users (UserID)
ON DELETE NO ACTION
ON UPDATE NO ACTION,
CONSTRAINT FK_Messages_Users_Chats FOREIGN KEY (ChatID)
REFERENCES Chats (ID)
ON DELETE CASCADE
ON UPDATE CASCADE,

CONSTRAINT FK_Messages_Group FOREIGN KEY  (GroupID)
REFERENCES Groups (GroupID)
ON DELETE CASCADE
ON UPDATE CASCADE
);
DELETE FROM Messages WHERE MessageID = 12
DBCC CHECKIDENT('Messages',RESEED);
SELECT * FROM Messages
INSERT INTO Messages(GroupID,Content,UserID,ChatID)
VALUES

('2','All good. Working a lot. And you?',4,4),
('1',' Good morning,Bob I have gone back to school.',5,1),
('2',' Good for you!,I am still at home',1,2),
('1',' What have you been up to?',4,3),
('2',' Working a lot.',3,4),
('1','Oh hey Alice, I didn’t see you there. Did you already get a table?',6,4),
('2','Yeah, right over here.',5,4),
('1','Hey, how did your interview go? Wasn’t that today?',1,4),
('1','Oh, yeah. I think it went well. I don’t know if I got the job yet, but they said they would call in a few days.',5,4),
('1',' How’s the family?.',7,4),
('1',' Everyone is good. Thanks!',6,6);

SELECT * FROM Messages


/*SentMessages Table*/

DROP TABLE  IF EXISTS WhatsappD.dbo.SentMessage
CREATE TABLE SentMessage
(
ID int IDENTITY(1,1) PRIMARY KEY,
MessageID int NOT NULL,
ReceiverID int NOT NULL,
TimeSent DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
CONSTRAINT FK_SentMessage_Messages FOREIGN KEY (MessageID)
REFERENCES Messages (MessageID)
ON DELETE CASCADE
ON UPDATE CASCADE
);


SELECT * FROM SentMessage;

INSERT INTO SentMessage(MessageID,ReceiverID) VALUES(2,2);
INSERT INTO SentMessage(MessageID,ReceiverID) VALUES(4,4);
INSERT INTO SentMessage(MessageID,ReceiverID) VALUES(6,1);
INSERT INTO SentMessage(MessageID,ReceiverID) VALUES(8,3);
INSERT INTO SentMessage(MessageID,ReceiverID) VALUES(10,5);
INSERT INTO SentMessage(MessageID,ReceiverID) VALUES(12,5);
INSERT INTO SentMessage(MessageID,ReceiverID) VALUES(14,6);

SELECT * FROM SentMessage;


/*ReceivedMessages Table*/
DROP TABLE  IF EXISTS WhatsappD.dbo.ReceivedMessages
CREATE TABLE ReceivedMessages
(
ID int IDENTITY(1,1) PRIMARY KEY NOT NULL,
MessageID int NOT NULL,
SenderID int NOT NULL,
TimeReceived DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
CONSTRAINT FK_ReceivedMessages_Messages FOREIGN KEY  (MessageID)
REFERENCES Messages (MessageID)
ON DELETE NO ACTION
ON UPDATE NO ACTION,
CONSTRAINT FK_ReceivedMessages_Users FOREIGN KEY (SenderID)
REFERENCES Users (UserID)
ON DELETE NO ACTION
ON UPDATE NO ACTION

);
/*ALTER TABLE ReceivedMessages
Add SID int NULL
ALTER TABLE ReceivedMessages
ADD CONSTRAINT FK_ReceivedMessages_SentMessage FOREIGN KEY(SID)
REFERENCES SentMessage(ID)
ON DELETE NO ACTION
ON UPDATE NO ACTION*/

ALTER TABLE ReceivedMessages
drop Constraint FK_ReceivedMessages_Messages
/*Update ReceivedMessages set SID =4 WHERE ID = 6;
DELETE FROM ReceivedMessages WHERE ID = 7*/
INSERT INTO ReceivedMessages(MessageID,SenderID) VALUES(1,1);
INSERT INTO ReceivedMessages(MessageID,SenderID) VALUES(3,3);
INSERT INTO ReceivedMessages(MessageID,SenderID) VALUES(5,5);
INSERT INTO ReceivedMessages(MessageID,SenderID) VALUES(7,4);
INSERT INTO ReceivedMessages(MessageID,SenderID) VALUES(9,6);
INSERT INTO ReceivedMessages(MessageID,SenderID) VALUES(11,1);
INSERT INTO ReceivedMessages(MessageID,SenderID) VALUES(13,7);

SELECT * FROM ReceivedMessages





 SELECT Users.UserName AS Sender,SentMessage.TimeSent, Messages.Content
FROM   dbo.Users  
INNER JOIN
             dbo.Messages ON dbo.Users.UserID = dbo.Messages.UserID
INNER JOIN
           
dbo.SentMessage ON Messages.MessageID  = dbo.SentMessage.MessageID


/*UNION ALL*/

 SELECT  Users.UserName AS Receiver,ReceivedMessages.TimeReceived, Messages.Content
FROM   dbo.Users  
INNER JOIN
             dbo.Messages ON dbo.Users.UserID = dbo.Messages.UserID
INNER JOIN
           
dbo.ReceivedMessages ON Messages.MessageID  = dbo.ReceivedMessages.MessageID



