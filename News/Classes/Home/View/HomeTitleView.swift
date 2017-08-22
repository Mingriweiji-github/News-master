//
//  HomeTitleView.swift
//  News
//
//  Created by M_Li on 2017/8/22.
//  Copyright © 2017年 M_Li. All rights reserved.
//

import UIKit
protocol HomeTitleViewDelegate:class{
    
    func titleView(_ titleView:HomeTitleView,selected:Int)
}
class HomeTitleView: UIView {

    weak var delegate: HomeTitleViewDelegate?
    
    var titles:[HomeTopicTitle]?{
    
        didSet{
        
            
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        theme_backgroundColor = "colors.cellBackgroundColor"
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //标题数组
    fileprivate lazy var titleLabels = [HomeTitleLabel]()
    
   fileprivate lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: KScreenWidth - 40, height: 40))
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = true
        scrollView.scrollsToTop = false
        return scrollView
    }()
    
    lazy var bottomLine: UIView = {
        let bottomView = UIView()
        bottomView.backgroundColor = UIColor.globalBackgroundColor()
        bottomView.height = 2
        bottomView.y = 38
        return bottomView
    }()

    lazy var rightButton: UIButton = {
        let rightButton = UIButton(type:.custom)
        rightButton.frame = CGRect(x: KScreenWidth - 40, y: 0, width: 40, height: 40)
        rightButton.setTitleColor(UIColor.white, for: .normal)
        rightButton.addTarget(self, action: #selector(rightButtonClicked), for: .touchUpInside)
        rightButton.theme_setImage("images.addChannelTitlbar", forState: .normal)
        rightButton.theme_setBackgroundImage("images.shadowAddTitlebar", forState: .normal)
        return rightButton
    }()
    lazy var bottomSepLine: UIView = {
        let bottomSepLine = UIView(frame: CGRect(x: 0, y: 39, width: KScreenWidth, height: 1))
        bottomSepLine.backgroundColor = UIColor.darkGray
        return bottomSepLine
    }()
    
    func rightButtonClicked(){
    
        
    }
    
}
extension HomeTitleView{

    func setupUI(){
    
        addSubview(scrollView)
        addSubview(rightButton)
        addSubview(bottomSepLine)
        
        scrollView.addSubview(bottomLine)
    }
    fileprivate func setupTitleLabel(){
    
        for (index,title) in titles!.enumerated() {
            let titleLabel = HomeTitleLabel()
            titleLabel.text = title.name
            titleLabel.tag = index
            titleLabel.font = UIFont.systemFont(ofSize: 16)
            titleLabel.textAlignment = .center
            titleLabel.theme_textColor = index == 0 ? "colors.videoNavTitleColorSelect" : "colors.black"
            
            scrollView.addSubview(titleLabel)
            titleLabels.append(titleLabel)
            
//            let tapGesture = UITapGestureRecognizer(target: self(), action: #selector()
            
        }
    }
}

//MAKR:监听点击事件


private class HomeTitleLabel:UILabel{

    var currentScale :CGFloat = 1.0{
    
        didSet{
        
            transform = CGAffineTransform(scaleX: currentScale, y: currentScale)
        }
    }
}
















