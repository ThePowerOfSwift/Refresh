//
//  CollectionViewController.swift
//  Refresh
//
//  Created by  lifirewolf on 16/3/3.
//  Copyright © 2016年  lifirewolf. All rights reserved.
//

import UIKit

class CollectionViewController: UIViewController {
    
    let collectionViewCellIdentifier = "color"
    var colors = [UIColor]()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // UICollectionViewFlowLayout的初始化（与刷新控件无关）
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSizeMake(80, 80)
        layout.sectionInset = UIEdgeInsetsMake(20, 20, 20, 20)
        layout.minimumInteritemSpacing = 20
        layout.minimumLineSpacing = 20
        
        collectionView.collectionViewLayout = layout
        
        collectionView.backgroundColor = UIColor.whiteColor()
        
        collectionView.dataSource = self
        collectionView.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: collectionViewCellIdentifier)
        
        // 下拉刷新
        collectionView.refreshHeader = RefreshNormalHeader {
            // 增加5条假数据
            for _ in 0..<10 {
                self.colors.insert(self.randomColor(), atIndex: 0)
            }
            
            // 模拟延迟加载数据，因此2秒后才调用（真实开发中，可以移除这段gcd代码）
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (Int64)(duration * Double(NSEC_PER_SEC))), dispatch_get_main_queue()) {
                self.collectionView.reloadData()
                
                // 结束刷新
                self.collectionView.refreshHeader.endRefreshing()
            }
        }
        
        collectionView.refreshHeader.beginRefreshing()
        
        // 上拉刷新
        collectionView.refreshFooter = RefreshAutoNormalFooter() {
            // 增加5条假数据
            for _ in 0..<10 {
                self.colors.append(self.randomColor())
            }
            
            // 模拟延迟加载数据，因此2秒后才调用（真实开发中，可以移除这段gcd代码）
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (Int64)(duration * Double(NSEC_PER_SEC))), dispatch_get_main_queue()) {
                self.collectionView.reloadData()
                
                // 结束刷新
                self.collectionView.refreshFooter.endRefreshing()
            }
        }
        
        // 默认先隐藏footer
        collectionView.refreshFooter.hidden = true
    }
    
    func randomColor() -> UIColor {
        return UIColor(red: CGFloat(arc4random_uniform(255))/255.0, green: CGFloat(arc4random_uniform(255))/255.0, blue: CGFloat(arc4random_uniform(255))/255.0, alpha: 1)
    }
}

extension CollectionViewController: UICollectionViewDataSource {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // 设置尾部控件的显示和隐藏
        collectionView.refreshFooter.hidden = colors.count == 0
        
        return colors.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(collectionViewCellIdentifier, forIndexPath: indexPath)
        cell.backgroundColor = colors[indexPath.row]
        
        return cell
    }
}

