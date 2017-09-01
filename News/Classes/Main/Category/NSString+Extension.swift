//
//  NSString+Extension.swift
//  News
//
//  Created by M_Li on 2017/9/1.
//  Copyright © 2017年 M_Li. All rights reserved.
//

import UIKit

extension String {
    subscript (range: Range<Int>) -> String {
        get {
            let startIndex = self.index(self.startIndex, offsetBy: range.lowerBound)
            let endIndex = self.index(self.startIndex, offsetBy: range.upperBound)
            return self[Range(startIndex..<endIndex)]
        }
        
        set {
            let startIndex = self.index(self.startIndex, offsetBy: range.lowerBound)
            let endIndex = self.index(self.startIndex, offsetBy: range.upperBound)
            let strRange = Range(startIndex..<endIndex)
            self.replaceSubrange(strRange, with: newValue)
        }
    }
}
extension NSString{//文本高度

    func getTextHeight(width:CGFloat) -> CGFloat {
        
        let size = CGSize(width: width, height: CGFloat(MAXFLOAT))
        return self.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 15)], context: nil).size.height
    }

}
