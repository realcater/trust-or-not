import UIKit
import AVFoundation

extension QuestionsVC: SingleGameDelegate {

    //MARK:- Protocol functions
    func showQuestionMode(showHelp: Bool, question: String, title: String, score: String) {
        hideAnswer()
        if showHelp { helpButton.isHidden = false }
        showChoiceButtons()
        setTexts(topText: question, bottomText: "")
        setScoreTitle(title: title, score: score)
    }
    func showResultsMode(fullResultsText: String, shortResultsText: String) {
        hideAnswer()
        bottomButton.show(color: K.Colors.foreground, title: K.Labels.Buttons.finishGame, sound: K.Sounds.click)
        questionText.text = fullResultsText
        showResultLabel(backgroundColor: K.Colors.ResultBar.trueAnswer, resultText: shortResultsText)
        K.Sounds.applause?.resetAndPlay(startVolume: 1, fadeDuration: nil)
    }
    func showAnswerMode(statementIsTrue: Bool, resultText: String, answer: AnswerChoice,    isLastQuestion: Bool, question: String, comment: String, title: String, score: String, withSound: Bool) {
        
        commentText.isHidden = false
        showResultLabel(statementIsTrue: statementIsTrue, resultText: resultText)
        if withSound { playResultSounds(answer: answer) }
        switchButtonsToAnswerMode(isLastQuestion: isLastQuestion)
        setTexts(topText: question, bottomText: comment)
        setScoreTitle(title: title, score: score)
    }
    
//MARK:- Support functions
    func showChoiceButtons() {
        topButton.show(color: K.Colors.Buttons.trueAnswer, title: K.Labels.Buttons.trust)
        middleButton.show(color: K.Colors.Buttons.doubtAnswer, title: K.Labels.Buttons.doubt)
        bottomButton.show(color: K.Colors.Buttons.falseAnswer, title: K.Labels.Buttons.notTrust)
    }
    func showResultLabel(statementIsTrue: Bool, resultText: String) {
        switch statementIsTrue {
        case true:
            showResultLabel(backgroundColor: K.Colors.ResultBar.trueAnswer, resultText: resultText)
        case false:
            showResultLabel(backgroundColor: K.Colors.ResultBar.falseAnswer, resultText: resultText)
        }
    }
    func showResultLabel(backgroundColor: UIColor, resultText: String) {
        resultLabel.backgroundColor = backgroundColor
        resultLabel.text = resultText
        resultLabel.isHidden = false
    }
    func playResultSounds(answer: AnswerChoice) {
        switch answer {
            case .trueAnswer: K.Sounds.correct?.play()
            case .falseAnswer: K.Sounds.error?.play()
            case .doubtAnswer: break
        }
    }
    func switchButtonsToAnswerMode(isLastQuestion: Bool) {
        topButton.isHidden = true
        middleButton.isHidden = true
        helpButton.isHidden = true
        
        let buttonTitle = isLastQuestion ? K.Labels.Buttons.showResults : K.Labels.Buttons.nextQuestion
        bottomButton.show(color: K.Colors.foreground, title: buttonTitle, sound: K.Sounds.page)
    }
    func setTexts(topText: String, bottomText: String) {
        questionText.text = topText
        commentText.text = bottomText
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
            self.questionText.flashScrollIndicators()
            self.commentText.flashScrollIndicators()
        })
    }
    func setScoreTitle(title: String, score: String) {
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
    
    func hideAnswer() {
        commentText.isHidden = true
        resultLabel.isHidden = true
    }
}
