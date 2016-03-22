//
//  setViewController.swift
//  swiftTest
//
//  Created by bocom on 16/1/25.
//  Copyright © 2016年 com.bankcomm. All rights reserved.
//

import UIKit
import CoreData

class setViewController: UIViewController,UITextFieldDelegate {
    var labName = UILabel()
    var labKey = UILabel()
    var txtName = UITextField()
    var txtKey = UITextField()
    var btnSubmit = UIButton(type: .System)
    var pTran = paramsTrans()
    var delegate = UIApplication.sharedApplication().delegate as! AppDelegate
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        NSLog("---\(self.classForCoder):加载成功---")   //转跳成功日志
        labName.text = "用户名:"
        labKey.text = "密码:"
        labName.textAlignment = NSTextAlignment.Left
        labKey.textAlignment = NSTextAlignment.Left
        
        txtName.borderStyle = UITextBorderStyle.RoundedRect;
        txtKey.borderStyle = txtName.borderStyle;
        txtName.borderStyle = UITextBorderStyle.RoundedRect;
        txtKey.borderStyle = UITextBorderStyle.RoundedRect;
        txtName.returnKeyType = UIReturnKeyType.Done;
        txtKey.returnKeyType = txtName.returnKeyType;
        txtName.clearButtonMode = UITextFieldViewMode.WhileEditing
        txtKey.clearButtonMode = txtName.clearButtonMode
        txtKey.secureTextEntry = true
        txtName.delegate = self
        txtKey.delegate = self
        
        btnSubmit.setTitle("确定", forState: UIControlState.Normal)
        btnSubmit.backgroundColor = UIColor(red: 0, green: 0.478, blue: 1, alpha: 1)
        btnSubmit.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        btnSubmit.titleLabel!.font = UIFont.systemFontOfSize(25)
        btnSubmit.addTarget(self, action: Selector("saveData"), forControlEvents: UIControlEvents.TouchUpInside)
        
        view.addSubview(labName)
        view.addSubview(labKey)
        view.addSubview(txtName)
        view.addSubview(txtKey)
        view.addSubview(btnSubmit)
        
        labName.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(view).offset(100)
            make.left.equalTo(view).offset(30)
            make.width.equalTo(60)
            make.height.equalTo(40)
        }
        labKey.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(view).offset(160)
            make.left.equalTo(view).offset(30)
            make.width.equalTo(40)
            make.height.equalTo(40)
        }
        txtName.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(view).offset(100)
            make.left.equalTo(view).offset(100)
            make.height.equalTo(30)
            make.right.equalTo(view).offset(-30)
        }
        
        txtKey.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(view).offset(160)
            make.left.equalTo(view).offset(80)
            make.height.equalTo(30)
            make.right.equalTo(view).offset(-30)
        }
        btnSubmit.snp_makeConstraints { (make) -> Void in
            make.bottom.equalTo(view).offset(0)
            make.left.equalTo(view).offset(0)
            make.right.equalTo(view).offset(0)
            make.height.equalTo(80)
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        NSLog(textField.text!)
        return true
    }
    
    func saveData(){
        //检查用户名和密码是否为空
        if txtName.text=="" || txtKey.text=="" {
            let alert = UIAlertController(title: "提示", message: "用户名或密码输入错误，请重新输入！", preferredStyle: UIAlertControllerStyle.Alert)
            let alertAct = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: { (UIAlertAction) -> Void in
                
            })
            
            alert.addAction(alertAct)
            self.presentViewController(alert, animated: true, completion: nil)
            return
        }
        
        delegate.addData(txtName.text!, key: txtKey.text!)
        self.pTran.paramsSet("userName", value: txtName.text!)
        self.pTran.paramsSet("passWord", value: txtKey.text!)
        let userData = delegate.getData()
              
        for user in userData.users {
            NSLog(user.valueForKey("userName") as! String)
            NSLog(user.valueForKey("passWord") as! String)
        }
        
        NSLog("******All Data: \(userData.nums)******")
        let rootView = ContainerViewController()
        delegate.grpList.removeAll()
        delegate.frmList.removeAllObjects()
        delegate.subList.removeAllObjects()
        delegate.image = UIImage()
        navigationController?.presentViewController(rootView, animated: true, completion: { () -> Void in
            NSLog("present success!")
        })
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
