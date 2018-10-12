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
        case gotResults
    }
    var currentNumber: Int
    var answerState: AnswerState
    var score: Int
    var answer: AnswerChoice?
    var statementIsTrue: Bool?
    var showHelp: Bool
    var isLastQuestion: Bool
    var question: String
    var comment: String
    var resultText: String {
        if statementIsTrue==nil || answer==nil {return ""}
        switch (statementIsTrue!, answer!) {
        case (true, .trueAnswer):
            return K.Labels.ResultBar.True.win
        case (true, .falseAnswer):
            return K.Labels.ResultBar.True.loose
        case (true, .doubtAnswer):
            return K.Labels.ResultBar.True.neutral
        case (false, .trueAnswer):
            return K.Labels.ResultBar.False.win
        case (false, .falseAnswer):
            return  K.Labels.ResultBar.False.loose
        case (false, .doubtAnswer):
            return K.Labels.ResultBar.False.neutral
        }
    }
    var textScore: String {
        switch score {
        case 1...Int.max: return "+"+String(score)
        case 0: return ""+String(score)
        default: return String(score)
        }
    }
    init() {
        currentNumber = 0
        answerState = .notAnswered
        score = 0
        showHelp = true
        isLastQuestion = false
        question = ""
        comment = ""
    }
}

protocol SingleGameDelegate: CrowdGameDelegate {
    func showQuestionMode(state: SingleGameState)
    func showAnswerMode(state: SingleGameState)
    func showResultsMode(fullResultsText: String, shortResultsText: String)
}

class SingleGame {
    
    var questionsPack : QuestionsPack!
    var state: SingleGameState!
    weak var delegate: SingleGameDelegate?
    
    init(delegate: SingleGameDelegate, questionsPack: QuestionsPack, state: SingleGameState) {
        self.delegate = delegate
        self.questionsPack = questionsPack
        self.state = state
        switch state.answerState {
            case .answered: delegate.showAnswerMode(state: state)
            case .notAnswered: delegate.showQuestionMode(state: state)
            case .gotResults: delegate.showResultsMode(fullResultsText: getFullResultsText(), shortResultsText: getShortResultsText())
        }
    }
    
    //MARK:- Events process
    func answerButtonPressed(button: AnswerChoice) {
        state.answerState = .answered
        state.statementIsTrue = questionsPack.questionTasks[state.currentNumber].answer
        switch (button, state.statementIsTrue!) {
            case (.doubtAnswer, _): state.answer = .doubtAnswer
            case (.trueAnswer, true): state.answer = .trueAnswer
            case (.falseAnswer, false): state.answer = .trueAnswer
            case (.trueAnswer, false): state.answer = .falseAnswer
            case (.falseAnswer, true): state.answer = .falseAnswer
        }
        switch state.answer! {
            case .trueAnswer: state.score += 1
            case .falseAnswer: state.score -= 1
            case .doubtAnswer: break
        }
        state.comment = questionsPack.questionTasks[state.currentNumber].comment
        if state.currentNumber+1 >= questionsPack.questionTasks.count {
            state.isLastQuestion = true
        }
        delegate?.showAnswerMode(state: state)
    }
    func nextQuestionButtonPressed() {
        if state.isLastQuestion {
            delegate?.showResultsMode(fullResultsText: getFullResultsText(), shortResultsText: getShortResultsText())
            state.answerState = .gotResults
        } else {
            state.currentNumber+=1
            if state.currentNumber == K.maxHelpShowedQty {state.showHelp = false}
            delegate?.showQuestionMode(state: state)
            state.answerState = .notAnswered
        }
    }
    func finishGameButtonPressed() {
        delegate?.returnToStartView()
    }
    //MARK:- ResultTexts
    func getShortResultsText() -> String {
        return K.Labels.ResultBar.Result.youGain + state.textScore
    }
    func getFullResultsText() -> String {
        for (score, textResult) in K.resultTexts {
            if state.score <= score {
                return textResult
            }
        }
        return ""
    }
}
    
