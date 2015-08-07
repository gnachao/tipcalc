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

let slider = UISlider()
let minSlide: Float = 1
let maxSlide: Float = 100

let texfield = UITextField()
let button = UIButton()
var defaultLastSegmentTitle: String? = ""
var unit: String = ""

extension UISegmentedControl {

    func allowEditingTitleLastIndex(margin: Float, view: UIView, unitOfSegmentItem: String) {
        // set unit
        unit = unitOfSegmentItem
        
        // get default last segment title
        defaultLastSegmentTitle = self.titleForSegmentAtIndex(self.numberOfSegments - 1)
        
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
        button.frame = CGRectMake(buttonLeftMargin, 0, buttonWidth, buttonHeight)
        button.layer.borderWidth = 2
        view.addSubview(button)
        
        // create temp text field
        texfield.frame = CGRectMake(buttonLeftMargin, 0, 1, 1)
        view.addSubview(texfield)
        
        button.addTarget(self, action: "buttonClick", forControlEvents: UIControlEvents.TouchUpInside)
        texfield.addTarget(self, action: "textfieldEditingChange", forControlEvents: UIControlEvents.EditingChanged)
    }
    
    func buttonClick(){
        // segmented control to select last index
        self.selectedSegmentIndex = self.numberOfSegments - 1
        
        // keyboard : decimal keypad
        texfield.keyboardType = UIKeyboardType.DecimalPad
        texfield.keyboardAppearance = UIKeyboardAppearance.Dark
        
        // keyboard : done button
        addDoneButton(texfield)
        
        // focus on textfield
        texfield.becomeFirstResponder()
        
        // set textfield equal to segment last index title exclude %
        let currentCustomRateStr = self.titleForSegmentAtIndex(self.numberOfSegments - 1)?.stringByReplacingOccurrencesOfString(unit, withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
        if currentCustomRateStr == defaultLastSegmentTitle {
            self.setTitle("", forSegmentAtIndex: self.numberOfSegments - 1)
        } else {
            texfield.text = currentCustomRateStr
        }
    }
    
    func textfieldEditingChange(){
        var textfieldValue: NSString = "0"
        slider.minimumValue = minSlide
        slider.maximumValue = maxSlide
        
        if texfield.text.length > 0 {
            if texfield.text.toInt() > 100 {
            let currentCustomRateStr = self.titleForSegmentAtIndex(self.numberOfSegments - 1)?.stringByReplacingOccurrencesOfString(unit, withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
                texfield.text = currentCustomRateStr
            }
        }
        
        textfieldValue = texfield.text
        slider.setValue(textfieldValue.floatValue, animated: true)
        self.setTitle(texfield.text + unit, forSegmentAtIndex: self.numberOfSegments - 1)
    }
    
    func done(){
        if texfield.text == "" || self.titleForSegmentAtIndex(self.numberOfSegments - 1) == "" || self.titleForSegmentAtIndex(self.numberOfSegments - 1) == unit {
            self.setTitle(defaultLastSegmentTitle, forSegmentAtIndex: self.numberOfSegments - 1)
        }
        texfield.resignFirstResponder()
    }
    
    func slidToChangeValue(){
        slider.minimumValue = minSlide
        slider.maximumValue = maxSlide
        
        var currentValue = Int(slider.value)
        self.setTitle("\(currentValue)" + unit, forSegmentAtIndex: self.numberOfSegments - 1)
    }
    
    func addDoneButton(textField: UITextField) -> Bool {
        
        // Create a button bar for the number pad
        let keyboardDoneButtonView = UIToolbar()
        keyboardDoneButtonView.barStyle = UIBarStyle.BlackTranslucent
        
        // Setup the buttons to be put in the system.
        var flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        let doneItem = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Done, target: self, action: Selector("done") )
        
        // slider
        let bounds = UIScreen.mainScreen().bounds
        let deviceWidth = bounds.size.width
        slider.frame.size.width = CGFloat(deviceWidth - 75)
        slider.addTarget(self, action: "slidToChangeValue", forControlEvents: UIControlEvents.ValueChanged)
        
        var items = NSMutableArray()
        items.addObject(UIBarButtonItem(customView: slider))
        items.addObject(flexSpace)
        items.addObject(doneItem)
        
        keyboardDoneButtonView.items = items as [AnyObject]
        keyboardDoneButtonView.sizeToFit()
        
        textField.inputAccessoryView = keyboardDoneButtonView
        
        return true
    }
}