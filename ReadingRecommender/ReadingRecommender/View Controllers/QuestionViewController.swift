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

    
    // MARK: - Private Properties
    private var shouldFinish = false
    private var itemSelected = false
    
    
    // MARK UI Elements
    private var buttons: [UIButton] = []
    private var labels: [UILabel] = []
    private var mainStackView = UIStackView()
    private var answerStackView = UIStackView()
    private var navButtonStackView = UIStackView()
    private var questionTextLabel = UILabel()
    private var nextButton = UIButton()
    private var previousButton = UIButton()
    let inceptionView = UIView()
    private let scrollView: UIScrollView = {
        let v = UIScrollView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    // MARK: - View Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let questionController = questionController else { return }
        guard let currentQuestion = currentQuestion else { return }
        
        self.view.addSubview(scrollView)
        
        scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        
        scrollView.addSubview(inceptionView)
        
        inceptionView.translatesAutoresizingMaskIntoConstraints = false
        inceptionView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.9).isActive = true
        inceptionView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        inceptionView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor)
        inceptionView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        inceptionView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        
        createMainStackView()
        inceptionView.addSubview(mainStackView)
        constrainMainStackView()

        scrollView.contentSize.width = self.view.frame.maxX

        createQuestionTextLabel(questionController: questionController, index: currentQuestion)
        mainStackView.addArrangedSubview(questionTextLabel)

        createButtons(questionController: questionController, currentQuestion: currentQuestion)
        createAnswerStackView()

        mainStackView.addArrangedSubview(answerStackView)


        createPreviouButton()
        createNextButton(questionController: questionController, currentQuestion: currentQuestion)
        createNavButtonStackView()

        mainStackView.addArrangedSubview(navButtonStackView)
        
    }
    
    private func updateViews() {
        guard let questionController = questionController else { return }
        guard let currentQuestion = currentQuestion else { return }
        
        createQuestionTextLabel(questionController: questionController, index: currentQuestion)
        createButtons(questionController: questionController, currentQuestion: currentQuestion)
        createAnswerStackView()
        createPreviouButton()
        createNextButton(questionController: questionController, currentQuestion: currentQuestion)
        createNavButtonStackView()
        createMainStackView()
    }
    
    // MARK: - UI Creation Functions
    private func createQuestionTextLabel(questionController: QuestionControler, index: Int) {
        questionTextLabel.translatesAutoresizingMaskIntoConstraints = false
        questionTextLabel.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        questionTextLabel.textAlignment = .center
        questionTextLabel.textColor = .white
        questionTextLabel.font = UIFont(name: "Raleway-Regular", size: 30)
        questionTextLabel.numberOfLines = 0
        questionTextLabel.lineBreakMode = .byWordWrapping
        questionTextLabel.text = questionController.questions[index].question
        questionTextLabel.sizeToFit()

//        view.addSubview(questionTextLabel)
    }
    
    private func createButtons(questionController: QuestionControler, currentQuestion: Int) {
        
        for index in 0..<questionController.questions[currentQuestion].answers.count {
            let button = UIButton()
            
            button.translatesAutoresizingMaskIntoConstraints = false
            
            button.setTitle(questionController.questions[currentQuestion].answers[index], for: .normal)
            button.titleLabel?.font = UIFont(name: "Raleway-Regular", size: 18)
            button.titleLabel?.numberOfLines = 0
            button.titleLabel?.textAlignment = .center
            button.setTitleColor(Appearance.tanColor, for: .normal)
            
            button.layer.borderColor = Appearance.tanColor.cgColor
            button.layer.borderWidth = 2
            button.layer.cornerRadius = 8
            
            button.contentEdgeInsets = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
            
            button.addTarget(self, action: #selector(buttonClicked(sender:)), for: .touchUpInside)
            
            view.addSubview(button)
            buttons.append(button)
        }
        
    }
    
    private func createAnswerStackView() {
        answerStackView.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(answerStackView)
        
        answerStackView.axis = .vertical
        answerStackView.distribution = .fill
        answerStackView.alignment = .fill
        answerStackView.spacing = 16
        
        for button in buttons {
            answerStackView.addArrangedSubview(button)
        }
    }
    
    private func createPreviouButton() {
        previousButton.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(previousButton)
        
        previousButton.setTitle("Previous", for: .normal)
        previousButton.titleLabel?.font = UIFont(name: "Raleway-Regular", size: 22)
        previousButton.titleLabel?.textAlignment = .center
        previousButton.setTitleColor(.white, for: .normal)
        previousButton.setTitleColor(.gray, for: .selected)
        
        previousButton.backgroundColor = Appearance.secondaryColor
        
        previousButton.layer.borderColor = Appearance.secondaryColor.cgColor
        previousButton.layer.borderWidth = 1
        previousButton.layer.cornerRadius = 8
        
        previousButton.addTarget(self, action: #selector(previousButtonTouchDown(sender:)), for: .touchDown)
        previousButton.addTarget(self, action: #selector(previousButtonTouchUp(sender:)), for: .touchUpInside)
        
        previousButton.sizeToFit()
    }
    
    private func createNextButton(questionController: QuestionControler, currentQuestion: Int) {
        nextButton.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(nextButton)
        
        if currentQuestion == questionController.questions.count - 1 {
            nextButton.setTitle("Finish", for: .normal)
        } else {
            nextButton.setTitle("Next", for: .normal)
        }
        
        nextButton.titleLabel?.font = UIFont(name: "Raleway-Regular", size: 22)
        nextButton.titleLabel?.textAlignment = .center
        nextButton.setTitleColor(.white, for: .normal)
        
        
        nextButton.backgroundColor = Appearance.secondaryColor
        
        nextButton.layer.borderColor = Appearance.secondaryColor.cgColor
        nextButton.layer.borderWidth = 1
        nextButton.layer.cornerRadius = 8
        
        nextButton.addTarget(self, action: #selector(nextButtonTouchDown(sender:)), for: .touchDown)
        nextButton.addTarget(self, action: #selector(nextButtonTouchUp(sender:)), for: .touchUpInside)
        
        nextButton.sizeToFit()
    }
    
    private func createNavButtonStackView() {
        navButtonStackView.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(navButtonStackView)
        
        navButtonStackView.axis = .horizontal
        navButtonStackView.distribution = .fillEqually
        navButtonStackView.alignment = .fill
        navButtonStackView.spacing = 8
        
        navButtonStackView.addArrangedSubview(previousButton)
        navButtonStackView.addArrangedSubview(nextButton)
    }
    
    private func createMainStackView() {
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(mainStackView)
        
        mainStackView.axis = .vertical
        mainStackView.distribution = .fill
        mainStackView.alignment = .fill
        mainStackView.spacing = 8
//        mainStackView.addArrangedSubview(questionTextLabel)
//        mainStackView.addArrangedSubview(answerStackView)
//        mainStackView.addArrangedSubview(navButtonStackView)



        
    }
    
    private func constrainMainStackView() {
        NSLayoutConstraint.activate([
            mainStackView.leadingAnchor.constraint(equalTo: inceptionView.leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: inceptionView.trailingAnchor),
            mainStackView.topAnchor.constraint(equalTo: inceptionView.topAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: inceptionView.bottomAnchor),
            mainStackView.widthAnchor.constraint(equalTo: inceptionView.widthAnchor)
            ])
    }
    
    // MARK: - Action Handling Functions
    private func clearButtons() {
        for buttton in buttons {
            UIView.animate(withDuration: 05) {
                buttton.setTitleColor(Appearance.tanColor, for: .normal)
                buttton.layer.borderColor = Appearance.tanColor.cgColor
                buttton.layer.backgroundColor = UIColor.clear.cgColor
            }
        }
    }
    
    private func isSelected() -> Bool {
        
        if itemSelected {
            return true
        } else {
            let alert = UIAlertController(title: "Nothing Selected", message: "Please select an answer to continue.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            present(alert, animated: true)
            return false
        }
    }
    
    @objc func buttonClicked(sender: UIButton){
        UIView.animate(withDuration: 0.5) {
            self.clearButtons()
            sender.setTitleColor(.white, for: .normal)
            sender.layer.borderColor = Appearance.tanColor.cgColor
            sender.layer.backgroundColor = Appearance.tanColor.cgColor
            sender.layer.cornerRadius = 8
        }
        
        guard let currentQuestion = currentQuestion else { return }
        guard let question = questionController else { return }
        
        question.answers[currentQuestion] = sender.titleLabel!.text!
        
        itemSelected = true

    }
    
    @objc func previousButtonTouchDown(sender: UIButton){
        previousButton.setTitleColor(.gray, for: .normal)
    }
    
    @objc func previousButtonTouchUp(sender: UIButton){
        previousButton.setTitleColor(.white, for: .normal)
        navigationController?.popViewController(animated: true)
    }
    
    @objc func nextButtonTouchDown(sender: UIButton){
        nextButton.setTitleColor(.gray, for: .normal)
    }
    
    @objc func nextButtonTouchUp(sender: UIButton){
        nextButton.setTitleColor(.white, for: .normal)
        
        guard let currentQuestion = currentQuestion else { return }
        guard let questionController = questionController else { return }
        
        if currentQuestion == questionController.questions.count - 1 {
            if isSelected() {
                performSegue(withIdentifier: "ShowBook", sender: nil)
            }
        } else {
            if isSelected() {
                performSegue(withIdentifier: "NextQuestion", sender: nil)
            }
        }
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "ReturnHome", sender: nil)
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
            
        } else if segue.identifier == "ShowBook" {
            
            guard let destination = segue.destination as? BookViewController,
            let questionController = questionController
            else {
                NSLog("Could not create destination for recommended book")
                return
            }
            
            destination.questoinController = questionController
        }
    }
    
}
