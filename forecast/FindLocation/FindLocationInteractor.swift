//
//  FindLocationInteractor.swift
//  forecast
//
//  Created by Jakob Vinther-Larsen on 19/02/2019.
//  Copyright © 2019 SHAPE A/S. All rights reserved.
//

import MapKit
import API
import Entities
import Client

protocol FindLocationInteractorOutput {
    func handleFindLocationSuccess(response: FindLocation.Response)
    func handleFindLocationFailure(error: Client.Error)
}

protocol FindLocationInteractorAction: class {
    func fetchWeather(coordinate: CLLocationCoordinate2D,
                      request: Request<CurrentWeather, APIError>,
                      completion: @escaping (FindLocation.Response) -> Void)
}


final class FindLocationInteractor {
    var output: FindLocationInteractorOutput!
    var action: FindLocationInteractorAction!
}

// MARK: - FindLocationViewControllerOutput
extension FindLocationInteractor: FindLocationViewControllerOutput {
    func viewIsReady() {
        // TODO
    }
    
    func locationSelected(at coordinate: CLLocationCoordinate2D) {
        let latitude = "\(coordinate.latitude)"
        let longitude = "\(coordinate.longitude)"
        let request = CurrentWeather.getCurrent(for: latitude, longitude: longitude)
        
        action.fetchWeather(coordinate: coordinate,
                            request: request,
                            completion: { [weak self] response in
            
            guard let self = self else {
                return
            }
            
            if let error = response.error {
                self.output.handleFindLocationFailure(error: error)
            } else {
                self.output.handleFindLocationSuccess(response: response)
            }
        })
    }
}
