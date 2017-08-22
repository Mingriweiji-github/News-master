//
//  HomeNavigationView.swift
//  News
//
//  Created by M_Li on 2017/8/22.
//  Copyright © 2017年 M_Li. All rights reserved.
//

import UIKit
import SnapKit
class HomeNavigationView: UIView {

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(titleImageView)
        addSubview(searchBar)
        titleImageView.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(KMargin)
            make.centerY.equalTo(self)
            make.size.equalTo(CGSize(width: 70, height: 20))
        }
        searchBar.snp.makeConstraints { (make) in
            make.left.equalTo(titleImageView.snp.right).offset(KMargin)
            make.right.equalTo(self).offset(-KMargin)
            make.centerY.equalTo(self)
            make.height.equalTo(30)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //Lazy
    
    lazy var searchBar: HomeSearchField = {
        let searchBar = HomeSearchField.searchBar()
        searchBar.placeholder = "MBA商业评论 | 魅族倒闭了么？"
        searchBar.background = UIImage(named:"searchbox_search_20x28_")
        return searchBar
    }()
    lazy var titleImageView: UIImageView = {
        let imageView = UIImageView(image:UIImage(named:UserDefaults.standard.bool(forKey: isNight) ? "title_night_72x20_" : "title_72x20_"))
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override var frame: CGRect{
        didSet{
        
            let newFrame = CGRect(x: 0, y: 0, width: KScreenWidth, height: 44)
            super.frame = newFrame
            
        }
    }
    
    
}
