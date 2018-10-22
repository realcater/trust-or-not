//Common properites and Init for Single&Crowd games classes

class ParentGame {
    //MARK:- Normal vars
    var questionsPack : QuestionsPack!
    weak var delegate: GameDelegate?
    var currentQuestionNumber = 0
    var answerState: AnswerState = .notAnswered
    var showHelp = true
    
    //MARK:- Computed vars
    var totalQuestionsQty: Int {
        return questionsPack!.questionTasks.count
    }
    var question: String {
        return questionsPack!.questionTasks[currentQuestionNumber].question
    }
    var comment: String {
        return questionsPack!.questionTasks[currentQuestionNumber].comment
    }
    var statementIsTrue: Bool {
        return questionsPack!.questionTasks[currentQuestionNumber].answer
    }
    var title: String {
        return "\(K.Labels.Titles.question)\(currentQuestionNumber+1)/\(totalQuestionsQty)"
    }
    //MARK:-
    init(questionsPack: QuestionsPack) {
        self.questionsPack = questionsPack
    }
}
