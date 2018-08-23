//
//  FunnyGame.swift
//  TrustOr
//
//  Created by Dmitry Dementyev on 21.08.2018.
//  Copyright © 2018 Dmitry Dementyev. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

class FunnyGame {
    var questionsPacks = ChineseAnimals()
    var topAnimal = 0
    var imageForRotate: UIImageView
    var centerImage : UIImageView
    var topTitle : UILabel
    var bottomTitle: UILabel
    var ratchelSound = initSound(mp3filename: "ratchel.mp3")
    var dingSound = initSound2(mp3filename: "ding.mp3")
    
    init(imageForRotate: UIImageView, centerImage : UIImageView, topTitle : UILabel, bottomTitle: UILabel) {
        self.imageForRotate = imageForRotate
        self.centerImage = centerImage
        self.topTitle = topTitle
        self.bottomTitle = bottomTitle
    }
    
    func showResults() {
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
        
        //dingSound?.play()
        UIView.transition(with: centerImage,
                          duration: K.intro.hideAnimationDuration,
                          options: .transitionCrossDissolve,
                          animations: { [weak self] in
                            self?.centerImage.isHidden = false
                            self?.bottomTitle.isHidden = false
            }, completion: nil)
    }
    
    func hideResults() {
        topTitle.font = UIFont(name: "Brushie Brushie", size: K.intro.titleFontSize)
        bottomTitle.font = UIFont(name: "Brushie Brushie", size: K.intro.titleFontSize)
        if self.topTitle.text != K.intro.rouletteText {
            UIView.transition(with: self.topTitle,
                              duration: K.intro.showAnimationDuration,
                              options: .transitionFlipFromBottom,
                              animations: { [weak self] in
                                self?.topTitle.text = K.intro.rouletteText
                },
                              completion: nil)
        }
        UIView.transition(with: self.centerImage,
                          duration: K.intro.hideAnimationDuration,
                          options: .transitionCrossDissolve,
                          animations: { [weak self] in
                            self?.bottomTitle.isHidden = true
                            self?.centerImage.isHidden = true
            }, completion: nil)
    }
    
    func run(winner: Int?) {
        if let winner=winner {
            topAnimal = winner
        } else {
            topAnimal = Int.random(in: 0...11)
        }
        var circlesQty = Double(topAnimal)/12+1.0
        if topAnimal == -1 { circlesQty = Double.random(in: 5.0...10.0) }
        topAnimal = topAnimal % 12
        hideResults()
        /*ratchelSound?.play()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5, execute: {
            self.ratchelSound?.stop()
        })*/
        imageRotation(rotate: imageForRotate, for: circlesQty, onCompletion: showResults)
    }
}
