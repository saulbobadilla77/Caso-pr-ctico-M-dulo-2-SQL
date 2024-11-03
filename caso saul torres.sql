--- Contexto

-- El restaurante "Sabores del Mundo", es conocido por su auténtica cocina y su ambiente acogedor.
-- Este restaurante lanzó un nuevo menú a principios de año y ha estado recopilando información detallada de las
-- transacciones de los clientes para identificar áreas de oportunidad y aprovechar al máximo sus datos para optimizar
-- las ventas.

--- Objetivo

-- Identificar cuáles son los productos del menú que han tenido más exito y cuáles son los que menos han gustado a los clientes.

--- Pasos a seguir

-- a) Crear la base dedatos con el archivo create_restaurant_db.sql

-- b) Explorar la tabla "menu_items" para conocer los productos del menú.

---- 1) Realizar consultas para contestar las siguientes preguntas:

SELECT * FROM menu_items

--- 1A -- Encontrar el número de artículos en el menú.

SELECT COUNT (DISTINCT item_name)
FROM menu_items

	--- R = 32

--- 1B -- ¿Cuál es el artículo menos caro y el más caro en el menú?

SELECT *
FROM menu_items
ORDER BY PRICE ASC, item_name


	--- R = 5.00 EDAMAME

SELECT *
FROM menu_items
ORDER BY PRICE DESC, item_name

	--- R = 19.95 SHRIMP SCAMPI


--- 1C -- ¿Cuántos platos americanos hay en el menú ?

SELECT COUNT (category)
FROM menu_items
WHERE category = 'American'
	
--- R = 6
	
--- 1D -- ¿Cuál es el precio promedio de los platos ?

	SELECT ROUND (AVG (price),2)
	FROM menu_items

--- R = 13.29
	

-- c) Explorar la tabla "order_details" para conocer los datos que han sido recolectados.

---- 1) Realizar consultas para contestar las siguientes preguntas:

	SELECT * FROM order_details
	

--- 1A -- ¿Cuántos pedidos únicos se realizaron en total?

	SELECT COUNT(DISTINCT order_id)
	FROM order_details

	--- R = 5370
	

--- 1B -- ¿Cuáles son los 5 pedidos que tuvieron mayor número de artículos ?

SELECT ORDER_ID, COUNT (ITEM_ID)
FROM ORDER_DETAILS
GROUP BY ORDER_ID
ORDER BY COUNT (ITEM_ID) DESC
LIMIT 5;

--- 1C -- ¿Cuándo se realizó el primer pedido y el último pedido ?

SELECT *
FROM order_details
ORDER BY order_date ASC, order_time ASC
LIMIT 1;


SELECT *
FROM order_details
ORDER BY order_date DESC, order_time DESC
LIMIT 1;


--- 1D -- ¿Cuántos pedidos se hicieron entre el '2023-01-01' y el '2023-01-05'

SELECT *
FROM order_details
WHERE order_date BETWEEN '2023-01-01' AND '2023-01-05';

--- R = 702

-- d) Usar ambas tablas para conocer la reacción de los clientes respecto al menú.

---- 1) Realizar un LEFT JOIN entre order_details y menu_items con el identificador item_id (tabla order_details)
---- y menu_item_id (tabla menu_items)

SELECT *
FROM ORDER_DETAILS AS O
LEFT JOIN MENU_ITEMS AS M
ON O.item_id=M.menu_item_id;

-- e) Una vez que hayas explorado los datos en las tablas correspondientes y respondido las preguntas planteadas, realiza
-- un análisis adicional utilizando este JOIN entre las tablas. El objetivos es identificar 5 puntos clave que puedan ser de 
-- utilidad para los dueños del restaurante en el lanzamiento de su nuevo menú. Para ello, crea tus propias consultas
-- y utiliza los resultados obtenido para llegar a estas conclusiones.


--- 1 ¿Cuáles son los platillos más pedidos del menú ?


SELECT COUNT (o.order_id), m.item_name
FROM ORDER_DETAILS AS O
LEFT JOIN MENU_ITEMS AS M
ON O.item_id=M.menu_item_id
GROUP BY m.item_name
ORDER BY COUNT (o.order_id) DESC

--- 2 ¿Cuántos pedidos recibió cada categoría del menú?

SELECT COUNT (o.order_id), m.category
FROM ORDER_DETAILS AS O
LEFT JOIN MENU_ITEMS AS M
ON O.item_id=M.menu_item_id
GROUP BY m.category


--- 3 ¿Cuál es la categoría más pedida del menú?

SELECT COUNT (o.order_id), m.category
FROM ORDER_DETAILS AS O
LEFT JOIN MENU_ITEMS AS M
ON O.item_id=M.menu_item_id
GROUP BY m.category
ORDER BY COUNT (o.order_id) DESC
LIMIT 1;

--- R = Asian

--- 4 ¿Cuál es la categoría menos pedida del menú?

SELECT COUNT (o.order_id), m.category
FROM ORDER_DETAILS AS O
LEFT JOIN MENU_ITEMS AS M
ON O.item_id=M.menu_item_id
GROUP BY m.category
ORDER BY COUNT (o.order_id) ASC

--- R = American

--- 5 ¿Cuál es platillo favorito de todo el menú ?

SELECT COUNT (o.order_id), m.item_name
FROM ORDER_DETAILS AS O
LEFT JOIN MENU_ITEMS AS M
ON O.item_id=M.menu_item_id
GROUP BY m.item_name
ORDER BY COUNT (o.order_id) DESC

--- R = Hamburger con 622 pedidos de la categoría American

--- 6 ¿Cuál es platillo menos pedido de todo el periodo ?

SELECT COUNT (o.order_id), m.item_name
FROM ORDER_DETAILS AS O
LEFT JOIN MENU_ITEMS AS M
ON O.item_id=M.menu_item_id
GROUP BY m.item_name
ORDER BY COUNT (o.order_id) ASC

--- R = Chicken Tacos con 123 órdenes en todo el periodo de la categoría Mexican



























































