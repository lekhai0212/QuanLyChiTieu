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
    
    class func createAttributedText(text:String, image:UIImage, size:CGFloat) -> NSAttributedString {
        
        let attachment:CustomTextAttachment = CustomTextAttachment()
        attachment.image = image
        attachment.setImageHeight(height: size)
        let attachmentAttr:NSAttributedString = NSAttributedString(attachment: attachment)
        
        let contentString:NSMutableAttributedString = NSMutableAttributedString(string: text)
        contentString.addAttribute(.font, value: UIFont.systemFont(ofSize: 16.0), range: NSMakeRange(0, text.count))
        contentString.addAttribute(.foregroundColor, value: UIColor.white, range: NSMakeRange(0, text.count))
        
        contentString.append(attachmentAttr)
        
        return contentString;
    }
}
