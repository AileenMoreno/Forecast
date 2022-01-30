//
//  DoubleExtension.swift
//  forecast
//
//  Created by Aileen Gabriela Moreno Perez on 20-11-21.
//  Copyright © 2021 SHAPE A/S. All rights reserved.
//

import Foundation

extension Double {
    func toTemperature() -> String {
        let degrees = Int(self)
        return degrees.toTemperature()
    }
}
