//
//  DailyForecastViewModel.swift
//  forecast
//
//  Created by Aileen Gabriela Moreno Perez on 18-11-21.
//  Copyright © 2021 SHAPE A/S. All rights reserved.
//

import Foundation

struct DailyForecastViewModel {
    var list: [HourlyWeatherViewModel]
    var lowestTemperature: String
    var highestTemperature: String
}



