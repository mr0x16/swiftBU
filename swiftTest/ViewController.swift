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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        modalView.modalPresentationStyle = .OverCurrentContext
        modalView.modalTransitionStyle = .CrossDissolve
        
        
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 100
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        
        self.navigationController?.navigationBar.backgroundColor = UIColor(red: 51/255, green: 165/255, blue: 252/255, alpha: 1.0)
        NSLog("---\(self.classForCoder):加载成功---")   //转跳成功日志
        self.title = "BU"
        self.tableView.dequeueReusableCellWithIdentifier("pCell")
        let left = UIBarButtonItem(title: "Left", style: .Plain, target: self, action: Selector("leftButton"))
        self.navigationItem.leftBarButtonItem = left
        self.addObserver(self, forKeyPath: "stateCount", options: .New, context:&mycontext)
        if delegate.getData().nums != 0{
            userLog()
        }
    }
    

    
    override func viewDidAppear(animated: Bool) {
//        NSLog("**********%@***********",self.delegate.strDate as String)
        if delegate.getData().nums == 0 {
            segueSetting()
        } else {
            self.presentViewController(modalView, animated: true, completion: nil)
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
                self.dismissViewControllerAnimated(true, completion: nil)
                self.setUpCell()
            }
        }
    }
    
    func setUpCell(){
        let dateSource = indexDataSource(cellDate: self.delegate.homePostList, cellId: "pCell", configureCell:{(cell, cellDate) in
            let pCell = cell as! indexPostCell
            pCell.configureForCell(cellDate as! postCell)
        })
        self.tableView.dataSource = dateSource
        self.tableView.reloadData()
        let diff = 0.015
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
    }
    
    func leftButton() {
        NSLog("left button")
        delegateView?.toggleLeftPanel()
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
        delegate.login()!.responseJSON{ response in
            if response.result.isSuccess {
                let body = response.result.value as! NSDictionary
                if body.valueForKey("result") as! String == "success"{
                    NSLog("*****论坛登录成功******")
                    self.pTran.paramsSet("session", value: body.valueForKey("session")!)
                    self.pTran.paramsSet("uid", value: body.valueForKey("uid")!)
                    self.pTran.paramsSet("status", value: body.valueForKey("status")!)
                    self.pTran.paramsSet("credit", value: body.valueForKey("credit")!)
                    self.stateCount++
                    let threadIndex = NSThread(target: self, selector: "getHome", object: nil)
                    let threadInfo = NSThread(target: self, selector: "userInfo", object: nil)
                    let threadFrm = NSThread(target: self, selector: "listFrm", object: nil)
                    threadIndex.start()
                    threadInfo.start()
                    threadFrm.start()
                } else {
                    let msg = body.valueForKey("msg") as! String
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
                    }
                    self.stateCount++
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
                            self.stateCount++
                        }
                    })
                }
                
//                self.performSelectorOnMainThread(Selector("dimissModal"), withObject:nil, waitUntilDone: true)
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
                                            self.delegate.subList.setValue(subCell(subName: forumName, fid: forumId), forKey: forumId)
                                            (self.delegate.frmList.valueForKey(frmStr) as! forumCell).subArray.addObject(forumId)
                                            (self.delegate.frmList.valueForKey(frmStr) as! forumCell).subArray.count
//                                            NSLog("-------SUB name is \(forumName),id is \(forumId)")
                                        }
                                    }
                                }
                            }
                            grpCal++
                        }
                    }
                    self.stateCount++
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

