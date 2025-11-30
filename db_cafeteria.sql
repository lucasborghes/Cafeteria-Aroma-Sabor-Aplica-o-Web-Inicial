-- Criação do banco (opcional, se já não existir)
CREATE DATABASE cafeteria_aroma_sabor;

-- Usar o banco (em alguns clientes, isso é feito na conexão)
-- \c cafeteria_aroma_sabor   -- no psql

-- 1) Tabela de produtos
CREATE TABLE produtos (
    id_produto SERIAL PRIMARY KEY,
    nome        VARCHAR(100) NOT NULL,
    preco       NUMERIC(10,2) NOT NULL,
    categoria   VARCHAR(50)
);

-- 2) Tabela de pedidos
CREATE TABLE pedidos (
    id_pedido    SERIAL PRIMARY KEY,
    data_pedido  TIMESTAMP NOT NULL DEFAULT NOW(),
    nome_cliente VARCHAR(100) NOT NULL,
    total        NUMERIC(10,2) NOT NULL
);

-- 3) Tabela de itens do pedido
CREATE TABLE itens_pedido (
    id_item      SERIAL PRIMARY KEY,
    id_pedido    INTEGER NOT NULL,
    id_produto   INTEGER NOT NULL,
    quantidade   INTEGER NOT NULL,
    preco_unitario NUMERIC(10,2) NOT NULL,
    CONSTRAINT fk_pedido
        FOREIGN KEY (id_pedido) REFERENCES pedidos(id_pedido),
    CONSTRAINT fk_produto
        FOREIGN KEY (id_produto) REFERENCES produtos(id_produto)
);

-- Inserir pelo menos 3 produtos
INSERT INTO produtos (nome, preco, categoria) VALUES
('Café espresso', 7.50, 'Café'),
('Cappuccino', 12.00, 'Café'),
('Bolo de chocolate', 9.00, 'Doce');

-- Inserir pelo menos 3 pedidos
INSERT INTO pedidos (data_pedido, nome_cliente, total) VALUES
('2025-11-30 09:15:00', 'Mariana', 19.50),
('2025-11-30 10:30:00', 'Carlos', 21.00),
('2025-11-30 11:05:00', 'Ana', 9.00);

-- Inserir itens para os pedidos
-- Pedido 1: Mariana
INSERT INTO itens_pedido (id_pedido, id_produto, quantidade, preco_unitario) VALUES
(1, 1, 1, 7.50),   -- 1 Café espresso
(1, 3, 1, 9.00);   -- 1 Bolo de chocolate

-- Pedido 2: Carlos
INSERT INTO itens_pedido (id_pedido, id_produto, quantidade, preco_unitario) VALUES
(2, 2, 1, 12.00),  -- 1 Cappuccino
(2, 3, 1, 9.00);   -- 1 Bolo de chocolate

-- Pedido 3: Ana
INSERT INTO itens_pedido (id_pedido, id_produto, quantidade, preco_unitario) VALUES
(3, 3, 1, 9.00);   -- 1 Bolo de chocolate
