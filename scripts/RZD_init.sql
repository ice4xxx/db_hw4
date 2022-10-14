CREATE schema rzd;

CREATE TABLE IF NOT EXISTS rzd.City
(
    Region TEXT,
    Name   TEXT,
    PRIMARY KEY (Region, Name)
);

CREATE TABLE IF NOT EXISTS rzd.Station
(
    Name     TEXT,
    Region   TEXT,
    CityName TEXT,
    Tracks   INT UNIQUE NOT NULL,
    PRIMARY KEY (Name),
    CONSTRAINT fk_city
        FOREIGN KEY (Region, CityName)
            REFERENCES rzd.City (Region, Name)
);

CREATE TABLE IF NOT EXISTS rzd.Train
(
    TrainNr          INT,
    StartStationName TEXT,
    EndStationName   TEXT,
    Length           INT NOT NULL,
    PRIMARY KEY (TrainNr),
    CONSTRAINT fk_start_station
        FOREIGN KEY (StartStationName)
            REFERENCES rzd.Station (Name),
    CONSTRAINT fk_end_station
        FOREIGN KEY (EndStationName)
            REFERENCES rzd.Station (Name)
);

CREATE TABLE IF NOT EXISTS rzd.Connection
(
    "From"    TEXT,
    "To"      TEXT,
    TrainNr   INT,
    Arrival   TIMESTAMP NOT NULL,
    Departure TIMESTAMP NOT NULL,
    PRIMARY KEY ("From", "To", TrainNr),
    CONSTRAINT fk_from_station
        FOREIGN KEY ("From")
            REFERENCES rzd.Station (Name),
    CONSTRAINT fk_to_station
        FOREIGN KEY ("To")
            REFERENCES rzd.Station (Name),
    CONSTRAINT fk_train
        FOREIGN KEY (TrainNr)
            REFERENCES rzd.Train (TrainNr)
);