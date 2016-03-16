//
//  forumCell.swift
//  swiftTest
//
//  Created by bocom on 16/1/30.
//  Copyright © 2016年 com.bankcomm. All rights reserved.
//

import UIKit

class forumCell: NSObject {
    var frmName: String
    var fid: String
    var desc: String
    var subArray = NSMutableArray()
    init(frmName: String, fid: String, desc: String) {
        self.frmName = frmName
        self.fid = fid
        self.desc = desc
    }
}
