//
//  IntroView.swift
//  Trust
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    private func setColors() {
        logoImage.tintColor = K.Colors.foreground
        centerImage.tintColor = K.Colors.foreground
        topTitle.textColor = K.Colors.foreground
        bottomTitle.textColor = K.Colors.foreground
    }
    private func setFonts() {
        topTitle.font = UIFont(name: K.Fonts.Name.intro, size: K.Fonts.Size.Intro.atStart)
        bottomTitle.font = UIFont(name: K.Fonts.Name.intro, size: K.Fonts.Size.Intro.atStart)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setColors()
        setFonts()
        view.setBackgroundImage(named: K.FileNames.background, alpha: K.Alpha.Background.main)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if startFunnyGame {
            funnyGame = FunnyGame(imageForRotate: logoImage, centerImage: centerImage, topTitle: topTitle, bottomTitle: bottomTitle)
            funnyGame.run(winner: nil)
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        if let touch = touches.first, touch.view == self.view {
            performSegue(withIdentifier: "introSkip", sender: self)
        }
    }
}
