-- Nome, website, sigla(PK), telefone1, telefone2, endereço 
INSERT INTO campus VALUES ('Universidade Federal de São Carlos', 'http://www2.ufscar.br/home/index.php', 'UFSCARSC', '16 3216-8520','', 'Rua dos passarinhos 1');
INSERT INTO campus VALUES ('Universidade Federal de São Carlos', 'http://www2.ufscar.br/home/index.php', 'UFSCARARA', '16 3216-8530','', 'Rua dos passarinhos 2');
INSERT INTO campus VALUES ('Universidade Federal de São Carlos', 'http://www2.ufscar.br/home/index.php', 'UFSCARSOR', '16 3216-8540','', 'Rua dos passarinhos 3');
INSERT INTO campus VALUES ('Universidade Federal de São Carlos', 'http://www2.ufscar.br/home/index.php', 'UFSCARLAG', '16 3216-8550','', 'Rua dos passarinhos 4');
INSERT INTO campus VALUES ('Universidade Federal de São Carlos', 'http://www2.ufscar.br/home/index.php', 'UFSCAR', '16 3216-8560','', 'Rua dos passarinhos 5');

-- Nome, website, ponto geográfico(varchar), sigla(PK), telefone1 
INSERT INTO centro VALUES ('Centro de Ciências Exatas e de Tecnologia', 'http://www.ccet.ufscar.br/', '10,10', 'CCET', '16 3315-8888');
INSERT INTO centro VALUES ('Centro de Ciências Biológicas e da Saúde', 'http://www.ccbs.ufscar.br/', '10,20', 'CCBS', '16 3315-5555');
INSERT INTO centro VALUES ('Centro de Educação e Ciências Humanas', 'http://www.cech.ufscar.br/', '10,30', 'CECH', '16 3315-4444');
INSERT INTO centro VALUES ('Centro de Ciências Agrárias', 'http://www.cca.ufscar.br/', '10,40', 'CCA', '16 3315-6666');
INSERT INTO centro VALUES ('Centro de Qualquer Coisa', 'http://www.cqc.ufscar.br/', '10,50', 'CQC', '16 3315-1111');


-- Nome, website, sigla(PK), sigla_campus(FK), telefone1, telefone2, endereço, sigla_centro 
INSERT INTO departamento VALUES ('Computação', 'http://www2.ufscar.br/home/index.php', 'DC', '16 3414-6582','', 'Estrada 1', 'CCET');
INSERT INTO departamento VALUES ('Biologia', 'http://www2.ufscar.br/home/index.php', 'DBIO', '16 3414-1010','', 'Estrada 2', 'CCBS');
INSERT INTO departamento VALUES ('Ciências Sociais', 'http://www2.ufscar.br/home/index.php', 'DCS', '16 3414-2020','', 'Estrada 3', 'CECH');
INSERT INTO departamento VALUES ('Agronomia', 'http://www2.ufscar.br/home/index.php', 'DAG', '16 3414-3036','', 'Estrada 4', 'CCA');
INSERT INTO departamento VALUES ('Deboa', 'http://www2.ufscar.br/home/index.php', 'DBOA', '16 3414-0000','', 'Estrada 5', 'CQC');

-- Número de créditos, nome (PK) 
INSERT INTO atcomp VALUES (60, 'IC');
INSERT INTO atcomp VALUES (60, 'CATIJR');
INSERT INTO atcomp VALUES (20, 'PYLADIES');
INSERT INTO atcomp VALUES (120, 'MARATONA');
INSERT INTO atcomp VALUES (40, 'PETBCC');

-- Ra estudante(FK), Nome da atividade complementar(FK),  
INSERT INTO realizaace VALUES ('1111', 'IC');
INSERT INTO realizaace VALUES ('2222', 'CATIJR');
INSERT INTO realizaace VALUES ('3333', 'PYLADIES');
INSERT INTO realizaace VALUES ('4444', 'MARATONA');
INSERT INTO realizaace VALUES ('5555', 'CATIJR');
