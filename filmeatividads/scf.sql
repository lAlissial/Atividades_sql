CREATE TABLE Filme ( 
       CodFILME         SERIAL                NOT NULL,
       Titulo           VARCHAR(25),
       Ano              INTEGER,
       Duracao          INTEGER,
       CodCATEG         INTEGER,
       CodEst           INTEGER);

CREATE TABLE Artista ( 
       CodART           SERIAL                NOT NULL,
       NomeART          VARCHAR(25),
       Cidade           VARCHAR(20),
       Pais             VARCHAR(20),
       DataNasc         DATE);

CREATE TABLE Estudio ( 
       CodEst           SERIAL               NOT NULL,
       NomeEst          VARCHAR(25));

CREATE TABLE Categoria ( 
       CodCATEG         SERIAL               NOT NULL,
       DescCATEG        VARCHAR(25));

CREATE TABLE Personagem ( 
       CodART           INTEGER             NOT NULL,
       CodFILME         INTEGER             NOT NULL,
       NomePers         VARCHAR(25),
       Cache            NUMERIC(15,2));

ALTER TABLE Filme ADD CONSTRAINT PKFilme PRIMARY KEY(CodFILME);

ALTER TABLE Artista ADD CONSTRAINT PKArtista PRIMARY KEY(CodART);

ALTER TABLE Estudio ADD CONSTRAINT PKEst PRIMARY KEY(CodEst);

ALTER TABLE Categoria ADD CONSTRAINT PKCategoria PRIMARY KEY(CodCATEG);

ALTER TABLE Personagem ADD CONSTRAINT PKPersonagem PRIMARY KEY(CodART,CodFILME);

ALTER TABLE Filme ADD CONSTRAINT FKFilme1Categ FOREIGN KEY(CodCATEG) REFERENCES Categoria;

ALTER TABLE Filme ADD CONSTRAINT FKFilme2Estud FOREIGN KEY(CodEst) REFERENCES Estudio;

ALTER TABLE Personagem ADD CONSTRAINT FKPersonagem2Artis FOREIGN KEY(CodART) REFERENCES Artista;

ALTER TABLE Personagem ADD CONSTRAINT FKPersonagem1Filme FOREIGN KEY(CodFILME) REFERENCES Filme;


