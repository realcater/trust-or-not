import UIKit

class SingleGame {
    //MARK:- normal vars
    var questionsPack : QuestionsPack!
    weak var delegate: GameDelegate?
    var currentQuestionNumber = 0
    var answerState: AnswerState = .notAnswered
    var score: Int = 0
    var answer: Bool?

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
        case (true, true):
            return K.Labels.ResultBar.True.win + K.Labels.ResultBar.Result.win
        case (true, false):
            return K.Labels.ResultBar.True.loose + K.Labels.ResultBar.Result.loose
        case (false, true):
            return K.Labels.ResultBar.False.win + K.Labels.ResultBar.Result.win
        case (false, false):
            return  K.Labels.ResultBar.False.loose + K.Labels.ResultBar.Result.loose
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
        for (limitScore, textResult) in K.resultTexts {
            if score <= limitScore {
                return textResult
            }
        }
        return ""
    }
    var nextQuestionButtonTitle: String {
        return isLastQuestion ? K.Labels.Buttons.showResults : K.Labels.Buttons.nextQuestion
    }
    var gameType: GameType {
        return .singleGame
    }
    //MARK:-
    init(questionsPack: QuestionsPack) {
        self.questionsPack = questionsPack
    }
    
    //MARK:- Events process
    func answerButtonPressed(button: Bool) {
        answerState = .answered
        answer = (statementIsTrue==button)
        if answer! { score += 1 }
        delegate?.showAnswerMode(gameType: gameType, statementIsTrue: statementIsTrue, resultText: answerResultText, answer: answer, nextQuestionButtonTitle: nextQuestionButtonTitle, question: question, comment: comment, title: title, score: textScore, withSound: true)
    }
    func nextQuestionButtonPressed() {
        if isLastQuestion {
            delegate?.showResultsMode(fullResultsText: fullResultsText, shortResultsText: shortResultsText, title: title, score: textScore, withSound: true)
            answerState = .gotResults
        } else {
            currentQuestionNumber+=1
            delegate?.showQuestionMode(gameType: gameType, showHelp: showHelp, question: question, title: title, score: textScore, withSound: true)
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
            delegate?.showAnswerMode(gameType: gameType, statementIsTrue: statementIsTrue, resultText: answerResultText, answer: answer!, nextQuestionButtonTitle: nextQuestionButtonTitle, question: question, comment: comment, title: title, score: textScore, withSound: false)
        case .notAnswered:
            delegate?.showQuestionMode(gameType: gameType, showHelp: showHelp, question: question, title: title, score: textScore, withSound: false)
        case .gotResults:
            delegate?.showResultsMode(fullResultsText: fullResultsText, shortResultsText: shortResultsText, title: title, score: textScore, withSound: false)
        }
    }
}
    
