//
//  subCell.swift
//  swiftTest
//
//  Created by bocom on 16/1/30.
//  Copyright © 2016年 com.bankcomm. All rights reserved.
//

import UIKit

class subCell: NSObject {
    var frmName: String
    var fid: String
    var desc: String
    init(frmName: String, fid: String, desc: String) {
        self.frmName = frmName
        self.fid = fid
        self.desc = desc
    }
}
