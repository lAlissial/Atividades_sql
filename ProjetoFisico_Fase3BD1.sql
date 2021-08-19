SET DATEFORMAT dmy

CREATE DATABASE Projeto_Logico_Fase3BD1
GO

USE Projeto_Logico_Fase3BD1
GO

CREATE TABLE BancoDeTalentos (
    idBanco                                       INT				NOT NULL,
    cargoPretendido                               VARCHAR(60)		NOT NULL,
    salarioPretendido                             DECIMAL(8,2)		NOT NULL,
    dataEntrevista                                DATE				NOT NULL,
    CONSTRAINT PK_idbanco                         PRIMARY KEY     (idBanco)
)

CREATE TABLE Departamento (
    nome_departamento                              VARCHAR(45)       NOT NULL,
    localizacao                                    VARCHAR(45)       NOT NULL,
    idDepartamento				                   INT               NOT NULL,
    CONSTRAINT PK_idDepartamento                   PRIMARY KEY (idDepartamento),
    CONSTRAINT AK_nome			                   UNIQUE (nome_departamento)
)

CREATE TABLE Empregado (
    idEmpregado                                     INT              NOT NULL,
    idBanco                                         INT              NOT NULL,
    idDepartamento                                  INT              NOT NULL,
    idSupervisor                                    INT              NULL,
    sexo_empregado                                  VARCHAR(1)       NOT NULL,
    salario                                         DECIMAL(8,2)     NOT NULL,
    dataNascimento                                  DATE             NOT NULL,
    num_seg_social                                  INT              NOT NULL,
    estado                                          VARCHAR(45)      NULL DEFAULT 'PB',
    cidade                                          VARCHAR(200)     NULL DEFAULT 'João Pessoa',
    rua                                             VARCHAR(200)     NOT NULL,
    numero                                          INT              NOT NULL,
    CONSTRAINT PK_idEmpregado                       PRIMARY KEY (idEmpregado),
    CONSTRAINT FK_idBanco                           FOREIGN KEY (idBanco)        REFERENCES BancoDeTalentos,
    CONSTRAINT FK_idSupervisor_Empregado            FOREIGN KEY (idSupervisor)   REFERENCES Empregado,
    CONSTRAINT FK_idDepartamento_Empregado          FOREIGN KEY (idDepartamento) REFERENCES Departamento,
    CONSTRAINT CK_idSupervisor			            CHECK(idSupervisor != idEmpregado),
    CONSTRAINT CK_sexo_empregado                    CHECK(sexo_empregado = 'F' or sexo_empregado = 'M'),
    CONSTRAINT CK_salario                           CHECK(salario >= 1100),
    CONSTRAINT AK_num_seguro_social                 UNIQUE(num_seg_social)
)

CREATE TABLE ProjetoDeRecrutamento (
    idProjetoDeRecrutamento                          INT              NOT NULL,
    idDepartamento                                   INT              NOT NULL,
    nome_projeto                                     VARCHAR(90)      NOT NULL,
    dataInicio                                       DATE             NOT NULL,
    dataPrevistaConclusao                            DATE             NOT NULL,
    orcamento                                        DECIMAL(9, 2)    NOT NULL,
    CONSTRAINT PK_idProjetoDeRecrutamento            PRIMARY KEY (idProjetoDeRecrutamento),
    CONSTRAINT FK_idDepartamento_ProjetoRecrutamento FOREIGN KEY (idDepartamento) REFERENCES Departamento,
    CONSTRAINT AK_idDepartamento                     UNIQUE (idDepartamento),
    CONSTRAINT AK_nomeRecrutamento                   UNIQUE (nome_projeto)
)

CREATE TABLE ProjetosDeMarketing (
    idProjeto_Marketing                             INT              NOT NULL,
    idDepartamento                                  INT              NOT NULL,
    descricao                                       VARCHAR(1000)    NOT NULL,
    metas                                           VARCHAR(5000)    NOT NULL,
    dataFim                                         DATE             NOT NULL,
    dataInicio                                      DATE             NOT NULL,
    CONSTRAINT PK_idProjeto                         PRIMARY KEY (idProjeto_Marketing),
    CONSTRAINT FK_idDepartamento_ProjetoMarketing   FOREIGN KEY (idDepartamento) REFERENCES Departamento
)

