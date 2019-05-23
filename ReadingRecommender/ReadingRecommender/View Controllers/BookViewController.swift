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
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateView()
    }
    
    // TODO: - Implement recommend call after I figure out if i am messing up or if it is server issue
    private func updateView() {
        
        guard let questionController = questoinController else { return }
        
        let answers = AnswerController(answer: questionController.answers)
        
        networkController.getRecommendation(answers: answers.answers[0]) { result in
            
            do {
                let book = try result.get()
                
                DispatchQueue.main.async {
                    self.titleLabel.text = book.book
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
