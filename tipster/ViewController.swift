//
//  ViewController.swift
//  tipster
//
//  Created by MacBKPro on 8/1/15.
//  Copyright (c) 2015 codepath-gna. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // bill total 
    @IBOutlet weak var billTotalUIView: UIView!
    @IBOutlet weak var billField: UITextField!
    
    // total payment
    @IBOutlet weak var totalPaymentUIView: UIView!
    @IBOutlet weak var totalPaymentSubUIView: UIView!
    @IBOutlet weak var totalPaymentLine: UIView!
    @IBOutlet weak var totalPaymentLine0: UIView!
    @IBOutlet weak var totalPaymentLine1: UIView!
    @IBOutlet weak var tipRateSegment: UISegmentedControl!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var serviceLabel: UILabel!
    @IBOutlet weak var serviceSymbolLabel: UILabel!
    
    
    // split payment
    @IBOutlet weak var splitPaymentUIView: UIView!
    @IBOutlet weak var splitPaymentSubUIView: UIView!
    @IBOutlet weak var splitSegment: UISegmentedControl!
    @IBOutlet weak var totalPerPerson: UILabel!
    @IBOutlet weak var tipPerPerson: UILabel!
    @IBOutlet weak var totalPerPersonExcudeTip: UILabel!
    @IBOutlet weak var splitCalculationTextView: UITextView!
    @IBOutlet weak var tipRateCalculationTextView: UITextView!
    @IBOutlet weak var splitPaymentLine: UIView!
    @IBOutlet weak var splitLabel: UILabel!
    
    // segment control button and textfield for manually set value
    var tipRateButton = UIButton()
    var tipRateTextfield = UITextField()
    var splitButton = UIButton()
    var splitTextfield = UITextField()
    let slider = UISlider()
    var defaulfTitleTipRateLastIndex: String?
    var defaultTitleSplitlastIndex: String?
    var setTipRateTitleAtIndex: Int = 0
    var setSplitTitleAtIndex: Int = 0
    var clickedButtonName: String = ""
    var clickedButtonNum: Int = 0
    
    
    
    // images
    @IBOutlet weak var foodBgk: UIImageView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setApearance()
        setDefaultOnDidLoad()
        userSetTipRateNumSplit()
    }

    @IBAction func billAmountEditingChange(sender: AnyObject) {
        calculate()
        setDefaulfTitleTipRateLastIndex()
        setDefaulfTitleSplitLastIndex()
    }
    
    @IBAction func segmentValueChanged(sender: AnyObject) {
        if (tipRateSegment.selectedSegmentIndex != setTipRateTitleAtIndex) || (splitSegment.selectedSegmentIndex != setSplitTitleAtIndex) {
            view.endEditing(true)
        }
        clickedButtonNum = 0
    }
    
    @IBAction func billTextfieldTouchDown(sender: UITextField) {
        clickedButtonNum = 0
        setDefaulfTitleTipRateLastIndex()
    }
    
    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
        clickedButtonNum = 0
        setDefaulfTitleTipRateLastIndex()
    }
    
    func calculate(){
        // remove $ sign
        billField.text = billField.text.stringByReplacingOccurrencesOfString("$", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
        
        animation()
        
        // calculate total and tip
        var tipPercentages = [0.05, 0.1, 0.15, 0.2, 0.25, 0.0]
        tipPercentages [5] = convertSegmentTitleAtIndexToDouble(tipRateSegment, index: setTipRateTitleAtIndex, unit: "%", defaultTitleAtIndex: defaulfTitleTipRateLastIndex)
        var tipPercentage = tipPercentages[tipRateSegment.selectedSegmentIndex]
        
        var billAmount = (billField.text as NSString).doubleValue
        var tip = billAmount * tipPercentage
        var total = billAmount + tip
        
        totalLabel.text = String(format: "$%.2f", total)
        tipLabel.text = String(format: "$%.2f", tip)
        
        // calculate split
        var splits = [1, 2, 3, 4, 5, 1]
        splits[5] = Int(convertSegmentTitleAtIndexToDouble(splitSegment, index: setSplitTitleAtIndex, unit: "", defaultTitleAtIndex: defaultTitleSplitlastIndex))
        var split = splits[splitSegment.selectedSegmentIndex]
        
        totalPerPerson.text = String(format: "$%.2f", total / Double(split))
        tipPerPerson.text = String(format: "$%.2f", tip / Double(split))
        totalPerPersonExcudeTip.text = String(format: "$%.2f", billAmount / Double(split))
        
        // update split
        splitLabel.text = "\(splits[splitSegment.selectedSegmentIndex])" + " People Split"
        
        // update service comment
        serviceLabel.text = tipRateSegment.titleForSegmentAtIndex(tipRateSegment.selectedSegmentIndex)! + " Service "
        let tipRateSelected = convertSegmentTitleAtIndexToDouble(tipRateSegment, index: tipRateSegment.selectedSegmentIndex, unit: "%", defaultTitleAtIndex: defaulfTitleTipRateLastIndex)
        println("\(tipRateSelected)")
        switch tipRateSelected {
        case 0...0.05:
            serviceLabel.text = serviceLabel.text! + "Poor"
            serviceLabel.textColor = UIColor(red: 1, green: 0, blue: 0, alpha: 1)
            serviceSymbolLabel.text = "👎🏻"
        case 0.06...0.1:
            serviceLabel.text = serviceLabel.text! + "Fair"
            serviceLabel.textColor = UIColor(red: 1, green: 0.3, blue: 0.14, alpha: 1)
            serviceSymbolLabel.text = "👌🏻"
        case 0.11...0.15:
            serviceLabel.text = serviceLabel.text! + "Good!"
            serviceLabel.textColor = UIColor(red:0.21, green:0.39, blue:0.55, alpha:1.0)
            serviceSymbolLabel.text = "👍🏻"
        case 0.16...0.20:
            serviceLabel.text = serviceLabel.text! + "Great!"
            serviceLabel.textColor = UIColor(red:0.22, green:0.56, blue:0.56, alpha:1.0)
            serviceSymbolLabel.text = "👍🏻👍🏻"
        case 0.21...0.25:
            serviceLabel.text = serviceLabel.text! + "Excellent!"
            serviceLabel.textColor = UIColor(red:0.00, green:0.50, blue:0.00, alpha:1.0)
            serviceSymbolLabel.text = "👍🏻👍🏻👍🏻"
        case 0.26...0.3:
            serviceLabel.text = serviceLabel.text! + "Perfect!"
            serviceLabel.textColor = UIColor(red:0.00, green:0.50, blue:0.00, alpha:1.0)
            serviceSymbolLabel.text = "👍🏻👍🏻👍🏻👍🏻"
        case 0.31...1:
            serviceLabel.text = serviceLabel.text! + "Perfect!"
            serviceLabel.textColor = UIColor(red:0.00, green:0.50, blue:0.00, alpha:1.0)
            serviceSymbolLabel.text = "👍🏻👍🏻👍🏻👍🏻👍🏻"
        default:
            serviceLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
  
        }
        
        // add $ sign back
        billField.text = "$" + billField.text
    }
    
    func animation(){
        let billTotalStr = billField.text.stringByReplacingOccurrencesOfString(" ", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
        if billTotalStr.length > 0 {
            if totalPaymentUIView.hidden == true {
                totalPaymentUIView.moveInFromLeft(duration: 1.0, completionDelegate: nil)
                totalPaymentUIView.hidden = false
            }
            if splitPaymentUIView.hidden == true {
                splitPaymentUIView.moveInFromRight(duration: 1.0, completionDelegate: nil)
                splitPaymentUIView.hidden = false
            }
            foodBgk.pushFromTop(duration: 1.0, completionDelegate: nil)
            foodBgk.hidden = true
            
            tipLabel.hidden = true
            tipLabel.pushFromTop(duration: 1.0, completionDelegate: nil)
            tipLabel.hidden = false
            
            serviceLabel.hidden = true
            serviceLabel.revealFromLeft(duration: 1.0, completionDelegate: nil)
            serviceLabel.hidden = false
            
            serviceSymbolLabel.hidden = true
            serviceSymbolLabel.revealFromLeft(duration: 1.0, completionDelegate: nil)
            serviceSymbolLabel.hidden = false
            
        } else {
            totalPaymentUIView.revealFromLeft(duration: 1.0, completionDelegate: nil)
            totalPaymentUIView.hidden = true
            splitPaymentUIView.revealFromRight(duration: 1.0, completionDelegate: nil)
            splitPaymentUIView.hidden = true
            foodBgk.pushFromBottom(duration: 1.0, completionDelegate: nil)
            foodBgk.hidden = false
        }
    }
    
    func convertSegmentTitleAtIndexToDouble(segment: UISegmentedControl, index: Int, unit: String, defaultTitleAtIndex: String?) -> Double{
        var currentCustomRateStr: NSString?
        currentCustomRateStr = segment.titleForSegmentAtIndex(index)
        if (currentCustomRateStr != defaultTitleAtIndex) && (currentCustomRateStr?.length > 0) {
            currentCustomRateStr = segment.titleForSegmentAtIndex(index)?.stringByReplacingOccurrencesOfString(unit, withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
            if unit == "%" {
                return currentCustomRateStr!.doubleValue/100
            } else {
                return currentCustomRateStr!.doubleValue
            }
            
        } else {
            return 0.0
        }
        
    }
    
    func setApearance(){
        
        // bill total : bkg
        billTotalUIView.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.4)
        // bill total : shadow
        billTotalUIView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).CGColor
        billTotalUIView.layer.shadowOffset = CGSizeMake(5, 5)
        billTotalUIView.layer.shadowOpacity = 0.5
        billTotalUIView.layer.shadowRadius = 2
        // bill total : border
        billTotalUIView.layer.borderColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).CGColor
        billTotalUIView.layer.borderWidth = 2
        billTotalUIView.layer.cornerRadius = 5
        
        // total payment : bkg
        totalPaymentUIView.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0)
        totalPaymentSubUIView.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.4)
        tipRateSegment.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        // total payment : shadow
        totalPaymentSubUIView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).CGColor
        totalPaymentSubUIView.layer.shadowOffset = CGSizeMake(5, 5)
        totalPaymentSubUIView.layer.shadowOpacity = 0.5
        totalPaymentSubUIView.layer.shadowRadius = 2
        // total payment : border
        totalPaymentLine.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.2)
        totalPaymentLine0.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        totalPaymentLine0.layer.borderColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).CGColor
        totalPaymentLine0.layer.borderWidth = 2
        totalPaymentLine1.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.2)
        totalPaymentUIView.layer.borderColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).CGColor
        totalPaymentUIView.layer.borderWidth = 2
        totalPaymentUIView.layer.cornerRadius = 5
        tipRateSegment.layer.borderColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).CGColor
        tipRateSegment.layer.borderWidth = 0
        
        // plit payment : background 
        splitPaymentUIView.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0)
        splitPaymentSubUIView.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.4)
        splitSegment.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        // split payment : shadow
        splitPaymentSubUIView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).CGColor
        splitPaymentSubUIView.layer.shadowOffset = CGSizeMake(5, 5)
        splitPaymentSubUIView.layer.shadowOpacity = 0.5
        splitPaymentSubUIView.layer.shadowRadius = 2
        // split payment : border 
        splitPaymentUIView.layer.borderColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).CGColor
        splitPaymentUIView.layer.borderWidth = 2
        splitPaymentUIView.layer.cornerRadius = 5
        splitPaymentLine.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        splitPaymentLine.layer.borderColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).CGColor
        splitPaymentLine.layer.borderWidth = 2
        
        // set font to all UISegmented Control
        var attr = NSDictionary(object: UIFont(name: "chalkduster", size: 16.0)!, forKey: NSFontAttributeName)
        UISegmentedControl.appearance().setTitleTextAttributes(attr as [NSObject : AnyObject], forState: .Normal)
    }
    
    func setDefaultOnDidLoad(){
        
        // show/hide, animation
        billTotalUIView.pushFromTop(duration: 1.0, completionDelegate: nil)
        totalPaymentUIView.hidden = true
        splitPaymentUIView.hidden = true
        foodBgk.pushFromBottom(duration: 1.0, completionDelegate: nil)
        
        // set names
        billField.text = "$"
        tipLabel.text = "$0.00"
        totalLabel.text = "$0.00"
        serviceSymbolLabel.text = ""
        serviceLabel.text = ""
        
        setTipRateTitleAtIndex = tipRateSegment.numberOfSegments - 1
        setSplitTitleAtIndex = splitSegment.numberOfSegments - 1
        defaulfTitleTipRateLastIndex = tipRateSegment.titleForSegmentAtIndex(setTipRateTitleAtIndex)
        defaultTitleSplitlastIndex = splitSegment.titleForSegmentAtIndex(setSplitTitleAtIndex)
    }

    func userSetTipRateNumSplit(){
        // tiprate segment control
        tipRateSegment.allowEditingTitle(totalPaymentUIView, margin: 16, texfield: tipRateTextfield, button: tipRateButton, changeAtIndex: setTipRateTitleAtIndex)
        tipRateButton.addTarget(self, action: "tipRateButtonClick", forControlEvents: UIControlEvents.TouchUpInside)
        tipRateTextfield.addTarget(self, action: "tipRateTextfieldEditingChange", forControlEvents: UIControlEvents.EditingChanged)
        
        // split segment control
        splitSegment.allowEditingTitle(splitPaymentUIView, margin: 16, texfield: splitTextfield, button: splitButton, changeAtIndex: setSplitTitleAtIndex)
        splitButton.addTarget(self, action: "splitRateButtonClick", forControlEvents: UIControlEvents.TouchUpInside)
        splitTextfield.addTarget(self, action: "splitRateTextfieldEditingChange", forControlEvents: UIControlEvents.EditingChanged)
    }
    
    func tipRateButtonClick(){
        
        if clickedButtonName == "tipRate" {
            clickedButtonNum += 1
        } else {
            clickedButtonNum = 1
            clickedButtonName = "tipRate"
        }
        
        tipRateSegment.buttonClick(tipRateTextfield, slider: slider, unit: "%")
        addDoneButton(tipRateTextfield)
        calculate()
    }

    func splitRateButtonClick(){
        
        if clickedButtonName == "split" {
            clickedButtonNum += 1
        } else {
            clickedButtonNum = 1
            clickedButtonName = "split"
        }
        
        splitSegment.buttonClick(splitTextfield, slider: slider, unit: "")
        addDoneButton(splitTextfield)
        calculate()
    }
    
    func tipRateTextfieldEditingChange(){
        tipRateSegment.textfieldEditingChange(tipRateTextfield, slider: slider, unit: "%", max: 100)
        calculate()
    }
    
    func splitRateTextfieldEditingChange(){
        splitSegment.textfieldEditingChange(splitTextfield, slider: slider, unit: "", max: 1000000)
        calculate()
    }
    
    func addDoneButton(textField: UITextField) -> Bool {
        if clickedButtonNum < 2 {
            // Create a bar to add item
            let keyboardDoneButtonView = UIToolbar()
            keyboardDoneButtonView.barStyle = UIBarStyle.BlackTranslucent
            
            // flex splace
            var flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
            
            // slider
            let bounds = UIScreen.mainScreen().bounds
            let deviceWidth = bounds.size.width
            slider.frame.size.width = CGFloat(deviceWidth - 75)
            
            // done button
            var doneItem = UIBarButtonItem()
            
            if textField == tipRateTextfield {
                slider.removeTarget(self, action: "slidToChangeSplit", forControlEvents: UIControlEvents.ValueChanged)
                slider.addTarget(self, action: "slidToChangeTipRate", forControlEvents: UIControlEvents.ValueChanged)
                doneItem = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Done, target: self, action: Selector("doneEditingTipRate") )
                slider.minimumValue = 1
                slider.maximumValue = 100
            } else if textField == splitTextfield {
                slider.removeTarget(self, action: "slidToChangeTipRate", forControlEvents: UIControlEvents.ValueChanged)
                slider.addTarget(self, action: "slidToChangeSplit", forControlEvents: UIControlEvents.ValueChanged)
                doneItem = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Done, target: self, action: Selector("doneEditingSplit") )
                slider.minimumValue = 1
                slider.maximumValue = 100
            }
            
            var items = NSMutableArray()
            items.addObject(UIBarButtonItem(customView: slider))
            items.addObject(flexSpace)
            items.addObject(doneItem)
            
            keyboardDoneButtonView.items = items as [AnyObject]
            keyboardDoneButtonView.sizeToFit()
            
            textField.inputAccessoryView = keyboardDoneButtonView
            
            // keyboard : decimal keypad
            textField.keyboardType = UIKeyboardType.DecimalPad
            textField.keyboardAppearance = UIKeyboardAppearance.Dark
            
            // focus on textfield
            textField.becomeFirstResponder()
        }
        return true
    }
    
    func slidToChangeTipRate(){
        var currentValue = Int(slider.value)
        tipRateSegment.setTitle("\(currentValue)" + "%", forSegmentAtIndex: tipRateSegment.numberOfSegments - 1)
        tipRateTextfield.text = "\(currentValue)"
        calculate()
    }
    
    func slidToChangeSplit(){
        var currentValue = Int(slider.value)
        splitSegment.setTitle("\(currentValue)", forSegmentAtIndex: setSplitTitleAtIndex)
        splitTextfield.text = "\(currentValue)"
        calculate()
    }
    
    func doneEditingTipRate(){
        setDefaulfTitleTipRateLastIndex()
        tipRateTextfield.resignFirstResponder()
        clickedButtonNum = 0
    }
    
    func doneEditingSplit(){
        setDefaulfTitleSplitLastIndex()
        splitTextfield.resignFirstResponder()
        clickedButtonNum = 0
    }
    
    func setDefaulfTitleTipRateLastIndex() {
        if (tipRateTextfield.text == "" && tipRateSegment.titleForSegmentAtIndex(setTipRateTitleAtIndex) == "") || tipRateSegment.titleForSegmentAtIndex(setTipRateTitleAtIndex) == "%" {
            tipRateSegment.setTitle(defaulfTitleTipRateLastIndex, forSegmentAtIndex: setTipRateTitleAtIndex)
        }
    }
    
    func setDefaulfTitleSplitLastIndex() {
        if splitTextfield.text == "" && splitSegment.titleForSegmentAtIndex(setSplitTitleAtIndex) == "" {
            splitSegment.setTitle(defaultTitleSplitlastIndex, forSegmentAtIndex: setSplitTitleAtIndex)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

