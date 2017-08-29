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

    weak var delegate: HomeTitleViewDelegate!
    var currentIndex:Int = 0
    
    
    var titles:[HomeTopicTitle]?{
    
        didSet{
        
            setupTitleLabel()
            setupTitleLabelsFrame()
            
            
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
    
        print("点击右侧搜索")
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
            
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(titleLableClicked(_:)))
            
            titleLabel.addGestureRecognizer(tapGesture)
            titleLabel.isUserInteractionEnabled = true
        }
    }
    
    fileprivate func setupTitleLabelsFrame() {
        
        for (i, label) in titleLabels.enumerated() {
            var w : CGFloat = 0
            let h : CGFloat = 40
            var x : CGFloat = 0
            let y : CGFloat = 0
            
            let topTitle = titles![i]
            
            w = (topTitle.name! as NSString).boundingRect(with: CGSize(width: CGFloat(MAXFLOAT), height:0), options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName : label.font], context: nil).width
            if i == 0 {
                x = KMargin * 0.5
                bottomLine.x = x
                bottomLine.width = w
            } else {
                let preLabel = titleLabels[i - 1]
                x = preLabel.frame.maxX + KMargin
            }
            label.frame = CGRect(x: x, y: y, width: w, height: h)
        }
        scrollView.contentSize = CGSize(width: titleLabels.last!.frame.maxX + KMargin * 0.5, height: 0)
    }
}

//MAKR:监听点击事件

extension HomeTitleView{

    @objc fileprivate func titleLableClicked(_ gesture:UITapGestureRecognizer){
    
        let targetLabel = gesture.view as! HomeTitleLabel
        
        adjustTitleLabel(targetIndex: targetLabel.tag)
        
        UIView.animate(withDuration: kAnimationDuration) { 
            self.bottomLine.centerX = targetLabel.centerX
            self.bottomLine.width = targetLabel.width
        }
        
        delegate.titleView(self, selected: currentIndex)
        
    }
    
    fileprivate func adjustTitleLabel(targetIndex:Int){
    
        if targetIndex == currentIndex  {
            return
        }
        
        let targetLabel = titleLabels[targetIndex]
        let currentLabel = titleLabels[currentIndex]
        
        targetLabel.textColor = UIColor.globalRedColor()
        currentLabel.textColor = UIColor.black
        targetLabel.currentScale = 1.5
        currentLabel.currentScale = 1.0
        
        UIView.animate(withDuration: kAnimationDuration) { 
            self.bottomLine.centerX = targetLabel.centerX
            self.bottomLine.width = targetLabel.width
        }
        
        currentIndex = targetIndex
        
        var  offsetX  = targetLabel.centerX - scrollView.width * 0.5
        
        if offsetX < 0 {
            offsetX = 0
        }
        
        var  maxOffSet = scrollView.contentSize.width - scrollView.width
        
        if maxOffSet < 0 {
            maxOffSet = 0
        }
        
        if offsetX > maxOffSet {
            offsetX = maxOffSet
        }
        scrollView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
        
    }
    
    @objc fileprivate func rightBtnClicked(){
    
        NotificationCenter.default.post(name: NSNotification.Name(rawValue:"homeTitleAddButtonClicked"), object: titles)
    }
    
    
}

extension HomeTitleView:HomePageViewDelegate{

    func pageView(_ pageView:HomePageView,currentIndex:Int){
    
        adjustTitleLabel(targetIndex: currentIndex)
    }
}

private class HomeTitleLabel:UILabel{

    var currentScale :CGFloat = 1.0{
    
        didSet{
        
            transform = CGAffineTransform(scaleX: currentScale, y: currentScale)
        }
    }
}
















