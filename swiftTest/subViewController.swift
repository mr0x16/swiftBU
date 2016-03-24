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
        let yGap = UIScreen.mainScreen().bounds.height/5
        
        
        let delegate = (UIApplication.sharedApplication().delegate) as! AppDelegate
        delegate.window?.backgroundColor = UIColor(red: 204/255, green: 232/255, blue: 255/255, alpha: 1)
    
        
        let containView = UIView()
        self.view.addSubview(containView)
        containView.backgroundColor = UIColor(red: 204/255, green: 232/255, blue: 255/255, alpha: 1)
        containView.snp_makeConstraints { (make) -> Void in
            make.center.equalTo(view.snp_center)
            make.left.equalTo(view.snp_left).offset(xGap)
            make.right.equalTo(view.snp_right).offset(-xGap)
            make.top.equalTo(view.snp_top).offset(yGap)
            make.bottom.equalTo(view.snp_bottom).offset(-yGap)
        }
        
        
        let btnCancel = UIButton(type: .System)
        btnCancel.setTitle("返回", forState: .Normal)
        btnCancel.setTitleColor(UIColor.blackColor(), forState: .Normal)
        btnCancel.addTarget(self, action: #selector(subViewController.cancelView), forControlEvents: .TouchUpInside)
        btnCancel.backgroundColor = UIColor(red: 204/255, green: 232/255, blue: 255/255, alpha: 1)
        containView.addSubview(btnCancel)
        btnCancel.snp_makeConstraints { (make) in
            make.left.equalTo(containView.snp_left)
            make.right.equalTo(containView.snp_right)
            make.bottom.equalTo(containView.snp_bottom)
            make.height.equalTo(yGap/2)
        }
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
