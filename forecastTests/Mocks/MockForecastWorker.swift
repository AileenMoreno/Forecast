//
//  MockForecastWorker.swift
//  forecastTests
//
//  Created by Aileen Gabriela Moreno Perez on 02-12-21.
//  Copyright © 2021 SHAPE A/S. All rights reserved.
//

import Foundation
import API
import Entities
import Client

@testable import forecast

class MockForecastWorker: ForecastInteractorAction {
    var error = false
    var forecast: CurrentForecast?
    
    func fetch(request: Request<CurrentForecast, APIError>,
               completion: @escaping (Forecast.Response) -> Void) {
        if error {
            completion(Forecast.Response(forecast: nil, error: Client.Error.client("random error")))
        } else {
            completion(Forecast.Response(forecast: forecast, error: nil))
        }
    }
}

