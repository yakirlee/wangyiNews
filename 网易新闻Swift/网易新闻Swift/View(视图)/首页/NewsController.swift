//
//  HomeController.swift
//  网易新闻Swift
//
//  Created by 李 on 16/3/19.
//  Copyright © 2016年 李. All rights reserved.
//


import UIKit
import SnapKit
import MJRefresh

class NewsController: UIViewController {
    
    // MARK: - 私有控件
    private lazy var newsView: UITableView = UITableView(frame: CGRectZero, style:.Plain)
    private lazy var refreshView: MJRefreshNormalHeader = MJRefreshNormalHeader {
        self.newsView.mj_header.endRefreshing()
    }
    private lazy var footView: MJRefreshAutoNormalFooter = MJRefreshAutoNormalFooter { 
        self.newsView.mj_footer.endRefreshing()
    }
    
    
    // MARK: - 属性
    var uid: String? {
        didSet{
            newsViewModel.loadNewsNews(uid ?? ""){ (result) -> () in
                self.newsViewList = result
                self.newsView.reloadData()
                self.newsView.mj_header.endRefreshing()
            }
        }
    }
    // MARK: - 私有属性
    private lazy var newsViewModel = NewsViewModel()
    private lazy var newsViewList = [News]()
    
    // MARK: - 生命周期
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        newsViewModel.channelList()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
    }
    
    // MARK: - 监听方法
    @objc private func selectedChannelToCollectionView(notify: NSNotification) {
        let selectedIndex = notify.object
        print(selectedIndex)
        
        
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension NewsController :UITableViewDataSource, UITableViewDelegate{
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsViewList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let isExtra = newsViewList[indexPath.row].imgextra?.count == 2
        
        var newsViewReuseID = "newsViewReuseID"
        if isExtra {
            newsViewReuseID = "extraReuseID"
        }
        if newsViewList[indexPath.row].imgType {
            newsViewReuseID = "bigImageReuseID"
        }
        
        let cell = tableView.dequeueReusableCellWithIdentifier(newsViewReuseID, forIndexPath: indexPath) as? NewsViewCell
        cell?.news = newsViewList[indexPath.row]
        return cell ?? UITableViewCell()
    }
    
    // 代理方法
    
}

// MARK: - UI设置
extension NewsController {
    
    private func setupUI() {
        self.view.backgroundColor = UIColor.whiteColor()
        
        newsView.registerClass(NewsViewCell.self, forCellReuseIdentifier: "newsViewReuseID")
        newsView.registerClass(NewsViewCell.self, forCellReuseIdentifier: "extraReuseID")
        newsView.registerClass(NewsViewCell.self, forCellReuseIdentifier: "bigImageReuseID")
        newsView.addSubview(refreshView)
        
        newsView.estimatedRowHeight = 80
        newsView.rowHeight = UITableViewAutomaticDimension
        
        newsView.dataSource = self
        newsView.delegate = self
    
        newsView.mj_header = refreshView
        newsView.mj_footer = footView

        
        view.addSubview(newsView)
        newsView.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(view)
            make.left.equalTo(view)
            make.right.equalTo(view)
            make.bottom.equalTo(view)
        }
        newsView.layer.drawsAsynchronously = true
        newsView.layer.shouldRasterize = true
        newsView.layer.rasterizationScale = UIScreen.mainScreen().scale
    }
    
}