CREATE TABLE Dependente (
    idEmpregado                                     INT              NOT NULL,
    nome_dependente                                 VARCHAR(200)     NOT NULL,
    sexo_dependente                                 VARCHAR(1)       NOT NULL,
    parentesco                                      VARCHAR(45)      NOT NULL,
    dataNascimento_dependente                       DATE             NOT NULL,
    CONSTRAINT FK_idEmpregado_Dependente            FOREIGN KEY (idEmpregado) REFERENCES Empregado,
    CONSTRAINT PK_idEmpregado_dependente            PRIMARY KEY (idEmpregado, nome_dependente),
    CONSTRAINT CK_sexo_dependente                   CHECK(sexo_dependente = 'F' or sexo_dependente = 'M'),
)

CREATE TABLE Gerencia (
    idEmpregado                                     INT              NOT NULL,
    idDepartamento                                  INT              NOT NULL,
    dataInicio_Gerencia                             DATE             NOT NULL,
    CONSTRAINT FK_idEmpregado_Gerencia              FOREIGN KEY (idEmpregado) REFERENCES Empregado,
    CONSTRAINT FK_idDepartamento_Gerencia           FOREIGN KEY (idDepartamento) REFERENCES Departamento,
    CONSTRAINT PK_gerencia                          PRIMARY KEY(idEmpregado, idDepartamento)
)

CREATE TABLE Trabalho (
    idEmpregado                                     INT             NOT NULL,
    idProjetoDeRecrutamento                         INT             NOT NULL,
    numeroDeHoras                                   INT             NOT NULL,
    descricaoDoTrabalho                             VARCHAR(5000)   NOT NULL,
    CONSTRAINT AK_numeroDeHoras                     CHECK(numeroDeHoras > 0),
    CONSTRAINT FK_idEmpregado_Trabalho              FOREIGN KEY (idEmpregado) REFERENCES Empregado,
    CONSTRAINT FK_idProjetoDeRecrutamento_Trabalho  FOREIGN KEY(idProjetodeRecrutamento) REFERENCES ProjetoDeRecrutamento,
    CONSTRAINT PK_Trabalho                          PRIMARY KEY (idEmpregado, idProjetoDeRecrutamento)
)

CREATE TABLE telefone (
    numeroTelefone                                  INT              NOT NULL,
    idDepartamento                                  INT              NOT NULL,
    CONSTRAINT FK_idDepartamento_Telefone           FOREIGN KEY (idDepartamento) REFERENCES Departamento,
    CONSTRAINT PK_numTelefone                       PRIMARY KEY (numeroTelefone, idDepartamento),
    CONSTRAINT AK_numTelefone                       CHECK(numeroTelefone >= 8)
)

CREATE TABLE DepartamentoDeAdministracao (
    fluxoCaixa                                      DECIMAL(12, 2)   NOT NULL,
    idDepartamento                                  INT              NOT NULL,
    CONSTRAINT FK_idDepartamentoDepAdm              FOREIGN KEY (idDepartamento) REFERENCES Departamento,
    CONSTRAINT PK_DepartamentoDeAdministracao       PRIMARY KEY (idDepartamento)
)

CREATE TABLE DepartamentoComercial (
    faturamento                                     DECIMAL(12, 2)   NOT NULL,
    idDepartamento                                  INT              NOT NULL,
    CONSTRAINT FK_idDepartamentoComercial           FOREIGN KEY (idDepartamento) REFERENCES Departamento,
    CONSTRAINT PK_DepartamentoComercial             PRIMARY KEY (idDepartamento)
)

CREATE TABLE Objetivos (
    idObjetivos                                     INT               NOT NULL,
    idDepartamento                                  INT               NOT NULL,
    planejamento                                    VARCHAR(1000)     NOT NULL,
    prazoConclusao                                  DATE              NOT NULL,
    CONSTRAINT PK_idObjetivos                       PRIMARY KEY (idObjetivos),
    CONSTRAINT FK_idDepartamentoObjetivos           FOREIGN KEY (idDepartamento) REFERENCES Departamento
)

CREATE TABLE Cliente (
    idEmpresaCliente                               INT               NOT NULL,
    idDepartamento                                 INT               NOT NULL,
    valorContratual                                DECIMAL(9, 2)     NOT NULL,
    CONSTRAINT FK_idDepartamentoCliente            FOREIGN KEY (idDepartamento) REFERENCES Departamento,
    CONSTRAINT PK_idEmpresaCliente                 PRIMARY KEY(idEmpresaCliente)
)

