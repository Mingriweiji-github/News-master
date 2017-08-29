//
//  HomePageView.swift
//  News
//
//  Created by M_Li on 2017/8/22.
//  Copyright © 2017年 M_Li. All rights reserved.
//

import UIKit
protocol HomePageViewDelegate:class {
    
    func pageView(_ pageView:HomePageView,currentIndex:Int)
    
}
class HomePageView: UIView {

    weak var homePageDelegate: HomePageViewDelegate?
    var startOffSet : CGFloat = 0
    var current : Int = 0
    
    var titles : [HomeTopicTitle]?{
        didSet{
            titleView.titles = titles
        }
    }
    
    var childVC : [TopicViewController]?{
    
        didSet{
        
            let vc = childVC![current]
            vc.view.frame = CGRect(x: 0, y: 0, width: collectionView.width, height: collectionView.height)
            collectionView.reloadData()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    lazy
    lazy var titleView: HomeTitleView = {
        
        let titleView = HomeTitleView()
        titleView.delegate = self
        return titleView
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: KScreenWidth, height: KScreenHeight - 64 - 44)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        let collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        
        return collectionView
    }()
    
    
}

extension HomePageView{

    fileprivate func setupUI(){
    
        backgroundColor = UIColor.white
        addSubview(titleView)
        addSubview(collectionView)
        
        titleView.snp.makeConstraints { (make) in
            make.left.top.right.equalTo(self)
            make.bottom.equalTo(collectionView.snp.top)
            make.height.equalTo(10)
        }
        
        collectionView.snp.makeConstraints { (make) in
            make.left.top.right.equalTo(self)
        }
        
        //???
        homePageDelegate = titleView as? HomePageViewDelegate
    }
}

extension HomePageView:UICollectionViewDelegateFlowLayout,UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.width, height: collectionView.height)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let pageCell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing:HomeCollectionViewCell.self), for: indexPath) as! HomeCollectionViewCell
        
        return pageCell
    }
}

extension HomePageView : UIScrollViewDelegate {

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        contentEndScrollView()
        
        scrollView.isScrollEnabled = true
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        if decelerate == false {
            contentEndScrollView()
        } else {
            scrollView.isScrollEnabled = false
        }
    }
//    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
//        startOffSet = scrollView.contentOffset.x
//    }
    private func contentEndScrollView(){
    
        let index = Int(collectionView.contentOffset.x / KScreenWidth)
        
        homePageDelegate?.pageView(self, currentIndex: index)
    }
    
}
extension HomePageView :HomeTitleViewDelegate{
    func titleView(_ titleView:HomeTitleView,selected:Int){
        current = selected
        let indexPath  = IndexPath(item: selected, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .left, animated: true)
    }
}
