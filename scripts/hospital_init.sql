CREATE SCHEMA IF NOT EXISTS hospital;

CREATE TABLE IF NOT EXISTS hospital.Station
(
    StatNr INT,
    Name   TEXT NOT NULL,
    PRIMARY KEY (StatNr)
);

CREATE TABLE IF NOT EXISTS hospital.Personell
(
    PersNr INT,
    StatNr INT,
    Name   TEXT UNIQUE NOT NULL,
    PRIMARY KEY (PersNr),
    CONSTRAINT fk_station
        FOREIGN KEY (StatNr)
            REFERENCES hospital.Station (StatNr)
);

CREATE TABLE IF NOT EXISTS hospital.Caregiver
(
    PersNr        INT,
    Qualification INT NOT NULL,
    PRIMARY KEY (PersNr),
    CONSTRAINT fk_personell
        FOREIGN KEY (PersNr)
            REFERENCES hospital.Personell (PersNr)
);

CREATE TABLE IF NOT EXISTS hospital.Doctor
(
    PersNr INT,
    Area   TEXT NOT NULL,
    Rank   INT  NOT NULL,
    PRIMARY KEY (PersNr),
    CONSTRAINT fk_personell
        FOREIGN KEY (PersNr)
            REFERENCES hospital.Personell (PersNr)
);

CREATE TABLE IF NOT EXISTS hospital.Patient
(
    PatientNr INT,
    PersNr    INT,
    Name      TEXT NOT NULL,
    Disease   TEXT NOT NULL,
    PRIMARY KEY (PatientNr),
    CONSTRAINT fk_person
        FOREIGN KEY (PersNr)
            REFERENCES hospital.Personell
);

CREATE TABLE IF NOT EXISTS hospital.StationRoom
(
    RoomNr INT,
    StatNr INT,
    Beds   INT UNIQUE NOT NULL,
    PRIMARY KEY (RoomNr),
    CONSTRAINT fk_station
        FOREIGN KEY (StatNr)
            REFERENCES hospital.Station (StatNr)
);

CREATE TABLE IF NOT EXISTS hospital.RoomAdmission
(
    Id        INT,
    StatNr    INT,
    RoomNr    INT,
    PatientNr INT,
    "From"    DATE NOT NULL,
    "To"      DATE NOT NULL,
    PRIMARY KEY (Id),
    CONSTRAINT fk_station
        FOREIGN KEY (StatNr)
            REFERENCES hospital.Station (StatNr),
    CONSTRAINT fk_room
        FOREIGN KEY (RoomNr)
            REFERENCES hospital.StationRoom(RoomNr),
    CONSTRAINT fk_patient
        FOREIGN KEY (PatientNr)
            REFERENCES hospital.Patient(PatientNr)
);