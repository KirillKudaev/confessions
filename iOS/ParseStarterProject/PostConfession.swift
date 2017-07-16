//
//  PostConfession.swift
//  Confessions
//
//  Created by Kirill Kudaev on 7/15/17.
//  Copyright © 2017 Parse. All rights reserved.
//

import Foundation

struct PostConfession {
    
    var body: String
    var hasPoll: Bool
    
    var error = false
    var errorMessage: String?
    
    init(body: String, hasPoll: Bool) {
        
        self.body = body
        self.hasPoll = hasPoll
        
        if body == "" {
            
            error = true
            errorMessage = "Please enter a description"
            
        } else if body.characters.count > 5000 {
            
            error = true
            errorMessage = "Sorry, description cannot exceed 5000 characters"
        }
    }
}
