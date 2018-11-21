//
//  QuizzesViewController.swift
//  Quiz
//
//  Created by g807 DIT UPM on 15/11/18.
//  Copyright © 2018 g807 DIT UPM. All rights reserved.
//

import UIKit

struct  quizComprobar: Codable  {
    let quizId: Int
    let answer: String
    let result: Bool
}

class QuizzesViewController: UIViewController {
    
    var question: Quiz!
    var image: UIImage!

    @IBOutlet weak var QuestionLabel: UILabel!
    
    @IBOutlet weak var AnswerSpaceLabel: UITextField!
    
    @IBOutlet weak var ImageLabel: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Responda: "
        QuestionLabel.text = question.question
        ImageLabel.image = image
    }

    
    @IBAction func pushComprobar(_ sender: UIButton) {
        
        let aok = AlertaOK()
        let anok = AlertaNOK()
        
        let URL_CHECK = "https://quiz2019.herokuapp.com/api/quizzes/\(question.id)/check?token=01c808eacecfa87b3766&answer=\(AnswerSpaceLabel.text ?? "")"
        
        guard let url = URL(string: URL_CHECK.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!) else {
            print("Error 1")
            return
        }
        
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url) {
                if let quiz = try? JSONDecoder().decode(quizComprobar.self, from: data) {
                    DispatchQueue.main.async {
                        if quiz.result == true {
                            aok.showAlert()
                            self.present(aok.alert!, animated: true)
                        } else {
                            anok.showAlert()
                            self.present(anok.alert!, animated: true)
                        }
                    }
                }
            }
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "Show tips" {
            if let tvc = segue.destination as? TipsTableViewController {

                tvc.tips = question.tips!
                
            }
        }
    }
    

}
