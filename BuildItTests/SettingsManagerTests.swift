//
//  SettingsManagerTests.swift
//  BuildItTests
//
//  Created by Yuki Konda on 5/19/18.
//  Copyright © 2018 Yuki Konda. All rights reserved.
//

import XCTest
@testable import BuildIt

class SettingsManagerTests: XCTestCase {
    
    func testButtonText() {
        let manager: SettingsManager = SettingsManager()
        manager.tempDisplayMode = .Celcius
        XCTAssert(manager.buttonText() == "°C")
        manager.tempDisplayMode = .Fahrenheit
        XCTAssert(manager.buttonText() == "°F")
    }
    
    func testToggleTempModeDisplay() {
        let manager: SettingsManager = SettingsManager()
        manager.tempDisplayMode = .Celcius
        manager.toggleTempDisplay()
        XCTAssert(manager.tempDisplayMode == .Fahrenheit)
        manager.toggleTempDisplay()
        XCTAssert(manager.tempDisplayMode == .Celcius)
    }
    
}
