//
//  ForecastConfig.swift
//  forecast
//
//  Created by Aileen Gabriela Moreno Perez on 15-11-21.
//  Copyright © 2021 SHAPE A/S. All rights reserved.
//

import UIKit
import MapKit
import API
import Entities

struct ForecastConfig {
    static func setup(api: ForecastClient,
                      coordinate: CLLocationCoordinate2D) -> UIViewController {
        let viewController = ForecastViewController()
        let interactor = ForecastInteractor()
        let presenter = ForecastPresenter()
        let worker = ForecastWorker(api: api)
        
        viewController.latitude = coordinate.latitude
        viewController.longitude = coordinate.longitude
        
        viewController.output = interactor
        interactor.output = presenter
        interactor.action = worker
        presenter.output = viewController
        
        return viewController
    }
}

