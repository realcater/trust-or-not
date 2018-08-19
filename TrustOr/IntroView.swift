//
//  IntroView.swift
//  TrustOr
//
//  Created by Dmitry Dementyev on 19.08.2018.
//  Copyright © 2018 Dmitry Dementyev. All rights reserved.
//

import UIKit

class IntroView: UIViewController {

    @IBOutlet weak var logoButton: UIButton!
    
    @IBOutlet weak var logoImage: UIImageView!
    @IBAction func logoButtonPressed(_ sender: Any) {
    }
    
    private func setAcceleration() {
        let timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { (timer) in
            self.view.layer.timeOffset = self.view.layer.convertTime(CACurrentMediaTime(), from: nil)
            self.view.layer.beginTime = CACurrentMediaTime()
            self.view.layer.speed = self.view.layer.speed * 0.55
        }
        timer.fire()
    }
    private func logoRotation() {
        //setAcceleration()
        let circlesQty : CGFloat = 2
        let sectorsQty : CGFloat = 12
        let acceleration = 1.05
        var duration : Double = 5
        for i in 0...Int(circlesQty*sectorsQty)-1 {
            print(i)
            let angle = CGFloat(i % Int(sectorsQty)+1)*CGFloat.pi*2.0/sectorsQty
            UIView.animate(withDuration: duration) { () -> Void in
                self.logoImage.transform = CGAffineTransform(rotationAngle: angle)
            }
            duration = duration / acceleration
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        logoImage.tintColor = K.foregroundColor
        logoRotation()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesEnded(_ touches: Set<UITouch>?, with: UIEvent?)
    {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
            //self.performSegue(withIdentifier: "introSkip", sender: self)
            self.logoRotation()
        })
        
    }
    
}
