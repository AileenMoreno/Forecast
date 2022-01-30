//
//  Wind.swift
//  Entities
//
//  Created by Aileen Gabriela Moreno Perez on 16-11-21.
//  Copyright © 2021 SHAPE A/S. All rights reserved.
//

import Foundation

public struct Wind: Codable {
    public let speed: Double
    public let deg: Int
    public let gust: Double
}
