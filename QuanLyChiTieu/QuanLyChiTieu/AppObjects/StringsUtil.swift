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
}
