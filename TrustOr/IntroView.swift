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
    @IBOutlet weak var bottomTitle: UILabel!
    @IBOutlet weak var topTitle: UILabel!
    var funnyGame : FunnyGame!
    
    @objc private func singleTap(recognizer: UITapGestureRecognizer) {
        if(recognizer.state == UIGestureRecognizerState.ended) {
            performSegue(withIdentifier: "introSkip", sender: self)
        }
    }
    @objc private func doubleTap(recognizer: UITapGestureRecognizer) {
        if(recognizer.state == UIGestureRecognizerState.ended) {
            funnyGame.run(winner: nil)
        }
    }
    @objc private func tripleTap(recognizer: UITapGestureRecognizer) {
        if(recognizer.state == UIGestureRecognizerState.ended) {
            funnyGame.run(winner: 11)
        }
    }
    @objc private func quadripleTap(recognizer: UITapGestureRecognizer) {
        if(recognizer.state == UIGestureRecognizerState.ended) {
            funnyGame.run(winner: -1)
        }
    }
    
    private func setColors() {
        logoImage.tintColor = K.foregroundColor
        centerImage.tintColor = K.foregroundColor
        topTitle.textColor = K.foregroundColor
        bottomTitle.textColor = K.foregroundColor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setColors()
        addTaps(for: self, forSingle: #selector(singleTap), forDouble: #selector(doubleTap), forTriple: #selector(tripleTap), forQuadriple: #selector(quadripleTap))
        funnyGame = FunnyGame(imageForRotate: logoImage, centerImage: centerImage, topTitle: topTitle, bottomTitle: bottomTitle)
    }

    override func touchesEnded(_ touches: Set<UITouch>?, with: UIEvent?)
    {
        
    }
}
