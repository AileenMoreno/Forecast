//
//  ForecastPresenterTests.swift
//  forecastTests
//
//  Created by Aileen Gabriela Moreno Perez on 24-11-21.
//  Copyright © 2021 SHAPE A/S. All rights reserved.
//

import XCTest
import Entities
import Client
import Foundation

@testable import forecast

class ForecastPresenterTests: XCTestCase {
    
    var presenter: ForecastPresenter!
    var viewController: MockForecastViewController!

    override func setUp() {
        super.setUp()
        presenter = ForecastPresenter()
        viewController = MockForecastViewController()
        presenter.output = viewController
    }

    // MARK: Tests Methods
    
    func testHandleLoadForecast_whenSuccessResponse_shouldViewModelExist() {
        
        // Given
        guard let forecast = CurrentForecast.readJSONData(from: "ForecastResponse_default") else {
            XCTAssert(false, "Tests should have loaded file with response")
            return
        }
        
        // When
        presenter.handleLoadForecastSuccess(forecast: forecast)
        
        
        // Verify
        XCTAssertNotNil(presenter.output)
        XCTAssertNotNil(viewController.onShowForecastModel)
        XCTAssertNotNil(viewController.onShowForecastModel?.list)
        XCTAssertEqual(viewController.onShowForecastModel?.list.count, 6)
    }
    
    func testHandleLoadForecast_whenSeveralDaysResponse_shouldDailyViewModelExist() {
        // Given
        guard let forecast = CurrentForecast.readJSONData(from: "ForecastResponse_default") else {
            XCTAssert(false, "Tests should have loaded file with response")
            return
        }
        
        // When
        presenter.handleLoadForecastSuccess(forecast: forecast)
        
        
        // Verify
        XCTAssertNotNil(presenter.output)
        XCTAssertNil(viewController.onShowErrorModel)
        XCTAssertNotNil(viewController.onShowForecastModel)
        XCTAssertNotNil(viewController.onShowForecastModel?.list)
        XCTAssertEqual(viewController.onShowForecastModel?.list.count, 6)
    }
    
    func testHandleLoadForecast_whenOneDayResponse_shouldDailyViewModelExist() {
        
        // Given
        guard let forecast = CurrentForecast.readJSONData(from: "ForecastResponse_oneDay") else {
            XCTAssert(false, "Tests should have loaded file with response")
            return
        }
        
        // When
        presenter.handleLoadForecastSuccess(forecast: forecast)
        
        
        // Verify
        XCTAssertNotNil(presenter.output)
        XCTAssertNil(viewController.onShowErrorModel)
        XCTAssertNotNil(viewController.onShowForecastModel)
        XCTAssertNotNil(viewController.onShowForecastModel?.list)
        
        // Verify only 1 day
        XCTAssertEqual(viewController.onShowForecastModel?.list.count, 1)
        
        // Verify only hours set in unique day
        XCTAssertEqual(viewController.onShowForecastModel?.list.first?.list.count, forecast.count)
    }
    
    func testHandleLoadForecast_whenClientFailed_shouldErrorViewModelExist() {
        // Given
        let error = Client.Error.client("something wrong happened!")
        
        // When
        presenter.handleLoadForecastFailure(error: error)
        
        
        // Verify
        XCTAssertNotNil(presenter.output)
        XCTAssertNil(viewController.onShowForecastModel)
        XCTAssertNotNil(viewController.onShowErrorModel)
        XCTAssertEqual(viewController.onShowErrorModel?.message, Constants.ErrorMessage.client)
    }
    
    func testHandleLoadForecast_whenParserFailed_shouldErrorViewModelExist() {
        
        // Given
        let error = NSError(domain: "", code: 500, userInfo: nil)
        let clientError = Client.Error.parser(error)
        
        // When
        presenter.handleLoadForecastFailure(error: clientError)
        
        
        // Verify
        XCTAssertNotNil(presenter.output)
        XCTAssertNil(viewController.onShowForecastModel)
        XCTAssertNotNil(viewController.onShowErrorModel)
        XCTAssertEqual(viewController.onShowErrorModel?.message, Constants.ErrorMessage.parser)
    }
    
    func testHandleLoadForecast_whenNetworkFailed_shouldErrorViewModelExist() {
        
        // Given
        let error = NSError(domain: "", code: 500, userInfo: nil)
        let clientError = Client.Error.network(error, 500)
        
        // When
        presenter.handleLoadForecastFailure(error: clientError)
        
        
        // Verify
        XCTAssertNotNil(presenter.output)
        XCTAssertNil(viewController.onShowForecastModel)
        XCTAssertNotNil(viewController.onShowErrorModel)
        XCTAssertEqual(viewController.onShowErrorModel?.message, Constants.ErrorMessage.network)
    }
    
    func testHandleLoadForecast_whenRemoteFailed_shouldErrorViewModelExist() {
        
        // Given
        let error = NSError(domain: "", code: 500, userInfo: nil)
        let clientError = Client.Error.remote(error, 500)
        
        // When
        presenter.handleLoadForecastFailure(error: clientError)

        
        // Verify
        XCTAssertNotNil(presenter.output)
        XCTAssertNil(viewController.onShowForecastModel)
        XCTAssertNotNil(viewController.onShowErrorModel)
        XCTAssertEqual(viewController.onShowErrorModel?.message, Constants.ErrorMessage.remote)
    }
}
