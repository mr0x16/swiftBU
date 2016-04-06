//
//  replayCell.swift
//  swiftTest
//
//  Created by bocom on 16/4/5.
//  Copyright © 2016年 com.bankcomm. All rights reserved.
//

import UIKit

class replayCell: NSObject {
    let message:NSMutableAttributedString
    init(str:String) {
        let encodedMsg = str.dataUsingEncoding(NSUnicodeStringEncoding)!
        let attributedOptions = [NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType]
        do{
            let attributeMsg = try NSMutableAttributedString(data: encodedMsg, options: attributedOptions, documentAttributes: nil)
            attributeMsg.enumerateAttribute(NSAttachmentAttributeName, inRange: NSMakeRange(0, attributeMsg.length), options: .LongestEffectiveRangeNotRequired, usingBlock: { (value, range, stop) in
                if value != nil {
                    NSLog("\(value!.classForCoder):width=\(value!.bounds.width), height=\(value!.bounds.height)")
                    let maxWidth = UIScreen.mainScreen().bounds.width - 40
                    let attachWidth = value!.bounds.width
                    if attachWidth > maxWidth {
                        replayCell.changeBounds(value as! NSTextAttachment)
//                        value!.bounds = CGRectMake(0, 0, maxWidth, attachHeight/scale)
                    }
                }
            })
            self.message = attributeMsg
        } catch {
            self.message = NSMutableAttributedString(string: "")
            print("Cannot create attributed String")
        }
    }
    
    static func changeBounds(attach: NSTextAttachment) -> Void {
        let maxWidth = UIScreen.mainScreen().bounds.width - 40
        let attachWidth = attach.bounds.width
        let attachHeight = attach.bounds.height
        let scale = attachWidth/maxWidth
        let targetHeight = attachHeight/scale
        attach.bounds = CGRectMake(0, 0, maxWidth, targetHeight)
        NSLog("\(attach.classForCoder)'s bounds has changed:width=\(attach.bounds.width), height=\(attach.bounds.height)")
    }
    
}
