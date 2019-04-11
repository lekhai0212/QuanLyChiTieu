//
//  AccountTypeCell.swift
//  QuanLyChiTieu
//
//  Created by admin on 4/10/19.
//  Copyright © 2019 KhaiLe. All rights reserved.
//

import UIKit
import Masonry

class AccountTypeCell: UITableViewCell {

    @IBOutlet weak var imgType: UIImageView!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var imgChoose: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imgType.mas_makeConstraints { (make:MASConstraintMaker?) in
            make?.centerY.equalTo()(self.mas_centerY)
            make?.left.equalTo()(self)?.offset()(15.0)
            make?.width.height()?.mas_equalTo()(32.0)
        }
        
        imgChoose.mas_makeConstraints { (make:MASConstraintMaker?) in
            make?.centerY.equalTo()(self.mas_centerY)
            make?.right.equalTo()(self)?.offset()(-15.0)
            make?.width.height()?.mas_equalTo()(18.0)
        }
        
        lbName.font = UIFont.systemFont(ofSize: 16.0, weight: .thin)
        lbName.textColor = UIColor(red: 80/255.0, green: 80/255.0, blue: 80/255.0, alpha: 1.0)
        lbName.mas_makeConstraints { (make:MASConstraintMaker?) in
            make?.left.equalTo()(imgType.mas_right)?.offset()(10)
            make?.right.equalTo()(imgChoose.mas_left)?.offset()(-10.0)
            make?.top.bottom()?.equalTo()(self)
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        if highlighted {
            self.backgroundColor = UIColor(red: 235/255.0, green: 235/255.0, blue: 235/255.0, alpha: 1.0)
        }else{
            self.backgroundColor = UIColor.white
        }
    }
}
