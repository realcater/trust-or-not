//
//  IntroView.swift
//  TrustOr
//
//  Created by Dmitry Dementyev on 19.08.2018.
//  Copyright © 2018 Dmitry Dementyev. All rights reserved.
//

import UIKit

class IntroView: UIViewController {

    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var centerImage: UIImageView!
    var questionsPacks = ChineseAnimals()
    var topAnimal = 0

    @IBOutlet weak var bottomTitle: UILabel!
    @IBOutlet weak var topTitle: UILabel!
    
    private func prepareMole() {
        let mole = QuestionsPack(name_gen: "", picname: "mole", num: -1, englishName: "Mole", questionTasks: [])
        questionsPacks.items.append(mole)
    }
    
    private func showResultsOfFunnyGame() {
        if topAnimal == -1 { topAnimal=12 }
        centerImage.image = UIImage(named: questionsPacks.items[topAnimal].picname)
        centerImage.tintColor = UIColor.red
        topTitle.text = questionsPacks.items[topAnimal].englishName+" wins!"
        topTitle.textColor = UIColor.red
        bottomTitle.text = "Fatality!!!"//"Be a "+questionsPacks.items[topAnimal].englishName+"!"
        if topAnimal == 12 { bottomTitle.text = "Always wins!!!"}
        bottomTitle.textColor = UIColor.red
        centerImage.isHidden = false
        topTitle.isHidden = false
        bottomTitle.isHidden = false
    }
    
    private func hideResultsOfFunnyGame() {
        centerImage.isHidden = true
        topTitle.isHidden = true
        bottomTitle.isHidden = true
    }
    private func logoRotation(for circlesQty:Double, onCompletion action: @escaping () -> Void) {
        let sectorsQty = 12.0
        let acceleration = 1.05
        var duration : Double = 5
        let rollsQty = Int(circlesQty*sectorsQty)
        var rollsFinished = 0
        for i in 0...rollsQty-1 {
            let angle = -CGFloat(i % Int(sectorsQty)+1)*CGFloat.pi*2.0/CGFloat(sectorsQty)
            UIView.animate(withDuration: duration, delay: 0.0, animations: {
                self.logoImage.transform = CGAffineTransform(rotationAngle: angle)
                }, completion: { finished in
                    rollsFinished+=1
                    if finished, rollsFinished == rollsQty { //block with i==0 finishes last of all i=..
                        action()
                    }
            })
           duration = duration / acceleration
        }
    }
    
    private func funnyGame(winner: Int?) {
        if let winner=winner {
            topAnimal = winner
        } else {
            topAnimal = Int(drand48()*12)
        }
        var circlesQty = Double(topAnimal)/12+1.0
        if topAnimal == -1 { circlesQty = 20 }
        topAnimal = topAnimal % 12
        hideResultsOfFunnyGame()
        logoRotation(for: circlesQty, onCompletion: showResultsOfFunnyGame)
        
    }
    @objc private func introViewDoubleTap(recognizer: UITapGestureRecognizer) {
        if(recognizer.state == UIGestureRecognizerState.ended) {
            funnyGame(winner: nil)
        }
    }
    @objc private func introViewTripleTap(recognizer: UITapGestureRecognizer) {
        if(recognizer.state == UIGestureRecognizerState.ended) {
            funnyGame(winner: 11)
        }
    }
    @objc private func introViewQuadripleTap(recognizer: UITapGestureRecognizer) {
        if(recognizer.state == UIGestureRecognizerState.ended) {
            prepareMole()
            funnyGame(winner: -1)
        }
    }
    private func addTaps() {
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(introViewDoubleTap))
        doubleTap.numberOfTapsRequired = 2
        let tripleTap = UITapGestureRecognizer(target: self, action: #selector(introViewTripleTap))
        tripleTap.numberOfTapsRequired = 3
        let quadripleTap = UITapGestureRecognizer(target: self, action: #selector(introViewQuadripleTap))
        quadripleTap.numberOfTapsRequired = 4
        
        doubleTap.require(toFail: tripleTap)
        doubleTap.require(toFail: quadripleTap)
        tripleTap.require(toFail: quadripleTap)
        view.addGestureRecognizer(doubleTap)
        view.addGestureRecognizer(tripleTap)
        view.addGestureRecognizer(quadripleTap)
        view.isUserInteractionEnabled = true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        logoImage.tintColor = K.foregroundColor
        centerImage.tintColor = K.foregroundColor
        topTitle.textColor = K.foregroundColor
        bottomTitle.textColor = K.foregroundColor
        addTaps()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesEnded(_ touches: Set<UITouch>?, with: UIEvent?)
    {
        DispatchQueue.main.asyncAfter(deadline: .now(), execute: {
            self.performSegue(withIdentifier: "introSkip", sender: self)
        })
    }
}
