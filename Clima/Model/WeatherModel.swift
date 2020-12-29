//
//  WeatherModel.swift
//  Clima
//
//  Created by Ervin Ng on 2020-08-03.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

struct WeatherModel {
    let conditionId: Int
    let cityName: String
    let temperature: Double
    //these 3 properties are stored properties
    
    //computed property
    var temperatureString: String {
        return String(format: "%.1f", temperature)
    }
    
    //computed property
    var conditionName: String {
        switch conditionId {
        case 200...202: return "cloud.bolt.rain"
        case 210...221: return "cloud.bolt"
        case 230...232: return "cloud.bolt.rain"
        case 300...321: return "cloud.drizzle"
        case 500...501: return "cloud.rain"
        case 502...511: return "cloud.heavyrain"
        case 520...521: return "cloud.rain"
        case 522: return "cloud.heavyrain"
        case 531: return "cloud.rain"
        case 600...602: return "snow"
        case 611...616: return "cloud.sleet"
        case 620...622: return "cloud.snow"
        case 701: return "cloud.fog"
        case 711: return "smoke"
        case 721: return "sun.haze"
        case 731: return "sun.dust"
        case 741: return "cloud.fog"
        case 751...761: return "sun.dust"
        case 762: return "smoke"
        case 771: return "wind.snow"
        case 781: return "tornado"
        case 800: return "sun.max"
        case 801...804: return "cloud"
        default: return "sun.max"
        }
    }
}
