//
//  WeatherCoreDataModel+CoreDataProperties.swift
//  EvangelistWeatherApp (iOS)
//
//  Created by Ragul ML on 18/08/22.
//
//

import Foundation
import CoreData


extension WeatherCoreDataModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WeatherCoreDataModel> {
        return NSFetchRequest<WeatherCoreDataModel>(entityName: "WeatherCoreDataModel")
    }

    @NSManaged public var city: String
    @NSManaged public var weather_description: String
    @NSManaged public var weather_min_temp: Double
    @NSManaged public var weather_max_temp: Double
    @NSManaged public var weather_current_lat: Double
    @NSManaged public var weather_current_lon: Double
    @NSManaged public var weather_primary_lat: Double
    @NSManaged public var weather_primary_lon: Double

}

extension WeatherCoreDataModel : Identifiable {

}
