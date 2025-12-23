# frozen_string_literal: true

# Limpiar base de datos
puts "Limpiando base de datos..."
AccountLesson.destroy_all
AccountQuestion.destroy_all
AccountTest.destroy_all
AccountOption.destroy_all
Option.destroy_all
Question.destroy_all
Lesson.destroy_all
Test.destroy_all
puts "Base de datos limpia."

# --- TEST A: Fundamentos ---
puts "Creando Test A..."
test_a = Test.create(letter: 'A', description: 'Fundamentos de Haskell', cant_questions: 5)

# Lessons A
Lesson.create(number: 1, title: 'Introducción a Haskell', test_letter: 'A')
Lesson.create(number: 2, title: 'Tu Entorno de Trabajo (GHCi)', test_letter: 'A')
Lesson.create(number: 3, title: 'Primeros Pasos: Aritmética', test_letter: 'A')
Lesson.create(number: 4, title: 'Tipos de Datos Básicos', test_letter: 'A')
Lesson.create(number: 5, title: 'Funciones Simples', test_letter: 'A')

# Questions A
q_a1 = Question.create(number: 1, description: '¿Qué característica define mejor a Haskell?', test_letter: 'A')
Option.create(number: 1, description: 'Es puramente funcional y perezoso', correct: true, question_number: q_a1.number, test_letter: 'A')
Option.create(number: 2, description: 'Es orientado a objetos e imperativo', correct: false, question_number: q_a1.number, test_letter: 'A')
Option.create(number: 3, description: 'Es dinámicamente tipado', correct: false, question_number: q_a1.number, test_letter: 'A')

q_a2 = Question.create(number: 2, description: '¿Cómo se inicia el intérprete interactivo de Haskell?', test_letter: 'A')
Option.create(number: 1, description: 'ghci', correct: true, question_number: q_a2.number, test_letter: 'A')
Option.create(number: 2, description: 'haskell-run', correct: false, question_number: q_a2.number, test_letter: 'A')
Option.create(number: 3, description: 'node', correct: false, question_number: q_a2.number, test_letter: 'A')

q_a3 = Question.create(number: 3, description: '¿Cuál es el resultado de 5 * (-3) en Haskell?', test_letter: 'A')
Option.create(number: 1, description: '-15', correct: true, question_number: q_a3.number, test_letter: 'A')
Option.create(number: 2, description: 'Error de sintaxis', correct: false, question_number: q_a3.number, test_letter: 'A')
Option.create(number: 3, description: '15', correct: false, question_number: q_a3.number, test_letter: 'A')

q_a4 = Question.create(number: 4, description: '¿Qué tipo tiene la expresión "Hola"?', test_letter: 'A')
Option.create(number: 1, description: '[Char] o String', correct: true, question_number: q_a4.number, test_letter: 'A')
Option.create(number: 2, description: 'Text', correct: false, question_number: q_a4.number, test_letter: 'A')
Option.create(number: 3, description: 'Char', correct: false, question_number: q_a4.number, test_letter: 'A')

q_a5 = Question.create(number: 5, description: '¿Cómo se define una función que duplica un número x?', test_letter: 'A')
Option.create(number: 1, description: 'doble x = x + x', correct: true, question_number: q_a5.number, test_letter: 'A')
Option.create(number: 2, description: 'function doble(x) { return x + x }', correct: false, question_number: q_a5.number, test_letter: 'A')
Option.create(number: 3, description: 'doble = x + x', correct: false, question_number: q_a5.number, test_letter: 'A')


# --- TEST B: Estructuras de Datos ---
puts "Creando Test B..."
Test.create(letter: 'B', description: 'Listas y Tuplas', cant_questions: 5)

# Lessons B
Lesson.create(number: 1, title: 'Introducción a las Listas', test_letter: 'B')
Lesson.create(number: 2, title: 'Operaciones con Listas', test_letter: 'B')
Lesson.create(number: 3, title: 'Funciones Comunes de Listas', test_letter: 'B')
Lesson.create(number: 4, title: 'Rangos (Ranges)', test_letter: 'B')
Lesson.create(number: 5, title: 'List Comprehensions', test_letter: 'B')

