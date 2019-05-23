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
    static var tanColor = #colorLiteral(red: 0.7529411765, green: 0.6235294118, blue: 0.5019607843, alpha: 1)
    
    static func setAppearance() {

        UINavigationBar.appearance().barTintColor = secondaryColor
        UIBarButtonItem.appearance().tintColor = .white
        
        
        UINavigationBar.appearance().largeTitleTextAttributes = [
                    NSAttributedString.Key.foregroundColor: UIColor.white,
                    NSAttributedString.Key.font: UIFont(name: "Bitter-Bold", size: 30)!
                ]
        
        UITextField.appearance().font = UIFont(name: "Raleway-Regular", size: 18)
    }
    
    static func styleQuestion(button: UIButton) {
        button.backgroundColor = .clear
        button.layer.borderColor = tanColor.cgColor
        button.layer.cornerRadius = 8
        button.layer.borderWidth = 1
        button.setTitleColor(tanColor, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 24, weight: .regular)
    }
    
    static func styleNavigation(button: UIButton) {
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = navButtonBackgroud
        button.layer.cornerRadius = 8
        button.titleLabel?.font = .systemFont(ofSize: 24, weight: .regular)
    }
    
    
    
}
