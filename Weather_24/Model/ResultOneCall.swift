//
//  ResultOneCall.swift
//  Weather_24
//
//  Created by cmStudent on 2022/03/09.
//

import Foundation

struct Welcome: Decodable {
    let lat, lon: Double
    let timezone: String
    let timezoneOffset: Int
    let current: Current
    let minutely: [Minutely]
    let hourly: [Current]
    struct Current: Decodable {
        let dt: Int
        let sunrise, sunset: Int?
        let temp, feelsLike: Double
        let pressure, humidity: Int
        let dewPoint, uvi: Double
        let clouds, visibility: Int
        let windSpeed: Double
        let windDeg: Int
        let weather: [Weather]
        let windGust, pop: Double?

        enum CodingKeys: String, CodingKey {
            case dt, sunrise, sunset, temp
            case feelsLike = "feels_like"
            case pressure, humidity
            case dewPoint = "dew_point"
            case uvi, clouds, visibility
            case windSpeed = "wind_speed"
            case windDeg = "wind_deg"
            case weather
            case windGust = "wind_gust"
            case pop
        }
    }
    let daily: [Daily]
    struct Daily: Decodable {
        let dt, sunrise, sunset, moonrise: Int
        let moonset: Int
        let moonPhase: Double
        let temp: Temp
        let feelsLike: FeelsLike
        let pressure, humidity: Int
        let dewPoint, windSpeed: Double
        let windDeg: Int
        let windGust: Double
        let weather: [Weather]
        let clouds: Int
        let pop, uvi: Double
        let rain: Double?

        enum CodingKeys: String, CodingKey {
            case dt, sunrise, sunset, moonrise, moonset
            case moonPhase = "moon_phase"
            case temp
            case feelsLike = "feels_like"
            case pressure, humidity
            case dewPoint = "dew_point"
            case windSpeed = "wind_speed"
            case windDeg = "wind_deg"
            case windGust = "wind_gust"
            case weather, clouds, pop, uvi, rain
        }
    }

    enum CodingKeys: String, CodingKey {
        case lat, lon, timezone
        case timezoneOffset = "timezone_offset"
        case current, minutely, hourly, daily
    }
}

struct Weather: Codable {
    let id: Int
    let main: Main
    let weatherDescription: Description
    let icon: String

    enum CodingKeys: String, CodingKey {
        case id, main
        case weatherDescription = "description"
        case icon
    }
}

struct Minutely: Codable {
    let dt: Int
    let precipitation: Double
}


struct Temp: Codable {
    let day, min, max, night: Double
    let eve, morn: Double
}

struct FeelsLike: Codable {
    let day, night, eve, morn: Double
}

enum Main: String, Codable {
    case clear = "Clear"
    case clouds = "Clouds"
    case rain = "Rain"
}

enum Description: String, Codable {
    case 厚い雲 = "厚い雲"
    case 小雨 = "小雨"
    case 晴天 = "晴天"
    case 曇りがち = "曇りがち"
    case 薄い雲 = "薄い雲"
    case 雲 = "雲"
}
