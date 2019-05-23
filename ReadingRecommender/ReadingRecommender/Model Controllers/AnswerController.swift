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
        answers.append(Answer(q1: answer[0], q2: answer[1], q3: answer[2], q4: answer[3], q5: answer[4], q6: answer[5]))
    }
}
