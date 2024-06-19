//
//  WeatherManagerExtension.swift
//  WeatherAppWidgetsExtension
//
//  Created by Filip Štěpánek on 19.02.2024.
//

import Foundation
import SwiftUI

class WeatherManagerExtensionWidget {
    
    // MARK: - Getting image name from current weather icon
    func getImageNameFromWeatherIcon(icon: String) -> String {
        switch icon {
        case "01d":
            return "todaySun"
        case "01n":
            return "todayMoon"
        case "02d":
            return "todayFewCloudsSun"
        case "02n":
            return "todayFewCloudsMoon"
        case "03d":
            return "todayCloudy"
        case "03n":
            return "todayCloudy"
        case "04d":
            return "todayCloudy"
        case "04n":
            return "todayCloudy"
        case "09d":
            return "todayShowers"
        case "09n":
            return "todayShowers"
        case "10d":
            return "todayRain"
        case "10n":
            return "todayRain"
        case "11d":
            return "todayThunderstorm"
        case "11n":
            return "todayThunderstorm"
        case "13d":
            return "todaySnow"
        case "13n":
            return "todaySnow"
        case "50d":
            return "todayMist"
        case "50n":
            return "todayMist"
        default:
            return "defaultImage"
        }
    }
    
    // MARK: - Getting image name from forecast icon
    func getImageNameFromForecastIcon(icon: String) -> String {
        switch icon {
        case "01d":
            return "forecastSun"
        case "01n":
            return "forecastMoon"
        case "02d":
            return "forecastFewCloudsSun"
        case "02n":
            return "forecastFewCloudsMoon"
        case "03d":
            return "forecastCloudy"
        case "03n":
            return "forecastCloudy"
        case "04d":
            return "forecastCloudy"
        case "04n":
            return "forecastCloudy"
        case "09d":
            return "forecastShowersLight"
        case "09n":
            return "forecastShowersLight"
        case "10d":
            return "forecastRain"
        case "10n":
            return "forecastRain"
        case "11d":
            return "forecastThunderstorm"
        case "11n":
            return "forecastThunderstorm"
        case "13d":
            return "forecastSnow"
        case "13n":
            return "forecastSnow"
        case "50d":
            return "forecastMist"
        case "50n":
            return "forecastMist"
        default:
            return "defaultImage"
        }
    }
    
    // MARK: - Getting weather info from weather icon
    func getWeatherInfoFromWeatherIcon(icon: String, temperature: Double) -> String {
        switch icon {
        case "01d":
            if temperature > 30 {
                return String(localized: "hot.message")
            } else {
                return String(localized: "day.clear.sky.message")
            }
        case "01n":
            return String(localized: "night.clear.sky.message")
        case "02d":
            return String(localized: "few.clouds.message")
        case "02n":
            return String(localized: "few.clouds.message")
        case "03d":
            return String(localized: "cloudy.message")
        case "03n":
            return String(localized: "cloudy.message")
        case "04d":
            return String(localized: "cloudy.message")
        case "04n":
            return String(localized: "cloudy.message")
        case "09d":
            return String(localized: "showers.message")
        case "09n":
            return String(localized: "showers.message")
        case "10d":
            return String(localized: "rainy.message")
        case "10n":
            return String(localized: "rainy.message")
        case "11d":
            return String(localized: "thunderstorm.message")
        case "11n":
            return String(localized: "thunderstorm.message")
        case "13d":
            return String(localized: "snow.message")
        case "13n":
            return String(localized: "snow.message")
        case "50d":
            return String(localized: "fog.message")
        case "50n":
            return String(localized: "fog.message")
        default:
            return String(localized: "no.info.current.weather")
        }
    }
    
    // MARK: - Getting weather info from forecast icon
    func getWeatherInfoFromForecastIcon(icon: String) -> String {
        switch icon {
        case "01d":
            return String(localized: "forecast.sun.message")
        case "01n":
            return String(localized: "forecast.moon.message")
        case "02d":
            return String(localized: "forecast.scattered.clouds.message")
        case "02n":
            return String(localized: "forecast.scattered.clouds.message")
        case "03d":
            return String(localized: "forecast.cloudy.message")
        case "03n":
            return String(localized: "forecast.cloudy.message")
        case "04d":
            return String(localized: "forecast.cloudy.message")
        case "04n":
            return String(localized: "forecast.cloudy.message")
        case "09d":
            return String(localized: "forecast.rain.showers.message")
        case "09n":
            return String(localized: "forecast.rain.showers.message")
        case "10d":
            return String(localized: "forecast.rain.message")
        case "10n":
            return String(localized: "forecast.rain.message")
        case "11d":
            return String(localized: "forecast.thunderstorm.message")
        case "11n":
            return String(localized: "forecast.thunderstorm.message")
        case "13d":
            return String(localized: "forecast.snowing.message")
        case "13n":
            return String(localized: "forecast.snowing.message")
        case "50d":
            return String(localized: "forecast.mist.message")
        case "50n":
            return String(localized: "forecast.mist.message")
        default:
            return String(localized: "forecast.no.info.current.weather")
        }
    }
}