INSERT INTO BancoDeTalentos (idBanco, cargoPretendido, salarioPretendido, dataEntrevista) VALUES (20, 'Administrador', 1350, '11/02/2008')
INSERT INTO BancoDeTalentos (idBanco, cargoPretendido, salarioPretendido, dataEntrevista) VALUES (21, 'Atendente de Telemarketing', 1100, '22/10/1999')
INSERT INTO BancoDeTalentos (idBanco, cargoPretendido, salarioPretendido, dataEntrevista) VALUES (22, 'Designer', 1500, '14/07/2018')
INSERT INTO BancoDeTalentos (idBanco, cargoPretendido, salarioPretendido, dataEntrevista) VALUES (23, 'Contador', 1350, '15/03/2007')
INSERT INTO BancoDeTalentos (idBanco, cargoPretendido, salarioPretendido, dataEntrevista) VALUES (24, 'Analista de Software', 1900, '30/08/2019')
INSERT INTO BancoDeTalentos (idBanco, cargoPretendido, salarioPretendido, dataEntrevista) VALUES (25, 'Segurança', 2000, '17/03/2015')

INSERT INTO Departamento (nome_departamento, localizacao, idDepartamento) VALUES ('Departamento Administrativo', 'Bloco A', 1)
INSERT INTO Departamento (nome_departamento, localizacao, idDepartamento) VALUES ('Departamento Financeiro', 'Bloco B', 2)
INSERT INTO Departamento (nome_departamento, localizacao, idDepartamento) VALUES ('Departamento Comercial', 'Bloco C', 3)
INSERT INTO Departamento (nome_departamento, localizacao, idDepartamento) VALUES ('Departamento de RH', 'Bloco D', 4)
INSERT INTO Departamento (nome_departamento, localizacao, idDepartamento) VALUES ('Departamento de Educação', 'Bloco E', 5)
INSERT INTO Departamento (nome_departamento, localizacao, idDepartamento) VALUES ('Departamento de Tecnologia', 'Bloco F', 6)

INSERT INTO Empregado (idEmpregado, idBanco, idDepartamento, sexo_empregado, salario, dataNascimento, num_seg_social, estado, cidade, rua, numero) VALUES (12, 20, 5, 'M', 25500, '22/05/2002', 14896, DEFAULT, DEFAULT, 'Rua do Jarro', 39)
INSERT INTO Empregado (idEmpregado, idBanco, idDepartamento, sexo_empregado, salario, dataNascimento, num_seg_social, estado, cidade, rua, numero) VALUES (13, 21, 2, 'F', 13250, '08/08/2000', 12369, 'Goias', 'Goiania', 'Rua Jureminha', 13)
INSERT INTO Empregado (idEmpregado, idBanco, idDepartamento, sexo_empregado, salario, dataNascimento, num_seg_social, estado, cidade, rua, numero) VALUES (14, 25, 4, 'F', 35201, '02/08/2001', 16325, DEFAULT, DEFAULT, 'Rua Jurubeba', 158)
INSERT INTO Empregado (idEmpregado, idBanco, idDepartamento, sexo_empregado, salario, dataNascimento, num_seg_social, estado, cidade, rua, numero) VALUES (15, 24, 1, 'M', 45000, '07/12/1996', 85962, 'Sao Paulo', 'Campinas', 'Rua Goiabada', 153)
INSERT INTO Empregado (idEmpregado, idBanco, idDepartamento, sexo_empregado, salario, dataNascimento, num_seg_social, estado, cidade, rua, numero) VALUES (16, 22, 3, 'M', 36212, '14/08/2002', 15634, DEFAULT, DEFAULT, 'Rua do Caju', 45)
INSERT INTO Empregado (idEmpregado, idBanco, idDepartamento, sexo_empregado, salario, dataNascimento, num_seg_social, estado, cidade, rua, numero) VALUES (17, 23, 6, 'F', 36520, '31/10/1989', 12563, 'Sao Paulo', 'Osasco', 'Rua 13 de Maio', 15)

