//
//  DataLoader.swift
//  GitSearchExtra
//
//  Created by Aliaksandr Chekushkin on 4/26/22.
//

import Foundation

class DataLoader {
    func request(_ endpoint: Endpointable, then handler: @escaping (Result<Data, NetworkError>) -> Void) {
        guard let url = endpoint.url else {
            return handler(.failure(NetworkError.urlIsNotValid))
        }

        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            
            let result = data.map(Result.success) ?? .failure(NetworkError.wrongMap)
            handler(result)
            
        }
        task.resume()
    }
}
