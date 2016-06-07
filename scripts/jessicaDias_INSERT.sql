-- Nome, website, sigla(PK) 
INSERT INTO campus VALUES ('Universidade Federal de São Carlos', 'http://www2.ufscar.br/home/index.php', 'UFSCARSC', '16 3216-8520',, 'Rua dos passarinho 2');

-- Nome, website, ponto geográfico(varchar), sigla(PK) 
INSERT INTO centro VALUES ('Centro de Ciências Exatas e de Tecnologia', 'http://www.ccet.ufscar.br/', '10,10', 'CCET', '16 3315-8888');

-- Nome, website, sigla(PK), sigla_campus(FK) 
INSERT INTO departamento VALUES ('Computação', 'http://www2.ufscar.br/home/index.php', 'DC', '16 3414-6582',, 'Estrada Highway to Hell 666', 'CCET');

-- Número de créditos, nome (PK) 
INSERT INTO atcomp VALUES (60, 'Iniciação Científica');

-- Ra estudante(FK), Nome da atividade complementar(FK),  
INSERT INTO realizaace VALUES ('1234', 'Iniciação Científica');