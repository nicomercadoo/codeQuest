AccountTest = Class.new(ActiveRecord::Base)
AccountLesson = Class.new(ActiveRecord::Base)
AccountQuestion = Class.new(ActiveRecord::Base)
AccountOption = Class.new(ActiveRecord::Base)
Account = Class.new(ActiveRecord::Base)

# lista de letras de los tests en el directorio /src/tests
tests_letters = ('A'..'E').to_a

tests_letters.each do |letter|
    # Test
    unless Dir.exist? "/src/tests/#{letter}"
        next
    end

    test = nil
    File.open("/src/tests/#{letter}/test-specs.txt", "r") do |f|
        lines = f.readlines.map(&:chomp)
        desc = lines[0][/description: (([[:ascii:]]|[á|é|í|ó|ú|ñ|Ñ])*)/,1]
        cq = lines[1][/cant_questions: (\d)/,1].to_i

        test = Test.create(letter: letter, description: desc, cant_questions: cq)
    end

    # Lesson
    # Para cada test se crean las lecciones
    l = 1
    while File.exist?("/src/lessons/L-#{test.letter}-#{l}.adoc")
        File.open ("/src/lessons/L-#{test.letter}-#{l}.adoc"), "r" do |f|
            title = f.readline.chomp[/= (([[:ascii:]]|[á|é|í|ó|ú|ñ|Ñ])*)/,1]
            lesson = Lesson.create(number: l, title: title, test_letter: test.letter)
            l += 1
        end
    end

    # Question
    # Para cada test se crean las preguntas
    q = 1
    while File.exist?("/src/tests/A/Q-A-#{q}/Q-#{q}.adoc")
        question = Question.create(number: q, description: "una descripcion", test_letter: test.letter)

        # Option
        # Para cada pregunta se crean las opciones
        # Se asume la primera como correcta
        o = 1
        while File.exist?("/src/tests/A/Q-A-#{q}/Q-#{q}-O-#{o}.adoc")
            option = Option.create(number: o, description: "una descripcion", correct: if o == 1 then true else false end, question_number: question.number, test_letter: test.letter)
            o += 1
        end
        q += 1
    end
end


# Test A
# test_a = Test.create(letter: "A", description: "Introducción", cant_questions: 5)

# lesson_a1 = Lesson.create(number: 1, title: "Introducción a Haskell", test_letter: test_a.letter)
# lesson_a2 = Lesson.create(number: 2, title: "Obtener el entorno", test_letter: test_a.letter)
# lesson_a3 = Lesson.create(number: 3, title: "Variables y funciones", test_letter: test_a.letter)
# lesson_a4 = Lesson.create(number: 4, title: "Valores de verdad", test_letter: test_a.letter)
# lesson_a5 = Lesson.create(number: 5, title: "Tipos básicos", test_letter: test_a.letter)

# question_a1 = Question.create(number: 1, description: "¿Qué es Haskell?", test_letter: test_a.letter)
# question_a2 = Question.create(number: 2, description: "¿Cuál de estos no es un tipo de dato en Haskell?", test_letter: test_a.letter)
# question_a3 = Question.create(number: 3, description: "¿Cómo se define una función?", test_letter: test_a.letter)
# question_a4 = Question.create(number: 4, description: "¿Cómo se crea una lista?", test_letter: test_a.letter)
# question_a5 = Question.create(number: 5, description: "¿Qué es la recursión?", test_letter: test_a.letter)





