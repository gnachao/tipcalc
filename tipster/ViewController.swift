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
    @IBOutlet weak var tipRateField: UITextField!
    @IBOutlet weak var tipRateButton: UIButton!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var serviceLabel: UILabel!
    
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
    
    
    // images
    @IBOutlet weak var foodBgk: UIImageView!
    

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setApearance()
        setDefaultOnDidLoad()
    }

    @IBAction func onEditingChanged(sender: AnyObject) {
        resetSegmentedControlCustomIndexDefault()
        var tipPercentages = [0.18, 0.2, 0.22, 0.0]
        var tipPercentage = tipPercentages[tipRateSegment.selectedSegmentIndex]

        var billAmount = (billField.text as NSString).doubleValue
        var tip = billAmount * tipPercentage
        var total = billAmount + tip
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
    }
    
    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
        resetSegmentedControlCustomIndexDefault()
        
        splitPaymentSubUIView.hidden = false
        splitPaymentSubUIView.moveInFromBottom(duration: 1.0, completionDelegate: nil)
        
    }
    
    @IBAction func setCustomRate(sender: AnyObject) {
        tipRateSegment.selectedSegmentIndex = 5
        tipRateField.becomeFirstResponder()
        if (tipRateSegment.titleForSegmentAtIndex(5) == "●●●"){
            tipRateField.text = ""
            tipRateSegment.setTitle("", forSegmentAtIndex: 5)
        } else {
            let currentCustomRateStr = tipRateSegment.titleForSegmentAtIndex(5)?.stringByReplacingOccurrencesOfString("%", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
            tipRateField.text = currentCustomRateStr
        }
    }
    
    @IBAction func tipRateFieldEditingChange(sender: AnyObject) {
        if (tipRateField.text as NSString).length > 4 {
           
            
        }
        
        tipRateSegment.setTitle(tipRateField.text + "%", forSegmentAtIndex: 5)
        
        switch (tipRateField.text as NSString).doubleValue {
        case 0...24.99:
            self.view.backgroundColor = UIColor.whiteColor()
        case 25...49.99:
            self.view.backgroundColor = UIColor(red: 0.933, green: 0.878, blue: 0.898, alpha: 1)
        case 50...100.00:
            self.view.backgroundColor = UIColor(red: 1, green: 0.882, blue: 0.725, alpha: 1)
        default:
            self.view.backgroundColor = UIColor(red: 1, green: 0.682, blue: 0.725, alpha: 1)
        }
        
    }

    func resetSegmentedControlCustomIndexDefault() {
        if (tipRateSegment.titleForSegmentAtIndex(5) == "") || (tipRateSegment.titleForSegmentAtIndex(5) == "%"){
            tipRateSegment.setTitle("●●●", forSegmentAtIndex: 3)
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
        
//        totalPaymentSubUIView.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3).CGColor
//        totalPaymentSubUIView.layer.borderWidth = 1
//        totalPaymentSubUIView.layer.cornerRadius = 5
//        
//        // total payment view tipRateSegment
//        tipRateSegment.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5).CGColor
//        tipRateSegment.layer.shadowOffset = CGSizeMake(5, 5)
//        tipRateSegment.layer.shadowOpacity = 1
//        tipRateSegment.layer.shadowRadius = 2
        
        
        
        
        // split payment view bkg

        
        // add shadow to guestCheckUIView
//        splitPaymentSubUIView.layer.shadowColor = UIColor(red: 0.514, green: 0.545, blue: 0.545, alpha: 1).CGColor;
//        splitPaymentSubUIView.layer.shadowOffset = CGSizeMake(5, 5);
//        splitPaymentSubUIView.layer.shadowOpacity = 1;
//        splitPaymentSubUIView.layer.shadowRadius = 1.0;
        
        // set font to all UISegmented Control
        var attr = NSDictionary(object: UIFont(name: "chalkduster", size: 16.0)!, forKey: NSFontAttributeName)
        UISegmentedControl.appearance().setTitleTextAttributes(attr as [NSObject : AnyObject], forState: .Normal)
    }
    
    func setDefaultOnDidLoad(){
        
        // show or hide
        tipRateField.hidden = true
        splitPaymentSubUIView.hidden = true
        foodBgk.hidden = true
        
        // set names
        tipLabel.text = "$0.00"
        totalLabel.text = "$0.00"
        
        tipRateButton.setTitle("", forState: UIControlState.Normal)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

