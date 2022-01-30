//
//  Forecast.swift
//  API
//
//  Created by Aileen Gabriela Moreno Perez on 13-11-21.
//  Copyright © 2021 SHAPE A/S. All rights reserved.
//

import Entities
import Client

extension CurrentForecast {
    public static func getCurrent(for latitude: String,
                                  longitude: String) -> Request<CurrentForecast, APIError> {
        let latitudeQuery = URLQueryItem(name: "lat", value: latitude)
        let longitudeQuery = URLQueryItem(name: "lon", value: longitude)
        let unitsQuery = URLQueryItem(name: "units", value: "metric")
        
        return Request(
            url: URL(string: "forecast")!,
            method: .get,
            parameters: [QueryParameters([latitudeQuery, longitudeQuery, unitsQuery])],
            resource: decodeResource(CurrentForecast.self),
            error: APIError.init,
            needsAuthorization: true
        )
    }
}
