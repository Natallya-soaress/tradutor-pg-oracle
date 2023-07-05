ALTER TABLE links ADD active NUMBER(1, 0);
ALTER TABLE links DROP COLUMN active;
ALTER TABLE links RENAME COLUMN title TO link_title;
ALTER TABLE links ADD target VARCHAR2(10);
ALTER TABLE links MODIFY(target DEFAULT '_blank';
ALTER TABLE links ADD CONSTRAINT const CHECK (target IN ('_self', '_blank', '_parent', '_top'));
ALTER TABLE links ADD CONSTRAINT unique_url UNIQUE (url);
ALTER TABLE links RENAME TO urls;
INSERT INTO table_name(column1, column2) VALUES (value1, value2);
INSERT INTO tabela(coluna1, coluna2, coluna3) VALUES (valor1, valor2, valor3), (valor4, valor5, valor6), (valor7, valor8, valor9);
INSERT INTO tabela_destino(coluna1, coluna2, coluna3)SELECT coluna1, coluna2, coluna3 FROM tabela_origem WHERE atributo = atributo;
CREATE TABLE COMPANY(ID NUMBER(10) PRIMARY KEY NOT NULL, NAME CLOB NOT NULL, AGE NUMBER(10) NOT NULL, ADDRESS CHAR(50), SALARY FLOAT);
CREATE TABLE tbl_editoras(ID_Editora NUMBER(10) CONSTRAINT pk_id_editora PRIMARY KEY, Nome_Editora VARCHAR2(35) UNIQUE NOT NULL, CONSTRAINT unq_Nome_Genero UNIQUE (Nome_Genero));
CREATE TABLE tbl_livros(ID_Livro NUMBER  CONSTRAINT pk_id_livro PRIMARY KEY, Nome_Livro VARCHAR2(50) NOT NULL, Autor NUMBER(10) NOT NULL, Editora NUMBER(10) NOT NULL, Data_Pub DATE, Genero NUMBER(10) NOT NULL, Preco_Livro FLOAT,  FOREIGN KEY (Autor) REFERENCES tbl_autores(ID_Autor),  FOREIGN KEY (Editora) REFERENCES tbl_editoras(ID_Editora),  FOREIGN KEY (Genero) REFERENCES tbl_generos(ID_Genero));
