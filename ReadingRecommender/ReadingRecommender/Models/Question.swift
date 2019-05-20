//
//  Question.swift
//  ReadingRecommender
//
//  Created by Christopher Aronson on 5/20/19.
//  Copyright © 2019 Christopher Aronson. All rights reserved.
//

import Foundation

struct Question: Codable {
    let question: String
    let answers: [Answer]
}

// MARK: - Answer
struct Answer: Codable {
    let answer1, answer2, answer3, answer4: String
}
