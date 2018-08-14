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

class ChineseAnimals {
    var items: [Animal]
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
        self.items = [mouse]
        print("init chinese animals")
    }
}
