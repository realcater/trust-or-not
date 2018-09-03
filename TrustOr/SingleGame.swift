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
}

class SingleGame {
    var questionText: UITextView
    var commentText: UITextView
    var trueAnswerButton: UIButton
    var doubtAsnwerButton: UIButton
    var falseAsnwerButton: UIButton
    var nextQuestionButton: UIButton
    var finishGameButton: UIButton
    var helpButton: UIButton
    var resultLabel: UILabel
    
    var questionsPack : QuestionsPack!
    var state: SingleGameState!
    weak var delegate: SingleGameDelegate?
    
    init(delegate: SingleGameDelegate, questionsPack: QuestionsPack, state: SingleGameState, questionText: UITextView, commentText: UITextView, trueAnswerButton: UIButton, doubtAsnwerButton: UIButton, falseAsnwerButton: UIButton, nextQuestionButton: UIButton, finishGameButton: UIButton, helpButton: UIButton, resultLabel: UILabel) {
        self.delegate = delegate
        self.questionsPack = questionsPack
        self.state = state
        self.questionText = questionText
        self.commentText = commentText
        self.trueAnswerButton = trueAnswerButton
        self.doubtAsnwerButton = doubtAsnwerButton
        self.falseAsnwerButton = falseAsnwerButton
        self.nextQuestionButton = nextQuestionButton
        self.finishGameButton = finishGameButton
        self.helpButton = helpButton
        self.resultLabel = resultLabel
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
        if state.currentNumber+1 < questionsPack.questionTasks.count {
            showUIWaitMode()
        } else {
            state.answerState = .finishGame
            showUIFinishGame()
        }
    }
    func nextQuestionButtonPressed() {
        state.currentNumber+=1
        if state.currentNumber == K.maxHelpShowedQty {
            state.showHelp = false
        }
        showUIAnswerMode()
        state.answerState = .notAnswered
    }
    func getResultsButtonPressed() {
        showUIResults()
        state.answerState = .gotResults
    }
    
    func finishGameButtonPressed() {
        delegate?.returnToStartView()
    }
    func getShortResultsText() -> String {
        return K.Labels.ResultBar.Result.youGain + (delegate?.textScore(state.score) ?? String(state.score))
    }
    func getFullResultsText() -> String {
        var text: String
        switch abs(state.score) {
        case 0...3:
            text = "Да, с годом \(questionsPack.name_gen) у вас явно сложные отношения - будем откровенны, не самый высокий результат... Но всегда есть куда стремиться! Может, попробовать другой год?"
        case 4...6:
            text = "Поздравляем! Вы вошли в число 29% людей, которые лучше всего справились с данным заданием! В логике или удачи вам не откажешь!"
        case 7...9:
            text = "Поздравляем! Вы вошли в число 7% людей, которые лучше всего справились с данным заданием! Вы чертовски умны и сообразительны или просто на короткой ноге с Тюхе!"
        case 10...12:
            text = "Фантастический результат! Вы вошли в число 2% людей, которые лучше всего справились с данным заданием! Вашей эрудиции и логике можно только позавидовать!"
        case 13...18:
            text = "Нереальный результат! Вы вошли в число 0.3% людей, которые лучше всего справились с данным заданием! Срочно играть в ”Что? Где? Когда?”!"
        default:
            text = "Все ответы верные? Серьёзно? Одно из двух: или вы играете не в первый раз, или ваша фамилия - Бер!"
        }
        if state.score < -3 {
            text = text + " (Да, мы в курсе, что вы отвечали специально неправильно! Но нас не проведёшь!)"
        }
        return text
    }
    
