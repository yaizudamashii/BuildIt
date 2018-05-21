//
//  WeatherHeaderView.swift
//  BuildIt
//
//  Created by Yuki Konda on 5/18/18.
//  Copyright © 2018 Yuki Konda. All rights reserved.
//

import UIKit

class WeatherHeaderView: UIView {

    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var cityNamLabel: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    func setForecast(forecast: Forecast, cityName: String, tempMode: TempDisplay?) {
        self.cityNamLabel.text = cityName
        self.weatherLabel.text = forecast.displayWeather
        self.temperatureLabel.text = "\(Forecast.tempText(forecast: forecast, tempMode: tempMode))"
        self.weatherImage.af_setImage(withURL: APIClient.imageURL(given: forecast))
    }
}
