//
//  CustomHeaderTableViewCell.swift
//  forecast
//
//  Created by Aileen Gabriela Moreno Perez on 21-11-21.
//  Copyright © 2021 SHAPE A/S. All rights reserved.
//

import UIKit

class CustomHeaderTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = Constants.CellIdentifier.customHeader
    static let estimatedHeight: CGFloat = 50
    
    var headerTitle: String! {
        didSet {
            self.refreshData()
        }
    }

    // MARK: Properties
    
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.systemOrange
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = NSLayoutConstraint.Axis.vertical
        stackView.distribution = UIStackView.Distribution.fill
        stackView.alignment = UIStackView.Alignment.leading
        stackView.spacing = 0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.backgroundColor = .clear
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
    func loadData(headerTitle: String) {
        self.headerTitle = headerTitle
    }
    
    // MARK: - Private functions
    
    private func configureCell() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        selectionStyle = .none
        
        stackView.addArrangedSubview(headerLabel)
        contentView.addSubview(stackView)
        
        stackView.topAnchor.constraint(equalTo: contentView.topAnchor,
                                       constant: 5).isActive = true
        stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,
                                          constant: -5).isActive = true
        stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,
                                           constant: 30).isActive = true
        stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,
                                            constant: -20).isActive = true
    }
    
    private func refreshData() {
        headerLabel.text = headerTitle
    }
}
