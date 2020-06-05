//
//  WeatherModel.swift
//  Clima
//
//  Created by Charithardha Palakodeti on 6/3/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

struct WeatherModel{
    let conditionId: Int
    let temperature: Double
    let cityName: String
    
    var temperatureString: String {
        return String(format: "%0.1f", temperature)
    }
    
    var conditionName: String {
        switch conditionId {
        case 200...232: return "cloud.bolt"
        case 300...321: return "cloud.drizzle"
        case 500...531: return "cloud.rain"
        case 600...622: return "cloud.snow"
        case 700...799: return "cloud.fog"
        case 800: return "sun.max"
        case 801...805: return "cloud.bolt"
        default:
            return "cloud"
        }
    }
}
