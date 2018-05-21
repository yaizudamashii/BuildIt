//
//  SettigsManager.swift
//  BuildIt
//
//  Created by Yuki Konda on 5/19/18.
//  Copyright © 2018 Yuki Konda. All rights reserved.
//

import UIKit

enum TempDisplay {
    case Celcius
    case Fahrenheit
}
class SettingsManager: NSObject {
    var tempDisplayMode: TempDisplay = .Celcius
    
    func buttonText() -> String {
        if (self.tempDisplayMode == .Celcius) {
            return "°C"
        } else {
            return "°F"
        }
    }
    
    func toggleTempDisplay() {
        if (self.tempDisplayMode == .Celcius) {
            self.tempDisplayMode = .Fahrenheit
        } else {
            self.tempDisplayMode = .Celcius
        }
    }
}
