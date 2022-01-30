//
//  MockForecastInteractor.swift
//  forecastTests
//
//  Created by Aileen Gabriela Moreno Perez on 24-11-21.
//  Copyright © 2021 SHAPE A/S. All rights reserved.
//

import Foundation

@testable import forecast

class MockForecastInteractor: ForecastViewControllerOutput {
    
    var onCallLoadForest: (latitude: Double, longitude: Double)?
    
    func loadForecast(at latitude: Double, longitude: Double) {
        onCallLoadForest = (latitude, longitude)
    }
}

