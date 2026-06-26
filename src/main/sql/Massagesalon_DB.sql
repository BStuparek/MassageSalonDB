CREATE TABLE IF NOT EXISTS Person (
    SVNr VARCHAR(10) PRIMARY KEY,
    Vorname VARCHAR(100) NOT NULL,
    Nachname VARCHAR(100) NOT NULL,
    PLZ VARCHAR(10) NOT NULL,
    Ort VARCHAR(100) NOT NULL,
    Straße VARCHAR(100) NOT NULL,
    Hausnummer VARCHAR(20) NOT NULL
    );
CREATE TABLE IF NOT EXISTS Bank (
    Bankleitzahl VARCHAR(10) PRIMARY KEY,
    Bankname VARCHAR(255) NOT NULL
    );

CREATE TABLE IF NOT EXISTS Massagetyp (
    MTypID VARCHAR(8) PRIMARY KEY,
    Beschreibung VARCHAR(255) NOT NULL,
    Dauer INT NOT NULL,
    Kosten DECIMAL(10, 2) NOT NULL
    );

CREATE TABLE IF NOT EXISTS Ort (
    Raumcodierung VARCHAR(7) PRIMARY KEY,
    Raumbeschreibung VARCHAR(255) NOT NULL
    );

CREATE TABLE IF NOT EXISTS Telefonnummern (
    SVNr VARCHAR(10),
    Telefonnummer VARCHAR(30),
    PRIMARY KEY (SVNr, Telefonnummer),
    FOREIGN KEY (SVNr) REFERENCES Person(SVNr) ON DELETE CASCADE
    );

CREATE TABLE IF NOT EXISTS Kunde (
    SVNr VARCHAR(10) PRIMARY KEY,
    Kundennummer INT UNIQUE NOT NULL,
    FOREIGN KEY (SVNr) REFERENCES Person(SVNr) ON DELETE CASCADE
    );

CREATE TABLE IF NOT EXISTS Angestellter_hat_Gehaltskonto (
    SVNr VARCHAR(10) PRIMARY KEY,
    Angestelltennummer INT UNIQUE NOT NULL,
    Kontonummer VARCHAR(20) NOT NULL,
    Bankleitzahl VARCHAR(10) NOT NULL,
    Kontostand DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (SVNr) REFERENCES Person(SVNr) ON DELETE CASCADE,
    FOREIGN KEY (Bankleitzahl) REFERENCES Bank(Bankleitzahl) ON DELETE RESTRICT
    );

CREATE TABLE IF NOT EXISTS Masseur (
    SV_Nummer VARCHAR(10) PRIMARY KEY,
    Lizenznummer INT UNIQUE NOT NULL,
    Ausbildungszeit INT NOT NULL,
    Qualifikation VARCHAR(255) NOT NULL,
    FOREIGN KEY (SV_Nummer) REFERENCES Angestellter_hat_Gehaltskonto(SVNr) ON DELETE CASCADE
    );

CREATE TABLE IF NOT EXISTS Sachbearbeiter (
    SV_Nummer VARCHAR(10) PRIMARY KEY,
    Einstellungsdatum DATE NOT NULL,
    FOREIGN KEY (SV_Nummer) REFERENCES Angestellter_hat_Gehaltskonto(SVNr) ON DELETE CASCADE
    );

CREATE TABLE IF NOT EXISTS Massage (
    MTypID VARCHAR(8),
    Tageszeit TIME,
    Raumcodierung VARCHAR(7),
    PRIMARY KEY (MTypID, Tageszeit, Raumcodierung),
    FOREIGN KEY (MTypID) REFERENCES Massagetyp(MTypID) ON DELETE CASCADE,
    FOREIGN KEY (Raumcodierung) REFERENCES Ort(Raumcodierung) ON DELETE RESTRICT
    );

CREATE TABLE IF NOT EXISTS koordinieren (
    MTypID VARCHAR(8),
    Tageszeit TIME,
    Raumcodierung VARCHAR(7),
    SV_Nummer_Sachbearbeiter VARCHAR(10),
    PRIMARY KEY (MTypID, Tageszeit, Raumcodierung),
    FOREIGN KEY (MTypID, Tageszeit, Raumcodierung) REFERENCES Massage(MTypID, Tageszeit, Raumcodierung) ON DELETE CASCADE,
    FOREIGN KEY (SV_Nummer_Sachbearbeiter) REFERENCES Sachbearbeiter(SV_Nummer) ON DELETE RESTRICT
    );

