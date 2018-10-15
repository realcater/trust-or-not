import UIKit
import AVFoundation

extension QuestionsVC: SingleGameDelegate {
    //MARK:- Protocol functions
    func showQuestionMode(showHelp: Bool, question: String, title: String, score: String, withSound: Bool) {

        showChoiceButtons()
        if showHelp { helpButton.isHidden = false }
        setTexts(topText: question, bottomText: "")
        resultLabel.isHidden = true
        setScoreTitle(title: title, score: score)
        if withSound { K.Sounds.page?.resetAndPlay() }
    }
    func showResultsMode(fullResultsText: String, shortResultsText: String, title: String, score: String, withSound: Bool) {
        onlyBottomButton(color: K.Colors.foreground, title: K.Labels.Buttons.finishGame)
        setTexts(topText: fullResultsText, bottomText: "")
        showResultLabel(backgroundColor: K.Colors.ResultBar.trueAnswer, resultText: shortResultsText)
        setScoreTitle(title: title, score: score)
        if withSound { K.Sounds.applause?.resetAndPlay(startVolume: 1) }
    }
    func showAnswerMode(statementIsTrue: Bool, resultText: String, answer: AnswerChoice,    isLastQuestion: Bool, question: String, comment: String, title: String, score: String, withSound: Bool) {
        
        let bottomButtonTitle = isLastQuestion ? K.Labels.Buttons.showResults : K.Labels.Buttons.nextQuestion
        onlyBottomButton(color: K.Colors.foreground, title: bottomButtonTitle)
        setTexts(topText: question, bottomText: comment)
        
        showResultLabel(statementIsTrue: statementIsTrue, resultText: resultText)
        setScoreTitle(title: title, score: score)
        if withSound { playResultSounds(answer: answer) }
    }
    
//MARK:- Support functions
    private func showChoiceButtons() {
        topButton.show(color: K.Colors.Buttons.trueAnswer, title: K.Labels.Buttons.trust)
        middleButton.show(color: K.Colors.Buttons.doubtAnswer, title: K.Labels.Buttons.doubt)
        bottomButton.show(color: K.Colors.Buttons.falseAnswer, title: K.Labels.Buttons.notTrust)
    }
    private func showResultLabel(statementIsTrue: Bool, resultText: String) {
        switch statementIsTrue {
        case true:
            showResultLabel(backgroundColor: K.Colors.ResultBar.trueAnswer, resultText: resultText)
        case false:
            showResultLabel(backgroundColor: K.Colors.ResultBar.falseAnswer, resultText: resultText)
        }
    }
    private func showResultLabel(backgroundColor: UIColor, resultText: String) {
        resultLabel.backgroundColor = backgroundColor
        resultLabel.text = resultText
        resultLabel.isHidden = false
    }
    private func playResultSounds(answer: AnswerChoice) {
        switch answer {
            case .trueAnswer:
                K.Sounds.correct?.play()
            case .falseAnswer:
                K.Sounds.error?.play()
            case .doubtAnswer:
                K.Sounds.click?.play()
        }
    }
    private func onlyBottomButton(color: UIColor, title: String) {
        topButton.isHidden = true
        middleButton.isHidden = true
        helpButton.isHidden = true
        bottomButton.show(color: color, title: title)
    }
    private func setTexts(topText: String, bottomText: String) {
        questionText.text = topText
        commentText.text = bottomText
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
            self.questionText.flashScrollIndicators()
            self.commentText.flashScrollIndicators()
        })
    }
    private func setScoreTitle(title: String, score: String) {
        let navView = UINib(nibName: "navView", bundle: nil).instantiate(withOwner: self, options: nil)[0] as! UIView
        let width = navigationController!.navigationBar.frame.width
        let height = navigationController!.navigationBar.frame.height
        navView.frame = CGRect(x: 0,y: 0, width: width-2*K.Margins.title, height: height)
        if let titleLabel = navView.viewWithTag(1000) as? UILabel {
            titleLabel.text = title
        }
        if let scoreLabel = navView.viewWithTag(1001) as? UILabel {
            scoreLabel.text = score
        }
        navigationItem.titleView = navView
    }
}
