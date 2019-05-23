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
        
        let encoder = JSONEncoder()
        encoder.outputFormatting = .sortedKeys
        let jsonData = try! encoder.encode(answers.answers[0])
        let jsonString = String(data: jsonData, encoding: .utf8)!
        print(jsonString)
        
        titleLabel.text = bookController.books.title
        descriptionLabel.text = bookController.books.description
    }

    @IBAction func homeButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "goHome", sender: nil)
    }
}