# Questions B
q_b1 = Question.create(number: 1, description: '¿Qué sucede si intentas crear una lista con diferentes tipos [1, "a"]?', test_letter: 'B')
Option.create(number: 1, description: 'Error, las listas deben ser homogéneas', correct: true, question_number: q_b1.number, test_letter: 'B')
Option.create(number: 2, description: 'Se crea una lista mixta', correct: false, question_number: q_b1.number, test_letter: 'B')
Option.create(number: 3, description: 'Convierte todo a String', correct: false, question_number: q_b1.number, test_letter: 'B')

q_b2 = Question.create(number: 2, description: '¿Qué operador agrega un elemento al principio de una lista (cons)?', test_letter: 'B')
Option.create(number: 1, description: ':', correct: true, question_number: q_b2.number, test_letter: 'B')
Option.create(number: 2, description: '++', correct: false, question_number: q_b2.number, test_letter: 'B')
Option.create(number: 3, description: '+', correct: false, question_number: q_b2.number, test_letter: 'B')

q_b3 = Question.create(number: 3, description: '¿Qué función devuelve el primer elemento de una lista?', test_letter: 'B')
Option.create(number: 1, description: 'head', correct: true, question_number: q_b3.number, test_letter: 'B')
Option.create(number: 2, description: 'first', correct: false, question_number: q_b3.number, test_letter: 'B')
Option.create(number: 3, description: 'init', correct: false, question_number: q_b3.number, test_letter: 'B')

q_b4 = Question.create(number: 4, description: '¿Qué genera la expresión [2,4..10]?', test_letter: 'B')
Option.create(number: 1, description: '[2,4,6,8,10]', correct: true, question_number: q_b4.number, test_letter: 'B')
Option.create(number: 2, description: '[2,3,4,5,6,7,8,9,10]', correct: false, question_number: q_b4.number, test_letter: 'B')
Option.create(number: 3, description: 'Error de sintaxis', correct: false, question_number: q_b4.number, test_letter: 'B')

q_b5 = Question.create(number: 5, description: '¿Qué hace [x*2 | x <- [1..3]]?', test_letter: 'B')
Option.create(number: 1, description: 'Devuelve [2, 4, 6]', correct: true, question_number: q_b5.number, test_letter: 'B')
Option.create(number: 2, description: 'Devuelve [1, 2, 3]', correct: false, question_number: q_b5.number, test_letter: 'B')
Option.create(number: 3, description: 'Devuelve [2, 4, 6, 8]', correct: false, question_number: q_b5.number, test_letter: 'B')


# --- TEST C: Tipos y Clases ---
puts "Creando Test C..."
Test.create(letter: 'C', description: 'Tipos y Typeclasses', cant_questions: 5)

# Lessons C
Lesson.create(number: 1, title: 'Tipos y Firmas', test_letter: 'C')
Lesson.create(number: 2, title: 'Variables de Tipo', test_letter: 'C')
Lesson.create(number: 3, title: 'Clases Eq y Ord', test_letter: 'C')
Lesson.create(number: 4, title: 'Clases Show y Read', test_letter: 'C')
Lesson.create(number: 5, title: 'Clases Enum y Bounded', test_letter: 'C')

# Questions C
q_c1 = Question.create(number: 1, description: 'En la firma "head :: [a] -> a", ¿qué es "a"?', test_letter: 'C')
Option.create(number: 1, description: 'Una variable de tipo (puede ser cualquier tipo)', correct: true, question_number: q_c1.number, test_letter: 'C')
Option.create(number: 2, description: 'Un tipo específico llamado "a"', correct: false, question_number: q_c1.number, test_letter: 'C')
Option.create(number: 3, description: 'Un carácter', correct: false, question_number: q_c1.number, test_letter: 'C')