# option_a1 = Option.create(number: 1, description: "Un lenguaje de programación funcional", correct: true, question_number: question_a1.number, test_letter: test_a.letter)
# option_a2 = Option.create(number: 2, description: "Un lenguaje de programación imperativo", correct: false, question_number: question_a1.number, test_letter: test_a.letter)
# option_a3 = Option.create(number: 3, description: "Un lenguaje de programación orientado a objetos", correct: false, question_number: question_a1.number, test_letter: test_a.letter)
# option_a16 = Option.create(number: 4, description: "alsdjflfk", correct: false, question_number: question_a1.number, test_letter: test_a.letter)
# option_a4 = Option.create(number: 1, description: "Un tipo de dato en Haskell", correct: false, question_number: question_a2.number, test_letter: test_a.letter)
# option_a5 = Option.create(number: 2, description: "Bool", correct: false, question_number: question_a2.number, test_letter: test_a.letter)
# option_a6 = Option.create(number: 3, description: "Arraylist", correct: true, question_number: question_a2.number, test_letter: test_a.letter)
# option_a7 = Option.create(number: 1, description: "Usando la palabra clave 'function'", correct: false, question_number: question_a3.number, test_letter: test_a.letter)
# option_a8 = Option.create(number: 2, description: "Usando el operador '=>'", correct: false, question_number: question_a3.number, test_letter: test_a.letter)
# option_a9 = Option.create(number: 3, description: "Usando el símbolo '->'", correct: true, question_number: question_a3.number, test_letter: test_a.letter)
# option_a10 = Option.create(number: 1, description: "Mediante un bucle", correct: false, question_number: question_a4.number, test_letter: test_a.letter)
# option_a11 = Option.create(number: 2, description: "Usando la palabra clave 'list'", correct: false, question_number: question_a4.number, test_letter: test_a.letter)
# option_a12 = Option.create(number: 3, description: "Mediante la notación de corchetes", correct: true, question_number: question_a4.number, test_letter: test_a.letter)
# option_a13 = Option.create(number: 1, description: "Un bucle que se llama a sí mismo", correct: false, question_number: question_a5.number, test_letter: test_a.letter)
# option_a14 = Option.create(number: 2, description: "Una función que se llama a sí misma", correct: true, question_number: question_a5.number, test_letter: test_a.letter)
# option_a15 = Option.create(number: 3, description: "Un tipo de dato en Haskell", correct: false, question_number: question_a5.number, test_letter: test_a.letter)

# Test B
test_b = Test.create(letter: "B", description: "Conceptos básicos", cant_questions: 5)

lesson_b1 = Lesson.create(number: 1, title: "Introducción a Haskell", test_letter: test_b.letter)
lesson_b2 = Lesson.create(number: 2, title: "Obtener el entorno", test_letter: test_b.letter)
lesson_b3 = Lesson.create(number: 3, title: "Variables y funciones", test_letter: test_b.letter)
lesson_b4 = Lesson.create(number: 4, title: "Valores de verdad", test_letter: test_b.letter)
lesson_b5 = Lesson.create(number: 5, title: "Tipos básicos", test_letter: test_b.letter)

question_b1 = Question.create(number: 1, description: "¿Cuál es el principal objetivo de Haskell?", test_letter: test_b.letter)
question_b2 = Question.create(number: 2, description: "¿Cómo se realiza una estructura condicional en Haskell?", test_letter: test_b.letter)
question_b3 = Question.create(number: 3, description: "¿Qué son los módulos en Haskell?", test_letter: test_b.letter)
question_b4 = Question.create(number: 4, description: "¿Cómo se concatenan cadenas de texto en Haskell?", test_letter: test_b.letter)
question_b5 = Question.create(number: 5, description: "¿Cuál es el concepto de currificación en Haskell?", test_letter: test_b.letter)

option_b1 = Option.create(number: 1, description: "Permitir la programación funcional", correct: true, question_number: question_b1.number, test_letter: test_b.letter)
option_b2 = Option.create(number: 2, description: "Permitir la programación orientada a objetos", correct: false, question_number: question_b1.number, test_letter: test_b.letter)
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
test_c = Test.create(letter: "C", description: "Programación funcional", cant_questions: 5)

