Test.destroy_all
Lesson.destroy_all
Account.destroy_all
Question.destroy_all
Option.destroy_all

# Cuentas de los dev

dosa = Account.create(name: 'Agustín Dosantos', email: 'agustind994@gmail.com', password: 'Boca2023', nickname: 'Dosaagu', progress: 0, theme_light: true)
juani = Account.create(name: 'Juani Villanueva', email: 'juani2002villa@gmail.com', password: 'Bocapasion123', nickname: 'Juani', progress: 0, theme_light: true)
sosa = Account.create(name: 'Santiago Sosa Moressi', email: 'santiagososamoressi@gmail.com', password: 'Bocapasion123', nickname: 'Santi', progress: 0, theme_light: true)
niko = Account.create(name: 'Nicolás Mercado', email: 'nicolasmercado452@gmail.com', password: 'NicoMercado22', nickname: 'Nico', progress: 0, theme_light: true)


# Test A
test_a = Test.create(letter: "A", description: "Introducción a Haskell", cant_questions: 5)

lesson_a1 = Lesson.create(number: 1, title: "Introducción a Haskell", description: "En esta lección, aprenderás sobre Haskell, un lenguaje de programación funcional puro. Haskell se basa en la evaluación lazy, lo que significa que los cálculos se posponen hasta que los resultados sean necesarios. Además, Haskell se destaca por su expresividad y concisión en el código. Conocerás los fundamentos de Haskell, su sintaxis y cómo se utiliza para resolver problemas de programación.", test_letter: test_a.letter)
lesson_a2 = Lesson.create(number: 2, title: "Tipos de datos en Haskell", description: "Los tipos de datos son una parte fundamental en Haskell. Aprenderás sobre los tipos básicos, como enteros, caracteres y booleanos. Además, explorarás los tipos algebraicos, que permiten crear estructuras de datos más complejas. Verás cómo definir tus propios tipos de datos personalizados en Haskell y cómo utilizarlos en tus programas.", test_letter: test_a.letter)
lesson_a3 = Lesson.create(number: 3, title: "Funciones en Haskell", description: "Las funciones son la piedra angular de la programación en Haskell. Aprenderás cómo definir funciones en Haskell, utilizando patrones de coincidencia y guardias para manejar diferentes casos. También explorarás las funciones de orden superior, que permiten pasar funciones como argumentos o devolver funciones como resultados. Descubrirás cómo aprovechar la composición de funciones y cómo implementar recursión en Haskell.", test_letter: test_a.letter)
lesson_a4 = Lesson.create(number: 4, title: "Listas en Haskell", description: "Las listas son una estructura de datos esencial en Haskell. Aprenderás cómo trabajar con listas, incluyendo su creación, manipulación y acceso a elementos. Explorarás las funciones de orden superior, como map, filter y foldr, que te ayudarán a transformar y procesar listas de manera eficiente. También verás cómo implementar recursión sobre listas para realizar operaciones más complejas.", test_letter: test_a.letter)
lesson_a5 = Lesson.create(number: 5, title: "Recursión en Haskell", description: "La recursión es una técnica poderosa en Haskell. Aprenderás cómo utilizar la recursión para resolver problemas de manera elegante y eficiente. Explorarás ejemplos prácticos, como el cálculo de factoriales y la búsqueda en árboles binarios, utilizando funciones recursivas. También descubrirás cómo optimizar funciones recursivas utilizando la recursión de cola.", test_letter: test_a.letter)

question_a1 = Question.create(number: 1, description: "¿Qué es Haskell?", test_letter: test_a.letter)
question_a2 = Question.create(number: 2, description: "¿Cuál de estos no es un tipo de dato en Haskell?", test_letter: test_a.letter)
question_a3 = Question.create(number: 3, description: "¿Cómo se define una función en Haskell?", test_letter: test_a.letter)
question_a4 = Question.create(number: 4, description: "¿Cómo se crea una lista en Haskell?", test_letter: test_a.letter)
question_a5 = Question.create(number: 5, description: "¿Qué es la recursión en Haskell?", test_letter: test_a.letter)