INSERT INTO ProjetoDeRecrutamento (idProjetoDeRecrutamento, idDepartamento, nome_projeto, dataInicio, dataPrevistaConclusao, orcamento) VALUES (10, 1, 'Projeto DVLContábil', '22/08/2019', '12/06/2021', 200000)
INSERT INTO ProjetoDeRecrutamento (idProjetoDeRecrutamento, idDepartamento, nome_projeto, dataInicio, dataPrevistaConclusao, orcamento) VALUES (20, 3, 'Projeto DVLComerce', '31/12/2019', '13/09/2021', 200000)
INSERT INTO ProjetoDeRecrutamento (idProjetoDeRecrutamento, idDepartamento, nome_projeto, dataInicio, dataPrevistaConclusao, orcamento) VALUES (30, 6, 'Projeto DVLSoft', '15/08/2018', '22/11/2022', 500000)
INSERT INTO ProjetoDeRecrutamento (idProjetoDeRecrutamento, idDepartamento, nome_projeto, dataInicio, dataPrevistaConclusao, orcamento) VALUES (40, 4, 'Projeto Empatia', '30/03/2020', '31/08/2021', 150000)
INSERT INTO ProjetoDeRecrutamento (idProjetoDeRecrutamento, idDepartamento, nome_projeto, dataInicio, dataPrevistaConclusao, orcamento) VALUES (50, 2, 'Projeto Admin Pro', '12/05/2020', '02/09/2023', 130000)
INSERT INTO ProjetoDeRecrutamento (idProjetoDeRecrutamento, idDepartamento, nome_projeto, dataInicio, dataPrevistaConclusao, orcamento) VALUES (60, 5, 'Projeto Educa mais', '29/04/2019', '09/12/2021', 100000)

INSERT INTO ProjetosDeMarketing (idProjeto_Marketing, idDepartamento, descricao, metas, dataFim, dataInicio) VALUES (1, 2, 'Fala Felas', 'O céu é o LIMITE', '15/08/2021', '05/02/2020')
INSERT INTO ProjetosDeMarketing (idProjeto_Marketing, idDepartamento, descricao, metas, dataFim, dataInicio) VALUES (2, 3, 'Djuqueratos', 'O céu é o LIMITE', '25/12/2022', '03/07/2021')
INSERT INTO ProjetosDeMarketing (idProjeto_Marketing, idDepartamento, descricao, metas, dataFim, dataInicio) VALUES (4, 5, 'Topíssimo','O céu é o LIMITE', '07/03/2022', '21/05/2019')
INSERT INTO ProjetosDeMarketing (idProjeto_Marketing, idDepartamento, descricao, metas, dataFim, dataInicio) VALUES (3, 4, 'Topzera', 'O céu é o LIMITE', '30/04/2023', '03/08/2020')
INSERT INTO ProjetosDeMarketing (idProjeto_Marketing, idDepartamento, descricao, metas, dataFim, dataInicio) VALUES (5, 1, 'Tops', 'O céu é o LIMITE', '17/09/2021', '16/02/2018')
INSERT INTO ProjetosDeMarketing (idProjeto_Marketing, idDepartamento, descricao, metas, dataFim, dataInicio) VALUES (6, 6, 'Top', 'O céu é o LIMITE', '09/07/2022', '12/02/2021')

INSERT INTO Dependente (idEmpregado, nome_dependente, sexo_dependente, parentesco, dataNascimento_dependente) VALUES (12, 'Zonya Jobertina do Rego', 'F', 'Filha', '11/02/2011')
INSERT INTO Dependente (idEmpregado, nome_dependente, sexo_dependente, parentesco, dataNascimento_dependente) VALUES (13, 'Josescleyton Guimarães Milanês Brito', 'M', 'Filho', '20/08/2005')
INSERT INTO Dependente (idEmpregado, nome_dependente, sexo_dependente, parentesco, dataNascimento_dependente) VALUES (15, 'Cleber da Silva Araujo', 'M', 'Filho', '26/07/2010')
INSERT INTO Dependente (idEmpregado, nome_dependente, sexo_dependente, parentesco, dataNascimento_dependente) VALUES (17, 'Janaina Marques Souza Silva', 'F', 'Filha', '23/01/2007')
INSERT INTO Dependente (idEmpregado, nome_dependente, sexo_dependente, parentesco, dataNascimento_dependente) VALUES (16, 'Soraya Campos do Jordão', 'F', 'Esposa', '03/06/1962')
INSERT INTO Dependente (idEmpregado, nome_dependente, sexo_dependente, parentesco, dataNascimento_dependente) VALUES (14, 'Bryan Adams Almond Garcia', 'M', 'Filho', '22/04/2018')
INSERT INTO Dependente (idEmpregado, nome_dependente, sexo_dependente, parentesco, dataNascimento_dependente) VALUES (14, 'Bruno Damasco Macieira Almond Garcia Filho', 'M', 'Filho', '27/03/2015')

