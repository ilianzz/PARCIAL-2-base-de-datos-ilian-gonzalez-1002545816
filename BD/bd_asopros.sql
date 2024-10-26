DROP DATABASE IF EXISTS asopros_ventas;
CREATE DATABASE asopros_ventas;
USE asopros_ventas;

-- Tabla de productos
CREATE TABLE products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255),
    description VARCHAR(255),
    price DECIMAL(10, 3),
    stock INT DEFAULT 0
);
-- Tabla de roles
CREATE TABLE roles (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    role_name VARCHAR(255) NOT NULL
);

-- Tabla de direcciones
CREATE TABLE addresses (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    address TEXT
);

-- Tabla de clientes
CREATE TABLE customers (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255),
    address_id INT,
    FOREIGN KEY (address_id) REFERENCES addresses(id)
);

-- Tabla de contactos para clientes
CREATE TABLE contacts (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    contact_type ENUM('email', 'phone'),
    contact_value VARCHAR(255),
    FOREIGN KEY (customer_id) REFERENCES customers(id)
);

-- Tabla intermedia entre clientes y roles
CREATE TABLE customer_roles (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    role_id INT,
    FOREIGN KEY (customer_id) REFERENCES customers(id),
    FOREIGN KEY (role_id) REFERENCES roles(id)
);

-- Tabla de estados de órdenes
CREATE TABLE order_status (
    id INT  NOT NULL AUTO_INCREMENT PRIMARY KEY,
    status_name VARCHAR(255)
);

-- Tabla de órdenes
CREATE TABLE orders (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    order_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    total DECIMAL(10, 3),
    status_id INT, 
    FOREIGN KEY (customer_id) REFERENCES customers(id),
    FOREIGN KEY (status_id) REFERENCES order_status(id)
);

-- Tabla de detalles de órdenes
CREATE TABLE order_details (
    id INT  NOT NULL AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    price DECIMAL(10, 3),
    subtotal DECIMAL(10, 3),
    FOREIGN KEY (order_id) REFERENCES orders(id),
    FOREIGN KEY (product_id) REFERENCES products(id)
);

-- Tabla de pagos
CREATE TABLE payments (
    id INT  NOT NULL AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    payment_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    payment_method VARCHAR(255),
    paid_amount DECIMAL(10, 3),
    FOREIGN KEY (order_id) REFERENCES orders(id)
);

-- Insertar productos
INSERT INTO products (name, description, price, stock)
VALUES 
('Organic Chocolate', '100% organic cacao chocolate', 20.000, 100),
('Mucilage Honey', 'Natural mucilage cacao jelly', 5.000, 50),
('Cocada', 'Cocada mixed with chocolate', 2.000, 40),
('Borojo Jelly', 'Natural borojo jelly', 7.000, 30);

-- Insertar roles
INSERT INTO roles (role_name)
VALUES ('Cliente'), ('Empleado');

-- Insertar estados de órdenes
INSERT INTO order_status (status_name)
VALUES ('Pending'), ('Paid');

-- Insertar direcciones 
INSERT INTO addresses (address)
VALUES 
('Primero de Enero, Mocoa'), 
('Puerto Rosario, Puerto Guzmán'), 
('La Unión, Mocoa'), 
('Villa Caimaron, Mocoa'), 
('17 de Julio, Mocoa'), 
('Pablo Sexto, Mocoa'); 

-- Insertar clientes 
INSERT INTO customers (name, address_id)
VALUES 
('Juan Pérez', 1), 
('Ana García', 2),
('Maria Rosales', 3),
('Sergio Moles', 1), 
('Alexis Soto', 1),  
('Manuela Lopez', 1),  
('Jaider Molinero', 3),
('Camila Vallejo', 4),
('Maria Muños', 5),
('Juan Lopez', 6);

-- Insertar contactos para clientes
INSERT INTO contacts (customer_id, contact_type, contact_value)
VALUES 
(1, 'email', 'juan@gmail.com'), (1, 'phone', '3145653312'),
(2, 'email', 'ana@gmail.com'), (2, 'phone', '3214537281'),
(3, 'email', 'maria@gmail.com'), (3, 'phone', '3115459816'),
(4, 'email', 'sergio@gmail.com'), (4, 'phone', '3147591795'),
(5, 'email', 'alexis@gmail.com'), (5, 'phone', '3112591796'),
(6, 'email', 'manuela@gmail.com'), (6, 'phone', '311545881'),
(7, 'email', 'jaide@gmail.com'), (7, 'phone', '3213830316'),
(8, 'email', 'camila@gmail.com'), (8, 'phone', '3115458672'),
(9, 'email', 'maria@gmail.com'), (9, 'phone', '3214337681'),
(10, 'email', 'juan@gmail.com'), (10, 'phone', '3112553347');

-- Asignar roles a clientes (cliente o empleado)
INSERT INTO customer_roles (customer_id, role_id)
VALUES 
(1, 1), (2, 1), (3, 1), (4, 2), (5, 2),
(6, 1), (7, 2), (8, 1), (9, 1), (10, 1);

-- Insertar órdenes
INSERT INTO orders (customer_id, total, status_id)
VALUES 
(1, 40.000, 1),
(2, 5.000, 1),
(3, 40.000, 1),
(4, 7.000, 2),
(5, 2.000, 2),
(6, 20.000, 2),
(7, 10.000, 2),
(8, 14.000, 2),
(9, 20.000, 1),
(10, 14.000, 2);

-- Insertar detalles de órdenes
INSERT INTO order_details (order_id, product_id, quantity, price, subtotal)
VALUES 
(1, 1, 2, 20.000, 40.000),
(2, 2, 1, 5.000, 5.000),
(3, 1, 2, 20.000, 40.000),
(4, 4, 2, 7.000, 14.000),
(5, 3, 3, 2.000, 6.000),
(6, 1, 1, 20.000, 20.000),
(7, 2, 2, 5.000, 10.000),
(8, 4, 2, 7.000, 14.000),
(9, 1, 1, 20.000, 20.000),
(10, 4, 2, 7.000, 14.000);

-- Insertar pagos
INSERT INTO payments (order_id, payment_method, paid_amount)
VALUES 
(1, 'credit card', 40.000),
(2, 'cash', 5.000),
(3, 'credit card', 40.000),
(4, 'cash', 14.000),
(5, 'cash', 6.000),
(6, 'credit card', 20.000),
(7, 'cash', 10.000),
(8, 'cash', 14.000),
(9, 'credit card', 20.000),
(10, 'cash', 14.000);
