//
//  ResultModel.swift
//  Weather_24
//
//  Created by cmStudent on 2022/01/06.
//

import Foundation

struct Request{
    let lat: String
    let lon: String
    let appid: String
    let exclude: String?
    let units: String?
    let lang: String?
    
    init (lat: String, lon: String, appid: String, exclude: String? = "", units: String? = "metric", lang: String? = "ja"){
        
        self.lat = lat
        self.lon = lon
        self.appid = appid
        self.exclude = exclude
        self.units = units
        self.lang = lang
    }
}


/// レスポンス用(json)
struct ResultOneCall: Decodable {
    // 逆ジオ用
    let lat: Double
    let lon: Double
    let timezone: String
    
    let hourly: [Current]
    let minutely:[Minutely]
    struct Current:Decodable{
        let dt: Int
        let sunrise, sunset: Int?
        let temp, feelsLike: Double
        let pressure, humidity: Int
        let dewPoint, uvi: Double
        let clouds, visibility: Int
        let windSpeed: Double
        let windDeg: Int
        let windGust: Double
        let weather: [Weather]
        let pop: Double?
        
        enum CodingKeys: String, CodingKey {
            case dt, sunrise, sunset, temp
            case feelsLike = "feels_like"
            case pressure, humidity
            case dewPoint = "dew_point"
            case uvi, clouds, visibility
            case windSpeed = "wind_speed"
            case windDeg = "wind_deg"
            case windGust = "wind_gust"
            case weather, pop
        }
    }
    
    struct Weather: Decodable {
        let id: Int
        let main: String
        let weatherDescription: String
        let icon: String
        
        enum CodingKeys: String, CodingKey {
            case id, main
            case weatherDescription = "description"
            case icon
        }
    

        enum Description: String, Codable {
            case 厚い雲 = "厚い雲"
            case 晴天 = "晴天"
            case 曇りがち = "曇りがち"
            case 薄い雲 = "薄い雲"
            case 雲 = "曇"
        }
    }
    
    let daily:[Daily]
    struct Daily: Decodable {
        let dt: Int
        let sunrise, sunset, moonrise: Int
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
            case weather, clouds, pop, uvi
        }
    }
    
    struct Minutely:Decodable {
        let dt: Int
        let precipitation: Double
    }
    
    struct FeelsLike: Decodable {
        let day, night, eve, morn: Double
    }
    
    struct Temp: Decodable {
        let day, min, max, night: Double
        let eve, morn: Double
    }
    
}

struct WeatherItem:Hashable{
    //時間
    //        let dt:Double!
    //気温
    let temp: String
    //湿度
    let humidity: String
    //天気
    /*let description: String?
     //気圧
     let pressure:Int?*/
}

struct OneCallJSON:Decodable{
    var list:[ResultOneCall]
}
