//
//  HomeScreenViewController.swift
//  ReadingRecommender
//
//  Created by Christopher Aronson on 5/20/19.
//  Copyright © 2019 Christopher Aronson. All rights reserved.
//

import UIKit

class HomeScreenViewController: UIViewController {
    
    let questionController = QuestionControler()
    var userController: UserController?
    var networkController: Network?

    @IBOutlet weak var usernameTextField: UILabel!
    @IBOutlet weak var takeTestButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let user = userController?.user else { return }
        
        usernameTextField.text = user.username
    }
    
    @IBAction func signOutButtonTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func myUnwindAction(segue: UIStoryboardSegue) {
        
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowQuiz" {

            guard let destination = segue.destination as? QuestionViewController else {
                NSLog("Could not create segue in from home screen to quiz")
                return
            }
            
            destination.currentQuestion = 0
            destination.questionController = questionController
        }
    }
    

}
