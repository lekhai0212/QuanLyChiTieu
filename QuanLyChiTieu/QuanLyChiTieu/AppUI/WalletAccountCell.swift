//
//  WalletAccountCell.swift
//  QuanLyChiTieu
//
//  Created by lam quang quan on 4/11/19.
//  Copyright © 2019 KhaiLe. All rights reserved.
//

import UIKit
import Masonry

class WalletAccountCell: UITableViewCell {
    @IBOutlet weak var imgType: UIImageView!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbMoney: UILabel!
    @IBOutlet weak var icMore: UIButton!
    @IBOutlet weak var lbSepa: UILabel!
    @IBOutlet weak var imgChecked: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        lbSepa.backgroundColor = UIColor(red: 235/255.0, green: 235/255.0, blue: 235/255.0, alpha: 1.0)
        lbSepa.mas_makeConstraints { (make:MASConstraintMaker?) in
            make?.left.right().bottom().equalTo()(self)
            make?.height.mas_equalTo()(1.0)
        }
        
        imgType.mas_makeConstraints { (make:MASConstraintMaker?) in
            make?.left.equalTo()(self)?.offset()(15.0)
            make?.centerY.equalTo()(self.mas_centerY)
            make?.width.height().mas_equalTo()(36.0)
        }
        
        icMore.imageEdgeInsets = UIEdgeInsetsMake(8, 8, 8, 8)
        icMore.mas_makeConstraints { (make:MASConstraintMaker?) in
            make?.right.equalTo()(self)?.offset()(-5.0)
            make?.centerY.equalTo()(self.mas_centerY)
            make?.width.height().mas_equalTo()(35.0)
        }
        
        imgChecked.mas_makeConstraints { (make:MASConstraintMaker?) in
            make?.right.equalTo()(self)?.offset()(-5.0)
            make?.centerY.equalTo()(self.mas_centerY)
            make?.width.height().mas_equalTo()(18.0)
        }
        
        lbName.textColor = UIColor(red: 80/255.0, green: 80/255.0, blue: 80/255.0, alpha: 1.0)
        lbName.font = UIFont.systemFont(ofSize: 17.0, weight: .regular)
        lbName.mas_makeConstraints { (make:MASConstraintMaker?) in
            make?.left.equalTo()(imgType.mas_right)?.offset()(10.0)
            make?.right.equalTo()(icMore.mas_left)?.offset()(-10.0)
            make?.top.equalTo()(self)?.offset()(10.0)
        }
        
        lbMoney.textColor = UIColor(red: 150/255.0, green: 150/255.0, blue: 150/255.0, alpha: 1.0)
        lbMoney.font = UIFont.systemFont(ofSize: 14.0, weight: .thin)
        lbMoney.mas_makeConstraints { (make:MASConstraintMaker?) in
            make?.left.right().equalTo()(lbName)
            make?.top.equalTo()(lbName.mas_bottom)
            make?.bottom.equalTo()(self)?.offset()(-10.0)
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
