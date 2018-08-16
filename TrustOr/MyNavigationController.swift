//
//  MyNavigationController.swift
//  TrustOr
//
//  Created by Dmitry Dementyev on 16.08.2018.
//  Copyright © 2018 Dmitry Dementyev. All rights reserved.
//

import UIKit

class MyNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.barTintColor = K.foregroundColor
        navigationBar.titleTextAttributes = [NSAttributedStringKey(rawValue: NSAttributedStringKey.foregroundColor.rawValue): K.backgroundColor]
        //UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey(rawValue: NSAttributedStringKey.foregroundColor.rawValue): K.backgroundColor]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
