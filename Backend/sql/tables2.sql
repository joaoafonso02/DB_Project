CREATE TABLE [Alarm]
(
 [id]          int IDENTITY (1, 1) NOT NULL ,
 [name]        varchar(50) NOT NULL ,
 [description] varchar(50) NOT NULL ,


 CONSTRAINT [PK_1] PRIMARY KEY CLUSTERED ([id] ASC)
);


CREATE TABLE [Insurance]
(
 [id]          int IDENTITY (1, 1) NOT NULL ,
 [description] varchar(50) NOT NULL ,
 [validity]    datetime NOT NULL ,
 [price]       money NOT NULL ,


 CONSTRAINT [PK_2] PRIMARY KEY CLUSTERED ([id] ASC)
);


CREATE TABLE [Supplier]
(
 [nif]     varchar(50) NOT NULL ,
 [name]    varchar(50) NOT NULL ,
 [phone]   varchar(20) NOT NULL ,
 [email]   varchar(50) NOT NULL ,
 [address] varchar(50) NOT NULL ,


 CONSTRAINT [PK_3] PRIMARY KEY CLUSTERED ([nif] ASC)
);


CREATE TABLE [Product]
(
 [id]           int IDENTITY (1, 1) NOT NULL ,
 [battery]      real NOT NULL ,
 [availability_status]       varchar(50) NOT NULL ,
 [loc_lat]      real NOT NULL ,
 [loc_long]     real NOT NULL ,
 [alarm]        int NOT NULL ,
 [insurance]    int NOT NULL ,
 [Supplier_nif] varchar(50) NOT NULL ,


 CONSTRAINT [PK_4] PRIMARY KEY CLUSTERED ([id] ASC),
 CONSTRAINT [FK_10] FOREIGN KEY ([insurance])  REFERENCES [Insurance]([id]),
 CONSTRAINT [FK_11] FOREIGN KEY ([Supplier_nif])  REFERENCES [Supplier]([nif]),
 CONSTRAINT [FK_9] FOREIGN KEY ([alarm])  REFERENCES [Alarm]([id])
);



CREATE NONCLUSTERED INDEX [FK_1] ON [Product] 
 (
  [alarm] ASC
 )



CREATE NONCLUSTERED INDEX [FK_2] ON [Product] 
 (
  [insurance] ASC
 )



CREATE NONCLUSTERED INDEX [FK_3] ON [Product] 
 (
  [Supplier_nif] ASC
 )



CREATE TABLE [Payment]
(
 [id]       int IDENTITY (1, 1) NOT NULL ,
 [total]    money NOT NULL ,
 [pay_date] datetime NOT NULL ,


 CONSTRAINT [PK_5] PRIMARY KEY CLUSTERED ([id] ASC)
);


CREATE TABLE [Users]
(
 [id]        int IDENTITY (1, 1) NOT NULL ,
 [name]      varchar(50) NULL ,
 [phone]     varchar(20) NULL ,
 [email]     varchar(50) NOT NULL ,
 [postalZip] varchar(50) NULL ,
 [region]    varchar(50) NULL ,
 [country]   varchar(50) NULL ,


 CONSTRAINT [PK_6] PRIMARY KEY CLUSTERED ([id] ASC)
);


CREATE TABLE [UAuthentication]
(
 [id]       int NOT NULL ,
 [username] varchar(50) NOT NULL ,
 [upass]    varchar(50) NOT NULL ,
 [utoken]   varchar(50) NULL ,


 CONSTRAINT [PK_7] PRIMARY KEY CLUSTERED ([id] ASC),
 CONSTRAINT [FK_1] FOREIGN KEY ([id])  REFERENCES [Users]([id])
);



CREATE NONCLUSTERED INDEX [FK_1] ON [UAuthentication] 
 (
  [id] ASC
 )



CREATE TABLE [Orders]
(
 [id]      int IDENTITY (1, 1) NOT NULL ,
 [user_id]    int NOT NULL ,
 [payment] int NOT NULL ,
 [product] int NOT NULL ,


 CONSTRAINT [PK_8] PRIMARY KEY CLUSTERED ([id] ASC),
 CONSTRAINT [FK_6] FOREIGN KEY ([user_id])  REFERENCES [Users]([id]),
 CONSTRAINT [FK_7] FOREIGN KEY ([payment])  REFERENCES [Payment]([id]),
 CONSTRAINT [FK_8] FOREIGN KEY ([product])  REFERENCES [Product]([id])
);



CREATE NONCLUSTERED INDEX [FK_1] ON [Orders] 
 (
  [user_id] ASC
 )



CREATE NONCLUSTERED INDEX [FK_2] ON [Orders] 
 (
  [payment] ASC
 )



CREATE NONCLUSTERED INDEX [FK_3] ON [Orders] 
 (
  [product] ASC
 )



CREATE TABLE [TGroups]
(
 [id]   int IDENTITY (1, 1) NOT NULL ,
 [gname] varchar(50) NULL ,


 CONSTRAINT [PK_9] PRIMARY KEY CLUSTERED ([id] ASC)
);


CREATE TABLE [TGroupMembers]
(
 [user_id]  int NOT NULL ,
 [group_id] int NOT NULL ,


 CONSTRAINT [PK_10] PRIMARY KEY CLUSTERED ([user_id] ASC, [group_id] ASC),
 CONSTRAINT [FK_2] FOREIGN KEY ([user_id])  REFERENCES [Users]([id]),
 CONSTRAINT [FK_3] FOREIGN KEY ([group_id])  REFERENCES [TGroups]([id]) ON DELETE CASCADE
);



CREATE NONCLUSTERED INDEX [FK_1] ON [TGroupMembers] 
 (
  [user_id] ASC
 )



CREATE NONCLUSTERED INDEX [FK_2] ON [TGroupMembers] 
 (
  [group_id] ASC
 )



CREATE TABLE [Messages]
(
 [id]        int IDENTITY (0, 1) NOT NULL ,
 [msg]       varchar(256) NOT NULL ,
 [sent_date] datetime DEFAULT GETDATE(),
 [user_id]   int NOT NULL ,
 [group_id]  int NOT NULL ,


 CONSTRAINT [PK_11] PRIMARY KEY CLUSTERED ([id] ASC),
 CONSTRAINT [FK_4] FOREIGN KEY ([user_id])  REFERENCES [Users]([id]),
 CONSTRAINT [FK_5] FOREIGN KEY ([group_id])  REFERENCES [TGroups]([id]) ON DELETE CASCADE
);



CREATE NONCLUSTERED INDEX [FK_1] ON [Messages] 
 (
  [user_id] ASC 
 )



CREATE NONCLUSTERED INDEX [FK_2] ON [Messages] 
 (
  [group_id] ASC
 )

