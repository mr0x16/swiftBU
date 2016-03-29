//
//  subViewController.swift
//  swiftTest
//
//  Created by 马雪松 on 16/3/24.
//  Copyright © 2016年 com.bankcomm. All rights reserved.
//

import UIKit

protocol subViewDelegate {
    func foo(fid:String)
}

class subViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    let delegate = UIApplication.sharedApplication().delegate as! AppDelegate
    var delegateView:subViewDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let xGap = UIScreen.mainScreen().bounds.width/7
        let yGap = UIScreen.mainScreen().bounds.height/7
        
        
        let delegate = (UIApplication.sharedApplication().delegate) as! AppDelegate
        delegate.window?.backgroundColor = UIColor(red: 204/255, green: 232/255, blue: 255/255, alpha: 1)
    
        
//        let containView = UIView()
        
//        containView.backgroundColor = UIColor(red: 204/255, green: 232/255, blue: 255/255, alpha: 1)
//        self.view.addSubview(containView)
        let tableView = UITableView()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        tableView.backgroundColor = UIColor.whiteColor()
        view.addSubview(tableView)
        tableView.registerClass(testTableViewCell.self, forCellReuseIdentifier: "fCell")
        let cell = UITableViewCell(style: .Default, reuseIdentifier: "fCell")
        let cellNum = CGFloat((delegate.frmList.valueForKey(delegate.currFrmId) as! forumCell).subArray.count)
        tableView.snp_makeConstraints { (make) in
            make.centerX.equalTo(view.snp_centerX)
            make.centerY.equalTo(view.snp_centerY).offset(-yGap/4)
            make.left.equalTo(view.snp_left).offset(xGap)
            make.right.equalTo(view.snp_right).offset(-xGap)
            make.height.equalTo(cell.frame.height * cellNum)
        }
        
        tableView.dataSource = self
        tableView.delegate = self
        
        let btnCancel = UIButton(type: .System)
        btnCancel.setTitle("返回", forState: .Normal)
        btnCancel.setTitleColor(UIColor.blackColor(), forState: .Normal)
        btnCancel.addTarget(self, action: #selector(subViewController.cancelView), forControlEvents: .TouchUpInside)
        btnCancel.backgroundColor = UIColor(red: 204/255, green: 232/255, blue: 255/255, alpha: 1)
        view.addSubview(btnCancel)
        btnCancel.snp_makeConstraints { (make) in
            make.left.equalTo(view.snp_left).offset(xGap)
            make.right.equalTo(view.snp_right).offset(-xGap)
            make.top.equalTo(tableView.snp_bottom)
            make.height.equalTo(yGap/2)
        }
        
//        containView.snp_makeConstraints { (make) -> Void in
//            make.center.equalTo(view.snp_center)
//            make.top.equalTo(tableView.snp_top)
//            make.left.equalTo(view.snp_left).offset(xGap)
//            make.right.equalTo(view.snp_right).offset(-xGap)
//        }
        // Do any additional setup after loading the view.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        var fid = delegate
        return (delegate.frmList.valueForKey(delegate.currFrmId) as! forumCell).subArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("fCell") as! testTableViewCell
        let row = indexPath.row
        let subId = (delegate.frmList.valueForKey(delegate.currFrmId) as! forumCell).subArray.objectAtIndex(row) as! String
        let currDate = delegate.subList.valueForKey(subId) as! subCell
        NSLog("Titel is \(currDate.frmName)")
        let encodedData = currDate.frmName.dataUsingEncoding(NSUTF8StringEncoding)!
        let attributedOptions = [NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType]
        do{
            let attributeString = try NSAttributedString(data: encodedData, options: attributedOptions, documentAttributes: nil)
            NSLog("attributedText is \(attributeString)")
            cell.mainLab.attributedText = attributeString
            
        } catch {
            print("Cannot create attributed String")
        }
        cell.descLab.text = currDate.desc
        cell.fid = currDate.fid
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let row = indexPath.row
        let subId = (delegate.frmList.valueForKey(delegate.currFrmId) as! forumCell).subArray.objectAtIndex(row) as! String
        self.dismissViewControllerAnimated(true, completion:{ () -> Void in
            self.delegateView?.foo(subId)
        })
    }
    
    func cancelView() -> Void {
        self.dismissViewControllerAnimated(true,completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
