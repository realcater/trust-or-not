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
