//
//  LocationManager.swift
//  BuildIt
//
//  Created by Yuki Konda on 5/19/18.
//  Copyright © 2018 Yuki Konda. All rights reserved.
//

import UIKit
import CoreLocation
class LocationManager: NSObject, CLLocationManagerDelegate {
    private let locManager: CLLocationManager = CLLocationManager()
    var cannotGetLocation: (() -> Void)?
    var didSendLocationAfterRequest: Bool = true
    var didGetLocation: ((_ location: CLLocation) -> Void)?
    
    func requestLocation() {
        self.locManager.delegate = self
        self.locManager.requestWhenInUseAuthorization()
        
        if (CLLocationManager.authorizationStatus() == CLAuthorizationStatus.denied) {
            self.cannotGetLocation?()
            return
        }
        if (CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedWhenInUse ||
            CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedAlways) {
            self.didSendLocationAfterRequest = false
            self.locManager.startUpdatingLocation()
        }
    }
    
    func stopLocationUpdates() {
        self.locManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if (status == .authorizedWhenInUse || status == .authorizedAlways) {
            self.didSendLocationAfterRequest = false
            self.locManager.startUpdatingLocation()
        } else if (status == .denied) {
            self.stopLocationUpdates()
            self.cannotGetLocation?()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if (self.didSendLocationAfterRequest == false) {
            if let location = locations.first {
                self.didGetLocation?(location)
                self.didSendLocationAfterRequest = true
            }
        }
    }
}
