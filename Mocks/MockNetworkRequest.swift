//
//  MockNetworkRequest.swift
//  Reciplease
//
//  Created by Margarita Blanc on 18/09/2019.
//  Copyright © 2019 Frederic Blanc. All rights reserved.
//

import Foundation

class MockNetworkRequest: NetworkRequestType {
    
    func request<T>(type: T.Type, url: URL, completion: @escaping (Result<T>) -> Void) where T : Decodable {
        do {
            let data = try Data(contentsOf: url)
            
            let jsonDecoder = JSONDecoder()
            guard let decodedData = try? jsonDecoder.decode(type.self, from: data ) else { return }
            completion(.success(value: decodedData))
        }
        catch {
            print(error)
        }
    }
}
