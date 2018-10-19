import UIKit



class CrowdGame: ParentGame {
    let gameType = GameType.crowdGame
    
    //MARK:- Normal vars
    var leftQuestions: [Int] = []
    
    //MARK:- Computed vars
    var isLastQuestionInQueer: Bool {
        return currentQuestionNumber+1 >= totalQuestionsQty
    }
    var isLastQuestionInGame: Bool {
        return isLastQuestionInQueer && leftQuestions.count == 0
    }
    override var title : String {
        var title = K.Labels.Titles.question + String(currentQuestionNumber+1)+"/"+String(totalQuestionsQty)
        if leftQuestions.count > 0 {
            title = title + " (+" + String(leftQuestions.count) + ")"
        }
        return title
    }
    var answerResultText: String {
        return statementIsTrue ? K.Labels.ResultBar.True.neutral : K.Labels.ResultBar.False.neutral
        }
    var nextQuestionButtonTitle: String {
        return isLastQuestionInGame ? K.Labels.Buttons.finishGame : K.Labels.Buttons.nextQuestion
    }
    
    //MARK:- Game logic = Data change functions
    func showAnswerButtonPressed() {
        answerState = .answered
        delegate?.showAnswerMode(gameType: gameType, statementIsTrue: statementIsTrue, resultText: answerResultText, answer: nil, nextQuestionButtonTitle: nextQuestionButtonTitle, question: question, comment: comment, title: title, score: "", withSound: true)
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
        case .answered: delegate?.showAnswerMode(gameType: gameType, statementIsTrue: statementIsTrue, resultText: answerResultText, answer: nil, nextQuestionButtonTitle: nextQuestionButtonTitle, question: question, comment: comment, title: title, score: "", withSound: false)
        case .notAnswered: delegate?.showQuestionMode(gameType: gameType, showHelp: showHelp, question: question, title: title, score: "", withSound: false)
        default: break
        }
    }
}
