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
    
    private func showResultsOfFunnyGame() {
        centerImage.tintColor = .red
        bottomTitle.textColor = .red
        bottomTitle.textColor = .red
        
        if topAnimal == -1 {
            centerImage.image = UIImage(named: "mole")
            bottomTitle.text = "Mole always wins!!!"
        } else {
            centerImage.image = UIImage(named: questionsPacks.items[topAnimal].picname)
            bottomTitle.text = questionsPacks.items[topAnimal].englishName+" wins!"
        }
        
        UIView.transition(with: view,
                          duration: K.intro.hideAnimationDuration,
                          options: .transitionCrossDissolve,
                          animations: { [weak self] in
                            self?.centerImage.isHidden = false
                            self?.bottomTitle.isHidden = false
            }, completion: nil)
    }
    
    typealias noArgsFunc = (() -> Void)?
    
    private func multiTransition(with view: UIView, duration : Double, options: UIViewAnimationOptions, animations: noArgsFunc, times: Int) {
        UIView.transition(with: view,
              duration: duration,
              options: options,
              animations: animations,
              completion: {finished in
                if finished, times > 1 {
                    self.multiTransition(with: view, duration: duration, options: options, animations: animations, times: times-1)
                }
            })
    }
    
    private func hideResultsOfFunnyGame() {
        topTitle.font = UIFont(name: "Brushie Brushie", size: K.intro.titleFontSize)
        bottomTitle.font = UIFont(name: "Brushie Brushie", size: K.intro.titleFontSize)
        if self.topTitle.text != K.intro.rouletteText {
            multiTransition(with: self.topTitle,
                            duration: K.intro.showAnimationDuration,
                            options: .transitionFlipFromBottom,
                            animations: { [weak self] in
                                self?.topTitle.text = K.intro.rouletteText
                            },
                            times: 10)
        }
        UIView.transition(with: self.centerImage,
                      duration: K.intro.hideAnimationDuration,
                      options: .transitionCrossDissolve,
                      animations: { [weak self] in
                            self?.bottomTitle.isHidden = true
                        self?.centerImage.isHidden = true
                }, completion: nil)
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
                    print("i=\(i)")
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
        performSegue(withIdentifier: "introSkip", sender: self)
        //UIView.transition(from: self., to: ChooseYearV, duration: 0.5, options: .transitionCrossDissolve, completion: nil)
    }
}