CREATE TABLE IF NOT EXISTS Kunde_für_Massage_bei_Masseur_vorgemerkt (
    MTypID VARCHAR(8),
    Tageszeit TIME,
    Raumcodierung VARCHAR(7),
    SVNr_Masseur VARCHAR(10),
    SVNr_Kunde VARCHAR(10),
    Datum DATE,
    PRIMARY KEY (MTypID, Tageszeit, Raumcodierung, SVNr_Masseur, SVNr_Kunde, Datum),
    FOREIGN KEY (MTypID, Tageszeit) REFERENCES Massage_mit_Sachbearbeiter_und_Raum(MTypID, Tageszeit) ON DELETE CASCADE,
    FOREIGN KEY (SVNr_Masseur) REFERENCES Masseur(SV_Nummer) ON DELETE CASCADE,
    FOREIGN KEY (SVNr_Kunde) REFERENCES Kunde(SVNr) ON DELETE CASCADE
    );

CREATE TABLE IF NOT EXISTS Buchtyp (
    ISBN VARCHAR(13) PRIMARY KEY,
    Titel VARCHAR(255) NOT NULL,
    Auflagejahr INT NOT NULL
    );

CREATE TABLE IF NOT EXISTS Voraussetzung (
    VoraussetzungISBN VARCHAR(13),
    Wird_Vorausgesetzt VARCHAR(13),
    PRIMARY KEY (VoraussetzungISBN, Wird_Vorausgesetzt),
    FOREIGN KEY (VoraussetzungISBN) REFERENCES Buchtyp(ISBN) ON DELETE CASCADE,
    FOREIGN KEY (Wird_Vorausgesetzt) REFERENCES Buchtyp(ISBN) ON DELETE CASCADE
    );

CREATE TABLE IF NOT EXISTS Buch (
    ISBN VARCHAR(13),
    Inventarnummer INT,
    entlehnt_von_SVNr VARCHAR(10),
    PRIMARY KEY (ISBN, Inventarnummer),
    FOREIGN KEY (ISBN) REFERENCES Buchtyp(ISBN) ON DELETE RESTRICT,
    FOREIGN KEY (entlehnt_von_SVNr) REFERENCES Angestellter_hat_Gehaltskonto(SVNr) ON DELETE SET NULL
    );

INSERT INTO Person (SVNr, Vorname, Nachname, PLZ, Ort, Straße, Hausnummer) VALUES
('1234230905', 'Max', 'Mustermann', '1100', 'Wien', 'Favoritenstraße', '15'),
('5678120402', 'Anna', 'Schmidt', '1030', 'Wien', 'Landstraßer Hauptstraße', '42'),
('9101050798', 'Elena', 'Huber', '1140', 'Wien', 'Linzer Straße', '101'),
('1121191195', 'Felix', 'Müller', '1010', 'Wien', 'Graben', '3'),
('3141251288', 'Laura', 'Bauer', '1120', 'Wien', 'Meidlinger Hauptstraße', '8a'),
('4455010290', 'Thomas', 'Pichler', '1100', 'Wien', 'Laxenburger Straße', '120'),
('7788150893', 'Sabine', 'Wagner', '1050', 'Wien', 'Schönbrunner Straße', '45'),
('2233190585', 'Michael', 'Gruber', '1180', 'Wien', 'Währinger Straße', '88');

INSERT INTO Bank (Bankleitzahl, Bankname) VALUES
('12000', 'Erste Bank'),
('19000', 'Raiffeisenbank'),
('20100', 'Bank Austria'),
('32000', 'Volksbank');

INSERT INTO Telefonnummern (SVNr, Telefonnummer) VALUES
('1234230905', '+43660111222'),
('1234230905', '016012345'),
('5678120402', '+43676999888'),
('9101050798', '+43650555444'),
('4455010290', '+436991234567'),
('7788150893', '+43664777666');

INSERT INTO Massagetyp (MTypID, Beschreibung, Dauer, Kosten) VALUES
('M_SCHULT', 'Schulter- & Nackenmassage', 30, 45.00),
('M_GANZPO', 'Ganzkörper-Sportmassage', 60, 85.00),
('M_SHIATS', 'Traditionelle Shiatsu-Behandlung', 50, 75.00),
('M_FUSSRE', 'Fußreflexzonenmassage', 45, 55.00),
('M_HOTSTO', 'Hot Stone Entspannungsmassage', 75, 110.00);

INSERT INTO Ort (Raumcodierung, Raumbeschreibung) VALUES
('R_M01', 'Massageraum 1 (Erdgeschoss - Standard)'),
('R_M02', 'Massageraum 2 (Obergeschoss - Sport)'),
('R_M03', 'Massageraum 3 (Asiatisches Ambiente)'),
('R_RUHE', 'Entspannungs- und Ruheraum mit Liegen');

INSERT INTO Kunde (SVNr, Kundennummer) VALUES
('1234230905', 10001),
('5678120402', 10002),
('4455010290', 10003),
('7788150893', 10004);

