//
//  DecodableExtension.swift
//  forecastTests
//
//  Created by Aileen Gabriela Moreno Perez on 24-11-21.
//  Copyright © 2021 SHAPE A/S. All rights reserved.
//
import Foundation

@testable import forecast

extension Decodable {
    static func readJSONData(from fileName: String) -> Self? {
        do {
            if let filePath = Bundle.main.path(forResource: fileName, ofType: "json") {
                let fileUrl = URL(fileURLWithPath: filePath)
                let data = try Data(contentsOf: fileUrl)
                let forecast = try? JSONDecoder().decode(Self.self, from: data)
                return forecast
            }
        } catch {
            print("The was a problem loading the json file")
        }
        return nil
    }
}
