//
//  WeatherCellViewModel.swift
//  forecast
//
//  Created by Aileen Gabriela Moreno Perez on 22-11-21.
//  Copyright © 2021 SHAPE A/S. All rights reserved.
//

import Foundation

struct WeatherCellViewModel {
    let forecast: HourlyWeatherViewModel
    let lowestTemperature: String
    let highestTemperature: String
}
