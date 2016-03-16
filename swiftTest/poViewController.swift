//
//  poViewController.swift
//  swiftTest
//
//  Created by 马雪松 on 16/2/1.
//  Copyright © 2016年 com.bankcomm. All rights reserved.
//

import UIKit

class fCell{
    var fName: String
    var fId: String
    var fAuthor:String
    var fViews: Int
    var replies:Int
    
    init(name:String, id:String, author: String, views:Int, reply:Int){
        self.fName = name
        self.fId = id
        self.fAuthor = author
        self.fViews = views
        self.replies = reply
    }
}

class poViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    var frmId:String = ""
    var frmName:String = ""
    var subArray = NSArray()
    var postArray = NSMutableArray()
    let delegate = (UIApplication.sharedApplication().delegate) as! AppDelegate
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        let poTable = UITableView()
        view.addSubview(poTable)
        poTable.dataSource = self;
        poTable.delegate = self;
        poTable.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell");
        frmId = self.delegate.currFrmId
        (self.frmName, self.subArray) = self.delegate.getFrmCell()
        self.title = "\(frmId):\(frmName)"
        poTable.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(view).offset(0)
            make.left.equalTo(view).offset(0)
            make.right.equalTo(view).offset(0)
            make.bottom.equalTo(view).offset(0)
        }
        self.delegate.listPosts(0, end: 20)!.responseJSON { (response) -> Void in
            let tempArray = response.result.value!.valueForKey("threadlist") as! NSArray
            for post in tempArray {
                let postTitle = (post.valueForKey("subject")!.stringByRemovingPercentEncoding!)!
                let author = (post.valueForKey("author")!.stringByRemovingPercentEncoding!)!
                self.postArray.addObject(post)
                NSLog("title is \(postTitle) author is \(author)")
            }
            poTable.reloadData()
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - tableView操作
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        NSLog("cell fuck!!!!!!!!!!!!!!!!!!!!!")
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        let row = indexPath.row
        cell.textLabel?.numberOfLines = 2
        cell.textLabel?.text = (self.postArray[row].valueForKey("subject")!.stringByRemovingPercentEncoding!)!
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        NSLog("number fuck!!!!!!!!!!!!!!!!!!!!!")
        return self.postArray.count;
    }
    
//    func numberOfSectionsInTableView(tableView: UITableView) -> Int{
////        NSLog("1 fuck!!!!!!!!!!!!!!!!!!!!!")
//        return 1
//    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
