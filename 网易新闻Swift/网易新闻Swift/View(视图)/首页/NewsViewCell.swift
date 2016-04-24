//
//  NewsViewCell.swift
//  网易新闻Swift
//
//  Created by 李 on 16/3/20.
//  Copyright © 2016年 李. All rights reserved.
//

import UIKit
import SnapKit

private let offset = 5

class NewsViewCell: UITableViewCell {
    
    var news: News? {
        didSet{
            iconView.gg_setImageWithURL(news?.imgsrc, placeholderName: "placeholder")
            titleView.text = news?.title
            digestView.text = news?.digest
            digestView.numberOfLines = 2

            iconView.snp_updateConstraints { (make) in
                
            }
            guard let extraImages = news?.imgextra else {
                return
            }
            var index = 0
            for dict in extraImages {
                if index == 0 {
                    extraViewOne.gg_setImageWithURL(dict["imgsrc"] as? String, placeholderName: "placeholder")
                } else {
                    extraViewTwo.gg_setImageWithURL(dict["imgsrc"] as? String, placeholderName: "placeholder")
                }
                index += 1
            }
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .Default, reuseIdentifier: reuseIdentifier)
        

        switch reuseIdentifier! {
        case "newsViewReuseID": setupUI()
        case "extraReuseID": setupExtraUI()
        case "bigImageReuseID": setupBigImageUI()
            
        default:break;
        }
    }
    
    // MARK: - 添加私有控件
    private lazy var iconView = UIImageView(gg_imageName: "placeholder")
    private lazy var titleView = UILabel(gg_text: "标题文本", fontSize: 15, color: UIColor.blackColor())
    private lazy var digestView = UILabel(gg_text: "详细介绍")
    private lazy var extraViewOne = UIImageView(gg_imageName: "placeholder")
    private lazy var extraViewTwo = UIImageView(gg_imageName: "placeholder")
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - 设置界面
extension NewsViewCell {
    
    private func setupBigImageUI() {
        
        contentView.addSubview(iconView)
        contentView.addSubview(titleView)
        contentView.addSubview(digestView)
        
        titleView.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(contentView).offset(offset)
            make.left.equalTo(contentView).offset(offset)
            make.right.equalTo(contentView).offset(offset)
        }
        titleView.sizeToFit()
        
        guard let image = iconView.image else {
            return
        }
        let iconViewH = image.size.height / image.size.width * UIScreen.mainScreen().bounds.width / 3
        iconView.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(titleView)
            make.right.equalTo(titleView)
            make.top.equalTo(titleView.snp_bottom).offset(offset)
            make.height.equalTo(iconViewH)
        }
        
        digestView.sizeToFit()
        digestView.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(iconView)
            make.right.equalTo(iconView)
            make.top.equalTo(iconView.snp_bottom).offset(offset)
            make.bottom.equalTo(contentView).offset(-offset)
        }

    }
    
    private func setupExtraUI() {
        
        contentView.addSubview(iconView)
        contentView.addSubview(titleView)
        contentView.addSubview(extraViewOne)
        contentView.addSubview(extraViewTwo)
        
        
        titleView.snp_makeConstraints(closure: { (make) -> Void in
            make.left.equalTo(contentView).offset(offset)
            make.top.equalTo(contentView).offset(offset)
            make.right.equalTo(contentView).offset(-offset)
        })
        
        let height: CGFloat = 100
        iconView.snp_makeConstraints(closure: { (make) -> Void in
            make.top.equalTo(titleView.snp_bottom).offset(offset)
            make.bottom.equalTo(contentView).offset(-offset)
            make.height.equalTo(height)
            make.left.equalTo(contentView).offset(offset)
            make.right.equalTo(extraViewOne.snp_left).offset(-offset)
            
            make.width.equalTo(extraViewTwo)
        })
        
        extraViewOne.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(iconView)
            make.bottom.equalTo(iconView)
            
            make.right.equalTo(extraViewTwo.snp_left).offset(-offset)
            
            make.width.equalTo(iconView)
        }
        
        extraViewTwo.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(iconView)
            make.bottom.equalTo(iconView)
            make.width.equalTo(extraViewOne)
            make.right.equalTo(contentView).offset(-offset)
        }
    }
    
    private func setupUI() {
        
        contentView.addSubview(iconView)
        contentView.addSubview(titleView)
        contentView.addSubview(digestView)
        
        
        titleView.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(contentView).offset(offset * 2)
            make.left.equalTo(iconView.snp_right).offset(offset)
            make.right.equalTo(contentView).offset(-offset)
        }
        titleView.sizeToFit()
       
        
        iconView.snp_makeConstraints { (make) -> Void in

            make.left.equalTo(contentView).offset(offset)
            make.width.equalTo(80)
            make.height.equalTo(60)
            make.bottom.equalTo(contentView)
        }
        
        digestView.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(titleView.snp_bottom).offset(offset)
            make.left.equalTo(titleView)
            make.right.equalTo(contentView).offset(-10)
            make.bottom.equalTo(iconView)
        }
        digestView.sizeToFit()
    }
}
