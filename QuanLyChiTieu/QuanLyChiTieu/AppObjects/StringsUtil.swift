//
//  StringsUtil.swift
//  QuanLyChiTieu
//
//  Created by lam quang quan on 4/10/19.
//  Copyright © 2019 KhaiLe. All rights reserved.
//

import UIKit

class StringsUtil: NSObject {
     class func getSizeOfText(content:String, font:UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedStringKey.font: font]
        let size:CGSize = content.size(withAttributes: fontAttributes)
        return size.width
    }
    
    class func currencyFormatting(str:String) -> String {
        if let value = Double(str) {
            let formatter = NumberFormatter()
            formatter.numberStyle = .currency
            formatter.maximumFractionDigits = 2
            formatter.positiveFormat = "#,##0 ¤"
            if let str = formatter.string(for: value) {
                return str
            }
        }
        return ""
    }
}
