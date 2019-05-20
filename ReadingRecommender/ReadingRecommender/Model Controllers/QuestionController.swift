//
//  QuestionController.swift
//  ReadingRecommender
//
//  Created by Christopher Aronson on 5/20/19.
//  Copyright © 2019 Christopher Aronson. All rights reserved.
//

import Foundation

class QuestionControler {
    var questions: [Question] = []
    
    init() {
        questions.append(Question(question: "What Color is the sky", answers: [Answer(answer1: "Black", answer2: "Green", answer3: "Blue", answer4: "Pink")]))
        questions.append(Question(question: "What is 1 + 1", answers: [Answer(answer1: "1", answer2: "2", answer3: "3", answer4: "4")]))
        questions.append(Question(question: "What is 2 x 2", answers: [Answer(answer1: "321", answer2: "4", answer3: "-16", answer4: "Purple")]))
        questions.append(Question(question: "Roses are?", answers: [Answer(answer1: "Red", answer2: "Neon Green", answer3: "Light Gray", answer4: "Um...")]))
        questions.append(Question(question: "What is 0 x 145,674", answers: [Answer(answer1: "412,351,243", answer2: "0", answer3: "1", answer4: "Nil")]))
        questions.append(Question(question: "What is this app called", answers: [Answer(answer1: "Reading Recommender", answer2: "Book Quiz", answer3: "Um...", answer4: "Huh?")]))
        questions.append(Question(question: "What is the best school ever", answers: [Answer(answer1: "Lambda", answer2: "Lambda", answer3: "Lambda", answer4: "Lambda")]))
        questions.append(Question(question: "What color is grass?", answers: [Answer(answer1: "Purple", answer2: "Green", answer3: "Orange", answer4: "Brown")]))
        questions.append(Question(question: "Live long and ", answers: [Answer(answer1: "Prosper", answer2: "Die", answer3: "Let Live", answer4: "You're a nerd")]))
        questions.append(Question(question: "How do you feel?", answers: [Answer(answer1: "😁", answer2: "🙂", answer3: "🙁", answer4: "🤯")]))
    }
}
