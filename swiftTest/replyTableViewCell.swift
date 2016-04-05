//
//  replyTableViewCell.swift
//  swiftTest
//
//  Created by 马雪松 on 16/4/6.
//  Copyright © 2016年 com.bankcomm. All rights reserved.
//

import UIKit

class replyTableViewCell: UITableViewCell {
    let msgView = UIView()
    let msgLabel = UILabel()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor(red: 204/255, green: 232/255, blue: 255/255, alpha: 1)
        let gapSpaceLeft = 12.0
        contentView.addSubview(msgView)
        msgView.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(contentView.snp_top).offset(20)
            make.right.equalTo(contentView.snp_right).offset(-gapSpaceLeft)
            make.left.equalTo(contentView).offset(gapSpaceLeft)
            make.bottom.equalTo(contentView.snp_bottom).offset(-20)
        }
        msgLabel.sizeToFit()
        msgLabel.lineBreakMode = NSLineBreakMode.ByWordWrapping
        msgLabel.numberOfLines = 1000
        msgView.addSubview(msgLabel)
        msgLabel.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(msgView).inset(UIEdgeInsetsZero)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