option_a1 = Option.create(number: 1, description: "Un lenguaje de programación funcional", correct: true, question_number: question_a1.number, test_letter: test_a.letter)
option_a2 = Option.create(number: 2, description: "Un lenguaje de programación imperativo", correct: false, question_number: question_a1.number, test_letter: test_a.letter)
option_a3 = Option.create(number: 3, description: "Un lenguaje de programación orientado a objetos", correct: false, question_number: question_a1.number, test_letter: test_a.letter)
option_a4 = Option.create(number: 1, description: "Un tipo de dato en Haskell", correct: false, question_number: question_a2.number, test_letter: test_a.letter)
option_a5 = Option.create(number: 2, description: "Bool", correct: false, question_number: question_a2.number, test_letter: test_a.letter)
option_a6 = Option.create(number: 3, description: "Arraylist", correct: true, question_number: question_a2.number, test_letter: test_a.letter)
option_a7 = Option.create(number: 1, description: "Usando la palabra clave 'function'", correct: false, question_number: question_a3.number, test_letter: test_a.letter)
option_a8 = Option.create(number: 2, description: "Usando el operador '=>'", correct: false, question_number: question_a3.number, test_letter: test_a.letter)
option_a9 = Option.create(number: 3, description: "Usando el símbolo '->'", correct: true, question_number: question_a3.number, test_letter: test_a.letter)
option_a10 = Option.create(number: 1, description: "Mediante un bucle", correct: false, question_number: question_a4.number, test_letter: test_a.letter)
option_a11 = Option.create(number: 2, description: "Usando la palabra clave 'list'", correct: false, question_number: question_a4.number, test_letter: test_a.letter)
option_a12 = Option.create(number: 3, description: "Mediante la notación de corchetes", correct: true, question_number: question_a4.number, test_letter: test_a.letter)
option_a13 = Option.create(number: 1, description: "Un bucle que se llama a sí mismo", correct: false, question_number: question_a5.number, test_letter: test_a.letter)
option_a14 = Option.create(number: 2, description: "Una función que se llama a sí misma", correct: true, question_number: question_a5.number, test_letter: test_a.letter)
option_a15 = Option.create(number: 3, description: "Un tipo de dato en Haskell", correct: false, question_number: question_a5.number, test_letter: test_a.letter)

# Test B
test_b = Test.create(letter: "B", description: "Conceptos básicos de Haskell", cant_questions: 5)

lesson_b1 = Lesson.create(number: 1, title: "Conceptos básicos de Haskell", description: "En esta lección, repasaremos los conceptos fundamentales de Haskell. Aprenderás sobre su historia y características principales, como la programación funcional y la evaluación lazy. También exploraremos la tipificación estática y fuerte de Haskell, así como su sistema de módulos y funciones puras. Al final de esta lección, comprenderás los conceptos básicos que fundamentan el lenguaje Haskell.", test_letter: test_b.letter)
lesson_b2 = Lesson.create(number: 2, title: "Estructuras de control en Haskell", description: "Aprenderás cómo utilizar las estructuras de control en Haskell. Descubrirás cómo realizar estructuras condicionales utilizando la expresión if-then-else, así como cómo utilizar estructuras de repetición, como el bucle for y el bucle while. Exploraremos ejemplos prácticos y veremos cómo aprovechar las estructuras de control para controlar el flujo de ejecución en tus programas Haskell.", test_letter: test_b.letter)
lesson_b3 = Lesson.create(number: 3, title: "Módulos en Haskell", description: "Esta lección se centra en el uso de módulos en Haskell. Aprenderás qué son los módulos y cómo puedes utilizarlos para organizar y reutilizar tu código. Exploraremos cómo importar módulos, cómo definir tus propios módulos y cómo utilizar la declaración de exportación para controlar qué funciones y tipos son visibles fuera del módulo. También discutiremos las mejores prácticas en el uso de módulos en Haskell.", test_letter: test_b.letter)
lesson_b4 = Lesson.create(number: 4, title: "Manipulación de cadenas en Haskell", description: "Aprenderás cómo manipular cadenas de texto en Haskell. Exploraremos las funciones y operadores disponibles para trabajar con cadenas, incluyendo la concatenación, la búsqueda y la manipulación de caracteres individuales. Descubrirás cómo utilizar las funciones proporcionadas por el módulo Data.Text para realizar operaciones eficientes con cadenas en Haskell. También veremos ejemplos prácticos de manipulación de cadenas en Haskell.", test_letter: test_b.letter)
lesson_b5 = Lesson.create(number: 5, title: "Programación funcional avanzada en Haskell", description: "En esta lección, exploraremos conceptos avanzados de programación funcional en Haskell. Aprenderás sobre la currificación, que es la transformación de una función de múltiples argumentos en una secuencia de funciones que toman un solo argumento. También descubrirás la aplicación de funciones parciales y las funciones de orden superior, que te permiten crear funciones más flexibles y reutilizables. Al final de esta lección, estarás familiarizado con técnicas avanzadas de programación funcional en Haskell.", test_letter: test_b.letter)

