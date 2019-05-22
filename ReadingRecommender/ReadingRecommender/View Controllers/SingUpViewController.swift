//
//  SingUpViewController.swift
//  ReadingRecommender
//
//  Created by Christopher Aronson on 5/21/19.
//  Copyright © 2019 Christopher Aronson. All rights reserved.
//

import UIKit

class SingUpViewController: UIViewController, UITextFieldDelegate {

    let userController = UserController()
    let network = Network()
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        
        view.addGestureRecognizer(tap)
        
        usernameTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == usernameTextField {
            textField.resignFirstResponder()
            passwordTextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
            signUpButtonTapped(view!)
        }
        
        return true
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
                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: {action in
                        self.navigationController?.popViewController(animated: true)
                    }))
                    self.present(alert, animated: true)
                }
            }
        }
        
    }
}
