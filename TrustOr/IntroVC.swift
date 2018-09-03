//
//  IntroView.swift
//  TrustOr
//
//  Created by Dmitry Dementyev on 19.08.2018.
//  Copyright © 2018 Dmitry Dementyev. All rights reserved.
//

import UIKit


class IntroVC: UIViewController {
    
    @IBOutlet weak var logoImage: UIRotatedImageView!
    @IBOutlet weak var centerImage: UIImageView!
    @IBOutlet weak var bottomTitle: UILabel!
    @IBOutlet weak var topTitle: UILabel!
    var funnyGame : FunnyGame!
    var startFunnyGame = false
    
    @objc private func singleTap(recognizer: UITapGestureRecognizer) {
        if(recognizer.state == UIGestureRecognizer.State.ended) {
            performSegue(withIdentifier: "introSkip", sender: self)
        }
    }
    @objc private func doubleTap(recognizer: UITapGestureRecognizer) {
        if(recognizer.state == UIGestureRecognizer.State.ended), startFunnyGame {
            funnyGame.run(winner: nil)
        }
    }
    
    private func setColors() {
        logoImage.tintColor = K.Colors.foreground
        centerImage.tintColor = K.Colors.foreground
        topTitle.textColor = K.Colors.foreground
        bottomTitle.textColor = K.Colors.foreground
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setColors()
        view.setBackgroundImage(named: K.FileNames.background, alpha: K.Alpha.Background.main)
        addTaps(singleTapAction: #selector(singleTap), doubleTapAction: #selector(doubleTap))
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if startFunnyGame {
            funnyGame = FunnyGame(imageForRotate: logoImage, centerImage: centerImage, topTitle: topTitle, bottomTitle: bottomTitle)
            funnyGame.run(winner: nil)
        }
    }
}
