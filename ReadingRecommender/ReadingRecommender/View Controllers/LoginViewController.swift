//
//  LoginViewController.swift
//  ReadingRecommender
//
//  Created by Christopher Aronson on 5/21/19.
//  Copyright © 2019 Christopher Aronson. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    let userController = UserController()
    let networkControll = Network()
    
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var continueAsGuestButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    


    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ContinueAsGuest" {
            let destination = segue.destination as! HomeScreenViewController
            
            destination.userController = userController
        } else if segue.identifier == "login" {
            let destination = segue.destination as! HomeScreenViewController
            
            destination.userController = userController
            destination.networkController = networkControll
        }
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        guard let username = userNameTextField.text,
        let password = passwordTextField.text
        else { return }
        
        userController.createUser(username: username, password: password)
        
        networkControll.Login(for: userController.user) { (error) in
            if let error = error {
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Error", message: "There was an issue loging in. Please Try again.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                    self.present(alert, animated: true)
                }
                NSLog("\(error)")
                return
            }
            
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "login", sender: nil)
            }
        }
        
        
    }
    
    @IBAction func signUpButtonTapped(_ sender: Any) {
    }
    
    @IBAction func continueButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "ContinueAsGuest", sender: sender)
    }
    
}
