//
//  FindLocationPresenter.swift
//  forecast
//
//  Created by Jakob Vinther-Larsen on 19/02/2019.
//  Copyright © 2019 SHAPE A/S. All rights reserved.
//

import Foundation
import Entities
import Client

protocol FindLocationPresenterOutput: class {
    func showWeather(model: FindLocation.ViewModel.Success)
    func showError(model: FindLocation.ViewModel.Failure)
}

final class FindLocationPresenter {
    weak var output: FindLocationPresenterOutput!
}

// MARK: - FindLocationInteractorOutput
extension FindLocationPresenter: FindLocationInteractorOutput {
    func handleFindLocationSuccess(response: FindLocation.Response) {
        guard let weather = response.weather,
              let coordinate = response.coordinate else {
            output.showError(model: FindLocation.ViewModel.Failure(message: "Error loading data"))
            return
        }
        
        let model = FindLocation.ViewModel.Success(place: weather.name,
                                                   date: weather.date.getDay(),
                                                   time: weather.date.getTime(),
                                                   coordinate: coordinate)
        output.showWeather(model: model)
    }
    
    func handleFindLocationFailure(error: Client.Error) {
        let model = FindLocation.ViewModel.Failure(message: error.localizedDescription)
        output.showError(model: model)
    }
}
