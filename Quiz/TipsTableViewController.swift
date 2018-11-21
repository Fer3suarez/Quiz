//
//  TipsTableViewController.swift
//  Quiz
//
//  Created by g807 DIT UPM on 21/11/2018.
//  Copyright © 2018 g807 DIT UPM. All rights reserved.
//

import UIKit

class TipsTableViewController: UITableViewController {
    
    var tips = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tips.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell Tips", for: indexPath)

        // Configure the cell...
        
        cell.textLabel?.text = tips[indexPath.row]

        return cell
    }
    

}
