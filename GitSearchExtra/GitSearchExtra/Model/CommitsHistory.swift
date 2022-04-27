//
//  CommitsHistory.swift
//  GitSearchExtra
//
//  Created by Aliaksandr Chekushkin on 4/27/22.
//

import Foundation

class CommitsHistory {
    let author: String?
    let email: String?
    let description: String?
    
    init(author: String?, email: String?, description: String?) {
        self.author = author
        self.email = email
        self.description = description
    }
}
