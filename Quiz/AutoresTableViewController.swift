//
//  AutoresTableViewController.swift
//  Quiz
//
//  Created by g807 DIT UPM on 14/11/18.
//  Copyright © 2018 g807 DIT UPM. All rights reserved.
//

import UIKit

struct Usuario : Codable {
    
    let id: Int?
    let isAdmin: Bool?
    let username: String?
}

class AutoresTableViewController: UITableViewController {
    
    let URLBASE = "https://quiz2019.herokuapp.com/api/users?token=01c808eacecfa87b3766"
    var items = [Usuario]()

    override func viewDidLoad() {
        super.viewDidLoad()

        download()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return items.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell Author", for: indexPath)

        // Configure the cell...
        let author = items[indexPath.row]
        
        cell.textLabel?.text = author.username

        return cell
    }
    
    func download() {
        guard let url = URL(string: URLBASE) else {
            print("Error 1")
            return
        }
        
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url) {
                if let items = try? JSONDecoder().decode([Usuario].self, from: data) {
                    
                    DispatchQueue.main.async {
                        self.items = items
                        self.tableView.reloadData()
                    }
                }
            }
        }
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "Show Author" {
            
            if let avc = segue.destination as? AuthorViewController {
                
                if let ip = tableView.indexPathForSelectedRow {
                    
                    avc.author = items[ip.row].username
                    avc.id = items[ip.row].id
                    avc.isAdmin = items[ip.row].isAdmin
                }
            }
        }
    }
}
