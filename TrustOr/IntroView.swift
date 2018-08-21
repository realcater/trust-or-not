//
//  IntroView.swift
//  TrustOr
//
//  Created by Dmitry Dementyev on 19.08.2018.
//  Copyright © 2018 Dmitry Dementyev. All rights reserved.
//

import UIKit
import AVFoundation

class IntroView: UIViewController {
    
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var centerImage: UIImageView!
    @IBOutlet weak var bottomTitle: UILabel!
    @IBOutlet weak var topTitle: UILabel!
    var funnyGame : FunnyGame!
    
    @objc private func introViewDoubleTap(recognizer: UITapGestureRecognizer) {
        if(recognizer.state == UIGestureRecognizerState.ended) {
            funnyGame.runFunnyGame(winner: nil)
        }
    }
    @objc private func introViewTripleTap(recognizer: UITapGestureRecognizer) {
        if(recognizer.state == UIGestureRecognizerState.ended) {
            funnyGame.runFunnyGame(winner: 11)
        }
    }
    @objc private func introViewQuadripleTap(recognizer: UITapGestureRecognizer) {
        if(recognizer.state == UIGestureRecognizerState.ended) {
            funnyGame.runFunnyGame(winner: -1)
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
    func playSounds() {
        for i in 1051...1336 {
            print(i)
            let systemSoundID: SystemSoundID = 1016
            AudioServicesPlaySystemSound (systemSoundID)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        logoImage.tintColor = K.foregroundColor
        centerImage.tintColor = K.foregroundColor
        topTitle.textColor = K.foregroundColor
        bottomTitle.textColor = K.foregroundColor
        funnyGame = FunnyGame(view: view, imageForRotate: logoImage, centerImage: centerImage, topTitle: topTitle, bottomTitle: bottomTitle)
        addTaps()
    }

    override func touchesEnded(_ touches: Set<UITouch>?, with: UIEvent?)
    {
        performSegue(withIdentifier: "introSkip", sender: self)
    }
}
