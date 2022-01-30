//
//  StringExtension.swift
//  forecast
//
//  Created by Aileen Gabriela Moreno Perez on 16-11-21.
//  Copyright © 2021 SHAPE A/S. All rights reserved.
//

import Foundation

extension String {
    func toDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy'-'MM'-'dd HH':'mm':'ss" // 2021-11-13 18:00:00
        return dateFormatter.date(from: self)
    }
}
