//
//  WeatherDataProvider.swift
//  BuildIt
//
//  Created by Yuki Konda on 5/17/18.
//  Copyright © 2018 Yuki Konda. All rights reserved.
//

import UIKit
import PromiseKit
import CoreLocation

class WeatherDataProvider: NSObject {
    
    let apiClient = APIClient()
    var response: ForecastsListResponse?
    weak var tableView: UITableView?
    var settingsManager: SettingsManager?
    
    func resetForecasts(location: CLLocation) -> Promise<Void> {
         return firstly { () -> Promise<Void> in
                    self.response = nil
                    DispatchQueue.main.async {
                        self.tableView?.reloadData()
                    }
                    return Promise()
                }.then(on: DispatchQueue.global(qos: .userInitiated)) { _ -> Promise<ForecastsListResponse> in
                    return self.apiClient.fetchWeather(for: location)
                }.map(on: DispatchQueue.main) { weatherResponse -> Void in
                    self.response = weatherResponse
                    self.insertForecastsInTableView(weatherResponse)
                }
    }
    
    func insertForecastsInTableView(_ response: ForecastsListResponse) {
        let section = 0
        var indexPaths = [IndexPath]()
        for (index, _) in response.forecasts.enumerated() {
            if (index == 0) {
                continue
            }
            let path = IndexPath(row: index-1, section: section)
            indexPaths.append(path)
        }
        self.tableView?.insertRows(at: indexPaths, with: .automatic)
    }
}

extension WeatherDataProvider: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let response: ForecastsListResponse = self.response {
            return max(0, response.forecasts.count - 1)
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ViewController.cellIdentifier, for: indexPath) as? WeatherTableViewCell else { return UITableViewCell() }
        if let forecast: Forecast = self.response?.forecasts[indexPath.row + 1] {
            cell.setUp(with: forecast, tempMode: self.settingsManager?.tempDisplayMode)
        }
        return cell
    }
}

extension WeatherDataProvider: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let response: ForecastsListResponse = self.response {
            if let forecast: Forecast = response.forecasts.first {
                let currentWeatherView: WeatherHeaderView = Bundle.main.loadNibNamed("WeatherHeaderView", owner: self, options: nil)!.first as! WeatherHeaderView
                currentWeatherView.setForecast(forecast: forecast, cityName: response.city, tempMode: self.settingsManager?.tempDisplayMode)
                return currentWeatherView
            }
        }
        return nil
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if let response: ForecastsListResponse = self.response {
            if let _ = response.forecasts.first {
                return 162.0
            }
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
