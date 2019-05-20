//
//  User.swift
//  ReadingRecommender
//
//  Created by Christopher Aronson on 5/20/19.
//  Copyright © 2019 Christopher Aronson. All rights reserved.
//

import Foundation

struct User: Equatable, Codable {
    let username: String
    let password: String
    let token: String   
}
