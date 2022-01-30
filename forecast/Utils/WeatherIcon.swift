//
//  WeatherIcon.swift
//  forecast
//
//  Created by Aileen Gabriela Moreno Perez on 19-11-21.
//  Copyright © 2021 SHAPE A/S. All rights reserved.
//

import Foundation

enum WeatherIcon: String, CaseIterable {
    case clearSkyDay = "01d"
    case clearSkyNight = "01n"
    case fewCloudsDay = "02d"
    case fewCloudsNight = "02n"
    case scatteredCloudsDay = "03d"
    case scatteredCloudsNight = "03n"
    case brokenCloudsDay = "04d"
    case brokenCloudsNight = "04n"
    case showerRainDay = "09d"
    case showerRainNight = "09n"
    case rainDay = "10d"
    case rainNight = "10n"
    case thunderstormDay = "11d"
    case thunderstormNight = "11n"
    case snowDay = "13d"
    case snowNight = "13n"
    case mistDay = "50d"
    case mistNight = "50n"
    
    static func build(rawValue: String) -> WeatherIcon {
        return WeatherIcon(rawValue: rawValue) ?? .scatteredCloudsDay
    }
}
