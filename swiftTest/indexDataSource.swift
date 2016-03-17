//
//  indexDataSource.swift
//  swiftTest
//
//  Created by bocom on 16/3/17.
//  Copyright © 2016年 com.bankcomm. All rights reserved.
//

import UIKit

class indexDataSource: NSObject,UITableViewDataSource{
    var delegate = UIApplication.sharedApplication().delegate as! AppDelegate
    override init() {
        super.init()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int{
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.delegate.homePostList.count == 0{
            return 0
        }
        return self.delegate.homePostList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("cell") as? indexPostCell
        if cell == nil{
            cell = indexPostCell(style: UITableViewCellStyle.Default, reuseIdentifier: "cell")
            cell?.selectionStyle = UITableViewCellSelectionStyle.None
        }
        let rowNo = indexPath.row as Int
        let currPost = self.delegate.homePostList[rowNo]
        let authorText = currPost.author
        let whenText = currPost.when
        let tid_sumText = currPost.tid_sum
        let titleText = currPost.pname
        cell!.pLabel.text = titleText
        cell!.aLabel.text = "发帖人：\(authorText)"
        cell!.wLabel.text = "最后回复：\(whenText)"
        cell!.tLabel.text = "回复数：\(tid_sumText)"
        return cell!
    }
}
