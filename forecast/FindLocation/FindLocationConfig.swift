//
//  FindLocationConfig.swift
//  forecast
//
//  Created by Jakob Vinther-Larsen on 19/02/2019.
//  Copyright © 2019 SHAPE A/S. All rights reserved.
//

import UIKit
import API

struct FindLocationConfig {
    static func setup(api apiClient: ForecastClient) -> UIViewController {
        let viewController = FindLocationViewController()
        let interactor = FindLocationInteractor()
        let presenter = FindLocationPresenter()
        let router = FindLocationRouter(api: apiClient)
        let worker = FindLocationWorker(api: apiClient)
        
        viewController.output = interactor
        viewController.action = router
        interactor.output = presenter
        interactor.action = worker
        presenter.output = viewController
        router.controller = viewController
        
        return viewController
    }
}
