import UIKit

enum AnswerChoice {
    case trueAnswer
    case doubtAnswer
    case falseAnswer
}

class SingleGameState {
    enum AnswerState {
        case notAnswered
        case answered
        case finishGame
        case gotResults
    }
    
    var currentNumber: Int
    var answerState: AnswerState
    var score: Int
    var lastAnswer: AnswerChoice
    var answerResultString: String
    var showHelp: Bool
    
    
    init() {
        currentNumber = 0
        answerState = .notAnswered
        score = 0
        lastAnswer = .trueAnswer
        answerResultString = ""
        showHelp = true
    }
}

protocol SingleGameDelegate: CrowdGameDelegate {
    func textScore(_ score: Int) -> String
    func setScoreTitle(title: String, score: Int)
    func showAnswer(state: SingleGameState, question: String, comment: String) 
    func hideAnswer()
    func showUIAnswerMode(state: SingleGameState, question: String, comment: String)
    func showUIWaitMode(state: SingleGameState, question: String, comment: String)
    func showUIFinishGame(state: SingleGameState, question: String, comment: String)
    func showUIResults(fullResultsText: String, shortResultsText: String)
    func reloadTexts(state: SingleGameState, question: String, comment: String)
}

class SingleGame {
    
    var questionsPack : QuestionsPack!
    var state: SingleGameState!
    weak var delegate: SingleGameDelegate?
    
    init(delegate: SingleGameDelegate, questionsPack: QuestionsPack, state: SingleGameState) {
        self.delegate = delegate
        self.questionsPack = questionsPack
        self.state = state
        restoreState()
    }
    
    //MARK:- Game logic = Data change functions
    func answerIsTrue() {
        state.answerResultString = K.Labels.ResultBar.Result.win
        state.score += 1
    }
    func answerIsFalse() {
        state.answerResultString = K.Labels.ResultBar.Result.loose
        state.score -= 1
    }
    func answerIsDoubt() {
        state.answerResultString = K.Labels.ResultBar.Result.doubt
    }

    func answerButtonPressed(button: AnswerChoice) {
        state.answerState = .answered
        if button == .doubtAnswer {
            answerIsDoubt()
        } else if (questionsPack.questionTasks[state.currentNumber].answer == true) && (button == .trueAnswer) || (questionsPack.questionTasks[state.currentNumber].answer == false) && (button == .falseAnswer) {
            answerIsTrue()
        } else {
            answerIsFalse()
        }
        let question = questionsPack.questionTasks[self.state.currentNumber].question
        let comment = questionsPack.questionTasks[state.currentNumber].comment
        if state.currentNumber+1 < questionsPack.questionTasks.count {
            delegate?.showUIWaitMode(state: state, question: question, comment: comment)
        } else {
            state.answerState = .finishGame
            delegate?.showUIFinishGame(state: state, question: question, comment: comment)
        }
    }
    func nextQuestionButtonPressed() {
        state.currentNumber+=1
        if state.currentNumber == K.maxHelpShowedQty {
            state.showHelp = false
        }
        let question = questionsPack.questionTasks[self.state.currentNumber].question
        let comment = questionsPack.questionTasks[state.currentNumber].comment
        delegate?.showUIAnswerMode(state: state, question: question, comment: comment)
        state.answerState = .notAnswered
    }
    func getResultsButtonPressed() {
        delegate?.showUIResults(fullResultsText: getFullResultsText(), shortResultsText: getShortResultsText())
        state.answerState = .gotResults
    }
    
    func finishGameButtonPressed() {
        delegate?.returnToStartView()
    }
    func getShortResultsText() -> String {
        return K.Labels.ResultBar.Result.youGain + (delegate?.textScore(state.score) ?? String(state.score))
    }
    func getFullResultsText() -> String {
        for (score, textResult) in K.resultTexts {
            if state.score <= score {
                return textResult
            }
        }
        return ""
    }
    func restoreState() {
        let question = questionsPack.questionTasks[self.state.currentNumber].question
        let comment = questionsPack.questionTasks[state.currentNumber].comment
        switch state.answerState {
        case .answered: delegate?.showUIWaitMode(state: state, question: question, comment: comment)
        case .finishGame: delegate?.showUIFinishGame(state: state, question: question, comment: comment)
        case .notAnswered: delegate?.showUIAnswerMode(state: state, question: question, comment: comment)
        case .gotResults: delegate?.showUIResults(fullResultsText: getFullResultsText(), shortResultsText: getShortResultsText())
        }
        delegate?.reloadTexts(state: state, question: question, comment: comment)
    }
    
}
    
