//
//  LandingModel.swift
//  EvangelistWeatherApp (iOS)
//
//  Created by Ragul ML on 16/08/22.
//

import Foundation

struct WeatherModel: Codable, Identifiable {
    let id: Int
    let name: String
    let coord: CoordModel?
    var weather: [Weather]
    let main: TemperatureModel?
}

struct Weather: Codable {
    let id: Int
    var main: String
    let description: String
    let icon: String
}

struct TemperatureModel: Codable {
    let temp_min: Double
    let temp_max: Double
}

struct CoordModel: Codable {
    let lon: Double
    let lat: Double
}

struct CoordinatesList {
    let coordinates: [Coordinates]
}

struct Coordinates {
    let id = UUID()
    let lat: String
    let lon: String
}
