//
//  LoginViewController.swift
//  Flash Chat iOS13
//
//  Created by Евгений Башун on 19.02.2022.
//  Copyright © 2022 Angela Yu. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    
    @IBAction func loginPressed(_ sender: UIButton) {
        guard let email = emailTextfield.text, let password = passwordTextfield.text else {return}
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            guard let self = self else { return }
            guard error != nil else {return}
            
            self.performSegue(withIdentifier: Constants.loginID, sender: self)
        }
        UserDefaults.standard.set(true, forKey: "Logged")
    }
    
}
