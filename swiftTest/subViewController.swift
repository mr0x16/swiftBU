//
//  subViewController.swift
//  swiftTest
//
//  Created by 马雪松 on 16/3/24.
//  Copyright © 2016年 com.bankcomm. All rights reserved.
//

import UIKit

class subViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let xGap = UIScreen.mainScreen().bounds.width/5
        let yGap = 74
        
        
        let delegate = (UIApplication.sharedApplication().delegate) as! AppDelegate
        delegate.window?.backgroundColor = UIColor(red: 204/255, green: 232/255, blue: 255/255, alpha: 1)

        let btnCancel = UIButton(type: .System)
        self.view.addSubview(btnCancel)
        btnCancel.snp_makeConstraints { (make) -> Void in
            make.center.equalTo(view.snp_center)
            make.width.equalTo(250)
            make.height.equalTo(154)
        }
        btnCancel.setTitle("返回", forState: .Normal)
        btnCancel.setTitleColor(UIColor.blackColor(), forState: .Normal)
        btnCancel.addTarget(self, action: #selector(subViewController.cancelView), forControlEvents: .TouchUpInside)
        btnCancel.backgroundColor = UIColor(red: 204/255, green: 232/255, blue: 255/255, alpha: 1)
        // Do any additional setup after loading the view.
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
