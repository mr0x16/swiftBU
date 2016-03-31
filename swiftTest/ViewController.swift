//
//  ViewController.swift
//  swiftTest
//
//  Created by bocom on 16/1/23.
//  Copyright © 2016年 com.bankcomm. All rights reserved.
//

import UIKit
import SnapKit
import Alamofire
import CoreData


protocol ViewControllerDelegate {
    func toggleLeftPanel()
    func collapseSidePanels()
}

extension ViewController: SidePanelViewControllerDelegate{
    func showCenter(){
        delegateView?.collapseSidePanels()
    }
}



class ViewController: UITableViewController{
    let delegate = (UIApplication.sharedApplication().delegate) as! AppDelegate
    var delegateView: ViewControllerDelegate?
    var pTran = paramsTrans()
    var forumList = NSMutableDictionary()
    dynamic var stateCount = 0
    private var mycontext = 0
    let modalView = secViewController()
    var dateSource = NSObject()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 204/255, green: 232/255, blue: 255/255, alpha: 1)
        modalView.modalPresentationStyle = .OverCurrentContext
        modalView.modalTransitionStyle = .CrossDissolve
        modalView.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 100
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        self.navigationController?.navigationBar.backgroundColor = UIColor(red: 51/255, green: 165/255, blue: 252/255, alpha: 1.0)
        NSLog("---\(self.classForCoder):加载成功---")   //转跳成功日志
        self.title = "BU"
