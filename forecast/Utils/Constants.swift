//
//  Constants.swift
//  forecast
//
//  Created by Aileen Gabriela Moreno Perez on 19-11-21.
//  Copyright © 2021 SHAPE A/S. All rights reserved.
//

import Foundation

struct Constants {
    static let forecastTitle = "📍Forecast"
    static let findLocationErrorTitle = "There's been an error!"
    static let findLocationErrorButtonTitle = "Ok."
    static let annotationTitle = "You selected this!"
    static let hourlyForecastTitle = "HOURLY FORECAST"
    
    
    struct CellIdentifier {
        static let currentWeather = "CurrentWeatherTableViewCell"
        static let forecast = "ForecastTableViewCell"
        static let customHeader = "CustomHeaderTableViewCell"
    }
    
    struct ErrorMessage {
        static let network = "There was an error. Please check your internet connection!"
        static let client = "Ups an error!. Something was wrong!"
        static let parser = "Ups! Data could not be read!"
        static let remote = "Server must be down. Try again later!"
        static let headerTitle = "OH NO!"
    }
    
    struct Image {
        static let forecastError = "forecastErrorImage"
    }
}
