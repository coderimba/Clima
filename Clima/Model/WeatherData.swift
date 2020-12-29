//
//  WeatherData.swift
//  Clima
//
//  Created by Ervin Ng on 2020-08-03.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

struct WeatherData: Codable {
    let name: String
    let main: Main
    let weather: [Weather] //weather is an array, so represent this by wrapping its type Weather inside []
}

struct Main: Codable {
    let temp: Double
  //  let feels_like: Double
  //  let temp_min: Double
  //  let temp_max: Double
}

struct Weather: Codable {
  //  let description: String
    let id: Int
}
