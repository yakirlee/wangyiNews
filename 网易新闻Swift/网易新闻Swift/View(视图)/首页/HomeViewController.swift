//
//  HomeViewController.swift
//  网易新闻Swift
//
//  Created by 李 on 16/3/21.
//  Copyright © 2016年 李. All rights reserved.
//

import UIKit


private let kChannelNormalFont: CGFloat = 14
private let kChannelSelectedFont: CGFloat = 18

private var currentIndex: CGFloat = 0
class homeFlowLayout: UICollectionViewFlowLayout {
    override func prepareLayout() {
        super.prepareLayout()
        
        minimumInteritemSpacing = 0
        minimumLineSpacing = 0
        itemSize = CGSize(width: UIScreen.mainScreen().bounds.width, height: UIScreen.mainScreen().bounds.height - 100)
        scrollDirection = .Horizontal
    }
}


class HomeViewController: UIViewController {
    
    // MARK: - 私有控件
    private lazy var homeCollectionView: UICollectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: homeFlowLayout())
    private lazy var channelView: UIScrollView = UIScrollView(frame: CGRectZero)
    
    
    // MARK: - 视图模型
    private lazy var newsViewModel = NewsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newsViewModel.channelList()
        
        setupUI()
    }
    
    // MARK: - 监听事件
    @objc private func tapGestureLabel(tapGesture: UITapGestureRecognizer) {
        
        let currentLabel = tapGesture.view as? UILabel
        guard let tag = currentLabel?.tag else {
            return
        }

        let indexpath = NSIndexPath(forItem: Int(tag), inSection: 0)
        homeCollectionView.scrollToItemAtIndexPath(indexpath, atScrollPosition: .Right, animated: false)
        selectedChangeLabel(currentLabel)
        let preLabel = channelView.subviews[Int(currentIndex)] as? UILabel
        labelReturnToNormal(preLabel)
    
        currentIndex = CGFloat(tag)
        
        
    }
    
    // MARK: - 私有方法
    private func selectedChangeLabel(selectedLabel: UILabel?) {
        selectedLabel?.textColor = UIColor.redColor()
        let scale: CGFloat = (kChannelSelectedFont - kChannelNormalFont)/kChannelNormalFont + 1
        selectedLabel?.transform = CGAffineTransformMakeScale(scale, scale)
        selectedLabel?.sizeToFit()
    

    }
    private func labelReturnToNormal(preLabel: UILabel?) {
        preLabel?.textColor = UIColor.blackColor()
        let scale: CGFloat = 1/((kChannelSelectedFont - kChannelNormalFont)/kChannelNormalFont + 1) + 0.2
        preLabel?.transform = CGAffineTransformMakeScale(scale, scale)
        preLabel?.font = UIFont.systemFontOfSize(kChannelNormalFont)
        preLabel?.sizeToFit()
    }
}
extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return newsViewModel.channelArray.count
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("homeCollectionViewID", forIndexPath: indexPath) as? HomeCell
        
        cell?.urlString = newsViewModel.channelArray[indexPath.item].tid
        
        return cell ?? UICollectionViewCell()
    }
    
    // 代理方法
    func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {

        let preLabel = channelView.subviews[Int(currentIndex)] as? UILabel
        labelReturnToNormal(preLabel)

        let index = indexPath.item
        let label = channelView.subviews[index] as? UILabel
        selectedChangeLabel(label)
        
        currentIndex = CGFloat(index)

        if index == 0 {
            selectedChangeLabel(label)
        }
    }

    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        currentIndex = scrollView.contentOffset.x / scrollView.bounds.width
        
        // 计算当前选中标签的中心点
        let label = channelView.subviews[Int(currentIndex)]
        var offset = label.center.x - channelView.bounds.width * 0.5
        let maxOffset = channelView.contentSize.width - channelView.bounds.width
        

        if offset < 0 {
            offset = 0
        } else if (offset > maxOffset){
            offset = maxOffset
        }
        channelView.setContentOffset(CGPoint(x: offset, y: 0), animated: true)
    }
    
   
}

// MARK: - 设置UI
extension HomeViewController {
    
    private func setupUI() {
        
        view.addSubview(channelView)
        view.addSubview(homeCollectionView)
        
        channelView.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(view)
            make.right.equalTo(view)
            make.top.equalTo(snp_topLayoutGuideBottom)
            make.height.equalTo(36)
        }
        
        homeCollectionView.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(view)
            make.right.equalTo(view)
            make.top.equalTo(channelView.snp_bottom)
            make.bottom.equalTo(view)
        }
        
        prepareChannelView()
        prepareCollectionView()
    }
    
    private func prepareChannelView() {
        
        channelView.backgroundColor = UIColor.whiteColor()
        channelView.showsVerticalScrollIndicator = false
        channelView.showsHorizontalScrollIndicator = false
//        channelView.delegate = self
        
        automaticallyAdjustsScrollViewInsets = false
        
        let margin: CGFloat = 8.0
        var x: CGFloat = margin
        let height:CGFloat = channelView.bounds.height
    
        var tag = 0
        for channel in newsViewModel.channelArray {
            guard let channelName = channel.tname else {
                return
            }
            
            let channelLabel = UILabel()
            channelLabel.tag = tag
            channelLabel.text = channelName
            channelLabel.tintColor = UIColor.darkGrayColor()
            channelLabel.userInteractionEnabled = true
            channelLabel.font = UIFont.systemFontOfSize(kChannelNormalFont)
            channelLabel.textAlignment = .Center
            channelLabel.frame = CGRectMake(x, 10, channelLabel.frame.width + margin, height)
            channelLabel.sizeToFit()
            
            x += channelLabel.bounds.width + margin
            tag += 1
            
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(HomeViewController.tapGestureLabel(_:)))
            channelLabel.addGestureRecognizer(tapGesture)
            channelView.addSubview(channelLabel)
            
        }
        channelView.contentSize = CGSize(width: x + margin, height: height)
        let selectedLabel = channelView.subviews[0] as? UILabel
        
        selectedChangeLabel(selectedLabel)

            }
    
    
    private func prepareCollectionView() {
        
        homeCollectionView.backgroundColor = UIColor.blueColor()
        homeCollectionView.bounces = false
        
        homeCollectionView.registerClass(HomeCell.self, forCellWithReuseIdentifier: "homeCollectionViewID")
        homeCollectionView.pagingEnabled = true
        homeCollectionView.showsHorizontalScrollIndicator = false
        homeCollectionView.dataSource = self
        homeCollectionView.delegate = self
    }
}
