//
//  APIProvider.swift
//  EvangelistWeatherApp (iOS)
//
//  Created by Ragul ML on 17/08/22.
//

import Foundation
import Combine

class APIProvider: WeatherService {
    
    var cancellables = Set<AnyCancellable>()
    var weatherDataModel = [WeatherModel]()
    weak var provider: UpdateWeatherProvider?
    
    init(provider: UpdateWeatherProvider) {
        self.provider = provider
    }
    
    func getWeather(coordinates: Coordinates) {
        let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(coordinates.lat)&lon=\(coordinates.lon)&appid=c504187429eefa5029bb944240d08f8d"
        guard let url = URL(string: urlString) else {
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .receive(on: DispatchQueue.main)
            .tryMap({ (data, response) -> Data in
                guard
                    let response = response as? HTTPURLResponse,
                    response.statusCode >= 200 else {
                        throw URLError(.badServerResponse)
                    }
                
                return data
            })
            .decode(type: WeatherModel.self, decoder: JSONDecoder())
            .collect()
            .sink(receiveCompletion: { (completion) in
                print("Completion:", completion)
            }, receiveValue: { (weatherData) in
                if let val = weatherData.first {
                    self.weatherDataModel.append(val)
                }
                if self.provider?.coordinateListCount == self.weatherDataModel.count {
                    self.provider?.updateWeatherDetails(data: self.weatherDataModel)
                }
            })
            .store(in: &cancellables)
    }
    
}
