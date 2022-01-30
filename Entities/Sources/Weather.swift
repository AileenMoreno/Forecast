//
//  Weather.swift
//  Entities
//
//  Created by Aileen Gabriela Moreno Perez on 16-11-21.
//  Copyright © 2021 SHAPE A/S. All rights reserved.
//

import Foundation

public struct Weather: Codable {
    public let id: Int
    public let state: String
    public let description: String
    public let icon: String

    enum CodingKeys: String, CodingKey {
        case id
        case state = "main"
        case description
        case icon
    }
}
