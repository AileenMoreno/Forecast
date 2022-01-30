//
//  System.swift
//  Entities
//
//  Created by Aileen Gabriela Moreno Perez on 21-11-21.
//  Copyright © 2021 SHAPE A/S. All rights reserved.
//

import Foundation

public struct System: Codable {
    public let partOfDay: String
    
    enum CodingKeys: String, CodingKey {
        case partOfDay = "pod"
    }
}
