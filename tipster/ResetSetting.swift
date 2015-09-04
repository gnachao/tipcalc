//
//  ResetSetting.swift
//  tipster
//
//  Created by MacBKPro on 9/4/15.
//  Copyright (c) 2015 codepath-gna. All rights reserved.
//

// When things become big and complicated, this class will be created for another reset setting scene

import UIKit

//class ResetSetting: UIViewController, UITableViewDataSource, UITableViewDelegate {

//    var tableView: UITableView?
//    var tableViewData = [[UITableViewCell]]()
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        tableView = UITableView(frame: view.bounds, style: .Grouped)
//        
//        // [?] why if let?
//        if let theTableView = tableView{
//            
//            // Registers a class for use in creating new table cells.
//            theTableView.registerClass(UITableViewCell.classForCoder(), forCellReuseIdentifier: "resetSetting")
//            
//            theTableView.dataSource = self // this class own datasource
//            theTableView.delegate = self // this class is the owner of the delegate function
//            theTableView.autoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight
//            
//            view.addSubview(theTableView)
//        }
//    }
//}