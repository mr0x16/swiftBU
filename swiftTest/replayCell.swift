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
            
            self.message = attributeMsg
        } catch {
            self.message = NSMutableAttributedString(string: "")
            print("Cannot create attributed String")
        }
        
    }
    
}
