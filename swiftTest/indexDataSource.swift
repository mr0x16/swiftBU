//
//  indexDataSource.swift
//  swiftTest
//
//  Created by bocom on 16/3/17.
//  Copyright © 2016年 com.bankcomm. All rights reserved.
//

import UIKit

class indexDataSource: NSObject,UITableViewDataSource,UITableViewDelegate{
    var cellDate:[AnyObject]
    var cellId:String
    var configCell:((AnyObject, AnyObject) -> ())?
    
    init(cellDate:[AnyObject], cellId:String, configureCell:(AnyObject,AnyObject) -> ()){
        self.cellDate = cellDate
        self.cellId = cellId
        self.configCell = configureCell
        super.init()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int{
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellDate.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier(self.cellId) as UITableViewCell!
        if cell == nil{
            if self.cellId == "pCell" {
                cell = indexPostCell(style: UITableViewCellStyle.Default, reuseIdentifier: self.cellId)
            }
            cell?.selectionStyle = UITableViewCellSelectionStyle.None
        }
        let rowNo = indexPath.row as Int
        let currDate = cellDate[rowNo]
        configCell!(cell,currDate)
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        NSLog("selected \(indexPath.row)")
    }
}
