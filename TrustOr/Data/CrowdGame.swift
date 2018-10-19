import UIKit



class CrowdGame {
    //MARK:- Normal vars
    var questionsPack : QuestionsPack!
    weak var delegate: GameDelegate?
    var currentQuestionNumber = 0
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
    var resultText: String {
        return statementIsTrue ? K.Labels.ResultBar.True.neutral : K.Labels.ResultBar.False.neutral
        }
    var nextQuestionButtonTitle: String {
        return isLastQuestionInGame ? K.Labels.Buttons.finishGame : K.Labels.Buttons.nextQuestion
    }
    var gameType: GameType {
        return .crowdGame
    }
    //MARK:-
    init(questionsPack: QuestionsPack) {
        self.questionsPack = questionsPack
    }
    
    //MARK:- Game logic = Data change functions
    func showAnswerButtonPressed() {
        answerState = .answered
        delegate?.showAnswerMode(gameType: gameType, statementIsTrue: statementIsTrue, resultText: resultText, answer: nil, nextQuestionButtonTitle: nextQuestionButtonTitle, question: question, comment: comment, title: title, score: "", withSound: true)
    }
    func laterButtonPressed() {
        leftQuestions.append(currentQuestionNumber)
        currentQuestionNumber += 1
        if currentQuestionNumber == K.maxHelpShowedQty {showHelp = false}
        if currentQuestionNumber == questionsPack.questionTasks.count {
            oneMoreQueer()
        }
        delegate?.showQuestionMode(gameType: gameType, showHelp: showHelp, question: question, title: title, score: "", withSound: true)
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
        delegate?.showQuestionMode(gameType: gameType, showHelp: showHelp, question: question, title: title, score: "", withSound: true)
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
        case .answered: delegate?.showAnswerMode(gameType: gameType, statementIsTrue: statementIsTrue, resultText: resultText, answer: nil, nextQuestionButtonTitle: nextQuestionButtonTitle, question: question, comment: comment, title: title, score: "", withSound: false)
        case .notAnswered: delegate?.showQuestionMode(gameType: gameType, showHelp: showHelp, question: question, title: title, score: "", withSound: false)
        default: break
        }
    }
}
