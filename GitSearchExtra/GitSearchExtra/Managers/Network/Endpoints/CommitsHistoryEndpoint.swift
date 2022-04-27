//
//  CommitsHistoryEndpoint.swift
//  GitSearchExtra
//
//  Created by Aliaksandr Chekushkin on 4/27/22.
//

import Foundation

struct CommitHistoryEndpoint: Endpointable {
    var url: URL?
    
    init(repoTitle: String?, authorName: String?) {
        
        guard let repoTitle = repoTitle, let authorName = authorName else { return }
        
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.github.com"
        components.path = "/repos/\(authorName)/\(repoTitle)/commits"
        
        self.url = components.url
    }
}
