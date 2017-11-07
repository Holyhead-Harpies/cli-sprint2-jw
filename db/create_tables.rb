require 'sqlite3'

db = SQLite3::Database.new('./db/test.sqlite')
begin
    db.transaction
    db.execute("CREATE TABLE `Customers` (
    `CustomerId`    INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    `Name`    TEXT NOT NULL,
    `Street_Address`    TEXT NOT NULL,
    `City`    TEXT NOT NULL,
    `State`    TEXT NOT NULL,
    `ZIP`    TEXT NOT NULL,
    `Phone`    TEXT NOT NULL,
    `created_at`  datetime NOT NULL,
    `updated_at`  datetime NOT NULL
    ); ")
    db.execute("CREATE TABLE `Products` (
    `ProductId` INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    `OwnerId` INTEGER NOT NULL,
    `Title` TEXT NOT NULL,
    `Description` TEXT NOT NULL,
    `Price` NUMERIC NOT NULL,
    `Quantity` INTEGER NOT NULL,
    `created_at`  datetime NOT NULL,
    `updated_at`  datetime NOT NULL,
    foreign key (`OwnerId`) references Customers (CustomerId)
    );")
    db.execute("CREATE TABLE `PaymentTypes` (
    `PaymentTypeId`    INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    `CustomerId`    INTEGER NOT NULL,
    `Card_Name`    TEXT NOT NULL,
    `Card_Number`    TEXT NOT NULL,
    `created_at`    datetime NOT NULL,
    `updated_at`    datetime NOT NULL,
    foreign key (`CustomerId`) references Customers (`CustomerId`)
    );")

    db.execute("CREATE TABLE `Orders` (
    `OrderId` INTEGER NOT NULL PRIMARY KEY autoincrement,
    `CustomerId` integer not null,
    `PaymentTypeId` integer not null,
    `Completed` BOOLEAN not null,
    `created_at`    datetime NOT NULL,
    `updated_at`    datetime NOT NULL,
    foreign key (`CustomerId`) references Customers (CustomerId),
    foreign key (`PaymentTypeId`) references PaymentTypes (PaymentTypeId)
    );")

    db.execute("create table OrdersProducts (
    OrderProductId integer not null primary key autoincrement,
    OrderId integer not null,
    ProductId integer not null,
    `created_at`    datetime NOT NULL,
    `updated_at`    datetime NOT NULL,
    foreign key (OrderId) references Orders (OrderId),
    foreign key (ProductId) references Products (ProductId)
    );")
    db.commit
    db.close
rescue SQLite3::Exception => e
    p e.message
    db.rollback
else
    
ensure
    
end