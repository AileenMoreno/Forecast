//
//  WeatherBackground.swift
//  forecast
//
//  Created by Aileen Gabriela Moreno Perez on 20-11-21.
//  Copyright © 2021 SHAPE A/S. All rights reserved.
//

import Foundation

enum PartOfDay: String, CaseIterable {
    case day = "d"
    case night = "n"
    
    static func build(rawValue: String) -> PartOfDay {
        return PartOfDay(rawValue: rawValue) ?? .day
    }
}
