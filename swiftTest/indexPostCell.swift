//
//  indexPostCell.swift
//  swiftTest
//
//  Created by 马雪松 on 16/3/14.
//  Copyright © 2016年 com.bankcomm. All rights reserved.
//

import UIKit

class indexPostCell: UITableViewCell {
    let pname = UIView()
    let pLabel = UILabel()
    
    let author = UIView()
    let aLabel = UILabel()
    
    let tid_sum = UIView()
    let tLabel = UILabel()
    
    let when = UIView()
    let wLabel = UILabel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor(red: 51/255, green: 165/255, blue: 252/255, alpha: 0.2)
//        self.pname.backgroundColor = UIColor.redColor()
//        self.author.backgroundColor = UIColor.greenColor()
//        self.tid_sum.backgroundColor = UIColor.blueColor()
//        self.when.backgroundColor = UIColor.brownColor()
        let gapSpaceLeft = 12.0
        contentView.addSubview(pname)
        contentView.addSubview(author)
        contentView.addSubview(tid_sum)
        contentView.addSubview(when)
        
        pname.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(contentView.snp_top).offset(20)
            make.right.equalTo(contentView.snp_right).offset(-gapSpaceLeft)
            make.left.equalTo(contentView).offset(gapSpaceLeft)
        }
        pLabel.sizeToFit()
        pLabel.lineBreakMode = NSLineBreakMode.ByWordWrapping
        pLabel.font = UIFont.systemFontOfSize(16)
        pLabel.numberOfLines = 2
        pname.addSubview(pLabel)
        pLabel.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(pname).inset(UIEdgeInsetsMake(10, 10, 10, 10))
        }
        
        author.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(pname.snp_left)
            make.top.equalTo(pname.snp_bottom)
            make.width.equalTo(UIScreen.mainScreen().bounds.width/3 - 8)
            make.bottom.equalTo(contentView.snp_bottom).offset(-20)
        }
        aLabel.sizeToFit()
        aLabel.font = UIFont.systemFontOfSize(10)
        author.addSubview(aLabel)
        aLabel.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(author).inset(UIEdgeInsetsMake(0, 10, 0, 0))
        }
        
        tid_sum.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(author.snp_right)
            make.top.equalTo(author.snp_top)
            make.width.equalTo(UIScreen.mainScreen().bounds.width/3-50)
            make.bottom.equalTo(author.snp_bottom)
        }
        tLabel.sizeToFit()
        tLabel.font = UIFont.systemFontOfSize(10)
        tid_sum.addSubview(tLabel)
        tLabel.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(tid_sum).inset(UIEdgeInsetsZero)
        }
        
        when.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(tid_sum.snp_right)
            make.top.equalTo(author.snp_top)
            make.right.equalTo(pname.snp_right)
            make.bottom.equalTo(author.snp_bottom)
        }
        wLabel.sizeToFit()
        wLabel.font = UIFont.systemFontOfSize(10)
        when.addSubview(wLabel)
        wLabel.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(when).inset(UIEdgeInsetsZero)
        }
        
    }
    
    func configureForCell(item: postCell){
        self.pLabel.text = item.pname
        self.aLabel.text = item.author
        self.tLabel.text = item.tid_sum
        self.wLabel.text = item.when
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
