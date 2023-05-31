--Aluno: Marcela Varejão Gomes
--Turma: SI1N
--Professor: Abrantes

DROP DATABASE uvv;

DROP ROLE marcela_varejao;

-- Crio o meu usuário com permissão de criar role, e criar banco de dados, com a senha encriptada. 

CREATE USER marcela_varejao 
                            WITH ENCRYPTED PASSWORD '123'
                            CREATEDB
                            CREATEROLE;

-- Crio o banco de dados me dando permissão de owner para conseguir ter todos os poderes.

CREATE DATABASE uvv
                    OWNER=marcela_varejao
                    ENCODING 'UTF8'
                    TEMPLATE template0
                    LC_CTYPE 'pt_BR.UTF-8'
                    LC_COLLATE 'pt_BR.UTF-8'
                    ALLOW_CONNECTIONS TRUE;


-- Conecto no banco de dados "uvv" usando meu usuário

\c "dbname=uvv user=marcela_varejao password=123";

-- Crio o esquema dando permissão para o meu usuário usar.

CREATE SCHEMA lojas AUTHORIZATION marcela_varejao;

-- Comando para configurar o esquema "lojas" como path principal.

SET SEARCH_PATH TO lojas, "$user", public;

-- Comando para alterar o usuário que está usando os comandos.

ALTER USER marcela_varejao
SET SEARCH_PATH TO lojas, "$user", public;

-- Criação da tabela produtos e todas as informações necessárias para o cadastro dos produtos no banco de dados.

CREATE TABLE produtos (
                produto_id NUMERIC(38) NOT NULL,
                nome VARCHAR(255) NOT NULL,
                preco_unitario NUMERIC(10,2),
                detalhes BYTEA,
                imagem BYTEA,
                imagem_mime_type VARCHAR(512),
                imagem_arquivo VARCHAR(512),
                imagem_charset VARCHAR(512),
                imagem_ultima_atualizacao DATE,
                CONSTRAINT produto_id_pk PRIMARY KEY (produto_id)
);
COMMENT ON TABLE produtos IS 'Tabela com as informações dos produtos';
COMMENT ON COLUMN produtos.produto_id IS 'Coluna com os id dos produtos';
COMMENT ON COLUMN produtos.nome IS 'Coluna com os nomes produto';
COMMENT ON COLUMN produtos.preco_unitario IS 'Coluna com o preço unitário dos produtos';
COMMENT ON COLUMN produtos.detalhes IS 'Coluna dos detalhes dos produtos';
COMMENT ON COLUMN produtos.imagem IS 'Coluna com as imagens dos produtos';
COMMENT ON COLUMN produtos.imagem_mime_type IS 'Coluna com as imagens dos produtos em formato mime';
COMMENT ON COLUMN produtos.imagem_arquivo IS 'Coluna com as imagens dos protudos em formato de arquivo';
COMMENT ON COLUMN produtos.imagem_charset IS 'Coluna com as imagens dos produtos em formato charset';
COMMENT ON COLUMN produtos.imagem_ultima_atualizacao IS 'Coluna com a ultima atualização das imagens dos produtos';

--Criação da tabela lojas e todas as informações necessárias para o cadastro das lojas no banco de dados.

CREATE TABLE lojas (
                loja_id NUMERIC(38) NOT NULL,
                nome VARCHAR(255) NOT NULL,
                endereco_web VARCHAR(100),
                endereco_fisico VARCHAR(512),
                latitude NUMERIC,
                longitude NUMERIC,
                logo BYTEA,
                logo_mime_type VARCHAR(512),
                logo_arquivo VARCHAR(512),
                logo_charset VARCHAR(512),
                logo_ultima_atualizacao DATE,
                CONSTRAINT loja_id_pk PRIMARY KEY (loja_id)
);
COMMENT ON TABLE  lojas IS 'Tabela com as informações das lojas';
COMMENT ON COLUMN lojas.loja_id IS 'Coluna com os id das lojas';
COMMENT ON COLUMN lojas.nome IS 'Coluna com os nome das lojas';
COMMENT ON COLUMN lojas.endereco_web IS 'Coluna com o link do endereço web';
COMMENT ON COLUMN lojas.endereco_fisico IS 'Coluna com o link do endereço fisico';
COMMENT ON COLUMN lojas.latitude IS 'Coluna com a latitude';
COMMENT ON COLUMN lojas.longitude IS 'Coluna com a longitude';
COMMENT ON COLUMN lojas.logo IS 'Coluna com a logo das lojas';
COMMENT ON COLUMN lojas.logo_mime_type IS 'Coluna com a logo mime';
COMMENT ON COLUMN lojas.logo_arquivo IS 'Coluna com a logo em arquivo';
COMMENT ON COLUMN lojas.logo_charset IS 'Coluna com a logo em charset';
COMMENT ON COLUMN lojas.logo_ultima_atualizacao IS 'Coluna com a ultima atualização da logo';

