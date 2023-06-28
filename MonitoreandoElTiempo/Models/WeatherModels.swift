//
//  WeatherModels.swift
//  MonitoreandoElTiempo
//
//  Created by Adrian Bello Cahuantzi on 27/06/23.
//

import Foundation

struct ResponseWeather: Codable {
    let coord: Coord
    let weather: [Weather]
    let main: Main
    let visibility: Int
    let wind: Wind
    let sys: Sys
    let name: String
    
}

struct Coord: Codable {
    let lon: Double
    let lat: Double
}
struct Weather: Codable {
    let description: String
}
struct Main: Codable {
    let temp: Double
    let humidity: Int
    
}

struct Wind: Codable {
    let speed: Double
}

struct Sys: Codable {
    let country: String
    let sunrise: Int
    let sunset: Int
}

struct modelAmanecerAtardecer {
    let titleModel: String
    let hourString: String
}
