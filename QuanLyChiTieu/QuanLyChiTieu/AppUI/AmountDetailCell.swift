//
//  AmountDetailCell.swift
//  QuanLyChiTieu
//
//  Created by lam quang quan on 4/10/19.
//  Copyright © 2019 KhaiLe. All rights reserved.
//

import UIKit
import Masonry

class AmountDetailCell: UITableViewCell {

    @IBOutlet weak var imgType: UIImageView!
    @IBOutlet weak var tfContent: UITextField!
    @IBOutlet weak var imgArrow: UIImageView!
    @IBOutlet weak var lbSepa: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imgType.mas_makeConstraints { (make:MASConstraintMaker?) in
            make?.left.equalTo()(self)?.offset()(7.5)
            make?.centerY.equalTo()(self.mas_centerY)
            make?.width.height().mas_equalTo()(30.0)
        }
        
        imgArrow.mas_makeConstraints { (make:MASConstraintMaker?) in
            make?.right.equalTo()(self)?.offset()(-5.0)
            make?.centerY.equalTo()(self.mas_centerY)
            make?.width.height().mas_equalTo()(15.0)
        }
        
        tfContent.borderStyle = .none
        tfContent.mas_makeConstraints { (make:MASConstraintMaker?) in
            make?.left.equalTo()(imgType.mas_right)?.offset()(5.0)
            make?.right.equalTo()(imgArrow.mas_left)?.offset()(-5.0)
            make?.centerY.equalTo()(self.mas_centerY)
            make?.height.mas_equalTo()(30.0)
        }
        
        lbSepa.backgroundColor = UIColor(red: 220/255.0, green: 220/255.0, blue: 220/255.0, alpha: 1.0)
        lbSepa.mas_makeConstraints { (make:MASConstraintMaker?) in
            make?.left.equalTo()(tfContent)
            make?.right.bottom().equalTo()(self)
            make?.height.mas_equalTo()(1.0)
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}