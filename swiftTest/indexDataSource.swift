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
    let delegate = UIApplication.sharedApplication().delegate as! AppDelegate
    let centerView:UIViewController
    init(centerVc:UIViewController,cellDate:[AnyObject], cellId:String, configureCell:(AnyObject,AnyObject) -> ()){
        self.cellDate = cellDate
        self.cellId = cellId
        self.configCell = configureCell
        self.centerView = centerVc
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
            switch self.cellId {
                case "pCell":
                    cell = indexPostCell(style: UITableViewCellStyle.Default, reuseIdentifier: self.cellId)
                case "fCell":
                    cell = testTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: self.cellId)
                default:
                    break
            }
            cell?.selectionStyle = UITableViewCellSelectionStyle.None
        }
        let rowNo = indexPath.row as Int
        if cellId == "pCell"{
            configCell!(cell,cellDate[rowNo])
        } else {
            let currDate = delegate.frmList.valueForKey(cellDate[rowNo] as! String)
            configCell!(cell,currDate!)
        }
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if cellId == "pCell" {
            NSLog("selected \(indexPath.row) post")
        } else {
            NSLog("selected \(indexPath.row) forum")
            let rowNo = indexPath.row as Int
            let currDate = delegate.frmList.valueForKey(cellDate[rowNo] as! String) as! forumCell
            NSLog("fid is \(currDate.fid)")
            delegate.currFrmId = currDate.fid
            let threadView = threadViewController()
            centerView.navigationController?.pushViewController(threadView, animated: true)
        }
        
    }
}
