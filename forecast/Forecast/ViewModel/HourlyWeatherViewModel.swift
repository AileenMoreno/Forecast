//
//  HourlyWeatherViewModel.swift
//  forecast
//
//  Created by Aileen Gabriela Moreno Perez on 24-11-21.
//  Copyright © 2021 SHAPE A/S. All rights reserved.
//

import Foundation
import UIKit

struct HourlyWeatherViewModel {
    let city: String
    let country: String
    let date: String
    let dayOfWeek: String
    let time: String
    let weatherImage: UIImage?
    let temperature: String
    let temperatureValue: Int
    let partOfDay: PartOfDay
}
