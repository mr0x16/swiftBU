//
//  File.swift
//  swiftTest
//
//  Created by bocom on 16/1/29.
//  Copyright © 2016年 com.bankcomm. All rights reserved.
//

import Foundation

class paramsTrans {
    func paramsSet(key: String, value: AnyObject){
        let userInfo = NSUserDefaults()
        userInfo.setValue(value, forKey: key)
    }
    
    func paramsGet(key: String) ->AnyObject {
        let userInfo = NSUserDefaults()
        let params = userInfo.valueForKey(key)
        return params!
    }
}
