//
//  FunnyGame.swift
//  TrustOr
//
//  Created by Dmitry Dementyev on 21.08.2018.
//  Copyright © 2018 Dmitry Dementyev. All rights reserved.
//

import Foundation
import UIKit

class FunnyGame {
    var questionsPacks = ChineseAnimals()
    var topAnimal = 0
    var imageForRotate: UIImageView
    var centerImage : UIImageView
    var topTitle : UILabel
    var bottomTitle: UILabel
    
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
            topAnimal = Int(drand48()*12)
        }
        var circlesQty = Double(topAnimal)/12+1.0
        if topAnimal == -1 { circlesQty = 20 }
        topAnimal = topAnimal % 12
        hideResults()
        imageRotation(rotate: imageForRotate, for: circlesQty, onCompletion: showResults)
    }
}
