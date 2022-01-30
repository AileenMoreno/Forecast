//
//  Forecast.swift
//  Entities
//
//  Created by Aileen Gabriela Moreno Perez on 13-11-21.
//  Copyright © 2021 SHAPE A/S. All rights reserved.
//

import Foundation

public struct CurrentForecast: Codable {
    public let code: String
    public let message: Int
    public let count: Int
    public let list: [ForecastElement]
    public let city: City
    
    enum CodingKeys: String, CodingKey {
        case code = "cod"
        case message
        case count = "cnt"
        case list
        case city
    }
}
