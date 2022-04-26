//
//  AvatarEndpoint.swift
//  GitSearchExtra
//
//  Created by Aliaksandr Chekushkin on 4/26/22.
//

import Foundation

struct AvatarURLEndpoint: Endpointable {
    let link: String?
    
    var url: URL? {
        return URL(string: link!)
    }
}
