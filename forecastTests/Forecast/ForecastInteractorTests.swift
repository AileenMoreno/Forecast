//
//  ForecastInteractorTests.swift
//  forecastTests
//
//  Created by Aileen Gabriela Moreno Perez on 24-11-21.
//  Copyright © 2021 SHAPE A/S. All rights reserved.
//

import XCTest
import Entities
import Client
import Foundation
import API

@testable import forecast

class ForecastInteractorTests: XCTestCase {
    
    var interactor: ForecastInteractor!
    var presenter: MockForecastPresenter!
    var worker: MockForecastWorker!

    override func setUp() {
        presenter = MockForecastPresenter()
        worker = MockForecastWorker()
        interactor = ForecastInteractor()
        
        interactor.action = worker
        interactor.output = presenter
    }
    
    // MARK: Tests Methods
    
    func testLoadForecast_whenFailResponse_shouldReturnError() {
        
        // Given
        worker.error = true
        
        // When
        interactor.loadForecast(at: 0, longitude: 1)
        
        // Verify
        XCTAssertTrue(presenter.didCallHandleLoadForecastFailure)
        XCTAssertFalse(presenter.didCallHandleLoadForecastSuccess)
    }
    
    func testLoadForecast_whenSuccessResponse_shouldReturnModel() {
        
        // Given
        guard let forecast = CurrentForecast.readJSONData(from: "ForecastResponse_default") else {
            XCTAssert(false, "Tests should have loaded file with response")
            return
        }
        
        worker.forecast = forecast
        
        // When
        interactor.loadForecast(at: 0, longitude: 1)
        
        
        // Verify
        XCTAssertTrue(presenter.didCallHandleLoadForecastSuccess)
        XCTAssertFalse(presenter.didCallHandleLoadForecastFailure)
    }
}
