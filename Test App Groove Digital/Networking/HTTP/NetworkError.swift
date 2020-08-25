//
//  HTTPError.swift
//  Test App Groove Digital
//
//  Created by Gianmaria Biselli on 8/24/20.
//  Copyright © 2020 Zodaj. All rights reserved.
//

import Foundation

public enum NetworkError: String {
    case success
    case authenticationError    = "Authentication is required."
    case badRequest             = "Found bad request."
    case noDecodableData        = "No decodable data returned from request."
    case urlOutdated            = "Requested URL is outdated."
    case unableToDecode         = "Unable to decode response."
    case unableToUnwrap         = "Unable to unwrap data."
    case failed                 = "Network request failed."
}
