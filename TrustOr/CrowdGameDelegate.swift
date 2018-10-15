import UIKit
import AVFoundation

extension QuestionsVC: CrowdGameDelegate {

//MARK:- Protocol functions
    func returnToStartView() {
        K.Sounds.click?.play()
        performSegue(withIdentifier: "backToStart", sender: self)
        keepLastItemsInNavStack(itemsQty: 2)
    }
    func showQuestionMode(showHelp: Bool, question: String, title: String, withSound: Bool) {
        hideAnswer()
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
    private func hideAnswer() {
        commentText.isHidden = true
        resultLabel.isHidden = true
    }
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
    private func setTexts(topText: String, bottomText: String) {
        questionText.text = topText
        commentText.text = bottomText
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
            self.questionText.flashScrollIndicators()
            self.commentText.flashScrollIndicators()
        })
    }
    private func setTitle(title: String) {
        self.title = title
    }
    private func keepLastItemsInNavStack(itemsQty: Int) {
        let navigationArray = self.navigationController?.viewControllers
        let newNavigationArray = Array(navigationArray!.suffix(itemsQty))
        self.navigationController?.viewControllers = newNavigationArray
    }
}
