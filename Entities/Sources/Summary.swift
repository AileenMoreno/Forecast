//
//  Summary.swift
//  Entities
//
//  Created by Aileen Gabriela Moreno Perez on 16-11-21.
//  Copyright © 2021 SHAPE A/S. All rights reserved.
//

import Foundation

public struct Summary: Codable {
    public let temperature: Double
    public let feelsLike: Double
    public let minimumTemperature: Double
    public let maximumTemperature: Double
    public let pressure: Int
    public let seaLevel: Int
    public let grndLevel: Int
    public let humidity: Int
    public let tempKf: Double

    enum CodingKeys: String, CodingKey {
        case temperature = "temp"
        case feelsLike = "feels_like"
        case minimumTemperature = "temp_min"
        case maximumTemperature = "temp_max"
        case pressure
        case seaLevel = "sea_level"
        case grndLevel = "grnd_level"
        case humidity
        case tempKf = "temp_kf"
    }
}
