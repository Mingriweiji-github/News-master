//
//  HomePageView.swift
//  News
//
//  Created by M_Li on 2017/8/22.
//  Copyright © 2017年 M_Li. All rights reserved.
//

import UIKit
protocol HomePageViewDelegate {
    
    func homePageView()
    
}
class HomePageView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //lazy
//    lazy var titleView: HomePageView = {
//        
//        let titleView = HomePageView
//        return title
//    }()
    
}

extension HomePageView{

    fileprivate func setupUI(){
    
        backgroundColor = UIColor.white
        
        
    }

}
