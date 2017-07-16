//
//  Confession.swift
//  Confessions
//
//  Created by Kirill Kudaev on 7/15/17.
//  Copyright © 2017 Parse. All rights reserved.
//

import Foundation

struct Confession {
    
    var id: String
    var body: String
    var hasPole: Bool
    var likes: Int
    var yesAnswers: Int
    var noAnswers: Int
    var createdAt: Date
    var updatedAt: Date
    
    init(id: String, body: String, hasPole: Bool, likes: Int, yesAnswers: Int, noAnswers: Int, createdAt: Date, updatedAt: Date) {
        
        self.id = id
        self.body = body
        self.hasPole = hasPole
        self.likes = likes
        self.yesAnswers = yesAnswers
        self.noAnswers = noAnswers
        self.createdAt = createdAt as Date
        self.updatedAt = updatedAt as Date
    }
}
