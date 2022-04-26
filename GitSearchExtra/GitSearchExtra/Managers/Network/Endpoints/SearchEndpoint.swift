//
//  Endpoint.swift
//  GitSearchExtra
//
//  Created by Aliaksandr Chekushkin on 4/26/22.
//

import Foundation

struct SearchEndpoint: Endpointable {
    let path: String
    let queryItems: [URLQueryItem]
}

extension SearchEndpoint {
    static func search(matching query: String,
                       sortedBy sorting: Sorting = .recency,
                       order: Order = .descending,
                       perPage: Int = 30,
                       pageNumber: Int = 1) -> SearchEndpoint {
        return SearchEndpoint(
            path: "/search/repositories",
            queryItems: [
                URLQueryItem(name: QueryName.q.rawValue, value: query),
                URLQueryItem(name: QueryName.sort.rawValue, value: sorting.rawValue),
                URLQueryItem(name: QueryName.order.rawValue, value: order.rawValue),
                URLQueryItem(name: QueryName.perPage.rawValue, value: "\(perPage)"),
                URLQueryItem(name: QueryName.page.rawValue, value: "\(pageNumber)")
            ]
        )
    }
}

extension SearchEndpoint {
    var url: URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.github.com"
        components.path = path
        components.queryItems = queryItems

        return components.url
    }
}

enum QueryName: String {
    case q = "q"
    case sort = "sort"
    case order = "order" //Default: desc; ignored if there's no Sorting
    case perPage = "per_page" // results per page, 30 - default, 100 - max
    case page = "page" // page number to fetch, default: 1
}


enum Sorting: String, CaseIterable {
    case numberOfForks = "forks"
    case bestMatch = "bestmatch"
    case numberOfStars = "stars"
    case recency = "updated"
}


enum Order: String, CaseIterable {
    case descending = "desc"
    case ascending = "asc"
}
