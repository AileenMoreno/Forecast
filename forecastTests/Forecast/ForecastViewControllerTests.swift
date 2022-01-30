//
//  ForecastViewControllerTests.swift
//  forecastTests
//
//  Created by Aileen Gabriela Moreno Perez on 24-11-21.
//  Copyright © 2021 SHAPE A/S. All rights reserved.
//
 
import XCTest
import Client
import API
import Entities

@testable import forecast

class ForecastViewControllerTests: XCTestCase {
    
    var viewController: ForecastViewController!
    var presenter: MockForecastPresenter!
    var interactor: MockForecastInteractor!
    

    override func setUp() {
        super.setUp()
        interactor = MockForecastInteractor()
        viewController = ForecastViewController()
        viewController.output = interactor
    }

    func testViewDidLoad() {
        // Given
        let latitud = 33.0
        let longitude = 35.0
        
        viewController.latitude = latitud
        viewController.longitude = longitude
        
        // When
        viewController.viewDidLoad()
        
        // Verify
        XCTAssertNotNil(interactor.onCallLoadForest)
        XCTAssertEqual(interactor.onCallLoadForest?.latitude, latitud)
        XCTAssertEqual(interactor.onCallLoadForest?.longitude, longitude)
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
       /* XCTAssertNotNil(presenter.output)
        XCTAssertNotNil(viewController.onShowForecastModel)
        XCTAssertNotNil(viewController.onShowForecastModel?.list)
        XCTAssertEqual(viewController.onShowForecastModel?.list.count, 6)*/
    }
}