--Criação da tabela estoques e todas as informações necessárias para o cadastro dos estoques no banco de dados.

CREATE TABLE estoques (
                estoque_id NUMERIC(38) NOT NULL,
                loja_id NUMERIC(38) NOT NULL,
                produto_id NUMERIC(38) NOT NULL,
                quantidade NUMERIC(38) NOT NULL,
                CONSTRAINT estoque_id_pk PRIMARY KEY (estoque_id)
);
COMMENT ON TABLE  estoques IS 'Tabela com as informações dos estoques';
COMMENT ON COLUMN estoques.estoque_id IS 'Coluna com os id dos estoques';
COMMENT ON COLUMN estoques.loja_id IS 'Coluna com o id das lojas';
COMMENT ON COLUMN estoques.produto_id IS 'Coluna com os id dos produtos';
COMMENT ON COLUMN estoques.quantidade IS 'Coluna com a quantidade de produtos por estoque';

--Criação da tabela clientes e todas as informações necessárias para o cadastro dos clientes no banco de dados.

CREATE TABLE clientes (
                cliente_id NUMERIC(38) NOT NULL,
                email VARCHAR(255) NOT NULL,
                nome VARCHAR(255) NOT NULL,
                telefone1 VARCHAR(20),
                telefone2 VARCHAR(20),
                telefone3 VARCHAR(20),
                CONSTRAINT cliente_id_pk PRIMARY KEY (cliente_id)
);
COMMENT ON TABLE clientes IS 'Tabela com as informações dos clientes';
COMMENT ON COLUMN clientes.cliente_id IS 'Coluna com o id dos clientes';
COMMENT ON COLUMN clientes.email IS 'Coluna com os emails dos clientes';
COMMENT ON COLUMN clientes.nome IS 'Coluna com os nomes dos clientes';
COMMENT ON COLUMN clientes.telefone1 IS 'Coluna com os primeiros telefones de contato dos clientes';
COMMENT ON COLUMN clientes.telefone2 IS 'Coluna com os segundos telefones de contato dos clientes';
COMMENT ON COLUMN clientes.telefone3 IS 'Coluna com os terceiros telefones de contato dos clientes';

--Criação da tabela pedidos e todas as informações necessárias para o cadastro dos pedidos no banco de dados.

CREATE TABLE pedidos (
                pedido_id NUMERIC(38) NOT NULL,
                data_hora TIMESTAMP NOT NULL,
                cliente_id NUMERIC(38) NOT NULL,
                status VARCHAR(15) NOT NULL,
                loja_id NUMERIC(38) NOT NULL,
                CONSTRAINT pedido_id_pk PRIMARY KEY (pedido_id)
);
COMMENT ON TABLE  pedidos IS 'Criação da tabela pedidos';
COMMENT ON COLUMN pedidos.pedido_id IS 'Coluna da chave primária da tabela pedidos "pedido_id", contendo o ID dos pedidos.';
COMMENT ON COLUMN pedidos.data_hora IS 'Coluna com a data e a hora de cada pedido.';
COMMENT ON COLUMN pedidos.cliente_id IS 'Coluna da chave estrangeira da tabela pedidos "cliente_id", contendo o ID dos clientes.';
COMMENT ON COLUMN pedidos.status IS 'Coluna com o status dos pedidos.';
COMMENT ON COLUMN pedidos.loja_id IS 'Coluna da chave estrangeira da tabela pedidos "loja_id", contendo o ID das lojas.';

--Criação da tabela envios e todas as informações necessárias para o cadastro dos envios no banco de dados.

