//
//  ApiTimeViewController.swift
//  MonitoreandoElTiempo
//
//  Created by Adrian Bello Cahuantzi on 20/06/23.
//

import Foundation

protocol DateOfClimateOutput: AnyObject {
    func succesResponse(_ model: ResponseWeather)
    func failedResponse(_ message: String)
}



class DateOfClimate: NSObject {
    
    public static let shared = DateOfClimate()
    private override init() {}
    var delegateDateOfClimate: DateOfClimateOutput?


    func doRequest(lat: Double, long: Double) {
        let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(long)&lang=es&appid=14026c3c10b308326f98a32270d14e22&units=metric")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let itemStore = try? JSONDecoder().decode(ResponseWeather.self, from: data) {
                    print(itemStore)
                    self.delegateDateOfClimate?.succesResponse(itemStore)
                } else {
                    print("Invalid Response")
                    
                    self.delegateDateOfClimate?.failedResponse("HTTP Request Failed \(error)")
                }
            }
            
        }
        task.resume()
    }
}





