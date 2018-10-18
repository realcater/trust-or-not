import UIKit
import AVFoundation

extension QuestionsVC: CrowdGameDelegate {

//MARK:- Protocol functions
    func returnToStartView() {
        K.Sounds.click?.play()
        performSegue(withIdentifier: "backToStart", sender: self)
        updateNavStack()
    }
    func showQuestionMode(showHelp: Bool, question: String, title: String, withSound: Bool) {
        resultLabel.isHidden = true
        helpButton.isHidden = !showHelp
        showChoiceButtons()
        setTexts(topText: question, bottomText: "")
        setTitle(title: title)
        if withSound { K.Sounds.page?.resetAndPlay() }
    }
    func showAnswerMode(statementIsTrue: Bool, resultText: String, isLastQuestion: Bool, question: String, comment: String, title: String, withSound: Bool) {
        commentText.isHidden = false
        showResultLabel(statementIsTrue: statementIsTrue, resultText: resultText)
        if withSound { playResultSounds(statementIsTrue: statementIsTrue, isLastQuestion: isLastQuestion) }
        switchButtonsToAnswerMode(isLastQuestion: isLastQuestion)
        setTexts(topText: question, bottomText: comment)
        setTitle(title: title)
    }
    
    //MARK:- Support functions
    
    private func showChoiceButtons() {
        topButton.isHidden = true
        middleButton.show(color: K.Colors.gray, title: K.Labels.Buttons.later)
        bottomButton.show(color: K.Colors.foreground, title: K.Labels.Buttons.showAnswer)
    }
    private func showResultLabel(statementIsTrue: Bool, resultText: String) {
        let color = statementIsTrue ? K.Colors.ResultBar.trueAnswer : K.Colors.ResultBar.falseAnswer
        showResultLabel(backgroundColor: color, resultText: resultText)
    }
    private func showResultLabel(backgroundColor: UIColor, resultText: String) {
        resultLabel.backgroundColor = backgroundColor
        resultLabel.text = resultText
        resultLabel.isHidden = false
    }
    private func playResultSounds(statementIsTrue: Bool, isLastQuestion: Bool) {
        let sound = statementIsTrue ? K.Sounds.correct : K.Sounds.error
        sound?.play()
        if isLastQuestion {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                K.Sounds.applause?.resetAndPlay()
            })
        }
    }
    private func switchButtonsToAnswerMode(isLastQuestion: Bool) {
        topButton.isHidden = true
        middleButton.isHidden = true
        helpButton.isHidden = true
        let buttonTitle = isLastQuestion ? K.Labels.Buttons.finishGame : K.Labels.Buttons.nextQuestion
        bottomButton.show(color: K.Colors.foreground, title: buttonTitle)
    }
    func setTexts(topText: String, bottomText: String) {
        questionText.text = topText
        commentText.text = bottomText
        //commentText.isHidden = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
            self.questionText.flashScrollIndicators()
            self.commentText.flashScrollIndicators()
        })
    }
    func setTitle(title: String) {
        self.title = title
    }
    //We leave only last 2 items in nav stack: the results of this very game and ChooseYearVC screen for choosing next game
    private func updateNavStack() {
        let navigationArray = self.navigationController?.viewControllers
        let newNavigationArray = Array(navigationArray!.suffix(2))
        self.navigationController?.viewControllers = newNavigationArray
    }
}
