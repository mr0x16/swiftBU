//
//  threadViewController.swift
//  swiftTest
//
//  Created by bocom on 16/3/23.
//  Copyright © 2016年 com.bankcomm. All rights reserved.
//

import UIKit

class threadViewController: UIViewController {
    let delegate = UIApplication.sharedApplication().delegate as! AppDelegate
    let modalView = secViewController()
    let tableView = UITableView()
    let collView = UIView()
    var screenWidth:CGFloat = 0
    var collHeight:CGFloat = 0
    var fid:String = ""
    var dateSource = NSObject()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.backgroundColor = UIColor(red: 204/255, green: 232/255, blue: 255/255, alpha: 1)
        self.view.backgroundColor = UIColor(red: 204/255, green: 232/255, blue: 255/255, alpha: 1)
        modalView.modalPresentationStyle = .OverCurrentContext
        modalView.modalTransitionStyle = .CrossDissolve
        
        self.screenWidth = UIScreen.mainScreen().bounds.width
        self.collHeight = self.screenWidth/3
        self.fid = delegate.currFrmId
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 100
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        let forum = delegate.frmList.valueForKey(self.fid) as! forumCell
        self.title = forum.frmName
        delegate.homePostList.removeAll()
//        if forum.subArray.count > 3 {
//            
//        }
        collView.backgroundColor = UIColor.grayColor()
        self.view.addSubview(collView)
        collView.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(view.snp_top).offset(64)
            make.left.equalTo(view.snp_left)
            make.right.equalTo(view.snp_right)
            make.height.equalTo(collHeight)
        }
        self.view.addSubview(tableView)
        tableView.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(collView.snp_bottom)
            make.left.equalTo(view.snp_left)
            make.right.equalTo(view.snp_right)
            make.bottom.equalTo(view.snp_bottom)
        }
        view.backgroundColor = UIColor(red: 204/255, green: 232/255, blue: 255/255, alpha: 1)
        self.presentViewController(modalView, animated: true, completion:{ () -> Void in
            self.getPost(0,step: 15)
        })
        // Do any additional setup after loading the view.
    }
    
    func getPost(begin:Int, step:Int){
        let end = begin + step
//        delegate.homePostList.removeAll()
        delegate.listPosts(begin, end: end)!.responseJSON(completionHandler: { (response) -> Void in
            if response.result.isSuccess {
                let body = response.result.value as! NSDictionary
                if body.valueForKey("result") as! String == "success"{
                    NSLog("*****获取forum成功******")
                    var author:String
                    var fid:String
                    var tid:String
                    var tid_sum:String
                    var pname:String
                    var when:String
                    for post in body.valueForKey("threadlist") as! NSArray {
                        author = (post.valueForKey("author")!.stringByRemovingPercentEncoding!)!
                        fid = self.fid
                        tid = post.valueForKey("tid") as! String
                        tid_sum = post.valueForKey("replies") as! String
                        when = "unknown"//(post.valueForKey("lastpost")!.stringByRemovingPercentEncoding!)!
                        pname = (post.valueForKey("subject")!.stringByRemovingPercentEncoding!)!
                        let p = postCell(author: author, fid: fid, tid: tid, tid_sum: tid_sum, pname: pname, when: when)
                        self.delegate.homePostList.append(p)
                        
                    }
                    self.updateCell()
                }
            } else {
                let nserror = response.result.error! as NSError
                NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
            }
            self.dismissViewControllerAnimated(true, completion: { () -> Void in
                NSLog("dismiss Done")
            })
        })
    }
    
    func updateCell(){
        self.dateSource = indexDataSource(centerVc: self, cellDate: self.delegate.homePostList, cellId: "pCell", configureCell:{(cell, cellDate) in
            let pCell = cell as! indexPostCell
            pCell.configureForCell(cellDate as! postCell)
        })
        self.tableView.dataSource = dateSource as! indexDataSource
        self.tableView.delegate = dateSource as! indexDataSource
        self.tableView.reloadData()
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
