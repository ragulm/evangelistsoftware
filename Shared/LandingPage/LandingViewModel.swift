//
//  LandingListModel.swift
//  EvangelistWeatherApp (iOS)
//
//  Created by Ragul ML on 16/08/22.
//

import Foundation
import Combine
import CoreData
import SwiftUI

protocol WeatherService {
    func getWeather(coordinates: Coordinates)
}

protocol UpdateWeatherProvider: AnyObject {
    var coordinateListCount: Int { get }
    func updateWeatherDetails(data: [WeatherModel])
}

class LandingViewModel: ObservableObject {
    @Published var weatherData: [WeatherCoreDataModel] = [WeatherCoreDataModel]()
    
    //    @Environment(\.managedObjectContext) var moc
    let persistenceControllerViewContext = PersistenceController.shared.container.viewContext
    
    @FetchRequest(entity: WeatherCoreDataModel.entity(), sortDescriptors: []) var weatherLocalData: FetchedResults<WeatherCoreDataModel>
    
    let coordinateList: CoordinatesList = CoordinatesList(coordinates: [Coordinates(lat: "11.273354", lon: "76.656517"), Coordinates(lat: "11.343730", lon: "76.793850"), Coordinates(lat: "11.406414", lon: "76.693245"), Coordinates(lat: "11.222806", lon: "76.664879"), Coordinates(lat: "11.245150", lon: "76.702810"), Coordinates(lat: "11.354720", lon: "76.800247"), Coordinates(lat: "12.295810", lon: "76.639381")])
    
    var weatherServices: WeatherService?
    
    init() {
        weatherServices = APIProvider(provider: self)
    }
    
    func validateWeatherDataExists() -> Bool {
        let request = WeatherCoreDataModel.fetchRequest()
        request.predicate = NSPredicate(format: "weather_primary_lat == %f", 11.0)
        do {
            let result = try persistenceControllerViewContext.fetch(request)
            if !result.isEmpty {
                self.weatherData = result
                return true
            } else {
                return false
            }
        } catch {
            print(error)
        }
        return false
    }
    
    
    func makeWeatherRequest() {
        if !self.validateWeatherDataExists() {
            for item in self.coordinateList.coordinates {
                weatherServices?.getWeather(coordinates: item)
            }
        }
    }
}

extension LandingViewModel: UpdateWeatherProvider {
    var coordinateListCount: Int {
        self.coordinateList.coordinates.count
    }
    
    func updateWeatherDetails(data: [WeatherModel]) {
        
        var weatherList = [WeatherCoreDataModel]()
        for item in data {
            let weather = WeatherCoreDataModel(context: persistenceControllerViewContext)
            weather.city = item.name
            weather.weather_max_temp = item.main?.temp_max ?? 0.0
            weather.weather_min_temp = item.main?.temp_min ?? 0.0
            weather.weather_description = item.weather.first?.description ?? "-"
            weather.weather_current_lat = item.coord?.lat ?? 0.0
            weather.weather_current_lon = item.coord?.lon ?? 0.0
            weather.weather_primary_lat = 11.0
            weather.weather_primary_lon = 76.0
            weatherList.append(weather)
            do {
                try persistenceControllerViewContext.save()
            } catch {
                print(error.localizedDescription)
            }
        }
        self.weatherData = weatherList
    }
}
