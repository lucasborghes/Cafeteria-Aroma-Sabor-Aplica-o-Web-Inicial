-- Criação do banco (opcional, se já não existir)
CREATE DATABASE cafeteria_aroma_sabor;

-- Usar o banco (em alguns clientes, isso é feito na conexão)
-- \c cafeteria_aroma_sabor   -- no psql

-----------------------------------------------------------
-- 1) Tabela de produtos (ATUALIZADA)
-----------------------------------------------------------
CREATE TABLE produtos (
    id_produto SERIAL PRIMARY KEY,
    nome        VARCHAR(100),
    preco       NUMERIC(10,2),
    categoria   VARCHAR(50)
);

-----------------------------------------------------------
-- 2) Tabela de pedidos (ATUALIZADA)
-----------------------------------------------------------
CREATE TABLE pedidos (
    id_pedido    SERIAL PRIMARY KEY,
    data_pedido  TIMESTAMP DEFAULT NOW(),
    nome_cliente VARCHAR(100),
    total        NUMERIC(10,2)
);

-----------------------------------------------------------
-- 3) Tabela de itens do pedido (ATUALIZADA)
-----------------------------------------------------------
CREATE TABLE itens_pedido (
    id_item        SERIAL PRIMARY KEY,
    id_pedido      INTEGER REFERENCES pedidos(id_pedido),
    id_produto     INTEGER REFERENCES produtos(id_produto),
    quantidade     INTEGER,
    preco_unitario NUMERIC(10,2)
);

-----------------------------------------------------------
-- Inserir produtos (ATUALIZADO)
-----------------------------------------------------------
INSERT INTO produtos (nome, preco, categoria) VALUES
('Café Espresso', 7.50, 'Café'),
('Cappuccino',    12.00, 'Café'),
('Bolo Caseiro',  9.00, 'Doce');

-----------------------------------------------------------
-- Inserir pedidos (MANTIDO)
-----------------------------------------------------------
INSERT INTO pedidos (data_pedido, nome_cliente, total) VALUES
('2025-11-30 09:15:00', 'Mariana', 19.50),
('2025-11-30 10:30:00', 'Carlos', 21.00),
('2025-11-30 11:05:00', 'Ana', 9.00);

-----------------------------------------------------------
-- Inserir itens para os pedidos (MANTIDO, só ajuste nos comentários)
-----------------------------------------------------------

-- Pedido 1: Mariana
INSERT INTO itens_pedido (id_pedido, id_produto, quantidade, preco_unitario) VALUES
(1, 1, 1, 7.50),   -- 1 Café Espresso
(1, 3, 1, 9.00);   -- 1 Bolo Caseiro

-- Pedido 2: Carlos
INSERT INTO itens_pedido (id_pedido, id_produto, quantidade, preco_unitario) VALUES
(2, 2, 1, 12.00),  -- 1 Cappuccino
(2, 3, 1, 9.00);   -- 1 Bolo Caseiro

-- Pedido 3: Ana
INSERT INTO itens_pedido (id_pedido, id_produto, quantidade, preco_unitario) VALUES
(3, 3, 1, 9.00);   -- 1 Bolo Caseiro

-----------------------------------------------------------
-- Exemplo de consulta (NOVO)
-----------------------------------------------------------
SELECT p.nome_cliente, pr.nome, ip.quantidade
FROM pedidos p
JOIN itens_pedido ip ON p.id_pedido = ip.id_pedido
JOIN produtos pr ON pr.id_produto = ip.id_produto;