INSERT INTO Gerencia (idEmpregado, idDepartamento, dataInicio_Gerencia) VALUES (12, 1, '20/02/2019')
INSERT INTO Gerencia (idEmpregado, idDepartamento, dataInicio_Gerencia) VALUES (14, 2, '21/02/2020')
INSERT INTO Gerencia (idEmpregado, idDepartamento, dataInicio_Gerencia) VALUES (16, 3, '20/02/2017')
INSERT INTO Gerencia (idEmpregado, idDepartamento, dataInicio_Gerencia) VALUES (15, 4, '20/02/2015')
INSERT INTO Gerencia (idEmpregado, idDepartamento, dataInicio_Gerencia) VALUES (13, 6, '20/02/2021')
INSERT INTO Gerencia (idEmpregado, idDepartamento, dataInicio_Gerencia) VALUES (17, 5, '20/02/2016')

INSERT INTO Trabalho (idEmpregado, idProjetoDeRecrutamento, numeroDeHoras, descricaoDoTrabalho) VALUES (12, 10, 120, 'Uma pessoa que não possui essas habilidades ainda pode fazer o trabalho')
INSERT INTO Trabalho (idEmpregado, idProjetoDeRecrutamento, numeroDeHoras, descricaoDoTrabalho) VALUES (13, 40, 180, 'A natureza do trabalho é permanente')
INSERT INTO Trabalho (idEmpregado, idProjetoDeRecrutamento, numeroDeHoras, descricaoDoTrabalho) VALUES (15, 20, 250, 'Eles serão compatíveis e complementarão um ao outro')
INSERT INTO Trabalho (idEmpregado, idProjetoDeRecrutamento, numeroDeHoras, descricaoDoTrabalho) VALUES (17, 60, 160, 'Esse padrão ajudará a diminuir alguma fraqueza da equipe')
INSERT INTO Trabalho (idEmpregado, idProjetoDeRecrutamento, numeroDeHoras, descricaoDoTrabalho) VALUES (14, 30, 300, 'Um funcionário pode optar por recusar a promoção')
INSERT INTO Trabalho (idEmpregado, idProjetoDeRecrutamento, numeroDeHoras, descricaoDoTrabalho) VALUES (16, 50, 90, 'Viajar está envolvido no trabalho')

INSERT INTO telefone (numeroTelefone, idDepartamento) VALUES (82074339, 5)
INSERT INTO telefone (numeroTelefone, idDepartamento) VALUES (40028922, 2)
INSERT INTO telefone (numeroTelefone, idDepartamento) VALUES (89663201, 1)
INSERT INTO telefone (numeroTelefone, idDepartamento) VALUES (56478936, 6)
INSERT INTO telefone (numeroTelefone, idDepartamento) VALUES (23556489, 4)
INSERT INTO telefone (numeroTelefone, idDepartamento) VALUES (32320216, 3)

INSERT INTO DepartamentoDeAdministracao (fluxoCaixa, idDepartamento) VALUES (120000, 1)
INSERT INTO DepartamentoDeAdministracao (fluxoCaixa, idDepartamento) VALUES (100000, 2)
INSERT INTO DepartamentoDeAdministracao (fluxoCaixa, idDepartamento) VALUES (50000, 3)
INSERT INTO DepartamentoDeAdministracao (fluxoCaixa, idDepartamento) VALUES (10000, 5)
INSERT INTO DepartamentoDeAdministracao (fluxoCaixa, idDepartamento) VALUES (50000, 6)
INSERT INTO DepartamentoDeAdministracao (fluxoCaixa, idDepartamento) VALUES (190000, 4)

INSERT INTO DepartamentoComercial (faturamento, idDepartamento) VALUES (200000, 5)
INSERT INTO DepartamentoComercial (faturamento, idDepartamento) VALUES (100000, 1)
INSERT INTO DepartamentoComercial (faturamento, idDepartamento) VALUES (500000, 2)
INSERT INTO DepartamentoComercial (faturamento, idDepartamento) VALUES (800000, 3)
INSERT INTO DepartamentoComercial (faturamento, idDepartamento) VALUES (300000, 4)
INSERT INTO DepartamentoComercial (faturamento, idDepartamento) VALUES (6000000, 6)

