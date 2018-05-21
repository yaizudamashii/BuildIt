//
//  TestForecast.swift
//  BuildItTests
//
//  Created by Yuki Konda on 5/19/18.
//  Copyright © 2018 Yuki Konda. All rights reserved.
//

import XCTest
import SwiftyJSON
@testable import BuildIt

class TestForecast: XCTestCase {
    
    func testTempText() {
        let dic: [String: Any] = [
            "dt": 100,
            "main": ["temp": 283.15],
            "weather": [["description": "today's weather",
                         "icon": "weather_icon"]]
        ]
        let json: JSON = JSON(dic)
        let forecast: Forecast = Forecast(json: json)
        XCTAssertEqual(Forecast.tempText(forecast: forecast, tempMode: .Celcius), "10°C")
        XCTAssertEqual(Forecast.tempText(forecast: forecast, tempMode: .Fahrenheit), "50°F")
    }
    
    func testInit() {
        let dic: [String: Any] = [
            "dt": 100,
            "main": ["temp": 283.15],
            "weather": [["description": "today's weather",
                         "icon": "weather_icon"]]
        ]
        let json: JSON = JSON(dic)
        let forecast: Forecast = Forecast(json: json)
        XCTAssertEqual(forecast.time, Date(timeIntervalSince1970: 100.0))
        XCTAssertEqual(forecast.temperature, 283.15)
        XCTAssertEqual(forecast.displayWeather, "today's weather")
        XCTAssertEqual(forecast.icon, "weather_icon")
    }
}
