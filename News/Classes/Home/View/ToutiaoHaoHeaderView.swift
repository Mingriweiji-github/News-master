//
//  ToutiaoHaoHeaderView.swift
//  News
//
//  Created by M_Li on 2017/9/4.
//  Copyright © 2017年 M_Li. All rights reserved.
//

import UIKit

protocol ToutiaohaoHeaderViewDelegate {
    func toutiaoHeaderButtonClicked()
}

class ToutiaoHaoHeaderView: UIView {

    var delegate:ToutiaohaoHeaderViewDelegate?
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white
        addSubview(moreBtn)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var moreBtn: UIButton = {
        let moreBtn = UIButton(frame: CGRect(x: 10, y: 10, width: KScreenWidth - 20, height: 35))
        moreBtn.addTarget(self, action: #selector(moreButtonClicked), for: .touchUpInside)
        moreBtn.setTitle("关注更多头条号", for: .normal)
        moreBtn.setImage(UIImage(named:"addpgc_subscribe_16x16_"), for: .normal)
        moreBtn.setTitleColor(UIColor(r: 230, g: 7, b: 20), for: .normal)
        moreBtn.layer.cornerRadius = 5
        moreBtn.layer.borderWidth = 1
        moreBtn.layer.masksToBounds = true
        return moreBtn
    }()
    
    func moreButtonClicked() {
        delegate?.toutiaoHeaderButtonClicked()
    }
}
