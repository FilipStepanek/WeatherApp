//
//  WeatherManagerExtension.swift
//  AppleWeatherSwift
//
//  Created by Filip Štěpánek on 18.01.2024.
//

import Foundation
import SwiftUI

class WeatherManagerExtension {
    
    // MARK: - Geting image name for forecast icon
    func getImageNameForWeatherIcon(icon: String) -> String {
        switch icon {
        case "01d":
            return "ForecastSun"
        case "01n":
            return "ForecastMoon"
        case "02d":
            return "ForecastFewCloudsSun"
        case "02n":
            return "ForecastFewCloudsMoon"
        case "03d":
            return "ForecastCloudy"
        case "03n":
            return "ForecastCloudy"
        case "04d":
            return "ForecastCloudy"
        case "04n":
            return "ForecastCloudy"
        case "09d":
            return "ForecastShowersLight"
        case "09n":
            return "ForecastShowersLight"
        case "10d":
            return "ForecastRain"
        case "10n":
            return "ForecastRain"
        case "11d":
            return "ForecastThunderstorm"
        case "11n":
            return "ForecastThunderstorm"
        case "13d":
            return "ForecastSnow"
        case "13n":
            return "ForecastSnow"
        case "50d":
            return "ForecastMist"
        case "50n":
            return "ForecastMist"
        default:
            return "defaultImage"
        }
    }
    
    // MARK: - Getting image name for forecast icon
    func getImageNameForForecastIcon(icon: String) -> String {
        switch icon {
        case "01d":
            return "ForecastSun"
        case "01n":
            return "ForecastMoon"
        case "02d":
            return "ForecastFewCloudsSun"
        case "02n":
            return "ForecastFewCloudsMoon"
        case "03d":
            return "ForecastCloudy"
        case "03n":
            return "ForecastCloudy"
        case "04d":
            return "ForecastCloudy"
        case "04n":
            return "ForecastCloudy"
        case "09d":
            return "ForecastShowersLight"
        case "09n":
            return "ForecastShowersLight"
        case "10d":
            return "ForecastRain"
        case "10n":
            return "ForecastRain"
        case "11d":
            return "ForecastThunderstorm"
        case "11n":
            return "ForecastThunderstorm"
        case "13d":
            return "ForecastSnow"
        case "13n":
            return "ForecastSnow"
        case "50d":
            return "ForecastMist"
        case "50n":
            return "ForecastMist"
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
    
    func getColor1(icon: String) -> Color {
        switch icon {
        case "01d":
            return .sun1
        case "10d":
            return .rain1
        case "04d":
            return .cloudy1
        default:
            return .default1
        }
    }
    
    func getColor2(icon: String) -> Color {
        switch icon {
        case "01d":
            return .sun2
        case "10d":
            return .rain2
        case "04d":
            return .cloudy2
        default:
            return .default2
        }
    }
}
