//
//  QuestionController.swift
//  ReadingRecommender
//
//  Created by Christopher Aronson on 5/20/19.
//  Copyright © 2019 Christopher Aronson. All rights reserved.
//

import Foundation

class QuestionControler {
    var questions: Question?
    var listOfAnswers: [String] = []
    var networkController = Network()
    
    init() {
        
        networkController.getQuestions { result in
            do {
                self.questions = try result.get()
            } catch {
                NSLog("Error")
            }
        }

        for _ in 1...10 {
            listOfAnswers.append("")
        }
    }
}
