//
//  BookViewController.swift
//  ReadingRecommender
//
//  Created by Christopher Aronson on 5/20/19.
//  Copyright © 2019 Christopher Aronson. All rights reserved.
//

import UIKit

class BookViewController: UIViewController {
    var questoinController: QuestionControler?
    var bookController = BookController()
    var networkController = Network()

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorTextLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel.text = ""
        authorTextLabel.text = ""
        descriptionLabel.text = ""
        
        updateView()
    }
 
    private func updateView() {
        
        guard let questionController = questoinController else { return }
        
        let answers = AnswerController(answer: questionController.answers)
        
        if answers.answers[0].Q1 == "Enlightenment and industrial Era" {
            answers.answers[0].Q1 = "Enlightenment and industrial Era (17th, 18th and part of the 19th  Century)"
        } else if answers.answers[0].Q1 == "Old books that have withstood the test of time" {
            answers.answers[0].Q1 = "Old books that have withstood the test of time (Everything before the 16th century)"
        }
        
        networkController.getRecommendation(answers: answers.answers[0]) { result in
            
            do {
                let book = try result.get()
                
                DispatchQueue.main.async {
                    self.titleLabel.text = book.book
                    self.authorTextLabel.text = book.author
                    self.descriptionLabel.text = book.description
                }
            } catch {
                print(error)
            }
        }
    }

    @IBAction func homeButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "goHome", sender: nil)
    }
}
