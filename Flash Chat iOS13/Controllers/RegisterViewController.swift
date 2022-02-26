//
//  RegisterViewController.swift
//  Flash Chat iOS13
//
//  Created by Евгений Башун on 19.02.2022.
//  Copyright © 2022 Angela Yu. All rights reserved.
//

import UIKit
import FirebaseAuth

class RegisterViewController: UIViewController {

    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!

    @IBAction func registerPressed(_ sender: UIButton) {
        guard let email = emailTextfield.text, let password = passwordTextfield.text else {return}
        
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            guard error != nil else {return}
            UserDefaults.standard.set(true, forKey: "Logged")
            self.performSegue(withIdentifier: Constants.registerID, sender: self)
            
        }
    }
    
}
