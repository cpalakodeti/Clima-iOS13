//
//  WeatherManager.swift
//  Clima
//
//  Created by Charithardha Palakodeti on 6/3/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation
import CoreLocation

struct WeatherManager {
    let weatherUrl = "https://api.openweathermap.org/data/2.5/weather?appid=1033f87ba9e22664c9e2663a85289d33&units=metric"
    
    var deligate: WeatherManagerDelegate?
    
    func fetchWeather(cityName:String) {
        let finalUrl = "\(weatherUrl)&q=\(cityName)"
        performRequest(finalUrl)
    }
    
//    func fetchWeather(_ latitude:Double,_ longitude:Double) {
//        let finalUrl = "\(weatherUrl)&lat=\(latitude)&lon=\(longitude)"
//        performRequest(finalUrl)
//    }
    
    func fetchWeather(_ latitude:CLLocationDegrees,_ longitude:CLLocationDegrees) {
        let finalUrl = "\(weatherUrl)&lat=\(latitude)&lon=\(longitude)"
        performRequest(finalUrl)
    }
    
    func performRequest(_ finalUrl: String) {
        
        // Step 1 - Create URL Instance
        if let url = URL(string: finalUrl){
            
            // Step 2 - Create a URL Session
            let session = URLSession(configuration: .default)
            
            // Step 3 - Assign a task to URL Session
            //            let task = session.dataTask(with: url, completionHandler: handle(data:response:error:))
            
            let task = session.dataTask(with: url) { (data, response, error) in
                if(error != nil) {
                    self.deligate?.didFailWithError(error)
                    return
                }
                
                if let safeData = data {
                    if let weather = self.parseJson(weatherData: safeData) {
                        self.deligate?.didUpdateWeather(self, weather)
                    }
                }
            }
            
            // Step 4 - Start the task
            task.resume()
        }
        
        
    }
    
    //    func handle(data:Data?, response:URLResponse?, error:Error?){
    //        if(error != nil) {
    //            print(error!)
    //            return
    //        }
    //
    //        if let safeData = data {
    //            let dataString = String(data: safeData, encoding: .utf8)
    //            print(dataString)
    //        }
    //    }
    
    func parseJson(weatherData : Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do{
            let decodedWeatherData = try decoder.decode(WeatherData.self, from: weatherData)
            return WeatherModel(conditionId: decodedWeatherData.weather[0].id, temperature: decodedWeatherData.main.temp, cityName: decodedWeatherData.name)
            
        } catch {
            deligate?.didFailWithError(error)
            return nil
        }
    }
}

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager,_ weather:WeatherModel)
    func didFailWithError(_ error: Error?)
}
