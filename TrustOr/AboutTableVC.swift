//
//  AboutTableVC.swift
//  Верю-Не-верю
//
//  Created by Dmitry Dementyev on 03.09.2018.
//  Copyright © 2018 Dmitry Dementyev. All rights reserved.
//

import UIKit

class AboutTableVC: UITableViewController {

    @IBAction func fb1Tapped(_ sender: Any) {
        if let url = URL(string: K.Urls.fb1) {
            UIApplication.shared.open(url)
        }
    }
    @IBAction func fb2Tapped(_ sender: Any) {
        if let url = URL(string: K.Urls.fb2) {
            UIApplication.shared.open(url)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        self.clearsSelectionOnViewWillAppear = false

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
}
