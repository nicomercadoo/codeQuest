Lesson = Class.new(ActiveRecord::Base)
lesson1 = Lesson.create(description_lesson: "Esto es haskell", completed_lesson: false)
lesson2 = Lesson.create(description_lesson: "Tipos de datos", completed_lesson: false)
lesson3 = Lesson.create(description_lesson: "Funciones", completed_lesson: false)

Question = Class.new(ActiveRecord::Base)
question1 = Question.create(description_question: "¿Que es haskell?", well_answered: false)
question2 = Question.create(description_question: "¿Cual de estos no es un tipo de dato en haskell?", well_answered: false)
question3 = Question.create(description_question: "¿Como se define el perfil de una funcion?", well_answered: false)

Test = Class.new(ActiveRecord::Base)
test1 = Test.create(letter: "A", completed_test: false, description_test: "Test de lecciones 1, 2 y 3",cant_questions: 3, acerted_answers: 0)

Option = Class.new(ActiveRecord::Base)
option1 = Option.create(description_option: "Es un lenguaje funcional", correct_option: true)
option2 = Option.create(description_option: "Es un lenguaje imperativo", correct_option: false)
option3 = Option.create(description_option: "Es un lenguaje orientado a objetos", correct_option: false)

option4 = Option.create(description_option: "Int", correct_option: false)
option5 = Option.create(description_option: "Bool", correct_option: false)
option6 = Option.create(description_option: "Arraylist", correct_option: true)

option7 = Option.create(description_option: "Usando solo ::", correct_option: false)
option8 = Option.create(description_option: "Usando solo ->", correct_option: false)
option9 = Option.create(description_option: "Usando :: y ->", correct_option: true)