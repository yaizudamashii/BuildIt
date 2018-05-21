//
//  TestForecastsListResponse.swift
//  BuildItTests
//
//  Created by Yuki Konda on 5/19/18.
//  Copyright © 2018 Yuki Konda. All rights reserved.
//

import XCTest
import SwiftyJSON
@testable import BuildIt

class TestForecastsListResponse: XCTestCase {
    
    func testInit() {
        let dic: [String: Any] = [
            "city": ["name": "My City"],
            "list": [[
                "dt": 100,
                "main": ["temp": 283.15],
                "weather": [["description": "today's weather",
                             "icon": "weather_icon"]]
            ]]
        ]
        let json: JSON = JSON(dic)
        let forecasts: ForecastsListResponse = ForecastsListResponse(json: json)
        XCTAssertEqual(forecasts.city, "My City")
        XCTAssertEqual(forecasts.forecasts.count, 1)
    }
}
