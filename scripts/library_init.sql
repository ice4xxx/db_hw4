CREATE SCHEMA IF NOT EXISTS library;

CREATE TABLE IF NOT EXISTS library.Publisher
(
    Id      UUID,
    Name    TEXT NOT NULL,
    Address TEXT NOT NULL,
    PRIMARY KEY (Id)
);

CREATE TABLE IF NOT EXISTS library.Book
(
    ISBN        INT,
    PublisherId UUID,
    Year        DATE NOT NULL,
    Name        TEXT NOT NULL,
    Author      TEXT NOT NULL,
    PagesCount  INT NOT NULL,
    PRIMARY KEY (ISBN),
    CONSTRAINT fk_publisher
        FOREIGN KEY (PublisherId)
            REFERENCES library.Publisher (Id)
);

CREATE TABLE IF NOT EXISTS library.Category
(
    Id   UUID,
    Name TEXT NOT NULL,
    PRIMARY KEY (Id)
);

CREATE TABLE IF NOT EXISTS library.BookCategory
(
    ISBN INT,
    CategoryId UUID,
    PRIMARY KEY (ISBN, CategoryId),
    CONSTRAINT fk_category
        FOREIGN KEY (CategoryId)
            REFERENCES library.Category (Id),
    CONSTRAINT fk_book
        FOREIGN KEY (ISBN)
            REFERENCES library.book (ISBN)
);

CREATE TABLE IF NOT EXISTS library.Reader
(
    Id        UUID,
    FirstName TEXT NOT NULL,
    LastName  TEXT NOT NULL,
    Address   TEXT NOT NULL,
    Birthday  date,
    PRIMARY KEY (Id)
);

CREATE TABLE IF NOT EXISTS library.Copy
(
    Id       UUID,
    ISBN     INT,
    Position INT NOT NULL,
    PRIMARY KEY (Id),
    CONSTRAINT fk_book
        FOREIGN KEY (ISBN)
            REFERENCES library.book (ISBN)
);

CREATE TABLE IF NOT EXISTS library.Rent
(
    Id         UUID,
    CopyId     UUID,
    ReaderId   UUID,
    ReturnDate DATE NOT NULL,
    PRIMARY KEY (Id),
    CONSTRAINT fk_copy
        FOREIGN KEY (CopyId)
            REFERENCES library.Copy (Id),
    CONSTRAINT fk_reader
        FOREIGN KEY (ReaderId)
            REFERENCES library.Reader (Id)
);