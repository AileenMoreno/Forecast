//
//  MockForecastPresenter.swift
//  forecastTests
//
//  Created by Aileen Gabriela Moreno Perez on 24-11-21.
//  Copyright © 2021 SHAPE A/S. All rights reserved.
//

import Foundation
import Entities
import Client

@testable import forecast

class MockForecastPresenter: ForecastInteractorOutput {
    
    var didCallHandleLoadForecastSuccess = false
    var didCallHandleLoadForecastFailure = false
    
    func handleLoadForecastSuccess(forecast: CurrentForecast) {
        didCallHandleLoadForecastSuccess = true
    }
    
    func handleLoadForecastFailure(error: Client.Error) {
        didCallHandleLoadForecastFailure = true
    }
}
