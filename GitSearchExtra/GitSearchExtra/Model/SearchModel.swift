//
//  SearchModel.swift
//  GitSearchExtra
//
//  Created by Aliaksandr Chekushkin on 4/26/22.
//

import Foundation
import UIKit

class SearchModel {
    var avatarURL: String?
    var avatarImage: UIImage?
    var repoTitle: String?
    var repoStars: Int?
    var authorID: Int?
    var authorName: String?
    
    init(avatarURL: String?, avatarImage: UIImage?, repoTitle: String?, repoStars: Int?, authorID: Int?, authorName: String?) {
        self.avatarURL = avatarURL
        self.avatarImage = avatarImage
        self.repoTitle = repoTitle
        self.repoStars = repoStars
        self.authorID = authorID
        self.authorName = authorName
    }
    
}