lesson_c1 = Lesson.create(number: 1, title: "Programación funcional", test_letter: test_c.letter)
lesson_c2 = Lesson.create(number: 2, title: "Recursión", test_letter: test_c.letter)
lesson_c3 = Lesson.create(number: 3, title: "Composición de funciones", test_letter: test_c.letter)
lesson_c4 = Lesson.create(number: 4, title: "Manejo de listas", test_letter: test_c.letter)
lesson_c5 = Lesson.create(number: 5, title: "Programación monádica", test_letter: test_c.letter)

question_c1 = Question.create(number: 1, description: "¿Qué es la programación funcional?", test_letter: test_c.letter)
question_c2 = Question.create(number: 2, description: "¿Cuál es el concepto central de la recursión?", test_letter: test_c.letter)
question_c3 = Question.create(number: 3, description: "¿Qué es la composición de funciones en Haskell?", test_letter: test_c.letter)
question_c4 = Question.create(number: 4, description: "¿Cómo se realiza el filtrado de una lista?", test_letter: test_c.letter)
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
test_d = Test.create(letter: "D", description: "Programación intermedia", cant_questions: 5)

lesson_d1 = Lesson.create(number: 1, title: "Manejo de excepciones en Haskell", test_letter: test_d.letter)
lesson_d2 = Lesson.create(number: 2, title: "Programación monádica", test_letter: test_d.letter)
lesson_d3 = Lesson.create(number: 3, title: "Lectura y escritura de archivos en Haskell", test_letter: test_d.letter)
lesson_d4 = Lesson.create(number: 4, title: "Estructuras de datos avanzadas en Haskell", test_letter: test_d.letter)
lesson_d5 = Lesson.create(number: 5, title: "Programación funcional lazzy", test_letter: test_d.letter)

question_d1 = Question.create(number: 1, description: "¿Cómo se manejan las excepciones en haskell?", test_letter: test_d.letter)
question_d2 = Question.create(number: 2, description: "¿Qué es la programación monádica?", test_letter: test_d.letter)
question_d3 = Question.create(number: 3, description: "¿Cómo se realiza la lectura de archivos en Haskell?", test_letter: test_d.letter)
question_d4 = Question.create(number: 4, description: "¿Cuáles son algunas estructuras de datos avanzadas en Haskell?", test_letter: test_d.letter)
question_d5 = Question.create(number: 5, description: "¿Qué significa la evaluación lazy?", test_letter: test_d.letter)

option_d1 = Option.create(number: 1, description: "Utilizando bloques try-catch", correct: true, question_number: question_d1.number, test_letter: test_d.letter)
option_d2 = Option.create(number: 2, description: "Utilizando sentencias if-else", correct: false, question_number: question_d1.number, test_letter: test_d.letter)
option_d3 = Option.create(number: 3, description: "Utilizando sentencias switch-case", correct: false, question_number: question_d1.number, test_letter: test_d.letter)
option_d4 = Option.create(number: 1, description: "Un enfoque de programación basado en monoides", correct: true, question_number: question_d2.number, test_letter: test_d.letter)
option_d5 = Option.create(number: 2, description: "Un enfoque de programación basado en bucles", correct: false, question_number: question_d2.number, test_letter: test_d.letter)
option_d6 = Option.create(number: 3, description: "Un enfoque de programación basado en condicionales", correct: false, question_number: question_d2.number, test_letter: test_d.letter)
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
test_e = Test.create(letter: "E", description: "Programación avanzada", cant_questions: 5)

lesson_e1 = Lesson.create(number: 1, title: "Tipos de datos avanzados", test_letter: test_e.letter)
lesson_e2 = Lesson.create(number: 2, title: "Programación funcional reactiva", test_letter: test_e.letter)
lesson_e3 = Lesson.create(number: 3, title: "Programación concurrente", test_letter: test_e.letter)
lesson_e4 = Lesson.create(number: 4, title: "Optimización y rendimiento", test_letter: test_e.letter)
lesson_e5 = Lesson.create(number: 5, title: "Dependencias externas y extensiones", test_letter: test_e.letter)

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
