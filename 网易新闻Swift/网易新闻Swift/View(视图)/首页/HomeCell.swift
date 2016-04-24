//
//  HomeCell.swift
//  网易新闻Swift
//
//  Created by 李 on 16/3/21.
//  Copyright © 2016年 李. All rights reserved.
//

import UIKit

class HomeCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    var urlString: String? {
        didSet{
            tableViewVc.uid = urlString
        }
    }
    // MARK: - 私有控件
    private lazy var tableViewVc: NewsController = NewsController()
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - 设置界面
extension HomeCell {
    
    private func setupUI() {
        contentView.addSubview(tableViewVc.view)
        
        tableViewVc.view.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(contentView)
            make.top.equalTo(contentView)
            make.right.equalTo(contentView)
            make.bottom.equalTo(contentView)
        }
    }
}