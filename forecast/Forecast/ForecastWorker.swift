//
//  ForecastWorker.swift
//  forecast
//
//  Created by Aileen Gabriela Moreno Perez on 01-12-21.
//  Copyright © 2021 SHAPE A/S. All rights reserved.
//

import Foundation
import Client
import API
import Entities

class ForecastWorker {
    
    let api: ForecastClient
    
    init(api apiClient: ForecastClient) {
        self.api = apiClient
    }
}

// MARK: - ForecastInteractorAction
extension ForecastWorker: ForecastInteractorAction {

    func fetch(request: Request<CurrentForecast, APIError>,
               completion: @escaping (Forecast.Response) -> Void) {
        
        _ = api.perform(request) { (result) in
            switch result {
            case .success(let forecast):
                completion(Forecast.Response(forecast: forecast,
                                             error: nil))
            case .failure(let error):
                completion(Forecast.Response(forecast: nil,
                                             error: error))
            }
        }
    }
}
