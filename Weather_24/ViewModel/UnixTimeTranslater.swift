//
//  UnixTimeTranslater.swift
//  Weather_24
//
//  Created by cmStudent on 2022/03/26.
//

import Foundation

class UnixTimeTranslater: ObservableObject{
    
    let dateFormatter = DateFormatter()
    
    func DayTranslate(unixTime:Int) -> String{
        let dateUnix = TimeInterval(unixTime)
        let date = NSDate(timeIntervalSince1970: dateUnix)
        
        dateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate:"MM/dd", options: 0, locale: Locale(identifier: "ja_jp"))
        let timeString = dateFormatter.string(from: date as Date)
        return timeString
    }
    
    func TimeTranslate(unixTime:Int) -> String{
        let dateUnix = TimeInterval(unixTime)
        let date = NSDate(timeIntervalSince1970: dateUnix)
        
        dateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "HH:mm", options: 0, locale: Locale(identifier: "ja_jp"))
        let timeString = dateFormatter.string(from: date as Date)
        return timeString
    }
}