    //MARK:- UI Change functions
    func restoreState() {
        switch state.answerState {
        case .answered: showUIWaitMode()
        case .finishGame: showUIFinishGame()
        case .notAnswered: showUIAnswerMode()
        case .gotResults: showUIResults()
        }
        reloadTexts()
    }
    private func reloadTexts() {
        if state.answerState != .gotResults {
            questionText.text = questionsPack.questionTasks[state.currentNumber].question
        }
        commentText.text = questionsPack.questionTasks[state.currentNumber].comment
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
            self.questionText.flashScrollIndicators()
        })
        let title = "\(K.Labels.Titles.question)\(state.currentNumber+1)/\(questionsPack.questionTasks.count)"
        delegate?.setScoreTitle(title: title, score: state.score)
    }
    private func showAnswer() {
        commentText.isHidden = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
            self.commentText.flashScrollIndicators()
        })
        if questionsPack.questionTasks[state.currentNumber].answer == true {
            resultLabel.backgroundColor = K.Colors.ResultBar.trueAnswer
            switch state.answerResultString {
            case K.Labels.ResultBar.Result.win:
                resultLabel.text = K.Labels.ResultBar.True.win
            case K.Labels.ResultBar.Result.loose:
                resultLabel.text = K.Labels.ResultBar.True.loose
            default:
                resultLabel.text = K.Labels.ResultBar.True.neutral
            }
        } else {
            resultLabel.backgroundColor = K.Colors.ResultBar.falseAnswer
            switch state.answerResultString {
            case K.Labels.ResultBar.Result.win:
                resultLabel.text = K.Labels.ResultBar.False.win
            case K.Labels.ResultBar.Result.loose:
                resultLabel.text = K.Labels.ResultBar.False.loose
            default:
                resultLabel.text = K.Labels.ResultBar.False.neutral
            }
        }
        resultLabel.text = resultLabel.text! + state.answerResultString
        resultLabel.isHidden = false
        reloadTexts()
    }
    private func hideAnswer() {
        commentText.isHidden = true
        resultLabel.isHidden = true
    }
    private func showUIAnswerMode() {
        hideAnswer()
        nextQuestionButton.isHidden = true
        if state.showHelp { helpButton.isHidden = false }
        
        trueAnswerButton.setTitle(K.Labels.Buttons.trust, for: .normal)
        trueAnswerButton.backgroundColor = K.Colors.Buttons.trueAnswer
        trueAnswerButton.isHidden = false
        
        doubtAsnwerButton.setTitle(K.Labels.Buttons.doubt, for: .normal)
        doubtAsnwerButton.backgroundColor = K.Colors.Buttons.doubtAnswer
        doubtAsnwerButton.isHidden = false
        
        falseAsnwerButton.setTitle(K.Labels.Buttons.notTrust, for: .normal)
        falseAsnwerButton.backgroundColor = K.Colors.Buttons.falseAnswer
        falseAsnwerButton.isHidden = false
        
        reloadTexts()
    }
    private func showUIWaitMode() {
        showAnswer()
        trueAnswerButton.isHidden = true
        doubtAsnwerButton.isHidden = true
        falseAsnwerButton.isHidden = true
        helpButton.isHidden = true

        nextQuestionButton.setTitle(K.Labels.Buttons.nextQuestion, for: .normal)
        nextQuestionButton.backgroundColor = K.Colors.foreground
        nextQuestionButton.isHidden = false
    }
    private func showUIFinishGame() {
        showAnswer()
        trueAnswerButton.isHidden = true
        doubtAsnwerButton.isHidden = true
        falseAsnwerButton.isHidden = true
        helpButton.isHidden = true
        
        finishGameButton.setTitle(K.Labels.Buttons.showResults, for: .normal)
        finishGameButton.backgroundColor = K.Colors.foreground
        finishGameButton.isHidden = false
    }
    private func showUIResults() {
        hideAnswer()
        helpButton.isHidden = true
        finishGameButton.setTitle(K.Labels.Buttons.finishGame, for: .normal)
        finishGameButton.isHidden = false
        print(questionText.text)
        questionText.text = getFullResultsText()
        print(questionText.text)
        questionText.isHidden = false
        resultLabel.text = getShortResultsText()
        resultLabel.backgroundColor = K.Colors.Buttons.trueAnswer
        resultLabel.isHidden = false
    }
}
