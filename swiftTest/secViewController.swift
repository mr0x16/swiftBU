//
//  secViewController.swift
//  swiftTest
//
//  Created by bocom on 16/1/25.
//  Copyright © 2016年 com.bankcomm. All rights reserved.
//

import UIKit

class secViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var item: [NSString] = [NSString]();
    let delegate = (UIApplication.sharedApplication().delegate) as! AppDelegate
    override func viewDidLoad() {
        super.viewDidLoad()
        NSLog("---\(self.classForCoder):转跳成功---")   //转跳成功日志

//        for var i=0;i<100;i++ {
//            item.append("test\(i)");
////            NSLog("element[%d] is %@", i+1, item[i]);
//        }
        delegate.window?.backgroundColor = UIColor.clearColor()
        self.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
//        self.modalPresentationStyle = .OverCurrentContext
//        self.modalTransitionStyle = .CrossDissolve
        let vTest = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        vTest.backgroundColor = UIColor.redColor()
//        self.view.addSubview(vTest)
//        self.modalTransitionStyle = .CrossDissolve
        
//        let listTable = UITableView(frame: CGRectZero, style: UITableViewStyle.Plain)
//        view.addSubview(listTable)
//        listTable.snp_makeConstraints { (make) -> Void in
//            make.top.equalTo(view).offset(0)
//            make.left.equalTo(view).offset(0)
//            make.height.equalTo(UIScreen.mainScreen().bounds.height)
//            make.width.equalTo(UIScreen.mainScreen().bounds.width)
//        }
//        listTable.dataSource = self;
//        listTable.delegate = self;
//        listTable.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell");
        // Do any additional setup after loading the view.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.item.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        let row = indexPath.row
        cell.textLabel!.text = item[row] as String
        return cell
    }
    
//    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        var vc = secViewController()
//        navigationController?.presentViewController(vc, animated: true, completion: { () -> Void in
//            NSLog("Success!")
//        })
//    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
//        let row = indexPath.row
        
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
