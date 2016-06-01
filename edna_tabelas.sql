--MODELO FISICO
create table pessoa
(
  rg varchar(9) not null,
  pre_nome varchar(20),
  meio_nome varchar(20),
  ultimo_nome varchar(20),
  email varchar(20),
  email_Institucional varchar(20),
  etnia varchar(15),
  sexo char,
  dataNascimento date,
  nome_mae varchar(20),
  nome_pai varchar(20),
  cidadeNata_nome varchar(20),
  cod_rec_curso varchar(10) ,
  pais_origem varchar(20),
  nacionalidade varchar(15),
     CONSTRAINT pessoa_pk PRIMARY KEY (rg),
 CONSTRAINT Reconhecimento_de_curso_tabela_pessoa_fk FOREIGN KEY (cod_rec_curso)
	REFERENCES public.reconhecimento_de_curso (cod_rec_curso) MATCH SIMPLE
	ON UPDATE NO ACTION ON DELETE NO ACTION
     );



create table pessoa_endereco
(
     num_casa int not null,
     rg  varchar(9) not null,
     rua varchar(15),
     complemento varchar(15),
     bairro varchar(15),
     uf varchar(2),
     cep int, 
     CONSTRAINT pessoa_fk FOREIGN KEY (rg)
	REFERENCES public.pessoa (rg) MATCH SIMPLE
	ON UPDATE NO ACTION ON DELETE NO ACTION,
        constraint  Pessoa_endereco_pk primary key (rg,num_casa,cep)
 
     );
create table pessoa_contato(
     ddd int not null, 
     numero int not null,
     tipo varchar(6) not null,
     ramal int not null,
     rg varchar(9) not null,
    
      CONSTRAINT pessoa_fk FOREIGN KEY (rg)
	REFERENCES public.pessoa (rg) MATCH SIMPLE
	ON UPDATE NO ACTION ON DELETE NO ACTION,
 constraint  contato_pk primary key (rg,ddd,numero,ramal,tipo)
    ); 


