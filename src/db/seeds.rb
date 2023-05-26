Lesson = Class.new(ActiveRecord::Base)
lesson1 = Lesson.create(number: 1, tittle: "Esto es haskell", description: "Haskell es un lenguaje de programación funcional puro, conocido por su evaluación lazy y su enfoque en la expresividad y la concisión del código. Pertenece al paradigma de programación funcional y fue creado por un comité liderado por Simon Peyton Jones en 1990. Haskell se basa en la teoría de categorías y promueve el uso de funciones para la resolución de problemas, evitando efectos secundarios. La evaluación lazy permite retrasar el cálculo hasta que los resultados sean necesarios, lo que puede conducir a una mayor eficiencia en ciertos casos. Haskell fomenta la programación declarativa y ofrece un sistema de tipos fuerte y estático.", completed: false)
lesson2 = Lesson.create(number: 2, tittle: "Tipos de datos", description: "En Haskell, el tipado es estático y fuerte. Cada expresión tiene un tipo definido en tiempo de compilación y se verifica su coherencia antes de la ejecución. El sistema de tipos de Haskell es poderoso y permite la inferencia automática de tipos. Los tipos ayudan a prevenir errores y garantizan la consistencia del programa. Haskell utiliza una combinación de tipos básicos, tipos algebraicos y tipos polimórficos para expresar estructuras de datos y comportamientos. La precisión y rigurosidad del tipado en Haskell contribuyen a la seguridad y la confiabilidad del código.", completed: false)
lesson3 = Lesson.create(number: 3, tittle: "Funciones", description: "Las funciones en Haskell son ciudadanos de primera clase y pueden ser pasadas como argumentos, devueltas como resultados y almacenadas en estructuras de datos. Haskell fomenta la composición de funciones y el estilo declarativo. Las funciones son puras, lo que significa que no tienen efectos secundarios y producen el mismo resultado para los mismos argumentos. Las funciones de alto orden permiten la abstracción y la reutilización de patrones comunes. La programación funcional en Haskell se basa en la aplicación de funciones y la transformación de datos, lo que promueve un código más conciso y modular.", completed: false)


Question = Class.new(ActiveRecord::Base)
question1 = Question.create(number: 1, description: "¿Que es haskell?", well_answered: false)
question2 = Question.create(number: 2, description: "¿Cual de estos no es un tipo de dato en haskell?", well_answered: false)
question3 = Question.create(number: 3, description: "¿Como se define el perfil de una funcion?", well_answered: false)


Test = Class.new(ActiveRecord::Base)
test1 = Test.create(letter: "A", description: "la pregunta del millón: cuánto es 500mil + 500mil", completed: false, cant_questions: 3, acerted_answers: 0)


Option = Class.new(ActiveRecord::Base)
option1 = Option.create(description: "Es un lenguaje funcional", correct: true)
option2 = Option.create(description: "Es un lenguaje imperativo", correct: false)
option3 = Option.create(description: "Es un lenguaje orientado a objetos", correct: false)

option4 = Option.create(description: "Int", correct: false)
option5 = Option.create(description: "Bool", correct: false)
option6 = Option.create(description: "Arraylist", correct: true)

option7 = Option.create(description: "Usando solo ::", correct: false)
option8 = Option.create(description: "Usando solo ->", correct: false)
option9 = Option.create(description: "Usando :: y ->", correct: true)
