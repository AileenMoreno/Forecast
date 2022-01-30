//
//  ForecastViewModelManager.swift
//  forecast
//
//  Created by Aileen Gabriela Moreno Perez on 16-11-21.
//  Copyright © 2021 SHAPE A/S. All rights reserved.
//

import Foundation
import UIKit
import Client
import Entities

class ForecastViewModelManager {
    
    // MARK: Creational methods
    
    static func create(from forecast: CurrentForecast) -> Forecast.ViewModel.Forecast {
        
        let listViewModel = forecast.list.map {ForecastViewModelManager.create(from: $0,city: forecast.city)}
        let forecastViewModel = ForecastViewModelManager.splitByDate(from: listViewModel)
        
        return Forecast.ViewModel.Forecast(list: forecastViewModel)
    }
    
    static func create(from error: Client.Error) -> Forecast.ViewModel.Error {
        var message = ""
        switch error {
        case .network:
            message = Constants.ErrorMessage.network
        case .remote:
            message = Constants.ErrorMessage.remote
        case .parser:
            message = Constants.ErrorMessage.parser
        case .client:
            message = Constants.ErrorMessage.client
        }
        
        return Forecast.ViewModel.Error(message: message)
    }
    
    private static func create(from list: [HourlyWeatherViewModel]) -> DailyForecastViewModel {
        let lowestTemperature = list.reduce(Int.max, {min($0, $1.temperatureValue)})
        let highestTemperature = list.reduce(Int.min, {max($0, $1.temperatureValue)})
        
        return DailyForecastViewModel(list: list,
                                      lowestTemperature: lowestTemperature.toTemperature(),
                                      highestTemperature: highestTemperature.toTemperature())
        
    }
    
    private static func create(from element: ForecastElement,
                               city: City) -> HourlyWeatherViewModel {
      
        let place = city.name
        let country = city.country
        let dateString = element.date.toDate()
        let date = dateString?.getDay() ?? "-"
        let dayOfWeek = dateString?.dayOfWeek() ?? ""
        let time = dateString?.getTime() ?? "-"
        let weatherImage = getWeatherImage(from: element.weather.first)
        let temperature = getTemperature(from: element.summary)
        let temperatureValue = Int(element.summary.temperature)
        let partOfDay = PartOfDay.build(rawValue: element.system.partOfDay)
        
        return HourlyWeatherViewModel(city: place,
                                      country: country,
                                      date: date,
                                      dayOfWeek: dayOfWeek,
                                      time: time,
                                      weatherImage: weatherImage,
                                      temperature: temperature,
                                      temperatureValue: temperatureValue,
                                      partOfDay: partOfDay)
    }
    
    // MARK: - Private methods
    
    private static func getTemperature(from summary: Summary) -> String {
        return summary.temperature.toTemperature()
    }
    
    private static func getWeatherImage(from weather: Weather?) -> UIImage? {
        guard let iconName = weather?.icon,
              let icon = WeatherIcon(rawValue: iconName) else {
            return nil
        }
        return UIImage(named: icon.rawValue)
    }
    
    // MARK: Logic methods
    
    private static func splitByDate(from list: [HourlyWeatherViewModel]) -> [DailyForecastViewModel] {
        
        guard let firstElement = list.first else {
            return []
        }
        
        var day = firstElement.date
        var hourlyList = [HourlyWeatherViewModel]()
        var dailyList = [DailyForecastViewModel]()
        
        for element in list {
            if element.date == day {
                hourlyList.append(element)
            } else {
                day = element.date
                let dayForecast = ForecastViewModelManager.create(from: hourlyList)
                dailyList.append(dayForecast)
                hourlyList = []
            }
        }
        
        if !hourlyList.isEmpty {
            let dayForecast = ForecastViewModelManager.create(from: hourlyList)
            dailyList.append(dayForecast)
        }
        
        return dailyList
    }
}
