//
//  FindLocationWorker.swift
//  forecast
//
//  Created by Aileen Gabriela Moreno Perez on 01-12-21.
//  Copyright © 2021 SHAPE A/S. All rights reserved.
//

import Foundation
import API
import Entities
import Client
import MapKit

class FindLocationWorker {
 
    private let api: ForecastClient
    
    init(api apiClient: ForecastClient) {
        self.api = apiClient
    }
}

// MARK: - FindLocationInteractorAction
extension FindLocationWorker: FindLocationInteractorAction {
    
    func fetchWeather(coordinate: CLLocationCoordinate2D,
                      request: Request<CurrentWeather, APIError> ,
                      completion: @escaping (FindLocation.Response) -> Void) {
        
        _ = api.perform(request) { (result) in
            switch result {
            case .success(let weather):
                completion(FindLocation.Response(weather: weather,
                                                 coordinate: coordinate,
                                                 error: nil))
            case .failure(let error):
                completion(FindLocation.Response(weather: nil,
                                                 coordinate: nil,
                                                 error: error))
            }
        }
    }
}