question_b1 = Question.create(number: 1, description: "¿Cuál es el principal objetivo de Haskell?", test_letter: test_b.letter)
question_b2 = Question.create(number: 2, description: "¿Cómo se realiza una estructura condicional en Haskell?", test_letter: test_b.letter)
question_b3 = Question.create(number: 3, description: "¿Qué son los módulos en Haskell?", test_letter: test_b.letter)
question_b4 = Question.create(number: 4, description: "¿Cómo se concatenan cadenas de texto en Haskell?", test_letter: test_b.letter)
question_b5 = Question.create(number: 5, description: "¿Cuál es el concepto de currificación en Haskell?", test_letter: test_b.letter)

option_b1 = Option.create(number: 1, description: "Permitir la programación funcional", correct: true, question_number: question_b1.number, test_letter: test_b.letter)
option_b2 = Option.create(number: 2, description: "Permitir la programación orientada a objetos", correct: false, question_number: question_a1.number, test_letter: test_b.letter)
option_b3 = Option.create(number: 3, description: "Permitir la programación imperativa", correct: false, question_number: question_b1.number, test_letter: test_b.letter)
option_b4 = Option.create(number: 1, description: "Mediante la estructura if-else", correct: true, question_number: question_b2.number, test_letter: test_b.letter)
option_b5 = Option.create(number: 2, description: "Usando la palabra clave 'switch'", correct: false, question_number: question_b2.number, test_letter: test_b.letter)
option_b6 = Option.create(number: 3, description: "Usando la estructura for", correct: false, question_number: question_b2.number, test_letter: test_b.letter)
option_b7 = Option.create(number: 1, description: "Son bloques de código reutilizables", correct: true, question_number: question_b3.number, test_letter: test_b.letter)
option_b8 = Option.create(number: 2, description: "Son operadores matemáticos", correct: false, question_number: question_b3.number, test_letter: test_b.letter)
option_b9 = Option.create(number: 3, description: "Son estructuras de datos en Haskell", correct: false, question_number: question_b3.number, test_letter: test_b.letter)
option_b10 = Option.create(number: 1, description: "Usando el operador '+'", correct: false, question_number: question_b4.number, test_letter: test_b.letter)
option_b11 = Option.create(number: 2, description: "Usando la función 'concat'", correct: false, question_number: question_b4.number, test_letter: test_b.letter)
option_b12 = Option.create(number: 3, description: "Usando el operador '++'", correct: true, question_number: question_b4.number, test_letter: test_b.letter)
option_b13 = Option.create(number: 1, description: "La aplicación de funciones parciales", correct: false, question_number: question_b5.number, test_letter: test_b.letter)
option_b14 = Option.create(number: 2, description: "La aplicación de funciones de orden superior", correct: false, question_number: question_b5.number, test_letter: test_b.letter)
option_b15 = Option.create(number: 3, description: "La transformación de funciones de varios argumentos en una secuencia de funciones que toman un solo argumento", correct: true, question_number: question_b5.number, test_letter: test_b.letter)

# Test C
test_c = Test.create(letter: "C", description: "Programación funcional en Haskell", cant_questions: 5)

