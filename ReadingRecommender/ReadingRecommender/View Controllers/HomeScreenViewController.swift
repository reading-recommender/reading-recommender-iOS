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
    let userController = UserController()

    @IBOutlet weak var usernameTextField: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        usernameTextField.text = userController.testUser.username
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
