import UIKit

extension QuestionsVC: SingleGameDelegate {

    //MARK:- Protocol functions
    func showQuestionMode(state: SingleGameState) {
        hideAnswer()
        if state.showHelp { helpButton.isHidden = false }
        showChoiceButtons()
        setTextsAndTitle(topText: state.question, bottomText: "", currentNumber: state.currentNumber, score: state.textScore)
    }
    func showResultsMode(fullResultsText: String, shortResultsText: String) {
        hideAnswer()
        bottomButton.setTitle(K.Labels.Buttons.finishGame, for: .normal)
        questionText.text = fullResultsText

        resultLabel.text = shortResultsText
        resultLabel.backgroundColor = K.Colors.ResultBar.trueAnswer
        resultLabel.isHidden = false
        
        K.Sounds.applause?.resetAndPlay(startVolume: 1, fadeDuration: nil)
        bottomButton.turnClickSoundOn(sound: K.Sounds.click)
    }
    func showAnswerMode(state: SingleGameState) {
        //commentText.isHidden = false
        showResultLabel(state: state)
        playResultSounds(answer: state.answer!)
        switchButtonsToAnswerMode(isLastQuestion: state.isLastQuestion)
        setTextsAndTitle(topText: state.question, bottomText: state.comment, currentNumber: state.currentNumber, score: state.textScore)
        //K.Sounds.correct?.play()
    }
    
//MARK:- Support functions
    func showChoiceButtons() {
        topButton.setTitle(K.Labels.Buttons.trust, for: .normal)
        topButton.backgroundColor = K.Colors.Buttons.trueAnswer
        topButton.isHidden = false
        
        middleButton.setTitle(K.Labels.Buttons.doubt, for: .normal)
        middleButton.backgroundColor = K.Colors.Buttons.doubtAnswer
        middleButton.isHidden = false
        
        bottomButton.setTitle(K.Labels.Buttons.notTrust, for: .normal)
        bottomButton.sound = nil
        bottomButton.backgroundColor = K.Colors.Buttons.falseAnswer
        bottomButton.isHidden = false
    }
    func showResultLabel(state: SingleGameState) {
        switch state.statementIsTrue! {
        case true: resultLabel.backgroundColor = K.Colors.ResultBar.trueAnswer
        case false: resultLabel.backgroundColor = K.Colors.ResultBar.falseAnswer
        }
        resultLabel.text = state.resultText
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
        bottomButton.setTitle(buttonTitle, for: .normal)
        bottomButton.turnClickSoundOn(sound: K.Sounds.page)
        bottomButton.backgroundColor = K.Colors.foreground
    }
    func setTextsAndTitle(topText: String, bottomText: String, currentNumber: Int, score: String) {
        questionText.text = topText
        commentText.text = bottomText
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
            self.questionText.flashScrollIndicators()
            self.commentText.flashScrollIndicators()
        })
        let title = "\(K.Labels.Titles.question)\(gameState.singleGameState.currentNumber+1)/\(currentNumber)"
        setScoreTitle(title: title, score: score)
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