lesson_c1 = Lesson.create(number: 1, title: "Programación funcional en Haskell", description: "En esta lección, exploraremos los conceptos clave de la programación funcional en Haskell. Aprenderás que la programación funcional es un paradigma de programación basado en funciones, donde las funciones son tratadas como ciudadanos de primera clase. Descubrirás cómo Haskell implementa la programación funcional y cómo aprovechar sus características principales, como la inmutabilidad, la evaluación perezosa y las funciones puras. Al final de esta lección, comprenderás los fundamentos de la programación funcional en Haskell.", test_letter: test_c.letter)
lesson_c2 = Lesson.create(number: 2, title: "Recursión en Haskell", description: "Aprenderás cómo utilizar la recursión para resolver problemas en Haskell. La recursión es un concepto central en Haskell y te permite definir funciones que se llaman a sí mismas para abordar problemas de forma iterativa. Exploraremos ejemplos prácticos de recursión, como la implementación de funciones para calcular factoriales y sumas de números. También discutiremos técnicas para escribir funciones recursivas eficientes y evitar bucles infinitos.", test_letter: test_c.letter)
lesson_c3 = Lesson.create(number: 3, title: "Composición de funciones en Haskell", description: "Esta lección se enfoca en la composición de funciones en Haskell. Aprenderás qué es la composición de funciones y cómo puedes combinar dos o más funciones para obtener una nueva función. Descubrirás cómo utilizar el operador de composición (.) en Haskell y cómo aplicar la composición de funciones para crear programas más concisos y expresivos. También veremos ejemplos prácticos de la composición de funciones en Haskell.", test_letter: test_c.letter)
lesson_c4 = Lesson.create(number: 4, title: "Manejo de listas en Haskell", description: "Aprenderás a trabajar con listas y funciones de orden superior en Haskell. Las listas son una estructura de datos fundamental en Haskell y te permiten almacenar y manipular colecciones de elementos. Exploraremos funciones de orden superior, como map, filter y reduce, que te permiten realizar operaciones comunes en listas de manera concisa y elegante. También veremos cómo utilizar patrones de comprensión de listas para generar y transformar listas en Haskell.", test_letter: test_c.letter)
lesson_c5 = Lesson.create(number: 5, title: "Programación monádica en Haskell", description: "En esta lección, exploraremos el concepto de programación monádica y su uso en Haskell. Las mónadas son una abstracción poderosa que te permite encapsular efectos secundarios en un contexto controlado. Aprenderás qué es una mónada y cómo utilizar las mónadas proporcionadas por Haskell, como Maybe, Either y IO, para trabajar con efectos secundarios de manera segura y modular. Al final de esta lección, comprenderás los fundamentos de la programación monádica y su aplicación en Haskell.", test_letter: test_c.letter)

question_c1 = Question.create(number: 1, description: "¿Qué es la programación funcional?", test_letter: test_c.letter)
question_c2 = Question.create(number: 2, description: "¿Cuál es el concepto central de la recursión en Haskell?", test_letter: test_c.letter)
question_c3 = Question.create(number: 3, description: "¿Qué es la composición de funciones en Haskell?", test_letter: test_c.letter)
question_c4 = Question.create(number: 4, description: "¿Cómo se realiza el filtrado de una lista en Haskell?", test_letter: test_c.letter)
question_c5 = Question.create(number: 5, description: "¿Qué es una mónada en Haskell?", test_letter: test_c.letter)

option_c1 = Option.create(number: 1, description: "Un paradigma de programación basado en funciones", correct: true, question_number: question_c1.number, test_letter: test_c.letter)
option_c2 = Option.create(number: 2, description: "Un paradigma de programación basado en objetos", correct: false, question_number: question_c1.number, test_letter: test_c.letter)
option_c3 = Option.create(number: 3, description: "Un paradigma de programación basado en eventos", correct: false, question_number: question_c1.number, test_letter: test_c.letter)
option_c4 = Option.create(number: 1, description: "La repetición de un bloque de código", correct: true, question_number: question_c2.number, test_letter: test_c.letter)
option_c5 = Option.create(number: 2, description: "La división de un problema en subproblemas más pequeños", correct: false, question_number: question_c2.number, test_letter: test_c.letter)
option_c6 = Option.create(number: 3, description: "La agrupación de elementos similares en una lista", correct: false, question_number: question_c2.number, test_letter: test_c.letter)
option_c7 = Option.create(number: 1, description: "La combinación de dos o más funciones para obtener una nueva función", correct: true, question_number: question_c3.number, test_letter: test_c.letter)
option_c8 = Option.create(number: 2, description: "La separación de una función en varias funciones más pequeñas", correct: false, question_number: question_c3.number, test_letter: test_c.letter)
option_c9 = Option.create(number: 3, description: "La aplicación de funciones a una lista", correct: false, question_number: question_c3.number, test_letter: test_c.letter)
option_c10 = Option.create(number: 1, description: "Usando la función 'filter'", correct: true, question_number: question_c4.number, test_letter: test_c.letter)
option_c11 = Option.create(number: 2, description: "Usando la función 'map'", correct: false, question_number: question_c4.number, test_letter: test_c.letter)
option_c12 = Option.create(number: 3, description: "Usando la función 'reduce'", correct: false, question_number: question_c4.number, test_letter: test_c.letter)
option_c13 = Option.create(number: 1, description: "Un tipo de dato en Haskell", correct: true, question_number: question_c5.number, test_letter: test_c.letter)
option_c14 = Option.create(number: 2, description: "Una función pura en Haskell", correct: false, question_number: question_c5.number, test_letter: test_c.letter)
option_c15 = Option.create(number: 3, description: "Un operador lógico en Haskell", correct: false, question_number: question_c5.number, test_letter: test_c.letter)

