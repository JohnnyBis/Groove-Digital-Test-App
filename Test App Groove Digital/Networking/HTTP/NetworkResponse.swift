//
//  HTTPResponse.swift
//  Test App Groove Digital
//
//  Created by Gianmaria Biselli on 8/24/20.
//  Copyright © 2020 Zodaj. All rights reserved.
//

import Foundation

struct NetworkResponse{
    
    static func handleNetworkResponse(_ response: HTTPURLResponse?) -> Result {
        
        guard let response = response else { return Result.failure(NetworkError.unableToUnwrap.rawValue)}
        
        switch response.statusCode {
            case 200...299: return .success
            case 401...500: return .failure(NetworkError.authenticationError.rawValue)
            case 501...599: return .failure(NetworkError.badRequest.rawValue)
            case 600: return .failure(NetworkError.urlOutdated.rawValue)
            default: return .failure(NetworkError.failed.rawValue)
        }
    }
}
