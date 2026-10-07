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
**Pregunta 1 — Recompra:** solo el 3,0% de los clientes (2.801 de 93.358) realiza una segunda compra. De los que vuelven, el tiempo típico hasta la segunda compra es de 71 días (mediana; media 112). No existe recompra temprana: quien regresa, tarda más de dos meses. La ventana de reenganche (las primeras semanas tras la compra) está desaprovechada.

**Pregunta 2 — ¿Qué distingue al que repite?** Se probaron tres factores del primer pedido: tiempo de entrega, valor de la compra y puntuación de la reseña. Ninguno predice la recompra: clientes satisfechos (5★) y descontentos (1★) repiten por igual (~3%), la entrega es idéntica entre grupos, y el valor apenas difiere. 

Conclusión: la baja retención no responde a una mala experiencia puntual, sino que es estructural del modelo marketplace. Implicación: no basta con "hacerlo bien" en el primer pedido; hace falta un mecanismo activo de reenganche.

**Pregunta 3 — Recomendación:** 

Diagnóstico. La recompra en Olist es del 3%: el 97% de los clientes compra una vez y no vuelve. Quien vuelve tarda una mediana de 71 días. Ninguno de los factores analizados del primer pedido (tiempo de entrega, puntuación de reseña, valor de compra) predice la recompra: clientes satisfechos y descontentos vuelven por igual. Conclusión: la baja retención no es un problema de experiencia puntual, sino estructural.

Recomendación. Dado que (a) la recompra, cuando ocurre, se produce hacia los 71 días, y (b) ninguna mejora de experiencia la moviliza, la única palanca con sentido es un disparador temporal activo. Por ejemplo, una campaña de reactivación (email + incentivo) enviada a los 45-60 días de la primera compra (antes de la ventana natural de recompra) para adelantarla y aumentarla. Es una acción proactiva de retención, no una mejora de servicio.

Impacto estimado. Con 42.131 clientes nuevos al año (base 2017) y asumiendo que la campaña elevara la recompra del 3% al 5% (+2 puntos), serían ~843 recompras adicionales al año. A un valor mediano de pedido de 86,58 R$, el ingreso incremental anual rondaría los 73.000 R$.

Supuestos y límites: el aumento de +2 puntos es solo orientativo. La cifra corresponde a facturación bruta, sin descontar el coste de la campaña ni el margen. Además, no todos los clientes que no repiten compra pueden recuperarse, ya que algunos productos son de compra única. Por tanto, la cifra es una estimación aproximada, no una previsión.
