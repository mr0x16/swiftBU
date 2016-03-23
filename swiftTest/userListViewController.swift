//
//  userListViewController.swift
//  swiftTest
//
//  Created by bocom on 16/1/26.
//  Copyright © 2016年 com.bankcomm. All rights reserved.
//

import UIKit
import CoreData

class userListViewController: UITableViewController{
    let delegate = (UIApplication .sharedApplication().delegate) as! AppDelegate
    var userArray = NSMutableArray()
    var pTran = paramsTrans()
    override func viewDidLoad() {
        super.viewDidLoad()
        NSLog("---\(self.classForCoder):加载成功---")   //转跳成功日志
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        let tempArray = delegate.getData().users
        userArray = tempArray.mutableCopy() as! NSMutableArray
        NSLog("Load: list has \(delegate.getData().nums) cells")
        
        let addBtn = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: #selector(userListViewController.segueSetting))
        navigationItem.rightBarButtonItem = addBtn
        let dimBtn = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: #selector(userListViewController.done))
        navigationItem.leftBarButtonItem = dimBtn
    }
    
    override func viewDidAppear(animated: Bool) {
        let tempArray = delegate.getData().users
        userArray = tempArray.mutableCopy() as! NSMutableArray
        NSLog("Appear:list has \(delegate.getData().nums) cells")
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

//    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 1
//    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        NSLog("select \(indexPath.row) cell")
        self.navigationController?.navigationBar.backgroundColor = UIColor(red: 51/255, green: 165/255, blue: 252/255, alpha: 1.0)
        let row = indexPath.row
        let name = userArray[row].valueForKey("userName") as! String
        let key = userArray[row].valueForKey("passWord") as! String
        self.pTran.paramsSet("userName", value: name)
        self.pTran.paramsSet("passWord", value: key)
        let rootView = ContainerViewController()
        delegate.grpList.removeAll()
        delegate.frmList.removeAllObjects()
        delegate.subList.removeAllObjects()
        delegate.image = UIImage()
        navigationController?.presentViewController(rootView, animated: true, completion: { () -> Void in
            NSLog("present success!")
        })
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        let rowNum = delegate.getData().nums
        return rowNum
    }
    
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        cell.accessoryType = UITableViewCellAccessoryType.DetailButton
        
        let row = indexPath.row as Int
        let userCell = userArray[row]
        let txtContext = userCell.valueForKey("userName") as? String
        NSLog("\(row+1) cell is \(txtContext!)")
        cell.textLabel!.text = txtContext
//         Configure the cell...
        return cell
    }
    
    func segueSetting()->Void {
        var setView = UIViewController()
        setView = setViewController()
        self.navigationController?.pushViewController(setView, animated: true)
    }
    
    
    func done() {
        NSLog("????????????")
        self.dismissViewControllerAnimated(true) { () -> Void in
            
        }
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            let row = indexPath.row
            let tempCell = userArray.objectAtIndex(row) as! NSManagedObject
            delegate.delData(tempCell)
            userArray.removeObjectAtIndex(row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    override func tableView(tableView: UITableView, accessoryButtonTappedForRowWithIndexPath indexPath: NSIndexPath) {
        NSLog("tap \(indexPath.row) cell")
        let row = indexPath.row
        let name = userArray[row].valueForKey("userName") as! String
        let key = userArray[row].valueForKey("passWord") as! String
        self.pTran.paramsSet("index", value: row)
        NSLog("num \(row) name is \(name) password is \(key)")
        let modifyView = modifyViewController()
        self.navigationController?.pushViewController(modifyView, animated: true)
    }
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
