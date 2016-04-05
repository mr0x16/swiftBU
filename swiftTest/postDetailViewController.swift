//
//  TableViewController.swift
//  swiftTest
//
//  Created by bocom on 16/4/5.
//  Copyright © 2016年 com.bankcomm. All rights reserved.
//

import UIKit

class postDetailViewController: UIViewController,UITableViewDelegate, UITableViewDataSource{
    let delegate = UIApplication.sharedApplication().delegate as! AppDelegate
    var tid:String = ""
    let modalView = secViewController()
    let replyList = [replayCell]()
    
    convenience init(tid:String){
        self.init()
        self.tid = tid
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 204/255, green: 232/255, blue: 255/255, alpha: 1)
        let rightBtn = UIBarButtonItem(barButtonSystemItem: .Compose, target: self, action: #selector(self.addReply))
        self.navigationItem.rightBarButtonItem = rightBtn
        modalView.modalPresentationStyle = .OverCurrentContext
        modalView.modalTransitionStyle = .CrossDissolve
        modalView.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        self.presentViewController(modalView, animated: true, completion: { () -> Void in
            self.getDetail(self.tid, begin: 0, end: 15)
        })
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    func addReply() -> Void {
        NSLog("I want Add Reply!")
    }
    
    func getDetail(tid:String, begin:Int, end:Int){
        delegate.listDetail(tid, begin: begin, end: end)!.responseJSON{response in
            if response.result.isSuccess{
                let body = response.result.value as! NSDictionary
                if body.valueForKey("result") as! String == "success"{
//                    NSLog(body.description)
                    for reply in body.valueForKey("postlist") as! NSArray {
                        NSLog((reply.valueForKey("message") as! String).stringByRemovingPercentEncoding!)
                        NSLog("\n")
                    }
                }
            }
        }
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell")
        
        return cell!
    }

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
