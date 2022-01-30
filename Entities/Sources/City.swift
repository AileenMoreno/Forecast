//
//  City.swift
//  Entities
//
//  Created by Aileen Gabriela Moreno Perez on 16-11-21.
//  Copyright © 2021 SHAPE A/S. All rights reserved.
//

import Foundation

public struct City: Codable {
    public let id: Int
    public let name: String
    public let coordinate: Coordinate
    public let country: String
    public let population, timezone, sunrise, sunset: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case coordinate = "coord"
        case country
        case population
        case timezone
        case sunrise
        case sunset
    }
}
