struct AnimalArray {
    struct QuestionTask {
        var question: String
        var answer: String
    }
    struct Animal {
        var name_gen : String
        var picname : String
        var num : Int
        var questionTasks: [QuestionTask]
    }
    var animals: [Animal]
    init() {
        var mouse = Animal(name_gen : "Мыши", picname : "0", num : 0, questionTasks : [])
        mouse.questionTasks = [
            QuestionTask(
                question: "Мыши живут больше пяти лет?",
                answer: "Не верно!"),
            QuestionTask(
                question: "Мышки симпатичные?",
                answer: "Верно!")
        ]
        self.animals = [mouse]
        print(self.animals[0].name_gen)
    }
}


