//
//  AuthorViewController.swift
//  Quiz
//
//  Created by g807 DIT UPM on 15/11/18.
//  Copyright © 2018 g807 DIT UPM. All rights reserved.
//

import UIKit

class AuthorViewController: UIViewController {
    
    var author: String!
    var id: Int!
    var isAdmin: Bool?

    @IBOutlet weak var authorLabel: UILabel!
    
    @IBOutlet weak var idLabel: UILabel!
    
    @IBOutlet weak var isAdminLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = author
        authorLabel.text = "Username: \(author!)"
        idLabel.text = "Id: \(id!)"
        isAdminLabel.text = "Is Admin: \(isAdmin ?? false)"

        // Do any additional setup after loading the view.
    }



}
