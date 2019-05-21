//
//  SingUpViewController.swift
//  ReadingRecommender
//
//  Created by Christopher Aronson on 5/21/19.
//  Copyright © 2019 Christopher Aronson. All rights reserved.
//

import UIKit

class SingUpViewController: UIViewController {

    let userController = UserController()
    let network = Network()
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func signUpButtonTapped(_ sender: Any) {
        guard let username = usernameTextField.text,
        let password = passwordTextField.text
        else {
                let alert = UIAlertController(title: "Missing Info", message: "Please enter both a username and a password", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                present(alert, animated: true)
                return
        }
        
        userController.createUser(username: username, password: password)
        let user = userController.user
        
        network.signUp(for: user) { (error) in
            
            if let error = error {
                NSLog("\(error)")
                return
            } else {
                DispatchQueue.main.sync {
                    let alert = UIAlertController(title: "Success", message: "Sign Up was successful. Please login now", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: {action in self.dismiss(animated: true, completion: nil) }))
                    self.present(alert, animated: true)
                }
            }
        }
        
    }
}
