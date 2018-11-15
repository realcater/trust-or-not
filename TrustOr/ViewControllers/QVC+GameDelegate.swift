import UIKit
import AVFoundation

protocol GameDelegate: class {
    func returnToStartView()
    func showQuestionMode(gameType: GameType, showHelp: Bool, question: String, title: String, score: String, withSound: Bool)
    func showAnswerMode(gameType: GameType, statementIsTrue: Bool, resultText: String, answer: Bool!, nextQuestionButtonTitle: String, question: String, comment: String, title: String, score: String, withSound: Bool)
    func showResultsMode(fullResultsText: String, shortResultsText: String, title: String, score: String, withSound: Bool)
}
//MARK:-
extension QuestionsVC: GameDelegate {
    func returnToStartView() {
        K.Sounds.click?.play()
        performSegue(withIdentifier: "backToStart", sender: self)
        updateNavStack()
    }
    func showQuestionMode(gameType: GameType, showHelp: Bool, question: String, title: String, score: String, withSound: Bool) {
        setTitle(title: title, score: score)
        setTexts(topText: question, bottomText: "")
        hideResultLabel()
        if showHelp { helpButton.isHidden = false }
        showChoiceButtons(gameType: gameType)
        if withSound { K.Sounds.page?.resetAndPlay() }
    }
    func showAnswerMode(gameType: GameType, statementIsTrue: Bool, resultText: String, answer: Bool!, nextQuestionButtonTitle: String, question: String, comment: String, title: String, score: String, withSound: Bool) {
        
        setTitle(title: title, score: score)
        setTexts(topText: question, bottomText: comment)
        showResultLabel(answer: answer, statementIsTrue: statementIsTrue, resultText: resultText)
        
        showContinueButton(color: K.Colors.foreground, title: nextQuestionButtonTitle)
        let needFinishGameSound = (nextQuestionButtonTitle == K.Labels.Buttons.finishGame)
        if withSound {
            playResultSounds(answer: answer, needFinishGameSound: needFinishGameSound)
        }
    }
    func showResultsMode(fullResultsText: String, shortResultsText: String, title: String, score: String, withSound: Bool) {
        showContinueButton(color: K.Colors.foreground, title: K.Labels.Buttons.finishGame)
        setTexts(topText: "", bottomText: fullResultsText)
        showResultLabel(backgroundColor: K.Colors.resultBar[true]!, resultText: shortResultsText)
        setTitle(title: title, score: score)
        if withSound { K.Sounds.applause?.resetAndPlay(startVolume: 1) }
    }
    //MARK:- Support functions
    private func showChoiceButtons(gameType: GameType) {
        topButton.show(color: K.Colors.Buttons.topChoice[gameType]!, title: K.Labels.Buttons.topChoice[gameType]!)
        bottomButton.show(color: K.Colors.Buttons.bottomChoice[gameType]!, title: K.Labels.Buttons.bottomChoice[gameType]!)
    }
    func showResultLabel(answer: Bool!, statementIsTrue: Bool, resultText: String) {
        if let answer = answer {
            showResultLabel(backgroundColor: K.Colors.resultBar[answer]!, resultText: resultText)
        } else {
            showResultLabel(backgroundColor: K.Colors.resultBar[statementIsTrue]!, resultText: resultText)
        }
    }
    func showResultLabel(backgroundColor: UIColor, resultText: String) {
        resultLabel.backgroundColor = backgroundColor
        resultLabel.text = resultText
        resultLabel.isHidden = false
        constraintFromQuestion.constant = K.Margins.FromQuestion.toResultLabel
    }
    func hideResultLabel() {
        constraintFromQuestion.constant = K.Margins.FromQuestion.toTopButton
        resultLabel.isHidden = true
    }
    func playResultSounds(answer: Bool!, needFinishGameSound: Bool) {
        switch answer {
            case true: K.Sounds.correct?.play()
            case false: K.Sounds.error?.play()
            default: K.Sounds.click?.play()
        }
        if needFinishGameSound {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                K.Sounds.applause?.resetAndPlay()
            })
        }
    }
    private func switchButtonsToAnswerMode(isLastQuestion: Bool) {
        topButton.isHidden = true
        topButton.isHidden = true
        helpButton.isHidden = true
        let buttonTitle = isLastQuestion ? K.Labels.Buttons.finishGame : K.Labels.Buttons.nextQuestion
        bottomButton.show(color: K.Colors.foreground, title: buttonTitle)
    }
    func showContinueButton(color: UIColor, title: String) {
        topButton.isHidden = true
        topButton.isHidden = true
        helpButton.isHidden = true
        bottomButton.show(color: color, title: title)
    }
    func setTexts(topText: String, bottomText: String) {
        let paragraph = NSMutableParagraphStyle()
        paragraph.alignment = .center
        paragraph.hyphenationFactor = K.hyphenationFactor
        let fontSize = K.useSmallerFonts ? K.Fonts.Size.TextView.zoomed : K.Fonts.Size.TextView.normal
        let questionAttributes = [NSAttributedString.Key.paragraphStyle: paragraph,
                          NSAttributedString.Key.font: UIFont.systemFont(ofSize: fontSize)]
        let commentAttributes = [NSAttributedString.Key.paragraphStyle: paragraph,
                                 NSAttributedString.Key.font: UIFont.italicSystemFont(ofSize: fontSize)]
        questionText.attributedText = NSAttributedString(string: topText,
                                                         attributes: questionAttributes)
        commentText.attributedText = NSAttributedString(string: bottomText,
                                                         attributes: commentAttributes)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
            self.questionText.flashScrollIndicators()
            self.commentText.flashScrollIndicators()
        })
    }
    func setTitle(title: String, score: String = "") {
        if score == "" {
            self.title = title
        } else {
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
    //We leave only last 2 items in nav stack: the results of this very game and ChooseYearVC screen for choosing next game
    private func updateNavStack() {
        let navigationArray = self.navigationController?.viewControllers
        let newNavigationArray = Array(navigationArray!.suffix(2))
        self.navigationController?.viewControllers = newNavigationArray
    }
}
