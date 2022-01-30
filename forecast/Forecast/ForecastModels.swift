//
//  ForecastModels.swift
//  forecast
//
//  Created by Aileen Gabriela Moreno Perez on 15-11-21.
//  Copyright © 2021 SHAPE A/S. All rights reserved.
//

import Foundation
import Entities
import CoreLocation
import Client

enum Forecast {
    struct Response {
        let forecast: CurrentForecast?
        let error: Client.Error?
    }
    
    struct ViewModel {
        struct Error {
            let message: String
        }
        
        struct Forecast {
            let list: [DailyForecastViewModel]
        }
    }
}
