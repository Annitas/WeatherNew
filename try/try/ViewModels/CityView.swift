//
//  CityView.swift
//  try
//
//  Created by Anita Stashevskaya on 03.06.2022.
//

//import Foundation
import CoreLocation
import SwiftUI

final class CityView: ObservableObject {
    @Published var weather = WeatherResponse.empty()
    @Published var city: String = "Omsk" {
        didSet {
            getLocation()
        }
    }
    
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        return formatter
    }()
    
    private lazy var dayFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE"
        return formatter
    }()
    
    private lazy var timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh a"
        return formatter
    }()
    
    init() {
        getLocation()
    }
    
    var date: String {
        return dateFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(weather.current.dt)))
    }
    
    var weatherIcon: String {
        if weather.current.weather.count > 0 {
            return weather.current.weather[0].icon
        }
        return "sun.max.fill"
    }
    
    var temperature: String {
        return getTempFor(temp: weather.current.temp)
    }
    
    var conditions: String {
        if weather.current.weather.count > 0 {
            return weather.current.weather[0].main //?
        }
        return ""
    }
    
    var windSpeed: String {
        return String(format: "%0.1f", weather.current.wind_speed)
    }
    
    var humidity: String {
        return String(format: "%d%%", weather.current.humidity)
    }
    
    var rainChance: String {
        return String(format: "%0.0f%%", weather.current.dew_point)
    }
    
    func getTimeFor(timestamp: Int) -> String {
        return timeFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(timestamp)))
    }
    
    func getTempFor(temp: Double) -> String {
        return String(format: "%0.1f", temp)
    }
    
    //MARK: -DAY
    
    func getDayFor(timestamp: Int) -> String {
        return dayFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(timestamp)))
    }
    
    private func getLocation() {
        CLGeocoder().geocodeAddressString(city) {(placemarks, error) in
            if let places = placemarks, let place = places.first {
                self.getWeather(coord: place.location?.coordinate)
            }
        }
    }
    
    private func getWeather(coord: CLLocationCoordinate2D?) {
        if let coord = coord {
            let urlString = API.getURLFor(lat: coord.latitude, lon: coord.longitude)
            getWeatherInternal(city: city, for: urlString)
        } else {
            let urlString = API.getURLFor(lat: 54.9914, lon: 73.3645)
            getWeatherInternal(city: city, for: urlString)
        }
    }
    
    private func getWeatherInternal(city: String, for urlString: String) {
        NetworkManager<WeatherResponse>.fetch(for: URL(string: urlString)!) { (result) in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self.weather = response
                }
            case .failure(let err):
                print(err)
            }
        }
    }
    
    func getAnimationFor(icon: String) -> String {
        switch icon {
        case "01d":
            return "sun.max.fill"
        case "01n":
            return "moon.fill"
        case "02d":
            return "cloud.sun.fill"
        case "02n":
            return "cloud.moon.fill"
        case "03d":
            return "smoke.fill"
        case "03n":
            return "cloud.moon.fill"
        case "04d":
            return "cloud.fill"
        case "04n":
            return "cloud.moon.fill"
        case "09d":
            return "cloud.heavyrain.fill"
        case "09n":
            return "cloud.moon.rain.fill"
        case "10d":
            return "cloud.sun.rain.fill"
        case "10n":
            return "cloud.rain.fill"
        case "11d":
            return "cloud.bolt.rain.fill"
        case "11n":
            return "cloud.moon.bolt.fill"
        case "13d":
            return "cloud.snow.fill"
        case "13n":
            return "cloud.snow.fill"
        case "50d":
            return "smoke.fill"
        case "50n":
            return "smoke.fill"
        default:
            return "sun.max.fill"
        }
    }
    
    func getWeatherIconFor(icon: String) -> Image {
        switch icon {
            case "01d":
                return Image(systemName: "sun.max.fill")
            case "01n":
                return Image(systemName: "moon.fill")
            case "02d":
                return Image(systemName: "cloud.sun.fill")
            case "02n":
                return Image(systemName: "cloud.moon.fill")
            case "03d":
                return Image(systemName: "smoke.fill")
            case "03n":
                return Image(systemName: "cloud.moon.fill")
            case "04d":
                return Image(systemName: "cloud.fill")
            case "04n":
                return Image(systemName: "cloud.moon.fill")
            case "09d":
                return Image(systemName: "cloud.heavyrain.fill")
            case "09n":
                return Image(systemName: "cloud.moon.rain.fill")
            case "10d":
                return Image(systemName: "cloud.sun.rain.fill")
            case "10n":
                return Image(systemName: "cloud.rain.fill")
            case "11d":
                return Image(systemName: "cloud.bolt.rain.fill")
            case "11n":
                return Image(systemName: "cloud.moon.bolt.fill")
            case "13d":
                return Image(systemName: "cloud.snow.fill")
            case "13n":
                return Image(systemName: "cloud.snow.fill")
            case "50d":
                return Image(systemName: "smoke.fill")
            case "50n":
                return Image(systemName: "smoke.fill")
            default:
                return Image(systemName: "sun.max.fill")
        }
    }
}
