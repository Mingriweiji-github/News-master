//
//  HomeSearchField.swift
//  News
//
//  Created by M_Li on 2017/8/22.
//  Copyright © 2017年 M_Li. All rights reserved.
//

import UIKit

class HomeSearchField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let  searchIcon = UIImageView()
        searchIcon.image = UIImage(named:"searchicon_search_20x20_")
        searchIcon.width = 30
        searchIcon.height = 30
        searchIcon.contentMode = .center
        leftView = searchIcon
        leftViewMode = .always
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    class func searchBar() -> HomeSearchField{
    
        return HomeSearchField()
    }
}