//        self.tableView.dequeueReusableCellWithIdentifier("pCell")
        let left = UIBarButtonItem(title: "Left", style: .Plain, target: self, action: #selector(ViewController.leftButton))
        self.navigationItem.leftBarButtonItem = left
        self.addObserver(self, forKeyPath: "stateCount", options: .New, context:&mycontext)
        if delegate.getData().nums != 0{
            userLog()
        }
    }
    

    
    override func viewDidAppear(animated: Bool) {
//        NSLog("**********%@***********",self.delegate.strDate as String)
        if delegate.getData().nums == 0 {
            self.navigationItem.leftBarButtonItem?.enabled = false
            segueSetting()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - 其他方法
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if(context == &mycontext){
            if stateCount == 4 {
                modalView.dismissViewControllerAnimated(true, completion: nil)
//                NSLog("执行刷新")
                self.setUpCell("pCell",local: 0)
            }
        }
    }
    
    func setUpCell(cId:String, local:Int){
        switch cId {
            case "pCell":
                self.dateSource = indexDataSource(centerVc: self, cellDate: self.delegate.homePostList, cellId: cId, configureCell:{(cell, cellDate) in
                    let pCell = cell as! indexPostCell
                    pCell.configureForCell(cellDate as! postCell)
                })
            case "fCell":
                
                self.dateSource = indexDataSource(centerVc: self,cellDate: self.delegate.grpList[local].frmArray as [AnyObject], cellId: cId, configureCell:{(cell, cellDate) in
                    let pCell = cell as! testTableViewCell
                    pCell.configureForCell(cellDate as! forumCell)
                })
            default:
                 break
        }
        
        self.tableView.dataSource = dateSource as! indexDataSource
        self.tableView.delegate = dateSource as! indexDataSource
        
        self.tableView.reloadData()
        
        if cId == "pCell"{
            let diff = 0.005
            let cells:[indexPostCell] = self.tableView.visibleCells as! [indexPostCell]
            for cell in cells{
                cell.transform = CGAffineTransformMakeTranslation(UIScreen.mainScreen().bounds.width, 0)
            }
            for i in 0..<cells.count {
                let cell:indexPostCell = cells[i] as indexPostCell
                let delay = diff*Double(i)
                UIView.animateWithDuration(1, delay: delay, options: UIViewAnimationOptions.AllowAnimatedContent, animations: { () -> Void in
                    cell.transform = CGAffineTransformMakeTranslation(0, 0)
                    }, completion: nil)
            }
        } else {
            let diff = 0.15
            let cells:[testTableViewCell] = self.tableView.visibleCells as! [testTableViewCell]
            for cell in cells{
                cell.transform = CGAffineTransformMakeTranslation(0,0)
            }
            for i in 0..<cells.count {
                let cell:testTableViewCell = cells[i] as testTableViewCell
                let delay = diff*Double(i)
                UIView.animateWithDuration(1, delay: delay, options: UIViewAnimationOptions.AllowAnimatedContent, animations: { () -> Void in
                    cell.transform = CGAffineTransformMakeTranslation(0, 0)
                    }, completion: nil)
            }
        }
    }
    
    func leftButton() {
        NSLog("left button")
        delegateView?.toggleLeftPanel()
    }
    
    func updateHomePost(){
        self.presentViewController(modalView, animated: true, completion: nil)
        self.leftButton()
        self.getHome()
    }
    
    func changeCell(local:Int){
        NSLog("call change")
        self.leftButton()
        self.setUpCell("fCell",local: local)
    }
    
    func segueSetting()->Void {
        
        let userNum = delegate.getData().nums
        var setView = UIViewController()
        if userNum != 0{
            setView = userListViewController()
        } else {
            setView = setViewController()
        }
        self.navigationController?.pushViewController(setView, animated: true)
    }
    

    
    func userLog(){
        self.presentViewController(modalView, animated: true, completion: nil)
        delegate.login()!.responseJSON{ response in
            if response.result.isSuccess {
                let body = response.result.value as! NSDictionary
                if body.valueForKey("result") as! String == "success"{
                    NSLog("*****论坛登录成功******")
                    self.pTran.paramsSet("session", value: body.valueForKey("session")!)
                    self.pTran.paramsSet("uid", value: body.valueForKey("uid")!)
                    self.pTran.paramsSet("status", value: body.valueForKey("status")!)
                    self.pTran.paramsSet("credit", value: body.valueForKey("credit")!)
                    self.stateCount += 1
                    let threadIndex = NSThread(target: self, selector: #selector(ViewController.getHome), object: nil)
                    let threadInfo = NSThread(target: self, selector: #selector(ViewController.userInfo), object: nil)
                    let threadFrm = NSThread(target: self, selector: #selector(ViewController.listFrm), object: nil)
                    threadIndex.start()
                    threadInfo.start()
                    threadFrm.start()
                } else {
                    let msg = body.valueForKey("msg") as! String
                    self.dismissViewControllerAnimated(true, completion: nil)
                    NSLog("*****论坛登录失败:\(msg)******")
                }
            } else {
                let nserror = response.result.error! as NSError
                NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }

    }
    
    func getHome(){
        delegate.indexPost()!.responseJSON{response in
            self.delegate.homePostList.removeAll()
            if response.result.isSuccess {
                let body = response.result.value as! NSDictionary
                if body.valueForKey("result") as! String == "success"{
                    var author:String
                    var fid:String
                    var tid:String
                    var tid_sum:String
                    var pname:String
                    var when:String
                    NSLog("*****获取首页帖子成功******")
                    for post in body.valueForKey("newlist") as! NSArray {
                        author = (post.valueForKey("author")!.stringByRemovingPercentEncoding!)!
                        fid = post.valueForKey("fid") as! String
                        tid = post.valueForKey("tid") as! String
                        tid_sum = post.valueForKey("tid_sum") as! String
                        when = (post.valueForKey("lastreply")!.valueForKey("when")!.stringByRemovingPercentEncoding!)!
                        pname = (post.valueForKey("pname")!.stringByRemovingPercentEncoding!)!
                        let p = postCell(author: author, fid: fid, tid: tid, tid_sum: tid_sum, pname: pname, when: when)
                        self.delegate.homePostList.append(p)
                        if self.stateCount >= 4{
                            self.setUpCell("pCell", local: 0)
                            self.modalView.dismissViewControllerAnimated(true, completion: nil)
                        }
                    }
                    self.stateCount += 1
                }
            }
        }
    }
    
    func userInfo(){
        delegate.getUserInfo()?.responseJSON(completionHandler: { (response) -> Void in
            if response.result.isSuccess{
                let body = response.result.value as! NSDictionary
                if body.valueForKey("result") as! String == "success"{
                    let content = body.valueForKey("memberinfo") as! NSDictionary
                    self.pTran.paramsSet("avatar", value:(content.valueForKey("avatar")!.stringByRemovingPercentEncoding!)!)
                    NSLog("**********\(self.pTran.paramsGet("avatar"))************")
                    self.pTran.paramsSet("bday", value: content.valueForKey("bday")!)
                    self.pTran.paramsSet("postnum", value: content.valueForKey("postnum")!)
                    self.pTran.paramsSet("threadnum", value: content.valueForKey("threadnum")!)
                    self.pTran.paramsSet("regdate", value: content.valueForKey("regdate")!)
                    self.pTran.paramsSet("lastvisit", value: content.valueForKey("lastvisit")!)
                    let url = "http://out.bitunion.org/" + (self.pTran.paramsGet("avatar") as! String)
                    NSLog("*********\(url)**********")
                    Alamofire.request(.GET, url).responseData({ (response) -> Void in
                        if response.result.isSuccess {
                            let data = response.data!
                            self.delegate.image = UIImage(data: data)
                            NSLog("Success: %d", data.length)
                            self.stateCount += 1
                        }
                    })
                }
            }
        })
    }
    
    func listFrm(){
        delegate.listForum()?.responseJSON(completionHandler: { (response) -> Void in
            if response.result.isSuccess {
                let body = response.result.value as! NSDictionary
                if body.valueForKey("result") as! String == "success"{
                    self.delegate.grpList.removeAll();
                    self.delegate.frmList.removeAllObjects()
                    self.delegate.subList.removeAllObjects()
                    NSLog("*****论坛列表获取成功******")
                    var forumName:String
                    var forumId:String
                    var forumDesc: String
                    var grpBody = NSDictionary()
                    var subArray = NSArray()
                    var frmBody = NSDictionary()
                    var grpCal = 0
                    var frmStr:String
                    for grp in body.valueForKey("forumslist")!.allKeys{
                        if grp as! String != ""{
                            grpBody = body.valueForKey("forumslist")?.valueForKey(grp as! String) as! NSDictionary
                            forumName = (grpBody.valueForKey("main")?.valueForKey("name")!.stringByRemovingPercentEncoding!)!
                            forumId = grpBody.valueForKey("main")?.valueForKey("fid") as! String
                            self.delegate.grpList.append(groupCell(grpName: forumName, fid: forumId))
//                            NSLog("GROUP name is \(forumName),id is \(forumId)")
                            for frm in grpBody.allKeys {
                                if frm as! String != "main"{
                                    forumName = (grpBody.valueForKey(frm as! String)?.valueForKey("main")?.firstObject!!.valueForKey("name")!.stringByRemovingPercentEncoding!)!
                                    if forumName == "后台管理区" {
                                        continue
                                    }
                                    forumDesc = (grpBody.valueForKey(frm as! String)?.valueForKey("main")?.firstObject!!.valueForKey("description")!.stringByRemovingPercentEncoding!)!
                                    forumId = grpBody.valueForKey(frm as! String)?.valueForKey("main")?.firstObject!!.valueForKey("fid")! as! String
                                    self.delegate.frmList.setValue(forumCell(frmName: forumName, fid: forumId, desc: forumDesc), forKey: forumId)
                                    self.delegate.grpList[grpCal].frmArray.addObject(forumId)
                                    frmStr = forumId
//                                    NSLog("---FORUM name is \(forumName),id is \(forumId)")
                                    frmBody = grpBody.valueForKey(frm as! String) as! NSDictionary
                                    if frmBody.count == 2{
                                        subArray = frmBody.valueForKey("sub") as! NSArray
                                        for sub in subArray{
                                            forumName = (sub.valueForKey("name")?.stringByRemovingPercentEncoding)!
                                            forumId = sub.valueForKey("fid") as! String
                                            forumDesc = (sub.valueForKey("description")?.stringByRemovingPercentEncoding)!
                                            self.delegate.subList.setValue(subCell(frmName: forumName, fid: forumId, desc: forumDesc), forKey: forumId)
                                            (self.delegate.frmList.valueForKey(frmStr) as! forumCell).subArray.addObject(forumId)
                                            (self.delegate.frmList.valueForKey(frmStr) as! forumCell).subArray.count
//                                            NSLog("-------SUB name is \(forumName),id is \(forumId)")
                                        }
                                    }
                                }
                            }
                            grpCal += 1
                        }
                    }
                    self.stateCount += 1
                } else {
                    let msg = body.valueForKey("msg") as! String
                    NSLog("*****获取论坛列表失败:\(msg)******")
                }
            } else {
                let nserror = response.result.error! as NSError
                NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        })
        
    }
    

}

