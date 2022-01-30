//
//  ForecastTableViewCell.swift
//  forecast
//
//  Created by Aileen Gabriela Moreno Perez on 21-11-21.
//  Copyright © 2021 SHAPE A/S. All rights reserved.
//

import UIKit

class ForecastTableViewCell: UITableViewCell {

    static let reuseIdentifier = Constants.CellIdentifier.forecast
    static let estimatedHeight: CGFloat = 100
    
    var viewModel: WeatherCellViewModel! {
        didSet {
            self.refreshData()
        }
    }
    
    // MARK: Properties
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.darkGray
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
        label.widthAnchor.constraint(equalToConstant: 70.0).isActive = true
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let weatherImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalToConstant: 20.0).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 70.0).isActive = true
        return imageView
    }()
    
    private let rangeLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.systemGray
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
        label.widthAnchor.constraint(equalToConstant: 100.0).isActive = true
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let weatherLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.darkGray
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
        label.widthAnchor.constraint(equalToConstant: 50.0).isActive = true
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = NSLayoutConstraint.Axis.horizontal
        stackView.distribution = UIStackView.Distribution.fillProportionally
        stackView.alignment = UIStackView.Alignment.fill
        stackView.spacing = 2
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
        configureStackView()
        configureConstraints()
    }
    
    private func configureStackView() {
        stackView.addArrangedSubview(timeLabel)
        stackView.addArrangedSubview(weatherImageView)
        stackView.addArrangedSubview(rangeLabel)
        stackView.addArrangedSubview(weatherLabel)
        contentView.addSubview(stackView)
    }
    
    private func configureConstraints() {
        stackView.topAnchor.constraint(equalTo: contentView.topAnchor,
                                       constant: 5).isActive = true
        stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,
                                          constant: -5).isActive = true
        stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,
                                           constant: 20).isActive = true
        stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,
                                            constant: -20).isActive = true
    }
    
    private func refreshData() {
        weatherImageView.image = viewModel.forecast.weatherImage
        timeLabel.text = viewModel.forecast.time
        rangeLabel.text = viewModel.lowestTemperature + "->" + viewModel.highestTemperature
        weatherLabel.text = viewModel.forecast.temperature
    }
}
