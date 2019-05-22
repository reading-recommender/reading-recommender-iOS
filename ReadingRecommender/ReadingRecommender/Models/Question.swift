//
//  Question.swift
//  ReadingRecommender
//
//  Created by Christopher Aronson on 5/20/19.
//  Copyright © 2019 Christopher Aronson. All rights reserved.
//

import Foundation

// MARK: - Question
struct Question: Codable {
    let question1, question10, question2, question3: [Question1Element]
    let question4, question5, question6, question7: [Question1Element]
    let question8, question9: [Question1Element]
}

// MARK: - Question1Element
struct Question1Element: Codable {
    let answers: [Answer]
    let question: String
}

// MARK: - Answer
struct Answer: Codable {
    let answer1, answer2, answer3, answer4: String
}
