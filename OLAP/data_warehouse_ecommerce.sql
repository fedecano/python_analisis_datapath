#creamos la base de datos para el modelo multidimensional
CREATE DATABASE dw_ecommerce;

##usamos la base de datos creada
USE dw_ecommerce;


/*CREAMOS LAS DIMENCIONES*/

/*creamos la tabla de CLIENTES*/
CREATE TABLE dimClientes (
	cliente_id VARCHAR(100) PRIMARY KEY,
    cliente_unique_id VARCHAR(100),
    nombre VARCHAR (100),
    apellido VARCHAR (100),
    sexo VARCHAR (1),
    estado VARCHAR (100)
);

/*creamos la tabla de Productos*/
CREATE TABLE dimProducts (
	producto_id varchar(100) PRIMARY KEY,
    nombre varchar (100),
);

/*creamos la tabla de Vendedor*/
CREATE TABLE dimVendedor (
	vendedor_id varchar(100) PRIMARY KEY,
    ciudad_vendedor varchar (100),
    estado_vendedor varchar(5)
);

/*creamos la tabla de dimension_time*/
CREATE TABLE dimTime (
    time_id INT PRIMARY KEY,
    year INT NOT NULL,
    quarter INT NOT NULL,
    month INT NOT NULL,
    day INT NOT NULL,
    day_of_week INT NOT NULL,
    day_of_year INT NOT NULL,
    week_of_year INT NOT NULL,
    is_weekend BOOLEAN NOT NULL
);


/* TABLAS DE HECHOS */
/*creamos la tabla de FactOrdenPorCliente*/
CREATE TABLE FactOrdenPorCliente (

	order_id varchar(100),
    cliente_id VARCHAR(100),
    estado_orden varchar(10),
    fecha_hora_orden_compra INTEGER,
    fecha_hora_orden_aprobada INTEGER,
    fecha_hora_entrega_transportadora INTEGER,
    fecha_hora_entrega_cliente INTEGER,
    fecha_estimada_entrega INTEGER,
    timestamp  timestamp,
    
    /* CREANDO LAS REALACIONES*/
    CONSTRAINT fk_orden_cliente FOREIGN KEY (cliente_id) REFERENCES dimClientes(cliente_id),
	CONSTRAINT fk_factwatchs_user FOREIGN KEY (userID) REFERENCES dimUser (userID),
    CONSTRAINT fk_ordencliente_time_compra FOREIGN KEY (fecha_hora_orden_compra) REFERENCES dimTime(time_id),
    CONSTRAINT fk_ordencliente_time_aprob FOREIGN KEY (fecha_hora_orden_aprobada) REFERENCES dimTime(time_id),
    CONSTRAINT fk_orden_entrega_transportadora FOREIGN KEY (fecha_hora_entrega_transportadora) REFERENCES dimTime(time_id),
    CONSTRAINT fk_orden_entrega_cliente FOREIGN KEY (fecha_hora_entrega_cliente) REFERENCES dimTime(time_id),
    CONSTRAINT fk_orden_estimada_entrega FOREIGN KEY (fecha_estimada_entrega) REFERENCES dimTime(time_id),

);

/*creamos la tabla de CLIENTES*/
CREATE TABLE item_orden (
	orden_item_id VARCHAR(100) PRIMARY KEY,
    orden_id VARCHAR(100),
    producto_id VARCHAR(100),
    vendedor_id VARCHAR(100),
    fecha_limite  INT ,
    precio float,
    valor_transporte float,
    FOREIGN KEY (orden_id) REFERENCES FactOrdenPorCliente(order_id),
    FOREIGN KEY (producto_id) REFERENCES dimProducts(producto_id),
    FOREIGN KEY (vendedor_id) REFERENCES dimVendedor(vendedor_id),
    FOREIGN KEY (fecha_limite) REFERENCES dimTime(time_id)
);

/*creamos la tabla de CLIENTES*/
CREATE TABLE pagos (
	orden_item_id VARCHAR(100) PRIMARY KEY,
    orden_id VARCHAR(100),
    producto_id VARCHAR(100),
    vendedor_id VARCHAR(100),
    time_id INT ,
    precio float,
    valor_transporte float
);