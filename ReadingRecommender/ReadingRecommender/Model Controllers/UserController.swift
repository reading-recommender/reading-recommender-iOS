//
//  UserController.swift
//  ReadingRecommender
//
//  Created by Christopher Aronson on 5/20/19.
//  Copyright © 2019 Christopher Aronson. All rights reserved.
//

import Foundation

class UserController {
    var user = User()
    
    func createUser(username: String, password: String) {
        user = User(username: username, password: password)
    }
    
    
}
