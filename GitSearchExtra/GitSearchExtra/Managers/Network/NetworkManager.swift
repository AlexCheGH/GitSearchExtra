//
//  NetworkManager.swift
//  GitSearchExtra
//
//  Created by Aliaksandr Chekushkin on 4/26/22.
//

import Foundation
import UIKit

class NetworkManager<T: Codable> {
    
    func getInfo(for endpoint: Endpointable,  completion: @escaping (T?) -> Void ) {
        makeRequest(endpoint: endpoint) { data in
            let result = self.decode(data)
            completion(result)
        }
    }

    func makeImageRequest(from link: String?, completion: @escaping(UIImage?) -> Void) {
        let endpoint = AvatarURLEndpoint(link: link)
        makeRequest(endpoint: endpoint) { data in
            let image = UIImage(data: data)
            completion(image)
        }
    }
    
    func makeRequest(endpoint: Endpointable, completion: @escaping (Data) -> Void ) {
        let dataLoader = DataLoader()
        
        dataLoader.request(endpoint) { result in
            switch result {
            case .failure(.urlIsNotValid):
                print("URL is not valid. Check the URL.")
            case .success(let data):
                completion(data)
            case .failure(.wrongMap):
                print("An error occured when trying to map the result.")
            }
        }
    }
    
    private func decode(_ data: Data) -> T? {
        let decoder = JSONDecoder()
        let result = try? decoder.decode(T.self, from: data)
        
        return result
    }
}

enum Result<Value, Error: Swift.Error> {
    case success(Value)
    case failure(Error)
}

enum NetworkError: Error {
    case urlIsNotValid
    case wrongMap
}
