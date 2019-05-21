//
//  Appearance.swift
//  ReadingRecommender
//
//  Created by Christopher Aronson on 5/20/19.
//  Copyright © 2019 Christopher Aronson. All rights reserved.
//

import UIKit

enum Appearance {
    static var secondaryColor = #colorLiteral(red: 0.462745098, green: 0.1960784314, blue: 0.2470588235, alpha: 1)
    static var backgroundColor = #colorLiteral(red: 0.8431372549, green: 0.8078431373, blue: 0.7803921569, alpha: 1)
    static var navButtonBackgroud = #colorLiteral(red: 0.337254902, green: 0.337254902, blue: 0.337254902, alpha: 1)
    
    static func setAppearance() {
    }
    
    static func styleQuestion(button: UIButton) {
        button.backgroundColor = .clear
        button.layer.borderColor = secondaryColor.cgColor
        button.layer.cornerRadius = 8
        button.layer.borderWidth = 1
        button.setTitleColor(secondaryColor, for: .normal)
    }
    
    static func styleNavigation(button: UIButton) {
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = navButtonBackgroud
        button.layer.cornerRadius = 8
    }
    
}