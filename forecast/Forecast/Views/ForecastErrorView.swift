//
//  ForecastErrorView.swift
//  forecast
//
//  Created by Aileen Gabriela Moreno Perez on 22-11-21.
//  Copyright © 2021 SHAPE A/S. All rights reserved.
//

import UIKit

class ForecastErrorView: UIView {
    
    // MARK: Properties
    
    private let errorImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: Constants.Image.forecastError)
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalToConstant: 200.0).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 200.0).isActive = true
        return imageView
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.darkGray
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.widthAnchor.constraint(equalToConstant: 300.0).isActive = true
        label.heightAnchor.constraint(equalToConstant: 60.0).isActive = true
        label.textAlignment = .center
        label.numberOfLines = 3
        return label
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = NSLayoutConstraint.Axis.vertical
        stackView.distribution = UIStackView.Distribution.fill
        stackView.alignment = UIStackView.Alignment.center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // MARK: Initializers
    
    convenience init(viewModel: Forecast.ViewModel.Error) {
       // self.init(frame: CGRect(x: 0, y: 0, width: 300, height: 270))
        self.init()
        self.descriptionLabel.text = viewModel.message
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureView()
    }
    
    // MARK: Methods
    
    func configureConstraints(with parentView: UIView) {
        heightAnchor.constraint(equalToConstant: 260).isActive = true
        widthAnchor.constraint(equalToConstant: 300).isActive = true
        centerXAnchor.constraint(equalTo: parentView.centerXAnchor).isActive = true
        centerYAnchor.constraint(equalTo: parentView.centerYAnchor, constant: -44).isActive = true
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    // MARK: Private Methods
    private func configureView() {
        configureStackView()
        configureConstraints()
    }
    
    private func configureStackView() {
        stackView.addArrangedSubview(errorImageView)
        stackView.addArrangedSubview(descriptionLabel)
        addSubview(stackView)
    }
    
    private func configureConstraints() {
        stackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }
}
