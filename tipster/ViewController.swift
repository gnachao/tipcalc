//
//  ViewController.swift
//  tipster
//
//  Created by MacBKPro on 8/1/15.
//  Copyright (c) 2015 codepath-gna. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    
    @IBOutlet weak var tipRateSegment: UISegmentedControl!
    @IBOutlet weak var tipRateField: UITextField!
    @IBOutlet weak var tipRateButton: UIButton!
    
    @IBOutlet weak var guestCheckUIView: UIView!
    @IBOutlet weak var guestCheckTotalUIView: UIView!

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
        
        guestCheckUIView.hidden = false
        guestCheckUIView.moveInFromBottom(duration: 1.0, completionDelegate: nil)
        
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
        // add shadow to guestCheckUIView
        guestCheckUIView.layer.shadowColor = UIColor(red: 0.514, green: 0.545, blue: 0.545, alpha: 1).CGColor;
        guestCheckUIView.layer.shadowOffset = CGSizeMake(5, 5);
        guestCheckUIView.layer.shadowOpacity = 1;
        guestCheckUIView.layer.shadowRadius = 1.0;
        
        // set font to all UISegmented Control
        var attr = NSDictionary(object: UIFont(name: "chalkduster", size: 16.0)!, forKey: NSFontAttributeName)
        UISegmentedControl.appearance().setTitleTextAttributes(attr as [NSObject : AnyObject], forState: .Normal)
        
        // add background to guestCheckUIView
        guestCheckUIView.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.2)
        guestCheckTotalUIView.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.4)
    }
    
    func setDefaultOnDidLoad(){
        
        // show or hide
        tipRateField.hidden = true
        guestCheckUIView.hidden = true
        
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

