//
//  groupCell.swift
//  swiftTest
//
//  Created by bocom on 16/1/30.
//  Copyright © 2016年 com.bankcomm. All rights reserved.
//

import UIKit

class groupCell: NSObject {
    var grpName: String
    var fid: String
    var frmArray = NSMutableArray()
    init(grpName: String, fid: String) {
        self.grpName = grpName
        self.fid = fid
    }
}
