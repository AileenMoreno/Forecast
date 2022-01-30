//
//  MockForecastViewController.swift
//  forecastTests
//
//  Created by Aileen Gabriela Moreno Perez on 24-11-21.
//  Copyright © 2021 SHAPE A/S. All rights reserved.
//

import Foundation

@testable import forecast

class MockForecastViewController: ForecastPresenterOutput {
    
    var onShowForecastModel: Forecast.ViewModel.Forecast?
    var onShowErrorModel: Forecast.ViewModel.Error?
    
    func showForecast(for model: Forecast.ViewModel.Forecast) {
        onShowForecastModel = model
    }
    
    func showError(for model: Forecast.ViewModel.Error) {
        onShowErrorModel = model
    }
}
