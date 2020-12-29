//
//  WeatherManager.swift
//  Clima
//
//  Created by Ervin Ng on 2020-08-01.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}

struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?&units=metric&appid=694b64b0b6bebf5a17c9990438995a63"
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(with: urlString)
    }
    
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        //1. Create a URL
        
        if let url = URL(string: urlString) {
            //2. Create a URLSession
            
            let session = URLSession(configuration: .default) //creates the browser (the thing that performs the networking)
            
            //3. Give the session a task
            
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return //exit out of this function
                }
                
                if let safeData = data {
                    /*let dataString = String(data: safeData, encoding: .utf8) //.utf8 is a standardised protocol for encoding texts from websites
                    print(dataString)*/
                    if let weather = self.parseJSON(safeData) {
                        self.delegate?.didUpdateWeather(self, weather: weather)
                    }
                }
            }
            //completionHandler will be triggered by the task; when the session completes its networking and the task is complete, the task is the one that will call the completionHandler. The completionHandler will pass those 3 arguments to the handle func so long as it has them. Effectively, we are leaving it to the task to trigger the handle function and once it does, the handle function will have access to the data, response, and error objects that the task sends over
            
            //4. Start the task
            task.resume()
        }
    }
    
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData) //add .self after WeatherData to represent the WeatherData data type (otherwise you'll be representing the WeatherData object)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            
            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp)
            return weather
        //    print(decodedData.main.feels_like)
        //    print(decodedData.main.temp_min)
        //    print(decodedData.main.temp_min)
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
    
}
