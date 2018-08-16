//
//  QuestionsView.swift
//  TrustOr
//
//  Created by Dmitry Dementyev on 16.08.2018.
//  Copyright © 2018 Dmitry Dementyev. All rights reserved.
//

import UIKit

class QuestionsView: UIViewController {
    @IBOutlet weak var showAnswerButton: UIButton!
    @IBOutlet weak var nextQuestionButton: UIButton!
    @IBOutlet weak var laterButton: UIButton!
    @IBOutlet weak var finishGameButton: UIButton!
    
    @IBOutlet weak var trueView: UIView!
    @IBOutlet weak var falseView: UIView!
    
    @IBOutlet weak var questionText: UITextView!
    @IBOutlet weak var commentText: UITextView!
    
    var animal : Animal!
    var currentQuestionNumber : Int = 0
    lazy var questionsQty = animal.questionTasks.count
    
    private func showAnswer() {
        commentText.isHidden = false
        if animal.questionTasks[currentQuestionNumber].answer == true {
            trueView.isHidden = false
        } else {
            falseView.isHidden = false
        }
    }
    
    private func hideAnswer() {
        commentText.isHidden = true
        trueView.isHidden = true
        falseView.isHidden = true
    }

    private func reloadTexts() {
        questionText.text = animal.questionTasks[currentQuestionNumber].question
        commentText.text = animal.questionTasks[currentQuestionNumber].comment
        title = K.questionLabel + String(currentQuestionNumber+1)+"/"+String(questionsQty)
    }
    //private func
    @IBAction func showAnswerButtonPressed(_ sender: Any) {
        showAnswer()
        print(currentQuestionNumber,questionsQty)
        if currentQuestionNumber+1 < questionsQty {
            showAnswerButton.isHidden = true
            nextQuestionButton.isHidden = false
        } else {
            showAnswerButton.isHidden = true
            laterButton.isHidden = true
            finishGameButton.isHidden = false
        }
    }
    
    @IBAction func nextQuestionButtonPressed(_ sender: Any) {
        hideAnswer()
        nextQuestionButton.isHidden = true
        showAnswerButton.isHidden = false
        currentQuestionNumber+=1
        reloadTexts()
    }
    
    @IBAction func laterButtonPressed(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = K.backgroundColor
        
        makeRoundedColorButton(for: showAnswerButton)
        makeRoundedColorButton(for: nextQuestionButton)
        makeRoundedGrayButton(for: laterButton)
        makeRoundedColorButton(for: finishGameButton)
        
        reloadTexts()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
