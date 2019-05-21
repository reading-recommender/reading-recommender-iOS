//
//  QuestionViewController.swift
//  ReadingRecommender
//
//  Created by Christopher Aronson on 5/20/19.
//  Copyright © 2019 Christopher Aronson. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {
    // MARK: - Properties
    var currentQuestion: Int?
    var questionController: QuestionControler?
    var numberOfAnsweredQuestions: Int?
    

    
    // MARK: - Private Properties
    private var shouldCancel = false
    private var shouldFinish = false
    private var itemSelected = false

    // MARK: - IBOutlets
    @IBOutlet weak var questionTextLabel: UILabel!
    @IBOutlet weak var answerOneButton: UIButton!
    @IBOutlet weak var answerTwoButton: UIButton!
    @IBOutlet weak var answerThreeButton: UIButton!
    @IBOutlet weak var answerFourButton: UIButton!
    @IBOutlet weak var previousButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    // MARK: - View Functions
    override func viewDidLoad() {
        super.viewDidLoad()

        updateView()
        previousButtonSetUp()
        nextButtonSetUp()
        setButtons()
        
    }
    
    private func updateView() {
        
        guard let questionIndex = currentQuestion else {
            NSLog("Could not get the index for the current question")
            return
        }
        
        guard let question = questionController?.questions[questionIndex] else {
            NSLog("Couldn't load question")
            return
        }
        
        
        questionTextLabel.text = question.question
        answerOneButton.setTitle(question.answers[0].answer1, for: .normal)
        answerTwoButton.setTitle(question.answers[0].answer2, for: .normal)
        answerThreeButton.setTitle(question.answers[0].answer3, for: .normal)
        answerFourButton.setTitle(question.answers[0].answer4, for: .normal)
        
    }
    
    private func previousButtonSetUp() {
        
        if let currentQuestion = currentQuestion, currentQuestion == 0 {
            previousButton.setTitle("Cancel", for: .normal)
            shouldCancel = true
        } else {
            previousButton.setTitle("Previous", for: .normal)
            shouldCancel = false
        }
    }
    
    private func nextButtonSetUp() {
        guard let questionController = questionController else { return }
        
        if let currentQuestion = currentQuestion, currentQuestion == questionController.questions.count - 1 {
            nextButton.setTitle("Finish", for: .normal)
            shouldFinish = true
        } else {
            nextButton.setTitle("Next", for: .normal)
            shouldFinish = false
        }
    }
    
    private func setButtons() {
        Appearance.styleQuestion(button: answerOneButton)
        Appearance.styleQuestion(button: answerTwoButton)
        Appearance.styleQuestion(button: answerThreeButton)
        Appearance.styleQuestion(button: answerFourButton)
        
        answerOneButton.addTarget(self, action: #selector(self.buttonClicked(sender:)), for: .touchUpInside)
        answerOneButton.tag = 1
        answerTwoButton.addTarget(self, action: #selector(self.buttonClicked(sender:)), for: .touchUpInside)
        answerOneButton.tag = 2
        answerThreeButton.addTarget(self, action: #selector(self.buttonClicked(sender:)), for: .touchUpInside)
        answerOneButton.tag = 3
        answerFourButton.addTarget(self, action: #selector(self.buttonClicked(sender:)), for: .touchUpInside)
        answerOneButton.tag = 4
        
        Appearance.styleNavigation(button: previousButton)
        Appearance.styleNavigation(button: nextButton)
    }
    
    func clearButtons() {
        Appearance.styleQuestion(button: answerOneButton)
        Appearance.styleQuestion(button: answerTwoButton)
        Appearance.styleQuestion(button: answerThreeButton)
        Appearance.styleQuestion(button: answerFourButton)
    }
    
    @objc func buttonClicked(sender: UIButton){
        UIView.animate(withDuration: 1) {
            self.clearButtons()
            sender.setTitleColor(.white, for: .normal)
            sender.layer.backgroundColor = Appearance.secondaryColor.cgColor
            sender.layer.cornerRadius = 8
        }
        
        guard let questionIndex = currentQuestion else { return }
        guard let question = questionController else { return }
        
        question.listOfAnswers[questionIndex] = sender.titleLabel!.text!
        
        itemSelected = true

    }

    @IBAction func previousButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        
        if !itemSelected {
            let alert = UIAlertController(title: "Nothing Selected", message: "Please select an answer before continuing", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true)
        } else {
            if shouldFinish {
                performSegue(withIdentifier: "ShowBook", sender: nil)
            } else {
                performSegue(withIdentifier: "NextQuestion", sender: nil)
            }
        }
        
    }
    
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "NextQuestion" {
            
            guard let destination = segue.destination as? QuestionViewController,
            let currentQuestion = currentQuestion,
            let questionController = questionController
            else {
                NSLog("Could not create destination for next question")
                return
            }
            
            destination.currentQuestion = currentQuestion + 1
            destination.questionController = questionController
        }
    }
    

}
