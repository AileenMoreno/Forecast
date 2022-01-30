
//
//  FindLocationRouter.swift
//  forecast
//
//  Created by Jakob Vinther-Larsen on 19/02/2019.
//  Copyright © 2019 SHAPE A/S. All rights reserved.
//

import MapKit
import API
import Entities

final class FindLocationRouter {
    weak var controller: FindLocationViewController?
    
    let api: ForecastClient
    
    init(api apiClient: ForecastClient) {
        self.api = apiClient
    }
}

// MARK: - FindLocationViewControllerOutput
extension FindLocationRouter: FindLocationViewControllerAction {
    func routeToForecast(for coordinate: CLLocationCoordinate2D) {
        
        guard let controller = controller else {
            return
        }
        
        let forecastController = ForecastConfig.setup(api: api,
                                                      coordinate: coordinate)
        controller.navigationController?.pushViewController(forecastController,
                                                            animated: true)
    }
}
