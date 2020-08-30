//
//  NetworkManager.swift
//  Test App Groove Digital
//
//  Created by Gianmaria Biselli on 8/24/20.
//  Copyright © 2020 Zodaj. All rights reserved.
//

import Foundation

struct NetworkManager {
    
    static let shared = NetworkManager()
    
    //Generic request function that can be used for multiple purposes. This avoids redundancies in the code base.
    static func request(router: Router, _ completion: @escaping (_ data: [AnalyticsItem?], _ result: Result) -> ()) {
        
        //Create a URL component
        var components = URLComponents()
        components.scheme = router.scheme
        components.host = router.host
        components.path = router.pathRoute
        components.queryItems = router.parameters
        
        let session = URLSession(configuration: .default)
        guard let url = components.url else { return }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = router.httpMethod.rawValue

        let dataTask = session.dataTask(with: urlRequest) { data, response, error in
            
            if let response = response as? HTTPURLResponse {
                
                let result = NetworkResponse.handleNetworkResponse(response)
                
                switch result {
                case .success:
                    guard let data = data else {
                        completion([nil], Result.failure("No data found."))
                        return
                    }
                    
                    let objectResponse = try! JSONDecoder().decode([AnalyticsItem].self, from: data)
                    DispatchQueue.main.async {
                        completion(objectResponse, Result.success)
                    }
                case .failure:
                    completion([nil], result)
                }
            }
        }
        dataTask.resume()
    }
}
