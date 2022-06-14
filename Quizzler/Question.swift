//
//  Question.swift
//  Quizzler-iOS13
//
//  Created by Jayvee Ballesteros on 2022/03/22.
//  Copyright © 2022 The App Brewery. All rights reserved.
//

import Foundation

struct Question {
    let text: String
    let choice: [String]
    let answer: String
    
    init(q: String, a: [String], correctAnswer: String) {
        text = q
        choice = a
        answer = correctAnswer
    }
}
