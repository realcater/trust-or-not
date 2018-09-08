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
        for (score, textResult) in K.resultTexts {
            if state.score <= score {
                return textResult
            }
        }
        return ""
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
            self.questionText.text = self.questionsPack.questionTasks[self.state.currentNumber].question
        }
        commentText.text = questionsPack.questionTasks[state.currentNumber].comment
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
            self.questionText.flashScrollIndicators()
        })
        let title = "\(K.Labels.Titles.question)\(state.currentNumber+1)/\(questionsPack.questionTasks.count)"
        delegate?.setScoreTitle(title: title, score: state.score)
    }
    private func showAnswer() {
        print("showAnswer()")
        commentText.isHidden = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
            self.commentText.flashScrollIndicators()
        })
        if questionsPack.questionTasks[state.currentNumber].answer == true {
            resultLabel.backgroundColor = K.Colors.ResultBar.trueAnswer
            switch state.answerResultString {
            case K.Labels.ResultBar.Result.win:
                resultLabel.text = K.Labels.ResultBar.True.win
                K.Sounds.correct?.play()
                print("==")
                print(state.answerResultString)
            case K.Labels.ResultBar.Result.loose:
                resultLabel.text = K.Labels.ResultBar.True.loose
                K.Sounds.error?.play()
            default:
                resultLabel.text = K.Labels.ResultBar.True.neutral
                //clickSound?.play()
                print("===")
                print(state.answerResultString)
            }
        } else {
            resultLabel.backgroundColor = K.Colors.ResultBar.falseAnswer
            switch state.answerResultString {
            case K.Labels.ResultBar.Result.win:
                resultLabel.text = K.Labels.ResultBar.False.win
                K.Sounds.correct?.play()
            case K.Labels.ResultBar.Result.loose:
                resultLabel.text = K.Labels.ResultBar.False.loose
                K.Sounds.error?.play()
            default:
                resultLabel.text = K.Labels.ResultBar.False.neutral
                //clickSound?.play()
                print("=====")
                print(state.answerResultString)
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
        questionText.text = getFullResultsText()
        questionText.isHidden = false
        resultLabel.text = getShortResultsText()
        resultLabel.backgroundColor = K.Colors.ResultBar.trueAnswer
        resultLabel.isHidden = false
    }
}
