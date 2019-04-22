//
//  CustomTextAttachment.swift
//  QuanLyChiTieu
//
//  Created by lam quang quan on 4/22/19.
//  Copyright © 2019 KhaiLe. All rights reserved.
//

import UIKit

class CustomTextAttachment: NSTextAttachment {
    var imgHeight:CGFloat!
    
    override func attachmentBounds(for textContainer: NSTextContainer?, proposedLineFragment lineFrag: CGRect, glyphPosition position: CGPoint, characterIndex charIndex: Int) -> CGRect {
        var bounds:CGRect = CGRect.zero
        bounds.origin = CGPoint(x: 0, y: -4.5)
        bounds.size = CGSize(width: imgHeight, height: imgHeight)
        return bounds
    }
    
    func setImageHeight(height:CGFloat) {
        imgHeight = height
    }
}