q_c2 = Question.create(number: 2, description: '¿Qué Typeclass permite comprobar igualdad (==)?', test_letter: 'C')
Option.create(number: 1, description: 'Eq', correct: true, question_number: q_c2.number, test_letter: 'C')
Option.create(number: 2, description: 'Ord', correct: false, question_number: q_c2.number, test_letter: 'C')
Option.create(number: 3, description: 'Equal', correct: false, question_number: q_c2.number, test_letter: 'C')

q_c3 = Question.create(number: 3, description: '¿Qué función convierte un valor a String?', test_letter: 'C')
Option.create(number: 1, description: 'show', correct: true, question_number: q_c3.number, test_letter: 'C')
Option.create(number: 2, description: 'read', correct: false, question_number: q_c3.number, test_letter: 'C')
Option.create(number: 3, description: 'toString', correct: false, question_number: q_c3.number, test_letter: 'C')

q_c4 = Question.create(number: 4, description: '¿Qué caracteriza a la clase Ord?', test_letter: 'C')
Option.create(number: 1, description: 'Permite ordenar sus valores (>, <)', correct: true, question_number: q_c4.number, test_letter: 'C')
Option.create(number: 2, description: 'Permite imprimir sus valores', correct: false, question_number: q_c4.number, test_letter: 'C')
Option.create(number: 3, description: 'Permite enumerar sus valores', correct: false, question_number: q_c4.number, test_letter: 'C')

q_c5 = Question.create(number: 5, description: '¿Qué función devuelve el sucesor de un Enum?', test_letter: 'C')
Option.create(number: 1, description: 'succ', correct: true, question_number: q_c5.number, test_letter: 'C')
Option.create(number: 2, description: 'next', correct: false, question_number: q_c5.number, test_letter: 'C')
Option.create(number: 3, description: 'pred', correct: false, question_number: q_c5.number, test_letter: 'C')


# --- TEST D: Sintaxis Avanzada ---
puts "Creando Test D..."
Test.create(letter: 'D', description: 'Sintaxis de Funciones', cant_questions: 5)

# Lessons D
Lesson.create(number: 1, title: 'Pattern Matching Básico', test_letter: 'D')
Lesson.create(number: 2, title: 'Pattern Matching Avanzado', test_letter: 'D')
Lesson.create(number: 3, title: 'Guardas (Guards)', test_letter: 'D')
Lesson.create(number: 4, title: 'Where y Let', test_letter: 'D')
Lesson.create(number: 5, title: 'Case Expressions', test_letter: 'D')

# Questions D
q_d1 = Question.create(number: 1, description: 'En pattern matching, ¿qué hace el patrón "_"?', test_letter: 'D')
Option.create(number: 1, description: 'Coincide con cualquier cosa (comodín)', correct: true, question_number: q_d1.number, test_letter: 'D')
Option.create(number: 2, description: 'Coincide solo con listas vacías', correct: false, question_number: q_d1.number, test_letter: 'D')
Option.create(number: 3, description: 'Lanza un error', correct: false, question_number: q_d1.number, test_letter: 'D')

q_d2 = Question.create(number: 2, description: '¿Cómo se descompone una lista en cabeza y cola?', test_letter: 'D')
Option.create(number: 1, description: '(x:xs)', correct: true, question_number: q_d2.number, test_letter: 'D')
Option.create(number: 2, description: '[x, xs]', correct: false, question_number: q_d2.number, test_letter: 'D')
Option.create(number: 3, description: 'head:tail', correct: false, question_number: q_d2.number, test_letter: 'D')

q_d3 = Question.create(number: 3, description: '¿Qué símbolo introduce una Guarda?', test_letter: 'D')
Option.create(number: 1, description: '|', correct: true, question_number: q_d3.number, test_letter: 'D')
Option.create(number: 2, description: '->', correct: false, question_number: q_d3.number, test_letter: 'D')
Option.create(number: 3, description: '=>', correct: false, question_number: q_d3.number, test_letter: 'D')