INSERT INTO Objetivos (idObjetivos, idDepartamento, planejamento, prazoConclusao) VALUES (1, 5, 'Surgimento de novas ideias. Novas tendências de mercado.', '09/01/2022')
INSERT INTO Objetivos (idObjetivos, idDepartamento, planejamento, prazoConclusao) VALUES (2, 3, 'Desenvolvimento de um clima organizacional. Confraternizações', '31/12/2021')
INSERT INTO Objetivos (idObjetivos, idDepartamento, planejamento, prazoConclusao) VALUES (5, 4, 'Ajudar o gestor a conquistar a confiança. Diálogos mais horizontais', '29/12/2021')
INSERT INTO Objetivos (idObjetivos, idDepartamento, planejamento, prazoConclusao) VALUES (3, 1, 'Alinhar toda a empresa. Busca por resultados', '01/01/2022')
INSERT INTO Objetivos (idObjetivos, idDepartamento, planejamento, prazoConclusao) VALUES (4, 2, 'Elevar a produtividade da organização. Aumentar a produção em 15% no próximo semestre', '01/12/2021')
INSERT INTO Objetivos (idObjetivos, idDepartamento, planejamento, prazoConclusao) VALUES (6, 6, 'Transformação digital. Home office', '01/06/2021')

INSERT INTO Cliente (idEmpresaCliente, idDepartamento, valorContratual) VALUES (21, 5, 6000000)
INSERT INTO Cliente (idEmpresaCliente, idDepartamento, valorContratual) VALUES (22, 4, 200000)
INSERT INTO Cliente (idEmpresaCliente, idDepartamento, valorContratual) VALUES (24, 2, 150000)
INSERT INTO Cliente (idEmpresaCliente, idDepartamento, valorContratual) VALUES (23, 1, 600000)
INSERT INTO Cliente (idEmpresaCliente, idDepartamento, valorContratual) VALUES (20, 3, 3000000)
INSERT INTO Cliente (idEmpresaCliente, idDepartamento, valorContratual) VALUES (25, 6, 1000000)

UPDATE Empregado SET idSupervisor = 13 WHERE idEmpregado = 12
UPDATE Empregado SET idSupervisor = 14 WHERE idEmpregado = 13
UPDATE Empregado SET idSupervisor = 16 WHERE idEmpregado = 14
UPDATE Empregado SET idSupervisor = 17 WHERE idEmpregado = 15
UPDATE Empregado SET idSupervisor = 12 WHERE idEmpregado = 16
UPDATE Empregado SET idSupervisor = 15 WHERE idEmpregado = 17


SELECT DEP.nome_departamento AS 'Nome do Departamento', PDR.nome_projeto FROM Departamento[DEP] JOIN ProjetoDeRecrutamento[PDR] on DEP.idDepartamento = PDR.idDepartamento

SELECT idEmpregado, COUNT(nome_dependente) AS 'Quantidade de dependentes por empregado' FROM Dependente GROUP BY idEmpregado HAVING COUNT (nome_dependente) > 0

SELECT sexo_empregado, COUNT (*) AS 'Quantidade ordenada de Empregados por sexo' FROM Empregado GROUP BY sexo_empregado

SELECT idEmpregado, idSupervisor, idDepartamento, estado FROM Empregado WHERE estado IN ('Goias', 'Sao Paulo') ORDER BY idEmpregado

SELECT idEmpregado, nome_dependente FROM Dependente WHERE nome_dependente LIKE '%Silva%' ORDER BY idEmpregado

SELECT * FROM BancoDeTalentos WHERE salarioPretendido BETWEEN 1100 and 1500 ORDER BY cargoPretendido

SELECT AVG (salarioPretendido) AS 'Média de salários pretendidos' FROM BancoDeTalentos

SELECT MAX (salario) AS 'Maior Salário' FROM Empregado WHERE sexo_empregado = 'F'

SELECT idEmpregado, estado, salario FROM Empregado WHERE salario IS NOT NULL

SELECT SUM (salario) AS 'Soma Total de Salários' FROM Empregado

SELECT COUNT (*) AS 'Quantidade de Empregados' FROM Empregado