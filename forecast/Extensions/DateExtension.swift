//
//  DateExtension.swift
//  forecast
//
//  Created by Aileen Gabriela Moreno Perez on 13-11-21.
//  Copyright © 2021 SHAPE A/S. All rights reserved.
//

import Foundation

extension Date {
    func getDay() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE, MMM d."
        return dateFormatter.string(from: self)
    }
    
    func dayOfWeek() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self).capitalized
    }
    
    func getTime() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "H:mm"
        return dateFormatter.string(from: self)
    }
}
