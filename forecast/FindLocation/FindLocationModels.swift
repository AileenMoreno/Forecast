//
//  FindLocationModels.swift
//  forecast
//
//  Created by Aileen Gabriela Moreno Perez on 13-11-21.
//  Copyright © 2021 SHAPE A/S. All rights reserved.
//

import Foundation
import Entities
import CoreLocation
import Client

enum FindLocation {
    struct Response {
        let weather: CurrentWeather?
        let coordinate: CLLocationCoordinate2D?
        let error: Client.Error?
    }
    
    struct ViewModel {
        
        struct Success {
            let place: String
            let date: String
            let time: String
            let coordinate: CLLocationCoordinate2D
        }
        
        struct Failure {
            let message: String
        }
    }
}
