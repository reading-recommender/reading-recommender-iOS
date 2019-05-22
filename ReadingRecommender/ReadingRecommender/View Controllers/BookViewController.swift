//
//  BookViewController.swift
//  ReadingRecommender
//
//  Created by Christopher Aronson on 5/20/19.
//  Copyright © 2019 Christopher Aronson. All rights reserved.
//

import UIKit

class BookViewController: UIViewController {
    var questoinController: QuestionViewController?
    var bookController = BookController()

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateView()
    }
    
    private func updateView() {
        titleLabel.text = bookController.books.title
        descriptionLabel.text = bookController.books.description
    }

    @IBAction func homeButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "goHome", sender: nil)
    }
}
