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
    var imageForRotate: UIRotatedImageView
    var centerImage : UIImageView
    var topTitle : UILabel
    var bottomTitle: UILabel
    
    init(imageForRotate: UIRotatedImageView, centerImage : UIImageView, topTitle : UILabel, bottomTitle: UILabel) {
        self.imageForRotate = imageForRotate
        self.centerImage = centerImage
        self.topTitle = topTitle
        self.bottomTitle = bottomTitle
    }
    
    func showResults() {
        centerImage.tintColor = K.Colors.funnyGameResults
        bottomTitle.textColor = K.Colors.funnyGameResults
        bottomTitle.textColor = K.Colors.funnyGameResults
        
        centerImage.image = UIImage(named: questionsPacks.items[topAnimal].picname)
        bottomTitle.text = questionsPacks.items[topAnimal].englishName + K.Labels.FunnyGame.win
        
        //dingSound?.play()
        UIView.transition(with: centerImage,
                          duration: K.Duration.FunnyGame.hideAnimation,
                          options: .transitionCrossDissolve,
                          animations: { [weak self] in
                            self?.centerImage.isHidden = false
                            self?.bottomTitle.isHidden = false
            }, completion: nil)
    }
    
    func hideResults() {
        topTitle.font = UIFont(name: K.Fonts.Name.intro, size: K.Fonts.Size.Intro.inFunnyGame)
        bottomTitle.font = UIFont(name: K.Fonts.Name.intro, size: K.Fonts.Size.Intro.inFunnyGame)
        if self.topTitle.text != K.Labels.Titles.roulette {
            UIView.transition(with: self.topTitle,
                              duration: K.Duration.FunnyGame.showAnimation,
                              options: .transitionFlipFromBottom,
                              animations: { [weak self] in
                                self?.topTitle.text = K.Labels.Titles.roulette
                },
                              completion: nil)
        }
        UIView.transition(with: self.centerImage,
                          duration: K.Duration.FunnyGame.hideAnimation,
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
            topAnimal = Int.random(in: 0...K.funnyGameAnimalsQty-1)
        }
        let circlesQty = Double(topAnimal)/Double(K.funnyGameAnimalsQty)+1.0
        topAnimal = topAnimal % K.funnyGameAnimalsQty
        hideResults()
        /*ratchelSound?.play()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5, execute: {
            self.ratchelSound?.stop()
        })*/
        imageForRotate.rotation(for: circlesQty, onCompletion: showResults)
    }
}

