//
//  ViewController.swift
//  BuildIt
//
//  Created by Yuki Konda on 5/17/18.
//  Copyright © 2018 Yuki Konda. All rights reserved.
//

import UIKit
import PromiseKit
import CoreLocation

class ViewController: UIViewController {
    static let cellIdentifier: String = "forecastCell"
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    var dataProvider: WeatherDataProvider = WeatherDataProvider()
    var locationManager: LocationManager = LocationManager()
    var settingsManager: SettingsManager = SettingsManager()
    @IBOutlet weak var CFButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.tableView.register(UINib(nibName: "WeatherTableViewCell", bundle: nil), forCellReuseIdentifier: ViewController.cellIdentifier)
        self.dataProvider.tableView = self.tableView
        self.tableView.dataSource = self.dataProvider
        self.tableView.delegate = self.dataProvider
        self.dataProvider.settingsManager = self.settingsManager
        
        self.title = "Five Day Weather"
        let refreshButton =  UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.refresh, target: self, action: #selector(ViewController.requestLocation))
        self.navigationItem.rightBarButtonItem = refreshButton
        self.CFButton.title = self.settingsManager.buttonText()
        
        self.locationManager.cannotGetLocation = { [weak self] in
            self?.displayNeedLocationAlert()
        }
        self.locationManager.didGetLocation = { [weak self] (location: CLLocation) in
            self?.resetData(location: location)
        }
        self.requestLocation()
    }

    @objc func requestLocation() {
        self.locationManager.requestLocation()
    }
    
    func displayNeedLocationAlert() {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Cannot get location", message: "Please let the app use your current location to get local weather data.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Settings", style: .default, handler: { action -> Void in
                if let settingsURL = URL(string: UIApplicationOpenSettingsURLString) {
                    UIApplication.shared.open(settingsURL, options: [:], completionHandler: nil)
                }
            }))
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
            self.present(alert, animated: true)
        }
    }
    
    func resetData(location: CLLocation) {
        self.locationManager.stopLocationUpdates()
        firstly { () -> Promise<Void> in
            DispatchQueue.main.async {
                self.activityIndicatorView.startAnimating()
                UIApplication.shared.isNetworkActivityIndicatorVisible = true
            }
            return Promise()
        }.then(on: DispatchQueue.global(qos: .userInitiated)) { _ -> Promise<Void> in
            return self.dataProvider.resetForecasts(location: location)
        }.ensure(on: DispatchQueue.main) {
            self.activityIndicatorView.stopAnimating()
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
        }.catch(on: DispatchQueue.main) { error -> Void in
            let alert = UIAlertController(title: "Fetching weather forecasts failed", message: "Please check your internet connection and try again", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
            self.present(alert, animated: true)
        }
    }
    
    @IBAction func didTapCFButton(_ sender: UIBarButtonItem) {
        self.settingsManager.toggleTempDisplay()
        self.CFButton.title = self.settingsManager.buttonText()
        self.dataProvider.tableView?.reloadData()
    }
}

