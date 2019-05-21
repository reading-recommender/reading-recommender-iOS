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
        }
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
    }
    
    @IBAction func signUpButtonTapped(_ sender: Any) {
    }
    
    @IBAction func continueButtonTapped(_ sender: Any) {
        userController.createGuest()
        
        performSegue(withIdentifier: "ContinueAsGuest", sender: sender)
    }
    
}
