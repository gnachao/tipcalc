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
    @IBOutlet weak var billTotalLabel: UILabel!
    
    // total payment
    @IBOutlet weak var totalPaymentUIView: UIView!
    @IBOutlet weak var totalPaymentSubUIView: UIView!
    @IBOutlet weak var tipRateSegment: UISegmentedControl!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var totalPaymentHeaderLabel: UILabel!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var serviceSymbolLabel: UILabel!
    
    // split payment
    @IBOutlet weak var splitPaymentUIView: UIView!
    @IBOutlet weak var splitPaymentSubUIView: UIView!
    @IBOutlet weak var splitSegment: UISegmentedControl!
    @IBOutlet weak var totalPerPerson: UILabel!
    @IBOutlet weak var tipPerPerson: UILabel!
    @IBOutlet weak var totalPerPersonExcudeTip: UILabel!
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
    var keyboardScreen = UILabel()
    
    // animation properties
    var tipOldStr: String? = ""
    var tipSymbolOldStr: String? = ""
    var totalOldStr: String? = ""
    var totalHeaderOldStr: String? = ""
    var splitOldStr: String? = ""
    var splitHeaderOldStr: String? = ""
    
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
        totalPaymentValueChangeAnimation()
        splitPaymentValueChangeAnimation()
    }
    
    @IBAction func tipRateChanged(sender: AnyObject) {
        if (tipRateSegment.selectedSegmentIndex != setTipRateTitleAtIndex) || (splitSegment.selectedSegmentIndex != setSplitTitleAtIndex) {
            view.endEditing(true)
        }
        clickedButtonNum = 0
        totalPaymentValueChangeAnimation()
    }
    
    @IBAction func splitChanged(sender: AnyObject) {
        clickedButtonNum = 0
        splitPaymentValueChangeAnimation()
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
        
        scenarioTransition()
        
        // calculate total and tip
        var tipPercentages = [0.05, 0.1, 0.15, 0.2, 0.25, 0.0]
        tipPercentages [5] = convertSegmentTitleAtIndexToDouble(tipRateSegment, index: setTipRateTitleAtIndex, unit: "%", defaultTitleAtIndex: defaulfTitleTipRateLastIndex)
        var tipPercentage = tipPercentages[tipRateSegment.selectedSegmentIndex]
        
        var billAmount = (billField.text as NSString).doubleValue
        var tip = billAmount * tipPercentage
        var total = billAmount + tip
        
        totalLabel.text = String(format: "$%.2f", total)
        tipLabel.text = String(format: "TIP: $%.2f", tip)
        
        // update total payment header label
        totalPaymentHeaderLabel.text = "Total Payment with " + "\(tipRateSegment.titleForSegmentAtIndex(tipRateSegment.selectedSegmentIndex)!) " + "Tip"
        
        // update service comment
        let tipRateSelected = convertSegmentTitleAtIndexToDouble(tipRateSegment, index: tipRateSegment.selectedSegmentIndex, unit: "%", defaultTitleAtIndex: defaulfTitleTipRateLastIndex)
        switch tipRateSelected {
        case 0...0.05:
            let color = UIColor(red: 1, green: 0, blue: 0, alpha: 1)
            serviceSymbolLabel.text = "Awful :: 👎🏻"
            serviceSymbolLabel.textColor = color
            serviceSymbolLabel.glowEffect(color)
        case 0.06...0.1:
            let color = UIColor(red:0.55, green:0.41, blue:0.08, alpha:1.0)
            serviceSymbolLabel.text = "OK :: 👌🏻"
            serviceSymbolLabel.textColor = color
            serviceSymbolLabel.glowEffect(color)
        case 0.11...0.15:
            let color = UIColor(red:0.21, green:0.39, blue:0.55, alpha:1.0)
            serviceSymbolLabel.text = "Good! :: 👍🏻"
            serviceSymbolLabel.textColor = color
            serviceSymbolLabel.glowEffect(color)
        case 0.16...0.20:
            let color = UIColor(red:0.22, green:0.56, blue:0.56, alpha:1.0)
            serviceSymbolLabel.text = "Awesome :: 👍🏻👍🏻"
            serviceSymbolLabel.textColor = color
            serviceSymbolLabel.glowEffect(color)
        case 0.21...1.0:
            let color = UIColor(red:0.00, green:0.50, blue:0.00, alpha:1.0)
            serviceSymbolLabel.text = "Excellent! :: 👍🏻👍🏻👍🏻"
            serviceSymbolLabel.textColor = color
            serviceSymbolLabel.glowEffect(color)
        default:
            let color = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
            serviceSymbolLabel.textColor = color
            serviceSymbolLabel.glowEffect(color)
        }
        
        // calculate split
        var splits = [1, 2, 3, 4, 5, 1]
        splits[5] = Int(convertSegmentTitleAtIndexToDouble(splitSegment, index: setSplitTitleAtIndex, unit: "", defaultTitleAtIndex: defaultTitleSplitlastIndex))
        var split = splits[splitSegment.selectedSegmentIndex]
        
        totalPerPerson.text = String(format: "$%.2f", total / Double(split))
        tipPerPerson.text = String(format: "$%.2f", tip / Double(split))
        totalPerPersonExcudeTip.text = String(format: "$%.2f", billAmount / Double(split))
        
        // update split
        splitLabel.text = "\(splits[splitSegment.selectedSegmentIndex])" + " People Split"
        
        // add $ sign back
        billField.text = "$" + billField.text
    }
    
    func scenarioTransition(){
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
            
        } else {
            totalPaymentUIView.revealFromLeft(duration: 1.0, completionDelegate: nil)
            totalPaymentUIView.hidden = true
            splitPaymentUIView.revealFromRight(duration: 1.0, completionDelegate: nil)
            splitPaymentUIView.hidden = true
            foodBgk.pushFromBottom(duration: 1.0, completionDelegate: nil)
            foodBgk.hidden = false
        }
    }
    
    func totalPaymentValueChangeAnimation(){
    
        if tipLabel.text != tipOldStr {
            tipLabel.hidden = true
            tipLabel.pushFromTop(duration: 1.0, completionDelegate: nil)
            tipLabel.hidden = false
        }
        if serviceSymbolLabel.text != tipSymbolOldStr {
            serviceSymbolLabel.hidden = true
            serviceSymbolLabel.flipFromLeft(1.0)
            serviceSymbolLabel.hidden = false
        }
        if totalLabel.text != totalOldStr {
            totalLabel.hidden = true
            totalLabel.moveInFromTop(duration: 0.3, completionDelegate: nil)
            totalLabel.hidden = false
        }
        if totalPaymentHeaderLabel.text != totalHeaderOldStr {
            totalPaymentHeaderLabel.revealFromLeft(duration: 0.5, completionDelegate: nil)
        }
        
        // update old value
        tipOldStr = tipLabel.text
        tipSymbolOldStr = serviceSymbolLabel.text
        totalOldStr = totalLabel.text
        totalHeaderOldStr = totalPaymentHeaderLabel.text
    }
    
    func splitPaymentValueChangeAnimation(){
        let splitNewStr = totalPerPerson.text! + tipPerPerson.text! + totalPerPersonExcudeTip.text!
        
        if splitNewStr != splitOldStr {
            totalPerPerson.hidden = true
            totalPerPerson.pushFromTop(duration: 0.4, completionDelegate: nil)
            totalPerPerson.hidden = false
            
            tipPerPerson.hidden = true
            tipPerPerson.pushFromTop(duration: 0.4, completionDelegate: nil)
            tipPerPerson.hidden = false
            
            totalPerPersonExcudeTip.hidden = true
            totalPerPersonExcudeTip.pushFromTop(duration: 0.4, completionDelegate: nil)
            totalPerPersonExcudeTip.hidden = false
        }
        if splitLabel.text != splitHeaderOldStr {
            splitLabel.revealFromLeft(duration: 0.5, completionDelegate: nil)
        }
        
        // update old value
        splitOldStr = totalPerPerson.text! + tipPerPerson.text! + totalPerPersonExcudeTip.text!
        splitHeaderOldStr = splitLabel.text
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
        
        // bill total header
        billTotalLabel.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
        billTotalLabel.layer.cornerRadius = 5
        billTotalLabel.layer.masksToBounds = true
        billTotalLabel.textColor = UIColor.whiteColor()
        
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
        totalPaymentUIView.layer.borderColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).CGColor
        totalPaymentUIView.layer.borderWidth = 2
        totalPaymentUIView.layer.cornerRadius = 5
        tipRateSegment.layer.borderColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).CGColor
        tipRateSegment.layer.borderWidth = 0
        
        // total payment header
        totalPaymentHeaderLabel.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
        totalPaymentHeaderLabel.layer.cornerRadius = 5
        totalPaymentHeaderLabel.layer.masksToBounds = true
        totalPaymentHeaderLabel.textColor = UIColor.whiteColor()

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
        
        // split payment header
        splitLabel.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
        splitLabel.layer.cornerRadius = 5
        splitLabel.layer.masksToBounds = true
        splitLabel.textColor = UIColor.whiteColor()
        
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
        serviceSymbolLabel.text = ""
        
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
        keyboardScreen.text = tipRateSegment.titleForSegmentAtIndex(setTipRateTitleAtIndex)! + " tip"
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
        keyboardScreen.text = splitSegment.titleForSegmentAtIndex(setSplitTitleAtIndex)! + " people"
    }
    
    func tipRateTextfieldEditingChange(){
        tipRateSegment.textfieldEditingChange(tipRateTextfield, slider: slider, unit: "%", max: 100)
        calculate()
        keyboardScreen.text = tipRateSegment.titleForSegmentAtIndex(setTipRateTitleAtIndex)! + " tip"
        totalPaymentValueChangeAnimation()
    }
    
    func splitRateTextfieldEditingChange(){
        splitSegment.textfieldEditingChange(splitTextfield, slider: slider, unit: "", max: 1000000)
        calculate()
        keyboardScreen.text = splitSegment.titleForSegmentAtIndex(setSplitTitleAtIndex)! + " people"
        splitPaymentValueChangeAnimation()
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
            slider.frame.size.width = CGFloat(deviceWidth - 150)
            
            // done button
            var doneItem = UIBarButtonItem()
            var clearItem = UIBarButtonItem()
            
            if textField == tipRateTextfield {
                slider.removeTarget(self, action: "slidToChangeSplit", forControlEvents: UIControlEvents.ValueChanged)
                slider.addTarget(self, action: "slidToChangeTipRate", forControlEvents: UIControlEvents.ValueChanged)
                doneItem = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Done, target: self, action: Selector("doneEditingTipRate") )
                clearItem = UIBarButtonItem(title: "Clear", style: UIBarButtonItemStyle.Done, target: self, action: Selector("clearTiprateTextfield") )
                slider.minimumValue = 1
                slider.maximumValue = 100
            } else if textField == splitTextfield {
                slider.removeTarget(self, action: "slidToChangeTipRate", forControlEvents: UIControlEvents.ValueChanged)
                slider.addTarget(self, action: "slidToChangeSplit", forControlEvents: UIControlEvents.ValueChanged)
                doneItem = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Done, target: self, action: Selector("doneEditingSplit") )
                clearItem = UIBarButtonItem(title: "Clear", style: UIBarButtonItemStyle.Done, target: self, action: Selector("clearSplitTextfield") )
                slider.minimumValue = 1
                slider.maximumValue = 100
            }
            
            var items = NSMutableArray()
            items.addObject(clearItem)
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
            
            // Keyboard screen
            keyboardScreen.frame = CGRectMake(0, -40, deviceWidth, 40)
            keyboardScreen.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7)
            keyboardScreen.layer.borderWidth = 1
            keyboardScreen.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.9).CGColor
            keyboardScreen.textColor = UIColor.whiteColor()
            keyboardScreen.font = UIFont(name: keyboardScreen.font.fontName, size: 40)
            keyboardScreen.textAlignment = NSTextAlignment.Center
            keyboardDoneButtonView.addSubview(keyboardScreen)
        }
        return true
    }
    
    func clearSplitTextfield(){
        splitSegment.setTitle("", forSegmentAtIndex: setSplitTitleAtIndex)
        splitTextfield.text = ""
        slider.value = 0
    }
    
    func clearTiprateTextfield() {
        tipRateSegment.setTitle("", forSegmentAtIndex: setTipRateTitleAtIndex)
        tipRateTextfield.text = ""
        slider.value = 0
        totalPaymentHeaderLabel.text = "Total Payment with " + "\(tipRateSegment.titleForSegmentAtIndex(tipRateSegment.selectedSegmentIndex)!) " + "Tip"
    }
    
    func slidToChangeTipRate(){
        var currentValue = Int(slider.value)
        tipRateSegment.setTitle("\(currentValue)" + "%", forSegmentAtIndex: tipRateSegment.numberOfSegments - 1)
        tipRateTextfield.text = "\(currentValue)"
        calculate()
        keyboardScreen.text = tipRateSegment.titleForSegmentAtIndex(setTipRateTitleAtIndex)! + " tip"
    }
    
    func slidToChangeSplit(){
        var currentValue = Int(slider.value)
        splitSegment.setTitle("\(currentValue)", forSegmentAtIndex: setSplitTitleAtIndex)
        splitTextfield.text = "\(currentValue)"
        calculate()
        keyboardScreen.text = splitSegment.titleForSegmentAtIndex(setSplitTitleAtIndex)! + " people"
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

