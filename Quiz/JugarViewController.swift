//
//  JugarViewController.swift
//  Quiz
//
//  Created by g807 DIT UPM on 21/11/2018.
//  Copyright © 2018 g807 DIT UPM. All rights reserved.
//

import UIKit

struct randomPlay: Codable {
    
    let quiz: Quiz
    let score: Int
}

struct randomQuizCheck: Codable {
    
    let answer: String
    let quizId: Int
    let result: Bool
    let score: Int
}

class JugarViewController: UIViewController {
    
    let URLBASE = "https://quiz2019.herokuapp.com/api/quizzes/randomPlay/new?token=01c808eacecfa87b3766"
    let URLNEXT = "https://quiz2019.herokuapp.com/api/quizzes/randomPlay/next?token=01c808eacecfa87b3766"

    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerLabel: UITextField!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var imageLabel: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        play(URLBASE)
        // Do any additional setup after loading the view.
    }
    
    func play(_ url: String) {
        guard let url = URL(string: url) else {
            print("Error 1")
            return
        }
        
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url){
                if let game = try? JSONDecoder().decode(randomPlay.self, from: data) {
                    DispatchQueue.main.async {
                        self.questionLabel.text = game.quiz.question
                        self.scoreLabel.text = "Score: \(game.score)"
                        self.answerLabel.text = ""
                        
                        if let url = URL(string: game.quiz.attachment?.url ?? ""),
                            let data = try? Data(contentsOf: url),
                            let img = UIImage(data: data) {
                            self.imageLabel.image = img
                            
                        }
                    }
                }
            }
        }
    }
    

    @IBAction func pushComprobar(_ sender: UIButton) {
        let anok = AlertaNOK()
        let URLCHECK = "https://quiz2019.herokuapp.com/api/quizzes/randomPlay/check?token=01c808eacecfa87b3766&answer=\(answerLabel.text ?? "")"
        
        guard let url = URL(string: URLCHECK.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!) else {
            print("Error 1")
            return
        }
        
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url) {
                if let quiz = try? JSONDecoder().decode(randomQuizCheck.self, from: data) {
                    DispatchQueue.main.async {
                        if quiz.result == true {
                            self.play(self.URLNEXT)
                        } else {
                            anok.showAlert()
                            self.present(anok.alert!, animated: true)
                            self.play(self.URLBASE)
                        }
                    }
                }
            }
        }
    }
}