q_d4 = Question.create(number: 4, description: '¿Cuál es la diferencia entre where y let?', test_letter: 'D')
Option.create(number: 1, description: 'let es una expresión, where es una cláusula sintáctica', correct: true, question_number: q_d4.number, test_letter: 'D')
Option.create(number: 2, description: 'where es una expresión, let es una declaración', correct: false, question_number: q_d4.number, test_letter: 'D')
Option.create(number: 3, description: 'No hay diferencia', correct: false, question_number: q_d4.number, test_letter: 'D')

q_d5 = Question.create(number: 5, description: '¿Para qué sirve "case ... of"?', test_letter: 'D')
Option.create(number: 1, description: 'Para hacer pattern matching en medio de una expresión', correct: true, question_number: q_d5.number, test_letter: 'D')
Option.create(number: 2, description: 'Para definir tipos de datos', correct: false, question_number: q_d5.number, test_letter: 'D')
Option.create(number: 3, description: 'Para importar módulos', correct: false, question_number: q_d5.number, test_letter: 'D')


# --- TEST E: Recursión y Orden Superior ---
puts "Creando Test E..."
Test.create(letter: 'E', description: 'Recursión y Funcional', cant_questions: 5)

# Lessons E
Lesson.create(number: 1, title: 'Introducción a la Recursión', test_letter: 'E')
Lesson.create(number: 2, title: 'Más Recursión', test_letter: 'E')
Lesson.create(number: 3, title: 'Currying', test_letter: 'E')
Lesson.create(number: 4, title: 'Map y Filter', test_letter: 'E')
Lesson.create(number: 5, title: 'Lambdas y Folds', test_letter: 'E')

# Questions E
q_e1 = Question.create(number: 1, description: '¿Qué es necesario para que una función recursiva termine?', test_letter: 'E')
Option.create(number: 1, description: 'Un caso base (edge condition)', correct: true, question_number: q_e1.number, test_letter: 'E')
Option.create(number: 2, description: 'Un bucle while', correct: false, question_number: q_e1.number, test_letter: 'E')
Option.create(number: 3, description: 'Usar la función break', correct: false, question_number: q_e1.number, test_letter: 'E')

q_e2 = Question.create(number: 2, description: '¿Qué es una función Curried?', test_letter: 'E')
Option.create(number: 1, description: 'Una función que toma sus argumentos uno a uno', correct: true, question_number: q_e2.number, test_letter: 'E')
Option.create(number: 2, description: 'Una función picante', correct: false, question_number: q_e2.number, test_letter: 'E')
Option.create(number: 3, description: 'Una función que no devuelve nada', correct: false, question_number: q_e2.number, test_letter: 'E')

q_e3 = Question.create(number: 3, description: '¿Qué hace la función map?', test_letter: 'E')
Option.create(number: 1, description: 'Aplica una función a cada elemento de una lista', correct: true, question_number: q_e3.number, test_letter: 'E')
Option.create(number: 2, description: 'Filtra una lista', correct: false, question_number: q_e3.number, test_letter: 'E')
Option.create(number: 3, description: 'Reduce una lista a un valor', correct: false, question_number: q_e3.number, test_letter: 'E')

q_e4 = Question.create(number: 4, description: '¿Cómo se escribe una función anónima (Lambda) que suma 1?', test_letter: 'E')
Option.create(number: 1, description: '\x -> x + 1', correct: true, question_number: q_e4.number, test_letter: 'E')
Option.create(number: 2, description: 'lambda x: x + 1', correct: false, question_number: q_e4.number, test_letter: 'E')
Option.create(number: 3, description: 'x => x + 1', correct: false, question_number: q_e4.number, test_letter: 'E')

q_e5 = Question.create(number: 5, description: '¿Qué función se usa para reducir una lista a un solo valor?', test_letter: 'E')
Option.create(number: 1, description: 'foldl / foldr', correct: true, question_number: q_e5.number, test_letter: 'E')
Option.create(number: 2, description: 'map', correct: false, question_number: q_e5.number, test_letter: 'E')
Option.create(number: 3, description: 'filter', correct: false, question_number: q_e5.number, test_letter: 'E')

puts "Datos sembrados exitosamente."
