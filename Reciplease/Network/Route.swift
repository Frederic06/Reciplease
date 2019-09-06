//
//  Route.swift
//  Reciplease
//
//  Created by Frédéric Blanc on 24/08/2019.
//  Copyright © 2019 Frederic Blanc. All rights reserved.
//

import UIKit

final class Route {
        let applicationKey = "7418b75cef7543d5ea683db5308ff87b"
        let applicationId = "b8643c24"
    
    
    func getURL (ingredients: String) -> URL?{
        
        let adress = "https://api.edamam.com/search?q=\(ingredients)&app_id=\(applicationId)&app_key=\(applicationKey)&to=50"
        
        guard let urlString = adress.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return nil}
        
        guard let url = URL(string: urlString) else { return nil }
        
        print(url)
        return url
    }
}
