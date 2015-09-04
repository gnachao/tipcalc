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
    
    // delcare private properties : setting data
    private(set) var defaultTipRate: Double = 0.05
    private(set) var minTipRate: Double = 0.0
    private(set) var maxTipRate: Double = 1.0
    
    init(){
        let defaults = NSUserDefaults.standardUserDefaults()
        
        // tip rate 
        let storedDefaultTipRate = defaults.doubleForKey("defaultTipRate")
        defaultTipRate = storedDefaultTipRate == 0 ? 0.05 : storedDefaultTipRate
        
        let storedMinTipRate = defaults.doubleForKey("minTipRate")
        minTipRate = storedMinTipRate == 0 ? 0.0 : storedMinTipRate
        
        let storedMaxTipRate = defaults.doubleForKey("maxTipRate")
        maxTipRate = storedMaxTipRate == 0 ? 1.0 : storedMaxTipRate
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
    
}