//
//  Date+Extension.swift
//  News
//
//  Created by M_Li on 2017/9/1.
//  Copyright © 2017年 M_Li. All rights reserved.
//

import Foundation

extension Date{

    //是否今年
    func isThisYear() ->Bool{
        
        let calender = Calendar.current
        
        let yearComps = calender.component(Calendar.Component.year, from: self)
        let nowComps = calender.component(Calendar.Component.year, from: Date())
        return yearComps == nowComps
    }
    //是否为昨天
    func isYesterday() -> Bool{
    
        var now = Date()
        let fmt = DateFormatter()
        fmt.dateFormat = "yyyy-MM-dd"
        
        let dateStr = fmt.string(from: self)
        let nowStr = fmt.string(from: now)
        
        let date = fmt.date(from: dateStr)
        now = fmt.date(from: nowStr)!
        
        let calender = Calendar.current
        let comps = calender.dateComponents([.year,.month,.day], from: date!, to: now)
        
        return  comps.year == 0 && comps.month == 0 && comps.day == 1
    }
    //是否今天
    func isToday() -> Bool {
        
        let now = Date()
        let fmt = DateFormatter()
        fmt.dateFormat = "yyyy-MM-dd"
        let dateStr = fmt.string(from:self)
        let nowStr = fmt.string(from: now)
        
        return dateStr == nowStr
    }

}
