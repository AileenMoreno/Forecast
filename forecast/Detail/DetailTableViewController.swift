//
//  DetailTableViewController.swift
//  forecast
//
//  Created by Aileen Gabriela Moreno Perez on 18-11-21.
//  Copyright © 2021 SHAPE A/S. All rights reserved.
//

import UIKit

protocol DetailViewDelegate: class {
    func displayDetailHeader(title: String)
}

class DetailTableViewController: UITableViewController {
    
    var forecast: DailyForecastViewModel!
    var page: Int!
    
    weak var delegate: DetailViewDelegate?
    
    static let currentWeatherSection = 0
    static let forecastection = 1
    
    var currentForecast: HourlyWeatherViewModel {
        return forecast.list[page]
    }
    
    init(forecast: DailyForecastViewModel,
         page: Int,
         delegate: DetailViewDelegate? = nil) {
        super.init(style: .grouped)
        self.forecast = forecast
        self.page = page
        self.delegate = delegate
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        delegate?.displayDetailHeader(title: currentForecast.dayOfWeek)
    }
    
    // MARK: - Private methods
    
    private func configureView() {
        configureTableView()
        configureBackground()
    }
    
    private func configureTableView() {
        tableView.register(CurrentWeatherTableViewCell.self,
                           forCellReuseIdentifier: CurrentWeatherTableViewCell.reuseIdentifier)
        
        tableView.register(ForecastTableViewCell.self,
                           forCellReuseIdentifier: ForecastTableViewCell.reuseIdentifier)
        
        tableView.register(CustomHeaderTableViewCell.self,
                           forCellReuseIdentifier: CustomHeaderTableViewCell.reuseIdentifier)
        tableView.separatorStyle = .none
    }
    
    private func configureBackground() {
        let partOfDay = forecast.list.first?.partOfDay ?? .day
        if partOfDay == .day {
            view.backgroundColor = Colors.dayBackground
        } else {
            view.backgroundColor = Colors.nightBackground
        }
    }
    
    private func forecastCellForRow(_ tableView: UITableView,
                                    at indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ForecastTableViewCell.reuseIdentifier,
                                                 for: indexPath) as! ForecastTableViewCell
        let viewModel = WeatherCellViewModel(forecast: forecast.list[indexPath.row],
                                             lowestTemperature: forecast.lowestTemperature,
                                             highestTemperature: forecast.highestTemperature)
        cell.loadData(from: viewModel)
        return cell
    }
    
    private func currentWeatherCellForRow(_ tableView: UITableView,
                                          at indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CurrentWeatherTableViewCell.reuseIdentifier,
                                                 for: indexPath) as! CurrentWeatherTableViewCell
        let viewModel = WeatherCellViewModel(forecast: forecast.list[indexPath.row],
                                             lowestTemperature: forecast.lowestTemperature,
                                             highestTemperature: forecast.highestTemperature)
        cell.loadData(from: viewModel)
        return cell
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        
        if section == DetailTableViewController.currentWeatherSection {
            return 1
        } else {
            return forecast.list.count
        }
    }
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == DetailTableViewController.currentWeatherSection {
            return currentWeatherCellForRow(tableView, at: indexPath)
        } else {
            return forecastCellForRow(tableView, at: indexPath)
        }
    }
    
    override func tableView(_ tableView: UITableView,
                            heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == DetailTableViewController.currentWeatherSection {
            return CurrentWeatherTableViewCell.estimatedHeight
        } else {
            return ForecastTableViewCell.estimatedHeight
        }
    }
    
    override func tableView(_ tableView: UITableView,
                            viewForHeaderInSection section: Int) -> UIView? {
        if section != DetailTableViewController.currentWeatherSection {
            let cell = tableView.dequeueReusableCell(withIdentifier: CustomHeaderTableViewCell.reuseIdentifier) as! CustomHeaderTableViewCell
            cell.loadData(headerTitle: Constants.hourlyForecastTitle)
            let headerView = UIView()
            headerView.addSubview(cell)
            return headerView
        }
        return nil
    }
    
    override func tableView(_ tableView: UITableView,
                            heightForHeaderInSection section: Int) -> CGFloat {

        if section != DetailTableViewController.currentWeatherSection {
            return CustomHeaderTableViewCell.estimatedHeight
        }
        return 0
    }
}
