---
title: Escribiendo Buen Software
teaching: 15
exercises: 0
questions:
- "¿Cómo puedo escribir software que otras personas puedan usar?"
objectives:
- "Describe las mejores prácticas para escribir en R y explica la justificación de cada una."
keypoints:
- "Documenta qué y por qué, no cómo."
- "Divide los programas en funciones cortas de un solo propósito."
- "Escribe pruebas re-ejecutables."
- "No repitas tu código."
- "No repitas tu código."
- "Se coherente en la nomenclatura, indentación y otros aspectos del estilo."
source: Rmd
---

## Hacer código legible

La parte más importante de escribir código es hacer que sea legible y comprensible.
Quieres que otra persona pueda tener tu código y comprenda lo que hace: la mayoría de las veces, esta persona 
serás tú 6 meses después, si no es comprensible te estarás culpando.

## Documentación: dinos qué y por qué, no cómo

Cuando comienzas por primera vez, tus comentarios a menudo describen lo que hace un comando, ya que aún te 
encuentras en aprendizaje y puede ayudarte a aclarar conceptos y recordarte más tarde. Sin embargo, estos 
comentarios no son particularmente útiles más adelante cuando no recuerda qué problema está tratando de 
resolver su código. Intenta incluir también comentarios que te digan * por qué * estás resolviendo un problema 
y * qué * problema es. El * cómo * puede venir después de eso: es un detalle de implementación del que 
idealmente no deberías preocuparte.

## Manten tu código modular

Nuestra recomendación es que debes separar tus funciones de los ##scripts## y 
almacenarlas en un archivo separado 'fuente' cuando abras la sesión R en tu proyecto. Este enfoque es bueno 
porque te deja un ##script## ordenado y un repositorio de funciones útiles que se pueden cargar en 
cualquier script en tu proyecto. También le permite agrupar funciones relacionadas 
fácilmente.

## Divide el problema en bloques pequeños

Cuando comienzas por primera vez, la resolución de problemas y la escritura de funciones pueden ser tareas 
desalentadoras y difíciles de separar de la inexperiencia del código. Trata de dividir tu problema en bloques 
digeribles y preocúpate por los detalles de la implementación más adelante: sigue dividiendo el problema en 
funciones cada vez más pequeñas hasta que llegues a un punto en el que puedas codificar una solución y 
reconstruye desde ese punto.

## Conoce que tu código está haciendo lo correcto

¡Asegúrate de probar tus funciones!

## No repitas tu código

Las funciones permiten una fácil reutilización dentro de un proyecto. Si identificas bloques de líneas de código similares a través de tu proyecto, esos suelen ser candidatos para ser
movido a funciones.

Si tus cálculos se realizan a través de una serie de funciones, entonces la
el proyecto se vuelve más modular y más fácil de cambiar. Este es especialmente el caso para el cual una entrada particular siempre da una salida particular.

## Recuerda ser elegante

Aplica consistentemente estilo a tu código.
