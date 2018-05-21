//
//  Weather.swift
//  BuildIt
//
//  Created by Yuki Konda on 5/17/18.
//  Copyright © 2018 Yuki Konda. All rights reserved.
//


import Foundation
import SwiftyJSON

struct Forecast {
    let displayWeather: String
    let icon: String
    let temperature: Double
    let time: Date
    
    static func tempText(forecast: Forecast, tempMode: TempDisplay?) -> String {
        if (tempMode == .Celcius) {
            return "\(Int(round(forecast.temperature - 273.15)))°C"
        } else if (tempMode == .Fahrenheit ) {
            return "\(Int(round(forecast.temperature * 9 / 5 - 459.67)))°F"
        } else {
            return "\(Int(round(forecast.temperature)))K"
        }
    }
    
    init(json: JSON) {
        self.time = Date(timeIntervalSince1970: json["dt"].doubleValue)
        self.temperature = json["main"]["temp"].doubleValue
        self.displayWeather = json["weather"].arrayValue[0]["description"].stringValue
        self.icon = json["weather"].arrayValue[0]["icon"].stringValue
    }
}
