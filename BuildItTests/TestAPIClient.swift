//
//  TestAPIClient.swift
//  BuildItTests
//
//  Created by Yuki Konda on 5/19/18.
//  Copyright © 2018 Yuki Konda. All rights reserved.
//

import XCTest
import SwiftyJSON
@testable import BuildIt

class TestAPIClient: XCTestCase {
    
    func testImageURL() {
        let dic: [String: Any] = [
            "dt": 100,
            "main": ["temp": 100],
            "weather": [["description": "today's weather",
                         "icon": "weather_icon"]]
        ]
        let json: JSON = JSON(dic)
        let forecast: Forecast = Forecast(json: json)
        XCTAssertEqual(APIClient.imageURL(given: forecast), URL(string: "https://openweathermap.org/img/w/weather_icon.png")!)
    }
    
}
