//
//  richTextViewController.swift
//  swiftTest
//
//  Created by 马雪松 on 16/4/6.
//  Copyright © 2016年 com.bankcomm. All rights reserved.
//

import UIKit

class richTextViewController: UIViewController {
    let richView = UITextView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 204/255, green: 232/255, blue: 255/255, alpha: 1)
        self.view.addSubview(richView)
        richView.backgroundColor = UIColor.whiteColor()
        richView.sizeToFit()
        let mailPattern = "(?<=src/s*=/s*[/'/\"\"]?)(?<url>[http/:////]?[^'\"\"]+)"
        NSLog(mailPattern)
        
        let msg = "<br/><br/><font size=\"5\">白鹅帮，支配北理良乡永恒的恐怖！<img src=\"http://out.bitunion.org/images/bz/80.gif\" border=\"0\"> </font><img src=http://out.bitunion.org/attachments/forumid_24/s/S/sSKZ_NTk1OQ==.jpg max-width:90% max-height:90% border=\"0\"/><a href=http://out.bitunion.org/thread-10471436-1-1.html>From BIT-Union Open API Project</a>"
        let encodedMsg = msg.dataUsingEncoding(NSUnicodeStringEncoding)!
        let attributedOptions = [NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType]
        do{
            let attributeMsg = try NSMutableAttributedString(data: encodedMsg, options: attributedOptions, documentAttributes: nil)
            
            richView.attributedText = attributeMsg
        } catch {
            richView.attributedText = NSMutableAttributedString(string: "")
            print("Cannot create attributed String")
        }
        richView.editable = false
        richView.snp_makeConstraints { (make) in
            make.edges.equalTo(view).inset(UIEdgeInsetsMake(20, 0, 80, 0))
        }
        // Do any additional setup after loading the view.
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
