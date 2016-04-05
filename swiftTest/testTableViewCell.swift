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
    var fid = ""
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
//        mainLab.font = UIFont.systemFontOfSize(16)
        title.addSubview(mainLab)
//        mainLab.backgroundColor = UIColor.redColor()
//        mainLab.attributedText.
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
//        var title = String()
        let title = "<font size=\"4\">"+(item.valueForKey("frmName") as! String).stringByReplacingOccurrencesOfString("+", withString: " ")+"</font>"
        let desc = "<font size=\"2\">"+(item.valueForKey("desc") as! String).stringByReplacingOccurrencesOfString("+", withString: " ")+"</font>"
        self.fid = item.fid

        NSLog("Titel is \(title)")
        let encodedTitle = title.dataUsingEncoding(NSUnicodeStringEncoding)!
        let encodeDesc = desc.dataUsingEncoding(NSUnicodeStringEncoding)!
        let attributedOptions = [NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType]
        do{
            let attributeTitle = try NSMutableAttributedString(data: encodedTitle, options: attributedOptions, documentAttributes: nil)
            let attributeDesc = try NSMutableAttributedString(data: encodeDesc, options: attributedOptions, documentAttributes: nil)
//            self.mainLab.attributedText
            attributeTitle.addAttribute(kCTFontSizeAttribute as String, value: CTFontCreateWithName(UIFont.systemFontOfSize(88).fontName , 88, nil), range: NSMakeRange(0, attributeTitle.length-1))
            self.mainLab.attributedText = attributeTitle
            
            self.descLab.attributedText = attributeDesc
            
        } catch {
            print("Cannot create attributed String")
        }
        
            //.text = item.valueForKey("frmName") as? String
        
        self.fid = item.fid
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
