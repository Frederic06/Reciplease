//
//  NetworkRequest.swift
//  Reciplease
//
//  Created by Frédéric Blanc on 24/08/2019.
//  Copyright © 2019 Frederic Blanc. All rights reserved.
//

import Foundation
import Alamofire

enum NetworkError: Error {
    case unknown
}

protocol NetworkRequestType {
    func request<T>(type: T.Type, url: URL, completion: @escaping (Result<T>) -> Void) where T: Decodable
}

final class NetworkRequest: NetworkRequestType {
    
    private let jsonDecoder = JSONDecoder()
    
    func request<T>(type: T.Type, url: URL, completion: @escaping (Result<T>) -> Void) where T : Decodable {
        Alamofire.request(url).responseJSON { (response) in
            if let error = response.error {
                completion(.error(error: error))
            } else if let data = response.data {
                guard let recipes = try? self.jsonDecoder.decode(T.self, from: data) else { return }
                completion(.succes(value: recipes))
            } else {
                completion(.error(error: NetworkError.unknown))
            }
        }
    }
    
    private func decodeJSON<T>(type: T.Type, data: Data, completion: @escaping (T) -> Void) where T: Decodable {
        
        guard let decodedData = try? jsonDecoder.decode(type.self, from: data) else { return }
        completion(decodedData)
    }
        
}
//    func request<Model: Codable>(_ url: String, completion: @escaping (Model?, Error?) -> Void) {
//        AF.request(url).responseDecodable { (response: DataResponse<Model>) in
//            if case .failure(let error) = response.result {
//                // Dans le cas d'erreur
//                return completion(nil, error)
//            }
//
//            let statusCode = response.response?.statusCode
//
//            if statusCode == 401 {
//                return completion(nil, NSError())
//            }
//            guard case .success(let result) = response.result else {
//                //Erreur improbable
//                return
//            }
//            completion(result, nil)
//
//        }
//    }

