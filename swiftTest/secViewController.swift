//
//  secViewController.swift
//  swiftTest
//
//  Created by bocom on 16/1/25.
//  Copyright © 2016年 com.bankcomm. All rights reserved.
//

import UIKit

class secViewController: UIViewController{
    var item: [NSString] = [NSString]();
    let delegate = (UIApplication.sharedApplication().delegate) as! AppDelegate
    override func viewDidLoad() {
        super.viewDidLoad()
        NSLog("---\(self.classForCoder):转跳成功---")   //转跳成功日志

//        for var i=0;i<100;i++ {
//            item.append("test\(i)");
////            NSLog("element[%d] is %@", i+1, item[i]);
//        }
        delegate.window?.backgroundColor = UIColor(red: 204/255, green: 232/255, blue: 255/255, alpha: 1)
        
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
    
//    override func dismissModalViewControllerAnimated(animated: Bool) {
    
//    }
    
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
