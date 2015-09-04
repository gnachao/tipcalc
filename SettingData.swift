//
//  SettingData.swift
//  tipster
//
//  Created by MacBKPro on 9/3/15.
//  Copyright (c) 2015 codepath-gna. All rights reserved.
//

import Foundation
import UIKit

class SettingData {
    // class property for the same instance to be returned when called
    class var SharedSettingData : SettingData {
        struct Singleton {
            static let instance = SettingData()
        }
        return Singleton.instance
    }
    
    // constant private properties : factory setting data
    private let originalDefaulTipRate: Double = 0.05
    private let originalMinTipRate: Double = 0.0
    private let originalMaxTipRate: Double = 1.0
    
    // delcare private properties : setting data
    private(set) var defaultTipRate: Double
    private(set) var minTipRate: Double
    private(set) var maxTipRate: Double
    
    init(){
        let defaults = NSUserDefaults.standardUserDefaults()
        
        // tip rate 
        let storedDefaultTipRate = defaults.doubleForKey("defaultTipRate")
        defaultTipRate = storedDefaultTipRate == 0 ? originalDefaulTipRate : storedDefaultTipRate
        
        let storedMinTipRate = defaults.doubleForKey("minTipRate")
        minTipRate = storedMinTipRate == 0 ? originalMinTipRate : storedMinTipRate
        
        let storedMaxTipRate = defaults.doubleForKey("maxTipRate")
        maxTipRate = storedMaxTipRate == 0 ? originalMaxTipRate : storedMaxTipRate
    }
    
    // set default tip rate
    func saveDefaultTipRate(newDefaultTipRate: Double){
        saveTipRate(newDefaultTipRate, key: "defaultTipRate")
    }
    
    // set default minimum tip rate
    func saveMinTipRate(newMinTipRate: Double){
        saveTipRate(newMinTipRate, key: "minTipRate")
    }
    
    // set default maximum tip rate
    func saveMaxTipRate(newMaxTipRate: Double){
        saveTipRate(newMaxTipRate, key: "maxTipRate")
    }
    
    // utility method to set tip rate
    private func saveTipRate(newValue: Double, key: String) {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setDouble(newValue, forKey: key)
        defaults.synchronize()
    }
    
    // reset defaul setting data to original state
    func resetAllSetting(){
        saveDefaultTipRate(originalDefaulTipRate)
        saveMinTipRate(originalMinTipRate)
        saveMaxTipRate(originalMaxTipRate)
    }
    
}