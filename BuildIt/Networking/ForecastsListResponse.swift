//
//  WeatherListResponse.swift
//  BuildIt
//
//  Created by Yuki Konda on 5/17/18.
//  Copyright © 2018 Yuki Konda. All rights reserved.
//

import UIKit
import SwiftyJSON

struct ForecastsListResponse {

    let forecasts: [Forecast]
    let city: String
    
    init(json: JSON) {
        self.city = json["city"]["name"].stringValue
        self.forecasts = json["list"].map({
            (key: String, child: JSON) -> Forecast in
            return Forecast(json: child)
        })
    }
}