# Test D
test_d = Test.create(letter: "D", description: "Programación intermedia en Haskell", cant_questions: 5)

lesson_d1 = Lesson.create(number: 1, title: "Manejo de excepciones en Haskell", description: "Aprenderás a manejar excepciones en Haskell. Descubrirás cómo utilizar bloques try-catch para capturar y manejar excepciones en tu código. Exploraremos las diferentes excepciones predefinidas en Haskell y cómo puedes crear tus propias excepciones personalizadas. También discutiremos las mejores prácticas para el manejo de excepciones y cómo evitar errores comunes al trabajar con excepciones.", test_letter: test_d.letter)
lesson_d2 = Lesson.create(number: 2, title: "Programación monádica en Haskell", description: "En esta lección, exploraremos la programación monádica en Haskell. Aprenderás que la programación monádica es un enfoque basado en monoides que te permite encapsular efectos secundarios y cálculos en un contexto controlado. Descubrirás qué es una mónada y cómo utilizar las mónadas en Haskell para escribir código modular y seguro. Veremos ejemplos prácticos de programación monádica en Haskell y cómo combinar múltiples mónadas para abordar situaciones complejas.", test_letter: test_d.letter)
lesson_d3 = Lesson.create(number: 3, title: "Lectura y escritura de archivos en Haskell", description: "Aprenderás cómo leer y escribir archivos en Haskell. Exploraremos las funciones predefinidas de Haskell, como readFile y writeFile, que te permiten interactuar con archivos en el sistema de archivos. Descubrirás cómo abrir archivos, leer su contenido, escribir en ellos y cerrarlos adecuadamente. También discutiremos cómo manejar errores y excepciones relacionados con la lectura y escritura de archivos.", test_letter: test_d.letter)
lesson_d4 = Lesson.create(number: 4, title: "Estructuras de datos avanzadas en Haskell", description: "Esta lección se enfoca en las estructuras de datos avanzadas en Haskell. Aprenderás sobre las estructuras de datos como árboles binarios y grafos, que son fundamentales para resolver problemas más complejos. Exploraremos cómo implementar y manipular estas estructuras de datos en Haskell, así como las operaciones comunes que puedes realizar en ellas. También discutiremos las ventajas y desventajas de diferentes estructuras de datos según el escenario de uso.", test_letter: test_d.letter)
lesson_d5 = Lesson.create(number: 5, title: "Programación funcional lazzy en Haskell", description: "Exploraremos el concepto de evaluación lazy en Haskell. Aprenderás que en Haskell, la evaluación lazy significa que los cálculos se realizan solo cuando los resultados son necesarios. Descubrirás cómo la evaluación lazy puede mejorar la eficiencia y la modularidad del código al evitar cálculos innecesarios. Veremos ejemplos de evaluación lazy en Haskell y cómo puedes aprovechar esta característica para escribir programas más eficientes y elegantes.", test_letter: test_d.letter)

question_d1 = Question.create(number: 1, description: "¿Cómo se manejan las excepciones en Haskell?", test_letter: test_d.letter)
question_d2 = Question.create(number: 2, description: "¿Qué es la programación monádica?", test_letter: test_d.letter)
question_d3 = Question.create(number: 3, description: "¿Cómo se realiza la lectura de archivos en Haskell?", test_letter: test_d.letter)
question_d4 = Question.create(number: 4, description: "¿Cuáles son algunas estructuras de datos avanzadas en Haskell?", test_letter: test_d.letter)
question_d5 = Question.create(number: 5, description: "¿Qué significa la evaluación lazy en Haskell?", test_letter: test_d.letter)

