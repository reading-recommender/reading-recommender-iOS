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
    @IBOutlet weak var doneButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateView()
        styleDoneButton()
    }
    
    private func updateView() {
        titleLabel.text = bookController.books.title
        descriptionLabel.text = bookController.books.description
    }
    
    private func styleDoneButton() {
        Appearance.styleNavigation(button: doneButton)
    }

    @IBAction func doneButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "unwindToHome", sender: nil)
    }

}
