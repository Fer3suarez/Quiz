//
//  QuizzesTableViewController.swift
//  Quiz
//
//  Created by g807 DIT UPM on 15/11/18.
//  Copyright © 2018 g807 DIT UPM. All rights reserved.
//

import UIKit

struct Quiz: Codable {
    let id: Int
    let question: String
    let author: Usuario?
    let attachment: Attachment?
    var favourite: Bool
    let tips: [String]?
}

struct Attachment: Codable {
    let filename: String
    let mime: String
    let url: String
}

struct Quizzes_Page: Codable {
    let quizzes: [Quiz]
    let pageno: Int
    let nextUrl: String?
}


class QuizzesTableViewController: UITableViewController {
    
    let URLBASE = "https://quiz2019.herokuapp.com/api/quizzes?token=01c808eacecfa87b3766"
    var quizzes = [Quiz]()
    var imagesCache = [String:UIImage]()
    var httpResponseCode = false

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        downloadAllQuizzes(URLBASE)

    }

    

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return quizzes.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell Quizzes", for: indexPath) as! QuizzesTableViewCell

        // Configure the cell...
        let quiz = quizzes[indexPath.row]
        
        cell.questionLabel.text = quiz.question
        cell.usernameLabel.text = quiz.author?.username ?? "Unknown"
        
        if let img = imagesCache[quiz.attachment?.url ?? ""] {
            
            cell.imageLabel.image = img
            
        } else {
            
            download(quiz.attachment?.url ?? "", index: indexPath)
            
        }
        cell.id = indexPath.row
        if quiz.favourite == false {
            cell.imageFav.imageView?.image = UIImage(named: "star")
        } else {
            cell.imageFav.imageView?.image = UIImage(named: "fav")
        }

        return cell
    }
    
    func downloadAllQuizzes(_ url: String){
        guard let url = URL(string: url) else {
            print("Error 1")
            return
        }
       
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url) {
                if let quizzesInThisPage = try? JSONDecoder().decode(Quizzes_Page.self, from: data) {
                    DispatchQueue.main.async {
                        for i in quizzesInThisPage.quizzes {
                            self.quizzes.append(i)
                            self.tableView.reloadData()
                        }
                        if quizzesInThisPage.nextUrl != "" {
                            self.downloadAllQuizzes(quizzesInThisPage.nextUrl!)
                        }
                    }
                }
            }
        }
    }
    
    func download(_ urls: String, index indexpath:IndexPath ) {
        
        DispatchQueue.global().async {
            
            if let url = URL(string: urls),
                let data = try? Data(contentsOf: url),
                let img = UIImage(data: data) {
                
                DispatchQueue.main.async {
                    
                    self.imagesCache[urls] = img
                    self.tableView.reloadRows(at: [indexpath], with: .fade)
                }
                
            }
        }
    }
    
    
    @IBAction func refresh(_ sender: UIBarButtonItem) {
        
        imagesCache.removeAll()
        quizzes.removeAll()
        downloadAllQuizzes(URLBASE)
    }
    
    @IBAction func Fav(_ sender: UIButton) {

        let cell = sender.superview?.superview as! QuizzesTableViewCell
        let indexPath = tableView.indexPath(for: cell)
        
        if quizzes[cell.id].favourite == false {
            if reqPUT(quizzes[cell.id].id) {
                quizzes[cell.id].favourite = true
            }
        } else {
            if reqDELETE(quizzes[cell.id].id){
                quizzes[cell.id].favourite = false
            }
        }
        self.httpResponseCode = false
        self.tableView.reloadRows(at: [indexPath!], with: .fade)
    }

    func reqPUT(_ id: Int) -> Bool {
        let urlPUT = "https://quiz2019.herokuapp.com/api/users/tokenOwner/favourites/\(id)?token=01c808eacecfa87b3766"
        guard let url = URL(string: urlPUT) else {
            return false
        }
        var urlReq = URLRequest(url: url)
        urlReq.httpMethod = "PUT"

        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)

        let task = session.dataTask(with: urlReq, completionHandler: {
            (_, response, _) in
            if let response = response {
                let httpResponse = response as! HTTPURLResponse
                if httpResponse.statusCode == 200 {
                    self.httpResponseCode = true
                }
            }
            })

        task.resume()
        return self.httpResponseCode
    }
    
func reqDELETE(_ id: Int) -> Bool {
        let urlDELETE = "https://quiz2019.herokuapp.com/api/users/tokenOwner/favourites/\(id)?token=01c808eacecfa87b3766"
        guard let url = URL(string: urlDELETE) else {
            return false
        }
        var urlReq = URLRequest(url: url)
        urlReq.httpMethod = "DELETE"

        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)

        let task = session.dataTask(with: urlReq, completionHandler: {
            (_, response, _) in
            if let response = response {
                let httpResponse = response as! HTTPURLResponse
                if httpResponse.statusCode == 200 {
                    self.httpResponseCode = true
                }
            }
            })

        task.resume()
        return self.httpResponseCode
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Show Quiz" {
            if let qvc = segue.destination as? QuizzesViewController {
                let quiz = quizzes[(tableView.indexPathForSelectedRow?.row)!]
                    
                    qvc.question = quiz
                qvc.image = imagesCache[quiz.attachment?.url ?? ""]
                
            }
            
        }
    }
    
    

}
