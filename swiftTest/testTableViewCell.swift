//
//  testTableViewCell.swift
//  swiftTest
//
//  Created by bocom on 16/2/2.
//  Copyright © 2016年 com.bankcomm. All rights reserved.
//

import UIKit

class testTableViewCell: UITableViewCell {
    let mainLab = UILabel()
    let rightLab = UILabel()
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addSubview(mainLab)
        self.addSubview(rightLab)
        self.backgroundColor = UIColor(red: 204/255, green: 232/255, blue: 255/255, alpha: 1)
        rightLab.font = UIFont.systemFontOfSize(10)
        rightLab.numberOfLines = 0
        rightLab.textColor = UIColor.grayColor()
        self.bounds.size = CGSizeMake(UIScreen.mainScreen().bounds.width, 75)
        mainLab.snp_makeConstraints { (make) -> Void in
            make.centerY.equalTo(self.snp_centerY)
            make.left.equalTo(self).offset(20)
            make.height.equalTo(50)
        }
        
        rightLab.snp_makeConstraints { (make) -> Void in
            make.centerY.equalTo(self.snp_centerY)
            make.left.equalTo(mainLab.snp_right).offset(20)
            make.right.equalTo(self).offset(-30)
        }
    }
    
    func configureForCell(item: forumCell){
        self.mainLab.text = item.valueForKey("frmName") as? String
        self.rightLab.text = item.valueForKey("desc") as? String
    }
    
    required init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)!
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
