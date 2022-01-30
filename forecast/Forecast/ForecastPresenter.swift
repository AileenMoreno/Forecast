//
//  ForecastPresenter.swift
//  forecast
//
//  Created by Aileen Gabriela Moreno Perez on 15-11-21.
//  Copyright © 2021 SHAPE A/S. All rights reserved.
//

import Foundation
import Entities
import Client

protocol ForecastPresenterOutput: class {
    func showForecast(for model: Forecast.ViewModel.Forecast)
    func showError(for model: Forecast.ViewModel.Error)
}

final class ForecastPresenter {
    weak var output: ForecastPresenterOutput?
}

// MARK: - ForecastInteractorOutput
extension ForecastPresenter: ForecastInteractorOutput {
    func handleLoadForecastSuccess(forecast: CurrentForecast) {
        guard let output = output else {
            return
        }
        
        let viewModel = ForecastViewModelManager.create(from: forecast)
        output.showForecast(for: viewModel)
    }
    
    func handleLoadForecastFailure(error: Client.Error) {
        guard let output = output else {
            return
        }
        
        let viewModel = ForecastViewModelManager.create(from: error)
        output.showError(for: viewModel)
    }
}
