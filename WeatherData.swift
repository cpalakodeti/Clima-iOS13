//
//  WeatherData.swift
//  Clima
//
//  Created by Charithardha Palakodeti on 6/3/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation
// Decodable is protocol which can convert json to Model
// Encodable is Protocol which can convert Model to Json
// Codable = Decodable + Encodable
struct WeatherData : Decodable {
    let name: String
    let main: Main
    let weather : [Weather]
}

struct Main : Decodable {
    let temp: Double
}

struct Weather : Decodable {
    let description: String
    let id:Int
}
