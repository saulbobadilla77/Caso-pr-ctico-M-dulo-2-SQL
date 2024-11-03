# Caso-pr-ctico-M-dulo-2-SQL
Análisis de restaurantes en SQL

El producto más vendido del restaurante Sabores del Mundo son las hamburguesas, cuenta con productos Americanos, Asiáticos, Mexicanos e Italianos, siendo un total de 32 platillos.
el artículo más barato es el Edemame y el más caro los camarones. 

El precio promedio es de 13.29 dólares.
En un lapso de 4 meses Enero 1 a Mayo 1, se tuvieron un total de 702 ordenes.

El top 5 de productos más vendidos son
1 hamburguesas
2 Edemame
3 Filete koreano
4 Hamburguesa con queso
5 Papas fritas

Se observa que el favorito es la comida americana, hamburguesas y papas por lo que los esfuerzos de la empresa deberían estar ahí.
Tal vez combinar promociones especiales con las papas fritas y edemames, que en precio son más económicos y parecen ser los complementos favoritos


Código:

/* 

Contexto

El restaurante "Sabores del Mundo", es conocido por su auténtica cocina y su ambiente acogedor. 
Este restaurante lanzó un nuevo menú a principios de año y ha estado recopilando información detallada sobre las transacciones 
de los clientes para identificar áreas de oportunidad y aprovechar al máximo sus datos para optimizar las ventas. 

Objetivo 

Identificar cuáles son los productos del menú que han tenido más éxito y cuales son los que menos han gustado a los clientes. 

Pasos a seguir 
a) Crear la base de datos con el archivo create_restaurant_db.sql 
b) Explorar la tabla “menu_items” para conocer los productos del menú.

 1.- Realizar consultas para contestar las siguientes preguntas: 

 ● Encontrar el número de artículos en el menú. 
 ● ¿Cuál es el artículo menos caro y el más caro en el menú?
 ● ¿Cuántos platos americanos hay en el menú? 
 ● ¿Cuál es el precio promedio de los platos? 
 
 c) Explorar la tabla “order_details” para conocer los datos que han sido recolectados. 
 
1.- Realizar consultas para contestar las siguientes preguntas:

● ¿Cuántos pedidos únicos se realizaron en total?
● ¿Cuáles son los 5 pedidos que tuvieron el mayor número de artículos? 
● ¿Cuándo se realizó el primer pedido y el último pedido?
● ¿Cuántos pedidos se hicieron entre el '2023-01-01' y el '2023-01-05'?

d) Usar ambas tablas para conocer la reacción de los clientes respecto al menú.

1.- Realizar un left join entre entre order_details y menu_items con el identificador
item_id(tabla order_details) y menu_item_id(tabla menu_items). 

e) Una vez que hayas explorado los datos en las tablas correspondientes y respondido las
preguntas planteadas, realiza un análisis adicional utilizando este join entre las tablas.

El objetivo es identificar 5 puntos clave que puedan ser de utilidad para los dueños del 
restaurante en el lanzamiento de su nuevo menú. 
Para ello, crea tus propias consultas y utiliza los resultados obtenidos para llegar a 
estas conclusiones.*/

--b) Explorar la tabla “menu_items” para conocer los productos del menú.
select * 
from menu_items;

-- ● Encontrar el número de artículos en el menú. 


select count (menu_item_id) 
from menu_items;

--  ● ¿Cuál es el artículo menos caro y el más caro en el menú?


-- Menos económico item_name: 

select item_name, price 
from menu_items
order by 2 asc
limit 1;

-- Mas caro item_name: 

select item_name, price
from menu_items
order by 2 desc
limit 1;



-- ● ¿Cuántos platos americanos hay en el menú? 

select count(menu_item_id)
from menu_items
where category = 'American';

-- ● ¿Cuál es el precio promedio de los platos? 

select round(avg(price),2)
from menu_items;

 --c) Explorar la tabla “order_details” para conocer los datos que han sido recolectados. 

select * 
from order_details;

-- ● ¿Cuántos pedidos únicos se realizaron en total?

select count(distinct(order_id))
from order_details;

--  ● ¿Cuáles son los 5 pedidos que tuvieron el mayor número de artículos? 

select order_details_id, order_id, item_id
from order_details
where item_id is not null
order by 3 desc
limit 5;


-- ● ¿Cuándo se realizó el primer pedido y el último pedido?

select order_date
from order_details
order by order_date
limit 1;

-- Ultimo pedido:

select order_date
from order_details
order by order_date desc
limit 1;

--● ¿Cuántos pedidos se hicieron entre el '2023-01-01' y el '2023-01-05'?

select count(order_details_id)
from order_details	
where order_date between '2023-01-01' and '2023-01-05';

/* 1.- Realizar un left join entre entre order_details y menu_items con el identificador
item_id(tabla order_details) y menu_item_id(tabla menu_items). */

select * from
order_details a
left join
menu_items b
on a.item_id = b.menu_item_id;


/*...Para ello, crea tus propias consultas y utiliza los resultados obtenidos para llegar a 
estas conclusiones.*/


--El producto más vendido
select b.item_name, 
	   count(b.item_name)
from
order_details a
left join
menu_items b
on a.item_id = b.menu_item_id	
group by item_name
order by 2 desc
limit 1;
--Top 5 de productos mas vendidos
select b.item_name, 
	   count(b.item_name)
from
order_details a
left join
menu_items b
on a.item_id = b.menu_item_id	
group by item_name
order by 2 desc
limit 5;

--Top 5 de productos menos vendidos
select b.item_name, 
count(b.item_name)
from
order_details a
left join
menu_items b
on a.item_id = b.menu_item_id	
where item_name is not null
group by item_name
order by 2 asc
limit 5;

-- Top 5 productos mas economicos

select item_name, price 
from menu_items
order by 2 asc
limit 5;

-- Top 5 productos mas caros

select item_name, price
from menu_items
order by 2 desc
limit 5;


