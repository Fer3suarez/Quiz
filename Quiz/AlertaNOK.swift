//
//  AlertaNOK.swift
//  Quiz
//
//  Created by g807 DIT UPM on 20/11/18.
//  Copyright © 2018 g807 DIT UPM. All rights reserved.
//

import UIKit

class AlertaNOK: UIView {
    
    var alert: UIAlertController?
    
    func showAlert() {
        alert = UIAlertController(title: "Respuesta incorrecta", message: nil, preferredStyle: .alert)
        alert?.addAction(UIAlertAction(title: "OK", style: .default))
    }
    
}
