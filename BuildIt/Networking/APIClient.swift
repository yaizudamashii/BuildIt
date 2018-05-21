//
//  APIClient.swift
//  BuildIt
//
//  Created by Yuki Konda on 5/17/18.
//  Copyright © 2018 Yuki Konda. All rights reserved.
//

import UIKit
import SwiftyJSON
import PromiseKit
import Alamofire
import CoreLocation

class APIClient: NSObject {
    static let apiKey: String = "5e1d9b91b388834941018c85159f8404"
    static let baseForecastsUrl: String = "https://api.openweathermap.org/data/2.5/forecast"
    
    static func imageURL(given forecast: Forecast) -> URL {
        return URL(string: "https://openweathermap.org/img/w/\(forecast.icon).png")!
    }
    
    
    func fetchWeather(for location: CLLocation) -> Promise<ForecastsListResponse> {
        let url: String = APIClient.baseForecastsUrl
        let params: [String: Any] = ["lat": location.coordinate.latitude,
                                     "lon": location.coordinate.longitude,
                                     "appid": APIClient.apiKey]
        
        return Promise<ForecastsListResponse> { seal in
            
            Alamofire.request(url, method: .get, parameters: params).validate().responseJSON(){ response in
                switch response.result {
                    case .success(let json):
                        if let jsonDict = json as? [String: Any] {
                            let jsonObj = JSON(jsonDict)
                            let forecastsListResponse: ForecastsListResponse = ForecastsListResponse(json: jsonObj)
                            seal.fulfill(forecastsListResponse)
                        } else {
                            seal.reject(AFError.responseValidationFailed(reason: .dataFileNil))
                        }
                    case .failure(let error):
                        seal.reject(error)
                }
            }
        }
    }
}
