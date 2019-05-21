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
    @IBOutlet weak var takeTestButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        usernameTextField.text = userController.testUser.username
        
        Appearance.styleNavigation(button: takeTestButton)
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
            destination.numberOfAnsweredQuestions = 0
            destination.questionController = questionController
        }
    }
    

}
