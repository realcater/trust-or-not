import UIKit

protocol CrowdGameDelegate: class {
    func returnToStartView()
    func showQuestionMode(showHelp: Bool, question: String, title: String, withSound: Bool)
    func showAnswerMode(statementIsTrue: Bool, resultText: String, isLastQuestion: Bool, question: String, comment: String, title: String, withSound: Bool)
}

class CrowdGame {
    //MARK:- Normal vars
    var questionsPack : QuestionsPack!
    weak var delegate: CrowdGameDelegate?
    var currentQuestionNumber: Int = 0
    var leftQuestions: [Int] = []
    var answerState: AnswerState = .notAnswered
    var showHelp = true
    
    //MARK:- Computed vars
    var totalQuestionsQty: Int {
        return questionsPack!.questionTasks.count
    }
    var isLastQuestionInQueer: Bool {
        return currentQuestionNumber+1 >= totalQuestionsQty
    }
    var isLastQuestionInGame: Bool {
        return isLastQuestionInQueer && leftQuestions.count == 0
    }
    var question: String {
        return questionsPack!.questionTasks[currentQuestionNumber].question
    }
    var comment: String {
        return questionsPack!.questionTasks[currentQuestionNumber].comment
    }
    var title : String {
        var title = K.Labels.Titles.question + String(currentQuestionNumber+1)+"/"+String(totalQuestionsQty)
        if leftQuestions.count > 0 {
            title = title + " (+" + String(leftQuestions.count) + ")"
        }
        return title
    }
    var statementIsTrue: Bool {
        return questionsPack!.questionTasks[currentQuestionNumber].answer
    }
    var answerResultText: String {
        return statementIsTrue ? K.Labels.ResultBar.True.neutral : K.Labels.ResultBar.False.neutral
        }
    
    //MARK:-
    init(questionsPack: QuestionsPack) {
        self.questionsPack = questionsPack
    }
    
    //MARK:- Game logic = Data change functions
    func showAnswerButtonPressed() {
        answerState = .answered
        delegate?.showAnswerMode(statementIsTrue: statementIsTrue, resultText: answerResultText, isLastQuestion: isLastQuestionInGame, question: question, comment: comment, title: title, withSound: true)
    }
    func laterButtonPressed() {
        leftQuestions.append(currentQuestionNumber)
        currentQuestionNumber += 1
        if currentQuestionNumber == K.maxHelpShowedQty {showHelp = false}
        if currentQuestionNumber == questionsPack.questionTasks.count {
            oneMoreQueer()
        }
        delegate?.showQuestionMode(showHelp: showHelp, question: question, title: title, withSound: true)
    }
    func nextQuestionButtonPressed() {
        if isLastQuestionInGame {
            delegate?.returnToStartView()
            return
        } else if isLastQuestionInQueer {
            answerState = .notAnswered
            oneMoreQueer()
        } else {
            answerState = .notAnswered
            currentQuestionNumber += 1
            if currentQuestionNumber == K.maxHelpShowedQty {showHelp = false}
        }
        delegate?.showQuestionMode(showHelp: showHelp, question: question, title: title, withSound: true)
    }
    private func oneMoreQueer() {
        var newQuestionTasks: [QuestionTask] = []
        for i in leftQuestions {
            newQuestionTasks.append(questionsPack.questionTasks[i])
        }
        questionsPack.questionTasks = newQuestionTasks
        leftQuestions = []
        currentQuestionNumber = 0
    }
    //MARK:- UI Change functions
    func show() {
        switch answerState {
        case .answered: delegate?.showAnswerMode(statementIsTrue: statementIsTrue, resultText: answerResultText, isLastQuestion: isLastQuestionInGame, question: question, comment: comment, title: title, withSound: false)
        case .notAnswered: delegate?.showQuestionMode(showHelp: showHelp, question: question, title: title, withSound: false)
        default: break
        }
    }
}
