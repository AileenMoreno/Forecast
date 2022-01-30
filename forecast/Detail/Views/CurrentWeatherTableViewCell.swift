//
//  CurrentWeatherTableViewCell.swift
//  forecast
//
//  Created by Aileen Gabriela Moreno Perez on 19-11-21.
//  Copyright © 2021 SHAPE A/S. All rights reserved.
//

import UIKit

class CurrentWeatherTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = Constants.CellIdentifier.currentWeather
    static let estimatedHeight: CGFloat = 300
    
    private var viewModel: WeatherCellViewModel! {
        didSet {
            self.refreshData()
        }
    }

    // MARK: Properties
    
    private let locationLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.systemOrange
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        label.heightAnchor.constraint(equalToConstant: 60.0).isActive = true
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let weatherImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalToConstant: 70.0).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 70.0).isActive = true
        return imageView
    }()
    
    private let temperatureLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.darkGray
        label.font = UIFont.systemFont(ofSize: 70, weight: .semibold)
        label.heightAnchor.constraint(equalToConstant: 60.0).isActive = true
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let innerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = NSLayoutConstraint.Axis.vertical
        stackView.distribution  = UIStackView.Distribution.fill
        stackView.alignment = UIStackView.Alignment.center
        stackView.spacing = -30
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let summaryLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.systemGray
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.heightAnchor.constraint(equalToConstant: 60.0).isActive = true
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = NSLayoutConstraint.Axis.vertical
        stackView.distribution = UIStackView.Distribution.fill
        stackView.alignment = UIStackView.Alignment.center
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.backgroundColor = Colors.cellBackground
        stackView.layer.cornerRadius = 12
        stackView.layer.masksToBounds = false
        return stackView
    }()

    // MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public functions
    func loadData(from viewModel: WeatherCellViewModel) {
        self.viewModel = viewModel
    }
    
    // MARK: - Private functions
    
    private func configureCell() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        selectionStyle = .none
        
        configureInnerStackView()
        configureMainStackView()
        configureConstraints()
    }
    
    private func configureMainStackView() {
        stackView.addArrangedSubview(innerStackView)
        stackView.addArrangedSubview(summaryLabel)
        contentView.addSubview(stackView)
    }
    
    private func configureInnerStackView() {
        innerStackView.addArrangedSubview(locationLabel)
        innerStackView.addArrangedSubview(weatherImageView)
        innerStackView.addArrangedSubview(temperatureLabel)
    }
    
    private func configureConstraints() {
        stackView.topAnchor.constraint(equalTo: contentView.topAnchor,
                                       constant: 30).isActive = true
        stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,
                                          constant: -5).isActive = true
        stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,
                                           constant: 20).isActive = true
        stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,
                                            constant: -20).isActive = true
    }
    
    private func refreshData() {
        locationLabel.text = viewModel.forecast.city
        weatherImageView.image = viewModel.forecast.weatherImage
        temperatureLabel.text = viewModel.forecast.temperature
        summaryLabel.text = "L:" + viewModel.lowestTemperature + " - H:" + viewModel.highestTemperature
    }
}
