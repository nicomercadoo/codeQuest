Test = Class.new(ActiveRecord::Base)
test1 = Test.create(letter: "A", description: "Introduccion a Haskell", completed: false, cant_questions: 3, acerted_answers: 0)

Question = Class.new(ActiveRecord::Base)
question1 = Question.create(number: 1, description: "¿Que es haskell?", well_answered: false, test_letter: "A")
question2 = Question.create(number: 2, description: "¿Cual de estos no es un tipo de dato en haskell?", well_answered: false, test_letter: "A")
question3 = Question.create(number: 3, description: "¿Como se define el perfil de una funcion?", well_answered: false, test_letter: "A")

Option = Class.new(ActiveRecord::Base)
option1 = Option.create(number: 1, description: "Es un lenguaje funcional", question_number: 1, correct: true)
option2 = Option.create(number: 2, description: "Es un lenguaje imperativo", question_number: 1, correct: false)
option3 = Option.create(number: 3, description: "Es un lenguaje orientado a objetos", question_number: 1, correct: false)
option4 = Option.create(number: 4, description: "Int", question_number: 2, correct: false)
option5 = Option.create(number: 5, description: "Bool", question_number: 2, correct: false)
option6 = Option.create(number: 6, description: "Arraylist", question_number: 2, correct: true)
option7 = Option.create(number: 7, description: "Usando solo ::", question_number: 3, correct: false)
option8 = Option.create(number: 8, description: "Usando solo ->", question_number: 3, correct: false)
option9 = Option.create(number: 9, description: "Usando :: y ->", question_number: 3, correct: true)

Lesson = Class.new(ActiveRecord::Base)
lesson1 = Lesson.create(number: 1, title: "Esto es haskell", description: "Haskell es un lenguaje de programación funcional puro, conocido por su evaluación lazy y su enfoque en la expresividad y la concisión del código. Pertenece al paradigma de programación funcional y fue creado por un comité liderado por Simon Peyton Jones en 1990. Haskell se basa en la teoría de categorías y promueve el uso de funciones para la resolución de problemas, evitando efectos secundarios. La evaluación lazy permite retrasar el cálculo hasta que los resultados sean necesarios, lo que puede conducir a una mayor eficiencia en ciertos casos. Haskell fomenta la programación declarativa y ofrece un sistema de tipos fuerte y estático.", test_letter: "A", completed: false)
lesson2 = Lesson.create(number: 2, title: "Tipos de datos", description: "En Haskell, el tipado es estático y fuerte. Cada expresión tiene un tipo definido en tiempo de compilación y se verifica su coherencia antes de la ejecución. El sistema de tipos de Haskell es poderoso y permite la inferencia automática de tipos. Los tipos ayudan a prevenir errores y garantizan la consistencia del programa. Haskell utiliza una combinación de tipos básicos, tipos algebraicos y tipos polimórficos para expresar estructuras de datos y comportamientos. La precisión y rigurosidad del tipado en Haskell contribuyen a la seguridad y la confiabilidad del código.", test_letter: "A", completed: false)
lesson3 = Lesson.create(number: 3, title: "Funciones", description: "Las funciones en Haskell son ciudadanos de primera clase y pueden ser pasadas como argumentos, devueltas como resultados y almacenadas en estructuras de datos. Haskell fomenta la composición de funciones y el estilo declarativo. Las funciones son puras, lo que significa que no tienen efectos secundarios y producen el mismo resultado para los mismos argumentos. Las funciones de alto orden permiten la abstracción y la reutilización de patrones comunes. La programación funcional en Haskell se basa en la aplicación de funciones y la transformación de datos, lo que promueve un código más conciso y modular.", test_letter: "A", completed: false)









