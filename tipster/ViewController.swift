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
    @IBOutlet weak var billAmountUIView: UIView!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tipLabel.text = "$0.00"
        totalLabel.text = "$0.00"
        tipRateField.hidden = true
        tipRateButton.setTitle("", forState: UIControlState.Normal)
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onEditingChanged(sender: AnyObject) {
        tipRateFieldDefault()
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
        tipRateFieldDefault()
    }
    
    @IBAction func setCustomRate(sender: AnyObject) {
        tipRateField.hidden = true
        tipRateSegment.selectedSegmentIndex = 3
        tipRateField.becomeFirstResponder()
        if (tipRateSegment.titleForSegmentAtIndex(3) == "..."){
            tipRateField.text = ""
            tipRateSegment.setTitle("", forSegmentAtIndex: 3)
        } else {
            let currentCustomRateStr = tipRateSegment.titleForSegmentAtIndex(3)?.stringByReplacingOccurrencesOfString("%", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
            tipRateField.text = currentCustomRateStr
        }
    }
    
    @IBAction func tipRateFieldEditingChange(sender: AnyObject) {
        
        tipRateSegment.setTitle(tipRateField.text + "%", forSegmentAtIndex: 3)
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
    
    func animateGuestCheck(view: UIImageView, animationTime: Float){
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationCurve(UIViewAnimationCurve.EaseInOut)
        UIView.setAnimationDuration(NSTimeInterval(animationTime))
        UIView.setAnimationTransition(UIViewAnimationTransition.CurlDown, forView: view, cache: false)
    }
    
    func tipRateFieldDefault() {
        if (tipRateSegment.titleForSegmentAtIndex(3) == "") || (tipRateSegment.titleForSegmentAtIndex(3) == "%"){
            tipRateSegment.setTitle("...", forSegmentAtIndex: 3)
        }
    }
}

