//
//  Analytics.swift
//  Test App Groove Digital
//
//  Created by Gianmaria Biselli on 8/24/20.
//  Copyright © 2020 Zodaj. All rights reserved.
//

import Foundation

struct AnalyticsItem: Codable {
    
    let time: String
    let nbPlays: Int
  
    enum CodingKeys: String, CodingKey {
        case time = "label"
        case nbPlays = "nb_plays"
    }
}
