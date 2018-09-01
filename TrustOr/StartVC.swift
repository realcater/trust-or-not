//
//  StartViewController.swift
//  Верю-Не-верю
//
//  Created by Dmitry Dementyev on 27.08.2018.
//  Copyright © 2018 Dmitry Dementyev. All rights reserved.
//

import UIKit

class StartVC: UIViewController {

    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var helpButton: UIButton!
    @IBOutlet weak var aboutButton: UIButton!
    
    @objc func multipleTap(_ sender: UIButton, event: UIEvent) {
        let touch: UITouch = event.allTouches!.first!
        if (touch.tapCount == 2) {
            performSegue(withIdentifier: "backToIntro", sender: self)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.setBackgroundImage(named: "textBackground", alpha: K.viewBackgroundAlpha)
        playButton.makeRounded(color: K.foregroundLighterColor, textColor: K.backgroundColor)
        helpButton.makeRounded(color: K.foregroundColor, textColor: K.backgroundColor)
        aboutButton.makeRounded(color: K.foregroundDarkerColor, textColor: K.backgroundColor)
        aboutButton.addTarget(self, action: #selector(multipleTap(_:event:)), for: UIControl.Event.touchDownRepeat)

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showFullHelp" {
            let helpVC = segue.destination as! HelpVC
            let pagesForLoad = [Int](0...8)
            helpVC.pagesForLoad = pagesForLoad
        } else if segue.identifier == "backToIntro" {
            let introVC = segue.destination as! IntroVC
            introVC.startFunnyGame = true
        }
    }
}
