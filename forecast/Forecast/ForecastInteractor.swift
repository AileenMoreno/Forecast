//
//  ForecastInteractor.swift
//  forecast
//
//  Created by Aileen Gabriela Moreno Perez on 15-11-21.
//  Copyright © 2021 SHAPE A/S. All rights reserved.
//

import API
import Entities
import Client

protocol ForecastInteractorOutput: class {
    func handleLoadForecastSuccess(forecast: CurrentForecast)
    func handleLoadForecastFailure(error: Client.Error)
}

// This would be for the workers
protocol ForecastInteractorAction: class {
    func fetch(request: Request<CurrentForecast, APIError>,
               completion: @escaping (Forecast.Response) -> Void)
}

final class ForecastInteractor {
    var output: ForecastInteractorOutput!
    var action: ForecastInteractorAction!
}

// MARK: - ForecastViewControllerAction
extension ForecastInteractor: ForecastViewControllerOutput {
    func loadForecast(at latitude: Double, longitude: Double) {
        let request = CurrentForecast.getCurrent(for: "\(latitude)",
                                                 longitude: "\(longitude)")
        action.fetch(request: request,
                     completion: { [weak self] response in
                        
            guard let self = self else {
                return
            }
            
            if let error = response.error {
                self.output.handleLoadForecastFailure(error: error)
            } else if let forecast = response.forecast {
                self.output.handleLoadForecastSuccess(forecast: forecast)
            }
        })
    }
}
