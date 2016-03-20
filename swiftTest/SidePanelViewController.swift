//
//  SidePanelViewController.swift
//  swiftTest
//
//  Created by 马雪松 on 16/2/5.
//  Copyright © 2016年 com.bankcomm. All rights reserved.
//

import UIKit

protocol SidePanelViewControllerDelegate {
    func showCenter()
}

class SidePanelViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var delegateView : SidePanelViewControllerDelegate?
    let delegate = (UIApplication.sharedApplication().delegate) as! AppDelegate
    let pTran = paramsTrans()
    let avatar = UIImageView(frame: CGRectZero)
    override func viewDidLoad() {
        super.viewDidLoad()
        NSLog("---\(self.classForCoder):加载成功---")   //转跳成功日志
        self.view.backgroundColor = UIColor(red: 142/255, green: 167/255, blue: 207/255, alpha: 1)
        let list = UITableView(frame: CGRectZero, style: UITableViewStyle.Plain)
        
        let userLab = UILabel()
        userLab.text = pTran.paramsGet("userName") as? String
        userLab.textAlignment = .Center
        userLab.adjustsFontSizeToFitWidth = true
        userLab.font = UIFont(name:"Helvetica", size: 20)
        
        let vTop = UIView(frame: CGRectZero)
        
        let btnSetting = UIButton(type: .System)

        self.view.addSubview(btnSetting)
        let splashWidth = CGRectGetWidth(UIScreen.mainScreen().bounds) - 200
        self.view.addSubview(list)
        self.view.addSubview(vTop)
        self.view.addSubview(userLab)
        vTop.addSubview(avatar)
        
        let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Cell")
        let cellNum = CGFloat(delegate.grpList.count)
        list.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(0)
            make.centerY.equalTo(self.view.snp_centerY).offset(30)
            make.width.equalTo(splashWidth)
            make.height.equalTo(cell.frame.height * cellNum)
        }
        vTop.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(0)
            make.left.equalTo(0)
            make.width.equalTo(splashWidth)
            make.bottom.equalTo(list.snp_top)
        }
        avatar.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(vTop.snp_top).offset(20)
            make.centerX.equalTo(vTop.snp_centerX)
            make.width.equalTo(splashWidth-50)
            make.height.equalTo(avatar.snp_width)
        }
        userLab.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(avatar.snp_bottom).offset(20)
            make.centerX.equalTo(avatar.snp_centerX)
            make.width.equalTo(avatar.snp_width)
            make.bottom.equalTo(list.snp_top).offset(-20)
        }
        btnSetting.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(self.view.snp_left).offset(20)
            make.bottom.equalTo(self.view.snp_bottom).offset(-20)
        }

        btnSetting.setTitle("设置", forState: .Normal)
        btnSetting.setTitleColor(UIColor.blackColor(), forState: .Normal)
        btnSetting.addTarget(self, action: "segueSetting", forControlEvents: .TouchUpInside)
        
        avatar.image = delegate.image
        list.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        list.backgroundColor = self.view.backgroundColor
        list.tableFooterView = UIView(frame:CGRectZero)
        list.scrollEnabled = false
        list.delegate = self
        list.dataSource = self
        self.view.subviews
        list.visibleCells
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        NSLog("Did Appear!")
//        let url = "http://out.bitunion.org/" + (pTran.paramsGet("avatar") as! String)
//        self.downloadImageFromURL(url)
//        let thdImg = NSThread(target:self, selector:Selector("downloadImageFromURL:"), object:url)
//        thdImg.start()
    }
    
    func segueSetting()->Void {
        var setView = UIViewController()
        setView = userListViewController()
        let nv = UINavigationController(rootViewController: setView)
        nv.modalTransitionStyle = .CrossDissolve
        self.presentViewController(nv, animated: true) { () -> Void in
            
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let grpCount = delegate.grpList.count
        return grpCount;
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        NSLog("\(indexPath.row)")
        let centerVC = (delegate.window?.rootViewController?.childViewControllers[0] as! UINavigationController).viewControllers[0] as! ViewController
        NSLog("\(centerVC)")
        centerVC.changeCell()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("Cell")
        if(cell == nil){
           cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Cell")
        }
        cell!.backgroundColor = self.view.backgroundColor
        let row = indexPath.row
        NSLog("\(row):\(delegate.grpList[row].grpName)")
        cell!.textLabel!.text = delegate.grpList[row].grpName
        cell?.textLabel?.textAlignment = .Center
        return cell!
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