option_d1 = Option.create(number: 1, description: "Utilizando bloques try-catch", correct: true, question_number: question_d1.number, test_letter: test_d.letter)
option_d2 = Option.create(number: 2, description: "Utilizando sentencias if-else", correct: false, question_number: question_d1.number, test_letter: test_d.letter)
option_d3 = Option.create(number: 3, description: "Utilizando sentencias switch-case", correct: false, question_number: question_d1.number, test_letter: test_d.letter)
option_d4 = Option.create(number: 1, description: "Un enfoque de programación basado en monoides", correct: true, question_number: question_d2.number, test_letter: test_d.letter)
option_d5 = Option.create(number: 2, description: "Un enfoque de programación basado en bucles", correct: false, question_number: question_d2.number, test_letter: test_d.letter)
option_d6 = Option.create(number: 3, description: "Un enfoque de programación basado en condicionales", correct: false, question_number: question_d2.number, test_letter: test_a.letter)
option_d7 = Option.create(number: 1, description: "Utilizando la función 'readFile'", correct: true, question_number: question_d3.number, test_letter: test_d.letter)
option_d8 = Option.create(number: 2, description: "Utilizando la función 'writeFile'", correct: false, question_number: question_d3.number, test_letter: test_d.letter)
option_d9 = Option.create(number: 3, description: "Utilizando la función 'openFile'", correct: false, question_number: question_d3.number, test_letter: test_d.letter)
option_d10 = Option.create(number: 1, description: "Árboles binarios y grafos", correct: true, question_number: question_d4.number, test_letter: test_d.letter)
option_d11 = Option.create(number: 2, description: "Listas y matrices", correct: false, question_number: question_d4.number, test_letter: test_d.letter)
option_d12 = Option.create(number: 3, description: "Colas y pilas", correct: false, question_number: question_d4.number, test_letter: test_d.letter)
option_d13 = Option.create(number: 1, description: "La evaluación se realiza solo cuando los resultados son necesarios", correct: true, question_number: question_d5.number, test_letter: test_d.letter)
option_d14 = Option.create(number: 2, description: "La evaluación se realiza de manera inmediata", correct: false, question_number: question_d5.number, test_letter: test_d.letter)
option_d15 = Option.create(number: 3, description: "La evaluación se realiza en paralelo", correct: false, question_number: question_d5.number, test_letter: test_d.letter)

# Test E
test_e = Test.create(letter: "E", description: "Programación avanzada en Haskell", cant_questions: 5)

lesson_e1 = Lesson.create(number: 1, title: "Tipos de datos avanzados en Haskell", description: "En esta lección, exploraremos los tipos de datos avanzados en Haskell. Aprenderás sobre los tipos algebraicos y tipos polimórficos, que te permiten representar estructuras de datos más complejas y expresar conceptos abstractos de manera concisa. Veremos cómo definir y utilizar estos tipos de datos en Haskell, y discutiremos algunas técnicas avanzadas de manipulación de tipos.", test_letter: test_e.letter)
lesson_e2 = Lesson.create(number: 2, title: "Programación funcional reactiva en Haskell", description: "Aprenderás cómo utilizar la programación funcional reactiva en Haskell. Descubrirás que la programación funcional reactiva es un paradigma basado en eventos que te permite construir aplicaciones reactivas y manejar flujos de datos asincrónicos. Exploraremos los conceptos clave de la programación funcional reactiva, como los eventos, los comportamientos y las señales, y cómo puedes utilizar bibliotecas específicas de Haskell para implementar este estilo de programación.", test_letter: test_e.letter)
lesson_e3 = Lesson.create(number: 3, title: "Programación concurrente en Haskell", description: "Esta lección se enfoca en la programación concurrente en Haskell. Aprenderás diferentes técnicas para realizar la programación concurrente, como el uso de hilos de ejecución y la comunicación entre ellos. Exploraremos cómo crear y administrar hilos en Haskell, así como las herramientas y abstracciones proporcionadas por el lenguaje para facilitar la programación concurrente. También discutiremos cómo manejar la concurrencia y evitar problemas como las condiciones de carrera y la incoherencia de datos.", test_letter: test_e.letter)
lesson_e4 = Lesson.create(number: 4, title: "Optimización y rendimiento en Haskell", description: "Aprenderás técnicas de optimización y mejora de rendimiento en Haskell. Descubrirás cómo optimizar bucles y utilizar estructuras de datos eficientes para mejorar el rendimiento de tus programas. Exploraremos técnicas como el desenrollado de bucles, la especialización de tipos y la evaluación estricta, que te permitirán escribir código más eficiente en Haskell. También discutiremos algunas herramientas y técnicas de perfilado para identificar y resolver cuellos de botella en tu código.", test_letter: test_e.letter)
lesson_e5 = Lesson.create(number: 5, title: "Dependencias externas y extensiones de Haskell", description: "Exploraremos cómo utilizar dependencias externas y extensiones de Haskell. Aprenderás a importar bibliotecas externas en tus proyectos Haskell para aprovechar funcionalidades adicionales y reutilizar código existente. Descubrirás cómo gestionar las dependencias de tu proyecto utilizando herramientas como Cabal o Stack. También discutiremos cómo habilitar y utilizar extensiones de Haskell, que son características adicionales que amplían el lenguaje y te permiten escribir código más expresivo y conciso.", test_letter: test_e.letter)

