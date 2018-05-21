//
//  WeatherTableViewCell.swift
//  BuildIt
//
//  Created by Yuki Konda on 5/18/18.
//  Copyright © 2018 Yuki Konda. All rights reserved.
//

import UIKit
import DateTools
import AlamofireImage

class WeatherTableViewCell: UITableViewCell {

    @IBOutlet weak var dayHourLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var tempLabel: UILabel!
    
    func setUp(with forecast: Forecast, tempMode: TempDisplay?) {
        self.dayHourLabel.text = "\(self.dayText(forecast: forecast))\t\(self.hourText(forecast: forecast))"
        self.tempLabel.text = "\(Forecast.tempText(forecast: forecast, tempMode: tempMode))"
        let url: URL = APIClient.imageURL(given: forecast)
        self.weatherImage.af_setImage(withURL: url)
    }
    
    func dayText(forecast: Forecast) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        dateFormatter.timeZone = TimeZone.current
        return dateFormatter.string(from: forecast.time)
    }
    
    func hourText(forecast: Forecast) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h a"
        dateFormatter.timeZone = TimeZone.current
        return dateFormatter.string(from: forecast.time)
    }
}