CREATE TABLE envios (
                envio_id NUMERIC(38) NOT NULL,
                loja_id NUMERIC(38) NOT NULL,
                cliente_id NUMERIC(38) NOT NULL,
                endereco_entrega VARCHAR(512) NOT NULL,
                status VARCHAR(15) NOT NULL,
                CONSTRAINT envio_id_pk PRIMARY KEY (envio_id)
);
COMMENT ON TABLE envios IS 'Tabela com as informações dos envios';
COMMENT ON COLUMN envios.envio_id IS 'Coluna com o id dos envios';
COMMENT ON COLUMN envios.loja_id IS 'Coluna com o id das lojas';
COMMENT ON COLUMN envios.cliente_id IS 'Coluna com o id dos clientes';
COMMENT ON COLUMN envios.endereco_entrega IS 'Coluna com o endereço de entrega dos produtos';
COMMENT ON COLUMN envios.status IS 'Coluna com os status dos envios';

--Criação da tabela pedidos_itens e todas as informações necessárias para o cadastro dos itens no banco de dados.

CREATE TABLE pedidos_itens (
                pedido_id NUMERIC(38) NOT NULL,
                produto_id NUMERIC(38) NOT NULL,
                numero_da_linha NUMERIC(38) NOT NULL,
                preco_unitario NUMERIC(10,2) NOT NULL,
                quantidade NUMERIC(38) NOT NULL,
                envio_id NUMERIC(38),
                CONSTRAINT pedidos_itens_pk PRIMARY KEY (pedido_id, produto_id)
);
COMMENT ON TABLE pedidos_itens IS 'Tabela com as informações dos itens dos pedidos';
COMMENT ON COLUMN pedidos_itens.pedido_id IS 'Coluna com o id dos protudos';
COMMENT ON COLUMN pedidos_itens.produto_id IS 'Coluna com o id dos pedidos';
COMMENT ON COLUMN pedidos_itens.numero_da_linha IS 'Coluna com o número da linha';
COMMENT ON COLUMN pedidos_itens.preco_unitario IS 'Coluna com o preço unitario dos itens';
COMMENT ON COLUMN pedidos_itens.quantidade IS 'Coluna com a quantidade dos itens';
COMMENT ON COLUMN pedidos_itens.envio_id IS 'Coluna com o id dos envios';

-- Criação das constraints de verificação.

ALTER TABLE pedidos 
ADD CONSTRAINT verificacao_pedidos
CHECK (status IN ('COMPLETO', 'ABERTO', 'CANCELADO', 'PAGO', 'ENVIADO', 'REEMBOLSADO'));

ALTER TABLE envios 
ADD CONSTRAINT verificacao_envios
CHECK (status IN ('TRANSITO', 'CRIADO', 'ENTREGUE', 'ENVIADO'));

ALTER TABLE lojas
ADD CONSTRAINT verificacao_enderecos
CHECK ((endereco_fisico IS NOT NULL AND endereco_web IS NULL) OR
       (endereco_fisico IS NULL AND endereco_web IS NOT NULL));
      
-- Constraints de criação das foreign key e primary key.
      
ALTER TABLE estoques ADD CONSTRAINT produtos_estoques_fk
FOREIGN KEY (produto_id)
REFERENCES produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE pedidos_itens ADD CONSTRAINT produtos_pedidos_itens_fk
FOREIGN KEY (produto_id)
REFERENCES produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE envios ADD CONSTRAINT lojas_envios_fk
FOREIGN KEY (loja_id)
REFERENCES lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE estoques ADD CONSTRAINT lojas_estoques_fk
FOREIGN KEY (loja_id)
REFERENCES lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE pedidos ADD CONSTRAINT lojas_pedidos_fk
FOREIGN KEY (loja_id)
REFERENCES lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE envios ADD CONSTRAINT clientes_envios_fk
FOREIGN KEY (cliente_id)
REFERENCES clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE pedidos ADD CONSTRAINT clientes_pedidos_fk
FOREIGN KEY (cliente_id)
REFERENCES clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE pedidos_itens ADD CONSTRAINT pedidos_pedidos_itens_fk
FOREIGN KEY (pedido_id)
REFERENCES pedidos (pedido_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE pedidos_itens ADD CONSTRAINT envios_pedidos_itens_fk
FOREIGN KEY (envio_id)
REFERENCES envios (envio_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
