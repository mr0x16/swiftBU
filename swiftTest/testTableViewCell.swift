//
//  testTableViewCell.swift
//  swiftTest
//
//  Created by bocom on 16/2/2.
//  Copyright © 2016年 com.bankcomm. All rights reserved.
//

import UIKit

class testTableViewCell: UITableViewCell {
    let title = UIView()
    let desc = UIView()
    let mainLab = UILabel()
    let descLab = UILabel()
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor(red: 204/255, green: 232/255, blue: 255/255, alpha: 1)
        contentView.addSubview(title)
        contentView.addSubview(desc)
        
        title.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(contentView.snp_top).offset(15)
            make.centerX.equalTo(contentView.snp_centerX)
        }
        mainLab.sizeToFit()
        mainLab.font = UIFont.systemFontOfSize(16)
        title.addSubview(mainLab)
        mainLab.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(title).inset(UIEdgeInsetsZero)
        }
        
        desc.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(title.snp_bottom)
            make.left.equalTo(contentView.snp_left).offset(25)
            make.right.equalTo(contentView.snp_right).offset(-25)
        }
        descLab.sizeToFit()
        descLab.textAlignment = .Center
        descLab.textColor = UIColor.grayColor()
        descLab.lineBreakMode = NSLineBreakMode.ByWordWrapping
        descLab.font = UIFont.systemFontOfSize(8)
        descLab.numberOfLines = 2
        desc.addSubview(descLab)
        descLab.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(desc).inset(UIEdgeInsetsZero)
        }
        
        
    }
    
    func configureForCell(item: forumCell){
        self.mainLab.text = item.valueForKey("frmName") as? String
        self.descLab.text = item.valueForKey("desc") as? String
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
