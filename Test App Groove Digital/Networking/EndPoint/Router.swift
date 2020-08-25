//
//  Router.swift
//  Test App Groove Digital
//
//  Created by Gianmaria Biselli on 8/24/20.
//  Copyright © 2020 Zodaj. All rights reserved.
//

import Foundation

enum Router {
    
    case getVideoAnalytics(date: String)
    //More API request cases go here if needed
    //Example:
    //case ...
    
    fileprivate var authToken: String {
        return "4e37e694a72ff8b338934c34616830c6"
    }
    
    var host: String {
        let urlBase = "matomo.groovetech.io"
        switch self {
            case .getVideoAnalytics:
                return urlBase
        }
    }
    
    var scheme: String {
        switch self {
            case .getVideoAnalytics:
                return "https"
        }
    }
    
    var pathRoute: String {
        switch self {
            case .getVideoAnalytics:
                return "/index.php"
        }
    }
    
    var parameters: [URLQueryItem] {
        switch self {
            case .getVideoAnalytics(let date):
                return [URLQueryItem(name: "date", value: date),
                        URLQueryItem(name: "expanded", value: "1"),
                        URLQueryItem(name: "filter_limit", value: "24"),
                        URLQueryItem(name: "format", value: "JSON"),
                        URLQueryItem(name: "filter_sort_column", value: "label"),
                        URLQueryItem(name: "filter_sort_order", value: "asc"),
                        URLQueryItem(name: "idSite", value: "5"),
                        URLQueryItem(name: "method", value: "MediaAnalytics.getVideoHours"),
                        URLQueryItem(name: "module", value: "API"),
                        URLQueryItem(name: "period", value: "day"),
                        URLQueryItem(name: "segment", value: ""),
                        URLQueryItem(name: "token_auth", value: authToken)]
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
            case .getVideoAnalytics:
                return .get
        }
    }
    
}
