//
//  AnswerController.swift
//  ReadingRecommender
//
//  Created by Christopher Aronson on 5/23/19.
//  Copyright © 2019 Christopher Aronson. All rights reserved.
//

import Foundation

class AnswerController {
    var answers: [Answer] = []
    
    init(answer: [String]) {
        answers.append(Answer(Q1: answer[0], Q2: answer[1], Q3: answer[2], Q4: answer[3], Q5: answer[4], Q6: answer[5]))
    }
}
