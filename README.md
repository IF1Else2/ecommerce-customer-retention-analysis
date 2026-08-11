# Retención de clientes en un e-commerce: ¿quién vuelve a comprar y qué hacer para que vuelvan más?

Análisis end-to-end sobre datos reales de un marketplace (Olist, ~100.000 pedidos).

## Preguntas del proyecto
1. ¿Cuántos clientes vuelven a comprar, y en qué momento los perdemos?
2. ¿Qué distingue a un cliente que repite de uno que no?
3. ¿Dónde debería intervenir la empresa, y cuánto vale hacerlo?

## Los datos
Dataset público de Olist (marketplace brasileño), ~100.000 pedidos entre 04/09/2016 y 17/10/2018. Nueve tablas: pedidos, clientes, líneas de pedido, pagos, reseñas, productos, vendedores, geolocalización y traducción de categorías. Volumen total: 99.441 pedidos, 112.650 líneas de pedido.

**Decisión de análisis:** para medir recompra se consideran solo pedidos `delivered` (97% del total). Se excluyen cancelados, no disponibles y pedidos en tránsito, por no representar compras completadas.

## Hallazgos
**Pregunta 1 — Recompra:** solo el 3,0% de los clientes (2.801 de 93.358) realiza una segunda compra. El 97% compra una vez y no vuelve. La caída más brutal está entre el primer y el segundo pedido.

*(Preguntas 2 y 3: en construcción)*
