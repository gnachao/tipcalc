//
//  UITableViewStaticTextfieldAndOptionViewController.swift
//
// GNA CHAO

/* NOTE:
[x] The CLASS is inherited from UIViewController, UITableViewDataSource, UITableViewDelegate
[x] Creates tableView obj and add it to view using view.addSubview(tableView) with the following configuration:
[x] tableView.dataSource = self
[x] tableView.delegate = self : so that the class can own the delegate methos of UITableViewController
[X] func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{...}
[x] it loops through array2D[indexPath.section][indexPath.row] for cell to return
[x] tableViewData = is the array2D of UITableViewCell to feed the table view
[x] customize cell and added to this array
[-] The rest are just makeup in which it's not hard to comprehend

FUTURE:
[X] getters and setters : a set of methods to retrieve or assign data form or to cell
*/

import UIKit

class SettingViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private var settingData = SettingData()
    
    var tableView: UITableView?
    var tableViewData = [[UITableViewCell]]()
    var sectionTitle = [String]()
    
    let defaultTipRateTextfield = UITextField()
    let minTipRateTextfield = UITextField()
    let maxTipRateTextfield = UITextField()
    let resetAllSettingButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView = UITableView(frame: view.bounds, style: .Grouped)
        
        // [?] why if let?
        if let theTableView = tableView{
            
            // Registers a class for use in creating new table cells.
            theTableView.registerClass(UITableViewCell.classForCoder(), forCellReuseIdentifier: "identifier")
            
            theTableView.dataSource = self // this class own datasource
            theTableView.delegate = self // this class is the owner of the delegate function
            theTableView.autoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight
            
            view.addSubview(theTableView)
        }
        addSetting()
        
    }
    
    // creating label
    func newLabelWithTitle(title: String) -> UILabel{
        let label = UILabel()
        label.text = title
        label.backgroundColor = UIColor.clearColor()
        label.sizeToFit()
        return label
    }
    
    // create textfield
    func newTextfield(placeholder: String?, keyboardType: UIKeyboardType, keyboardAppearance: UIKeyboardAppearance) -> UITextField{
        let textfield = UITextField()
        textfield.placeholder = placeholder
        textfield.backgroundColor = UIColor.clearColor()
        textfield.sizeToFit()
        textfield.keyboardType = keyboardType
        textfield.keyboardAppearance = keyboardAppearance
        textfield.textAlignment = .Right
        return textfield
    }
    
    // create cell with a textfield with title
    func newCellWithTextfieldAndTitle(title: String, textfield: UITextField, initValue: Double, placeholder: String, keyboardType: UIKeyboardType, keyboardAppearance: UIKeyboardAppearance, action: Selector, event: UIControlEvents)->UITableViewCell{
        let cell = UITableViewCell()
        
        cell.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.5)
        cell.textLabel?.text = title
        cell.textLabel?.sizeToFit()
        
        textfield.placeholder = placeholder
        textfield.backgroundColor = UIColor.clearColor()
        textfield.sizeToFit()
        textfield.keyboardType = keyboardType
        textfield.keyboardAppearance = keyboardAppearance
        textfield.textAlignment = .Right
        textfield.text = "\(initValue)"
        textfield.addTarget(self, action: action, forControlEvents: event)
        textfield.frame.size.width = UIScreen.mainScreen().bounds.width - cell.textLabel!.frame.size.width - 35
        cell.accessoryView = textfield
        
        return cell
    }
    
    // add settings to array2D to feed UITableView
    func addSetting(){
        // section: tip rate
        var tipRate = [UITableViewCell]()
        sectionTitle.append("Tip Rate")
        tipRate.append(newCellWithTextfieldAndTitle("Default", textfield: defaultTipRateTextfield, initValue: settingData.defaultTipRate, placeholder: "%", keyboardType: UIKeyboardType.DecimalPad, keyboardAppearance: UIKeyboardAppearance.Dark, action: "defaultTipRateEditingChange", event: UIControlEvents.EditingChanged))
        tipRate.append(newCellWithTextfieldAndTitle("Minimum", textfield: minTipRateTextfield, initValue: settingData.minTipRate, placeholder: "%", keyboardType: UIKeyboardType.DecimalPad, keyboardAppearance: UIKeyboardAppearance.Dark, action: "minimumTipRateEditingChange", event: UIControlEvents.EditingChanged))
        tipRate.append(newCellWithTextfieldAndTitle("Maximum", textfield: maxTipRateTextfield, initValue: settingData.maxTipRate, placeholder: "%", keyboardType: UIKeyboardType.DecimalPad, keyboardAppearance: UIKeyboardAppearance.Dark, action: "maximumTipRateEditingChange", event: UIControlEvents.EditingChanged))
        tableViewData.append(tipRate)
        
        // reset default
        var reset = [UITableViewCell]()
        sectionTitle.append("Reset")
        
        var resetAllSettingCell = UITableViewCell()
        resetAllSettingButton.setTitle("Reset All setting", forState: UIControlState.Normal)
        resetAllSettingButton.setTitleColor(self.view.tintColor, forState: UIControlState.Normal)
        resetAllSettingButton.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Left
        resetAllSettingButton.frame = CGRectInset(resetAllSettingCell.contentView.bounds, 15, 0)
        resetAllSettingButton.addTarget(self, action: "resetAllSetting", forControlEvents: UIControlEvents.TouchUpInside)
        resetAllSettingCell.addSubview(resetAllSettingButton)
        reset.append(resetAllSettingCell)
        
        tableViewData.append(reset)
       
    }
    
    func resetAllSetting(){
        println("Press reset all setting")
        settingData.resetAllSetting()
        defaultTipRateTextfield.text = "\(settingData.defaultTipRate)"
        minTipRateTextfield.text = "\(settingData.minTipRate)"
        maxTipRateTextfield.text = "\(settingData.maxTipRate)"
    }
    
    func defaultTipRateEditingChange(){
        let defaultTipRateStr: NSString = defaultTipRateTextfield.text
        settingData.saveDefaultTipRate(defaultTipRateStr.doubleValue)
    }
    
    func minimumTipRateEditingChange(){
        let minTipRateStr: NSString = minTipRateTextfield.text
        settingData.saveMinTipRate(minTipRateStr.doubleValue)
    }
    
    func maximumTipRateEditingChange(){
        let maxTipRateStr: NSString = maxTipRateTextfield.text
        settingData.saveMaxTipRate(maxTipRateStr.doubleValue)
    }
    
    // define number of sections
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return tableViewData.count
    }
    
    // define number of rows in each sections
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewData[section].count
    }
    
    // return instances of the UITableViewCell class as rows that populated into table
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = tableViewData[indexPath.section][indexPath.row]
        return cell
    }
    
    // title sections
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitle[section]
    }
    
    // hide keyboard when tap anywhere on view
    @IBAction func tapView(sender: AnyObject) {
        view.endEditing(true)
    }
}