question_e1 = Question.create(number: 1, description: "¿Cuáles son los tipos de datos avanzados en Haskell?", test_letter: test_e.letter)
question_e2 = Question.create(number: 2, description: "¿Qué es la programación funcional reactiva?", test_letter: test_e.letter)
question_e3 = Question.create(number: 3, description: "¿Cómo se realiza la programación concurrente en Haskell?", test_letter: test_e.letter)
question_e4 = Question.create(number: 4, description: "¿Qué técnicas se utilizan para la optimización y rendimiento en Haskell?", test_letter: test_e.letter)
question_e5 = Question.create(number: 5, description: "¿Cómo se utilizan dependencias externas y extensiones en Haskell?", test_letter: test_e.letter)

option_e1 = Option.create(number: 1, description: "Tipos algebraicos y tipos polimórficos", correct: true, question_number: question_e1.number, test_letter: test_e.letter)
option_e2 = Option.create(number: 2, description: "Tipos básicos y tipos compuestos", correct: false, question_number: question_e1.number, test_letter: test_e.letter)
option_e3 = Option.create(number: 3, description: "Tipos numéricos y tipos de cadena", correct: false, question_number: question_e1.number, test_letter: test_e.letter)
option_e4 = Option.create(number: 1, description: "Un paradigma de programación basado en eventos", correct: true, question_number: question_e2.number, test_letter: test_e.letter)
option_e5 = Option.create(number: 2, description: "Un paradigma de programación basado en objetos", correct: false, question_number: question_e2.number, test_letter: test_e.letter)
option_e6 = Option.create(number: 3, description: "Un paradigma de programación basado en funciones", correct: false, question_number: question_e2.number, test_letter: test_e.letter)
option_e7 = Option.create(number: 1, description: "Utilizando hilos de ejecución y comunicación entre ellos", correct: true, question_number: question_e3.number, test_letter: test_e.letter)
option_e8 = Option.create(number: 2, description: "Utilizando técnicas de paralelismo automático", correct: false, question_number: question_e3.number, test_letter: test_e.letter)
option_e9 = Option.create(number: 3, description: "Utilizando memoria compartida y exclusión mutua", correct: false, question_number: question_e3.number, test_letter: test_e.letter)
option_e10 = Option.create(number: 1, description: "Optimización de bucles y uso eficiente de estructuras de datos", correct: true, question_number: question_e4.number, test_letter: test_e.letter)
option_e11 = Option.create(number: 2, description: "Utilizando técnicas de programación dinámica", correct: false, question_number: question_e4.number, test_letter: test_e.letter)
option_e12 = Option.create(number: 3, description: "Utilizando técnicas de memoización", correct: false, question_number: question_e4.number, test_letter: test_e.letter)
option_e13 = Option.create(number: 1, description: "A través de importación directa de bibliotecas externas", correct: true, question_number: question_e5.number, test_letter: test_e.letter)
option_e14 = Option.create(number: 2, description: "A través de la definición de tipos de datos personalizados", correct: false, question_number: question_e5.number, test_letter: test_e.letter)
option_e15 = Option.create(number: 3, description: "A través de la utilización de lenguajes de programación externos", correct: false, question_number: question_e5.number, test_letter: test_e.letter)

