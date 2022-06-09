//
//  APIExtensions.swift
//  try
//
//  Created by Anita Stashevskaya on 03.06.2022.
//

import Foundation

extension API {
    static let BaseURLString = "https://api.openweathermap.org/data/2.5/"
    
    static func getURLFor(lat: Double, lon: Double) -> String {
        return "\(BaseURLString)onecall?lat=\(lat)&lon=\(lon)&exclude=minutely&appid=\(key)&units=imperial"
    }
}
//onecall?lat=37.5485&lon=-121.9886&exclude=minutely&appid=d2b758466054981c7a9596f7549c12be&units=metric
