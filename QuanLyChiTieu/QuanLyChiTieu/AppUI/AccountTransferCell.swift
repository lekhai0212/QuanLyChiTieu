//
//  AccountTransferCell.swift
//  QuanLyChiTieu
//
//  Created by admin on 4/23/19.
//  Copyright © 2019 KhaiLe. All rights reserved.
//

import UIKit
import Masonry

class AccountTransferCell: UITableViewCell {

    @IBOutlet weak var imgType: UIImageView!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var imgArrow: UIImageView!
    @IBOutlet weak var lbSepa: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imgType.mas_makeConstraints { (make:MASConstraintMaker?) in
            make?.left.equalTo()(self)?.offset()(10.0)
            make?.centerY.equalTo()(self.mas_centerY)
            make?.width.height()?.equalTo()(30.0)
        }
        
        imgArrow.mas_makeConstraints { (make:MASConstraintMaker?) in
            make?.right.equalTo()(self)?.offset()(-10.0)
            make?.centerY.equalTo()(self.mas_centerY)
            make?.width.height()?.equalTo()(18.0)
        }
        
        lbTitle.textColor = UIColor.gray
        lbTitle.font = UIFont.systemFont(ofSize: 13.0, weight: .thin)
        lbTitle.mas_makeConstraints { (make:MASConstraintMaker?) in
            make?.left.equalTo()(imgType.mas_right)?.offset()(10.0)
            make?.right.equalTo()(imgArrow.mas_left)?.offset()(-10.0)
            make?.top.equalTo()(self)?.offset()(10.0)
            make?.bottom.equalTo()(self.mas_centerY)
        }
        
        lbName.textColor = UIColor(red: (80/255.0), green: (80/255.0), blue: (80/255.0), alpha: 1.0)
        lbName.font = UIFont.systemFont(ofSize: 18.0, weight: .thin)
        lbName.mas_makeConstraints { (make:MASConstraintMaker?) in
            make?.left.right().equalTo()(lbTitle)
            make?.top.equalTo()(self.mas_centerY)
            make?.bottom.equalTo()(self)?.offset()(-10.0)
        }
        
        lbSepa.backgroundColor = UIColor(red: (240/255.0), green: (240/255.0), blue: (240/255.0), alpha: 1.0)
        lbSepa.mas_makeConstraints { (make:MASConstraintMaker?) in
            make?.bottom.left().right().equalTo()(lbTitle)
            make?.height.mas_equalTo()(1.0)
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}