INSERT INTO Angestellter_hat_Gehaltskonto (SVNr, Angestelltennummer, Kontonummer, Bankleitzahl, Kontostand) VALUES
('9101050798', 501, 'AT121200012345', '12000', 2450.75),
('1121191195', 502, 'AT891900098765', '19000', 1890.00),
('3141251288', 503, 'AT452010011223', '20100', 3100.50),
('2233190585', 504, 'AT763200022334', '32000', 2150.00);

INSERT INTO Masseur (SV_Nummer, Lizenznummer, Ausbildungszeit, Qualifikation) VALUES
('9101050798', 7001, 24, 'Heilmasseur, Triggerpunkttherapie, Akupunktur'),
('1121191195', 7002, 12, 'Klassische Massage, Sportmassage'),
('2233190585', 7003, 36, 'Diplom-Masseur, Shiatsu-Meister, Hot Stone');

INSERT INTO Sachbearbeiter (SV_Nummer, Einstellungsdatum) VALUES
('3141251288', '2024-01-15');

INSERT INTO Massage (MTypID, Tageszeit, Raumcodierung) VALUES
('M_SCHULT', '09:00:00', 'R_M01'),
('M_SCHULT', '10:00:00', 'R_M01'),
('M_FUSSRE', '11:00:00', 'R_M01'),
('M_SCHULT', '14:00:00', 'R_M01'),
('M_SCHULT', '15:00:00', 'R_M01'),
('M_GANZPO', '09:00:00', 'R_M02'),
('M_GANZPO', '11:00:00', 'R_M02'),
('M_GANZPO', '14:00:00', 'R_M02'),
('M_SHIATS', '10:00:00', 'R_M03'),
('M_SHIATS', '14:00:00', 'R_M03'),
('M_HOTSTO', '16:00:00', 'R_M03');

INSERT INTO koordinieren (MTypID, Tageszeit, Raumcodierung, SV_Nummer_Sachbearbeiter) VALUES
('M_SCHULT', '09:00:00', 'R_M01', '3141251288'),
('M_SCHULT', '10:00:00', 'R_M01', '3141251288'),
('M_FUSSRE', '11:00:00', 'R_M01', '3141251288'),
('M_SCHULT', '14:00:00', 'R_M01', '3141251288'),
('M_SCHULT', '15:00:00', 'R_M01', '3141251288'),
('M_GANZPO', '09:00:00', 'R_M02', '3141251288'),
('M_GANZPO', '11:00:00', 'R_M02', '3141251288'),
('M_GANZPO', '14:00:00', 'R_M02', '3141251288'),
('M_SHIATS', '10:00:00', 'R_M03', '3141251288'),
('M_SHIATS', '14:00:00', 'R_M03', '3141251288'),
('M_HOTSTO', '16:00:00', 'R_M03', '3141251288');

INSERT INTO Kunde_für_Massage_bei_Masseur_vorgemerkt (MTypID, Tageszeit, Raumcodierung, SVNr_Masseur, SVNr_Kunde, Datum) VALUES
('M_SCHULT', '09:00:00', 'R_M01', '9101050798', '1234230905', '2026-07-01'),
('M_GANZPO', '11:00:00', 'R_M02', '1121191195', '5678120402', '2026-07-01'),
('M_SHIATS', '14:00:00', 'R_M03', '2233190585', '4455010290', '2026-07-02');

INSERT INTO Buchtyp (ISBN, Titel, Auflagejahr) VALUES
('9783131234560', 'Grundlagen der Anatomie für Masseure', 2021),
('9783131234561', 'Triggerpunkttherapie - Theorie und Praxis', 2022),
('9783131234562', 'Sportmassage: Techniken und Anwendung', 2020),
('9783131234563', 'Shiatsu - Traditionelle Methoden', 2019),
('9783131234564', 'Buchhaltung für Kleinunternehmen', 2023),
('9783131234565', 'Arbeitsrecht in Österreich - Grundlagen', 2022),
('9783131234566', 'Hot Stone Massage Kompendium', 2018);

INSERT INTO Voraussetzung (VoraussetzungISBN, Wird_Vorausgesetzt) VALUES
('9783131234560', '9783131234561'),
('9783131234560', '9783131234562'),
('9783131234561', '9783131234566'),
('9783131234565', '9783131234564');

INSERT INTO Buch (ISBN, Inventarnummer, entlehnt_von_SVNr) VALUES
('9783131234560', 1001, '9101050798'),
('9783131234560', 1002, NULL),
('9783131234561', 1003, '1121191195'),
('9783131234562', 1004, NULL),
('9783131234562', 1005, NULL),
('9783131234563', 1006, '2233190585'),
('9783131234564', 1007, '3141251288'),
('9783131234565', 1008, NULL),
('9783131234566', 1009, '2233190585');
