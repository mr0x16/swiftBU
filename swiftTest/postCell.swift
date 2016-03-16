//
//  post.swift
//  swiftTest
//
//  Created by 马雪松 on 16/3/14.
//  Copyright © 2016年 com.bankcomm. All rights reserved.
//

import UIKit

class postCell: NSObject {
    var author:String
    var fid:String
    var tid:String
    var tid_sum:String
    var pname:String
    var when:String
    
    init(author: String, fid:String, tid:String, tid_sum:String, pname:String, when:String) {
        self.author = author
        self.fid = fid
        self.tid = tid
        self.tid_sum = tid_sum
        self.pname = pname
        self.when = when
        
        super.init()
    }
}
