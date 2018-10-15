import UIKit

enum AnswerChoice {
    case trueAnswer
    case doubtAnswer
    case falseAnswer
}

protocol SingleGameDelegate: CrowdGameDelegate {
    func showQuestionMode(showHelp: Bool, question: String, title: String, score: String, withSound: Bool)
    func showResultsMode(fullResultsText: String, shortResultsText: String, title: String, score: String, withSound: Bool)
    func showAnswerMode(statementIsTrue: Bool, resultText: String, answer: AnswerChoice, isLastQuestion: Bool, question: String, comment: String, title: String, score: String, withSound: Bool)
}

class SingleGame {
    //MARK:- normal vars
    var questionsPack : QuestionsPack!
    weak var delegate: SingleGameDelegate?
    var currentQuestionNumber = 0
    var answerState: AnswerState = .notAnswered
    var score: Int = 0
    var answer: AnswerChoice?

    //MARK:- Computed vars
    var showHelp : Bool {
        return currentQuestionNumber < K.maxHelpShowedQty
    }
    var statementIsTrue: Bool {
        return questionsPack!.questionTasks[currentQuestionNumber].answer
    }
    var totalQuestionsQty: Int {
        return questionsPack!.questionTasks.count
    }
    var isLastQuestion: Bool {
        return currentQuestionNumber+1 >= totalQuestionsQty
    }
    var question: String {
        return questionsPack!.questionTasks[currentQuestionNumber].question
    }
    var comment: String {
        return questionsPack!.questionTasks[currentQuestionNumber].comment
    }
    var answerResultText: String {
        if answer==nil {return ""}
        switch (statementIsTrue, answer!) {
        case (true, .trueAnswer):
            return K.Labels.ResultBar.True.win + K.Labels.ResultBar.Result.win
        case (true, .falseAnswer):
            return K.Labels.ResultBar.True.loose + K.Labels.ResultBar.Result.loose
        case (true, .doubtAnswer):
            return K.Labels.ResultBar.True.neutral + K.Labels.ResultBar.Result.doubt
        case (false, .trueAnswer):
            return K.Labels.ResultBar.False.win + K.Labels.ResultBar.Result.win
        case (false, .falseAnswer):
            return  K.Labels.ResultBar.False.loose + K.Labels.ResultBar.Result.loose
        case (false, .doubtAnswer):
            return K.Labels.ResultBar.False.neutral + K.Labels.ResultBar.Result.doubt
        }
    }
    var textScore: String {
        switch score {
        case 1...Int.max: return "+"+String(score)
        case 0: return ""+String(score)
        default: return String(score)
        }
    }
    var title: String {
        return "\(K.Labels.Titles.question)\(currentQuestionNumber+1)/\(totalQuestionsQty)"
    }
    var shortResultsText: String {
        return K.Labels.ResultBar.Result.youGain + textScore
    }
    var fullResultsText: String {
        for (score, textResult) in K.resultTexts {
            if score <= score {
                return textResult
            }
        }
        return ""
    }
    //MARK:-
    init(questionsPack: QuestionsPack) {
        self.questionsPack = questionsPack
    }
    
    //MARK:- Events process
    func answerButtonPressed(button: AnswerChoice) {
        answerState = .answered
        switch (button, statementIsTrue) {
            case (.doubtAnswer, _): answer = .doubtAnswer
            case (.trueAnswer, true): answer = .trueAnswer
            case (.falseAnswer, false): answer = .trueAnswer
            case (.trueAnswer, false): answer = .falseAnswer
            case (.falseAnswer, true): answer = .falseAnswer
        }
        switch answer! {
            case .trueAnswer: score += 1
            case .falseAnswer: score -= 1
            case .doubtAnswer: break
        }
        delegate?.showAnswerMode(statementIsTrue: statementIsTrue, resultText: answerResultText, answer: answer!, isLastQuestion: isLastQuestion, question: question, comment: comment, title: title, score: textScore, withSound: true)
    }
    func nextQuestionButtonPressed() {
        if isLastQuestion {
            delegate?.showResultsMode(fullResultsText: fullResultsText, shortResultsText: shortResultsText, title: title, score: textScore, withSound: true)
            answerState = .gotResults
        } else {
            currentQuestionNumber+=1
            delegate?.showQuestionMode(showHelp: showHelp, question: question, title: title, score: textScore, withSound: true)
            answerState = .notAnswered
        }
    }
    func finishGameButtonPressed() {
        delegate?.returnToStartView()
    }
    //MARK:-
    func show() {
        switch answerState {
        case .answered:
            delegate?.showAnswerMode(statementIsTrue: statementIsTrue, resultText: answerResultText, answer: answer!, isLastQuestion: isLastQuestion, question: question, comment: comment, title: title, score: textScore, withSound: false)
        case .notAnswered:
            delegate?.showQuestionMode(showHelp: showHelp, question: question, title: title, score: textScore, withSound: false)
        case .gotResults:
            delegate?.showResultsMode(fullResultsText: fullResultsText, shortResultsText: shortResultsText, title: title, score: textScore, withSound: false)
        }
    }
}
    
