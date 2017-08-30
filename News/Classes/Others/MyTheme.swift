//
//  MyTheme.swift
//  News
//
//  Created by M_Li on 2017/8/30.
//  Copyright © 2017年 M_Li. All rights reserved.
//

import Foundation
import SwiftTheme

enum MyTheme: Int{
    case day = 0
    case night = 1
    
    static var current = MyTheme.day
    static var last = MyTheme.day
    
    static func swithchTo(_ theme:MyTheme){
        last = current
        current = theme
        
        switch theme {
        case .day:
            ThemeManager.setTheme(plistName: "default_theme", path: .mainBundle)
        case .night:
            ThemeManager.setTheme(plistName: "night_theme", path: .mainBundle)
        }
    }
    
    static func switchNight(_ isToNight: Bool){
    
        swithchTo(isToNight ? .night : .day)
    }
    
    static func isDay() -> Bool{
       return current == .night
    }
    

}
