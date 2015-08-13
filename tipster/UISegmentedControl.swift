//
//  UISegmentedControl.swift
//  tipster
//
//  Created by GNA CHAO on 8/6/15.
//  Copyright (c) 2015 codepath-gna. All rights reserved.
//
//
//  Thank you for the following people who make the resource available for reading:
//  Ref: https://www.snip2code.com/Snippet/238097/iOS---Swift---Add-a-Done-button-to-a-Key
//       http://iostechsolutions.blogspot.com/2014/11/swift-add-uitoolbar-or-done-button-on.html

import UIKit

var indexToChange: Int = 0
var defaultTitle: String? = ""

extension UISegmentedControl {

    func allowEditingTitleLastIndex(view: UIView, margin: Float, texfield: UITextField, button: UIButton, unitOfSegmentItem: String){
        indexToChange = self.numberOfSegments - 1
        allowEditingTitle(view, margin: margin, texfield: texfield, button: button, changeAtIndex: indexToChange)
    
    }
    
    func allowEditingTitle(view: UIView, margin: Float, texfield: UITextField, button: UIButton, changeAtIndex: Int) {
        
        // set init values
        indexToChange = changeAtIndex
        defaultTitle = self.titleForSegmentAtIndex(changeAtIndex)
        
        // get device width
        var bounds = UIScreen.mainScreen().bounds
        var deviceWidth = bounds.size.width
        
        // get segment width
        let segmentWidth = deviceWidth - CGFloat(2 * margin)
        
        // calculate button width, height, margin left
        let buttonWidth = segmentWidth / CGFloat(self.numberOfSegments) - 1
        let buttonHeight = self.frame.height
        let buttonLeftMargin = buttonWidth * CGFloat(self.numberOfSegments - 1)
        
        // create button
        button.frame = CGRectMake(buttonLeftMargin, self.layer.frame.origin.x + self.frame.size.height, buttonWidth, buttonHeight)
        button.layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0).CGColor
        view.addSubview(button)
        
        // create temp text field
        texfield.frame = CGRectMake(buttonLeftMargin, 0, 1, 1)
        view.addSubview(texfield)
    }
    
    func buttonClick(texfield: UITextField, slider: UISlider, unit: String){
        var textfieldValue: NSString = "0"
        
        // segmented control to select last index
        self.selectedSegmentIndex = indexToChange
        
        // set textfield equal to segment last index title exclude %
        let currentCustomRateStr = self.titleForSegmentAtIndex(indexToChange)?.stringByReplacingOccurrencesOfString(unit, withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
        if currentCustomRateStr == defaultTitle {
            self.setTitle("", forSegmentAtIndex: indexToChange)
        } else {
            texfield.text = currentCustomRateStr
        }
        
        textfieldValue = texfield.text
        slider.setValue(textfieldValue.floatValue, animated: true)
        
    }
    
    func textfieldEditingChange(texfield: UITextField, slider: UISlider, unit: String, max: Int){
        var textfieldValue: NSString = "0"
        
        if texfield.text.length > 0 {
            if texfield.text.toInt() > max {
            let currentCustomRateStr = self.titleForSegmentAtIndex(indexToChange)?.stringByReplacingOccurrencesOfString(unit, withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
                texfield.text = currentCustomRateStr
            }
        }
        
        textfieldValue = texfield.text
        slider.setValue(textfieldValue.floatValue, animated: true)
        self.setTitle(texfield.text + unit, forSegmentAtIndex: indexToChange)
    }
}