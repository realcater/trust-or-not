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
    var game = 0

    @IBOutlet weak var bottomTitle: UILabel!
    @IBOutlet weak var topTitle: UILabel!
    private func setAcceleration() {
        let timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { (timer) in
            self.view.layer.timeOffset = self.view.layer.convertTime(CACurrentMediaTime(), from: nil)
            self.view.layer.beginTime = CACurrentMediaTime()
            self.view.layer.speed = self.view.layer.speed * 0.55
        }
        timer.fire()
    }
    private func prepareMole() {
        let mole = QuestionsPack(name_gen: "", picname: "mole", num: -1, englishName: "Mole", questionTasks: [])
        questionsPacks.items.append(mole)
    }
    
    private func showResultsOfFunnyGame() {
        let date=Date()
        print("===ShowResults=====\(date)")
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
        let date=Date()
        print("===HideResults=====\(date)")
        centerImage.isHidden = true
        topTitle.isHidden = true
        bottomTitle.isHidden = true
    }
    private func logoRotation(for circlesQty:Double, onCompletion action: @escaping () -> Void) {
        print("Rotation start")
        let sectorsQty = 12.0
        let acceleration = 1.05
        var duration : Double = 5
        let rollsQty = Int(circlesQty*sectorsQty)-1
        var rollsFinished = 0
        //print("rollsQty=\(rollsQty)")
        for i in 0...rollsQty {
            //print("start: i=\(i)")
            let angle = -CGFloat(i % Int(sectorsQty)+1)*CGFloat.pi*2.0/CGFloat(sectorsQty)
            UIView.animate(withDuration: duration, delay: 0.0, animations: {
                self.logoImage.transform = CGAffineTransform(rotationAngle: angle)
                }, completion: { finished in
                    rollsFinished+=1
                    //print("rollsFinished=\(rollsFinished)")
                    if finished, rollsFinished == rollsQty+1 { //block with i==0 finishes last of all i=..
                        action()
                    }
            })
           duration = duration / acceleration
        }
    }
    
    private func funnyGame(winner: Int?) {
        let date=Date()
        print("=====---GAME#\(game) Starts!!!  \(date)=====")
        game+=1
        if let winner=winner {
            print("topAnimal=\(topAnimal)")
            topAnimal = winner
        } else {
            print("topAnimal=\(topAnimal)")
            topAnimal = Int(drand48()*12)
        }
        print("New TopAnimal=\(topAnimal)")
        var circlesQty = Double(topAnimal)/12+1.0
        if topAnimal == -1 { circlesQty = 20 }
        print(Int(circlesQty*12))
        topAnimal = topAnimal % 12
        print("topAnimal=\(topAnimal)")
        hideResultsOfFunnyGame()
        logoRotation(for: circlesQty, onCompletion: showResultsOfFunnyGame)
        
    }
    @objc private func introViewDoubleTap(recognizer: UITapGestureRecognizer) {
        if(recognizer.state == UIGestureRecognizerState.ended) {
            print("went through 2taps")
            funnyGame(winner: nil)
        }
    }
    @objc private func introViewTripleTap(recognizer: UITapGestureRecognizer) {
        if(recognizer.state == UIGestureRecognizerState.ended) {
            print("went through 3taps")
            funnyGame(winner: 11)
        }
    }
    @objc private func introViewQuadripleTap(recognizer: UITapGestureRecognizer) {
        if(recognizer.state == UIGestureRecognizerState.ended) {
            print("went through 4taps")
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
        addTaps()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesEnded(_ touches: Set<UITouch>?, with: UIEvent?)
    {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
            self.performSegue(withIdentifier: "introSkip", sender: self)
        })
        
    }
    
}
