//
//  StartViewController.swift
//  Верю-Не-верю
//
//  Created by Dmitry Dementyev on 27.08.2018.
//  Copyright © 2018 Dmitry Dementyev. All rights reserved.
//

import UIKit

class StartVC: UIViewController {

    @IBOutlet weak var playButton: MyButton!
    @IBOutlet weak var helpButton: MyButton!
    @IBOutlet weak var aboutButton: MyButton!
    @IBOutlet weak var touchView: UIView!
    
    @objc private func doubleTap(recognizer: UITapGestureRecognizer) {
        if(recognizer.state == UIGestureRecognizer.State.ended) {
            let introVC = self.navigationController!.viewControllers.first as! IntroVC
            introVC.startFunnyGame = true
            _ = navigationController?.popViewController(animated: true)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.setBackgroundImage(named: K.FileNames.background, alpha: K.Alpha.Background.main)
        playButton.makeRounded(color: K.Colors.foregroundLighter, textColor: K.Colors.background, sound: K.Sounds.click)
        helpButton.makeRounded(color: K.Colors.foreground, textColor: K.Colors.background, sound: K.Sounds.click)
        aboutButton.makeRounded(color: K.Colors.foregroundDarker, textColor: K.Colors.background, sound: K.Sounds.click)
        addTaps(for: touchView, doubleTapAction: #selector(doubleTap))
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
            helpVC.pagesForLoad = K.helpPagesAll
        }
    }
}
