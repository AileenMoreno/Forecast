//
//  ForecastElement.swift
//  Entities
//
//  Created by Aileen Gabriela Moreno Perez on 16-11-21.
//  Copyright © 2021 SHAPE A/S. All rights reserved.
//

import Foundation

public struct ForecastElement: Codable {
    public let dt: Int
    public let summary: Summary
    public let weather: [Weather]
    public let wind: Wind
    public let visibility: Int
    public let date: String
    public let system: System

    enum CodingKeys: String, CodingKey {
        case dt, weather, wind, visibility
        case summary = "main"
        case date = "dt_txt"
        case system = "sys"
    }
}
