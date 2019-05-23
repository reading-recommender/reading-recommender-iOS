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
    var answers: [String] = []
    
    init() {
        questions.append(Question(question: "I prefer to read books written:", answers: ["Modern works",
                                                                                         "Enlightenment and industrial Era (17th, 18th and part of the 19th  Century)",
                                                                                         "Old books that have withstood the test of time (Everything before the 16th century)"]))
        
        questions.append(Question(question: "I prefer books that are more:", answers: ["Optimistic", "Pessimistic", "Realistic"]))
        
        questions.append(Question(question: "After reading a book I like to feel:", answers: ["Joyful and relieved"," Somber and contemplative", "Achieved and informed"]))
        
        questions.append(Question(question: "When reading I appreciate humor:", answers: ["Not at all", "A little", "A large amount"]))
        
        questions.append(Question(question: "I’d prefer to read:", answers: ["Western", "Romanticism", "Dystopia", "Drama", "Fantasy", "Historical", "Other"]))
        
        questions.append(Question(question: "My preferred book length is:", answers: ["Short", "Long"]))
        
        for _ in 0..<questions.count {
            answers.append("")
        }
    }
}
