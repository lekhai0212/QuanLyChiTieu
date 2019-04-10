//
//  BalanceCell.swift
//  QuanLyChiTieu
//
//  Created by lam quang quan on 4/10/19.
//  Copyright © 2019 KhaiLe. All rights reserved.
//

import UIKit
import Masonry

class BalanceCell: UITableViewCell {

    @IBOutlet weak var lbAmount: UILabel!
    @IBOutlet weak var tfAmount: UITextField!
    @IBOutlet weak var lbSymbol: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        lbAmount.font = UIFont.systemFont(ofSize: 14.0, weight: .thin)
        lbAmount.textColor = UIColor(red: 80/255.0, green: 80/255.0, blue: 80/255.0, alpha: 1.0)
        lbAmount.mas_makeConstraints { (make:MASConstraintMaker?) in
            make?.left.equalTo()(self)?.offset()(10.0)
            make?.right.equalTo()(self)?.offset()(-10.0)
            make?.top.equalTo()(self)
            make?.height.mas_equalTo()(35.0)
        }
        
        lbSymbol.font = UIFont.systemFont(ofSize: 24.0, weight: .regular)
        lbSymbol.textColor = lbAmount.textColor
        lbSymbol.mas_makeConstraints { (make:MASConstraintMaker?) in
            make?.right.equalTo()(self)?.offset()(-10.0)
            make?.top.equalTo()(lbAmount.mas_bottom)
            make?.bottom.equalTo()(self)
            make?.width.mas_equalTo()(35.0)
        }
        
        tfAmount.font = UIFont.systemFont(ofSize: 28.0, weight: .thin)
        tfAmount.textColor = UIColor(red: 0, green: 0.686, blue: 0.94, alpha: 1.0)
        tfAmount.mas_makeConstraints { (make:MASConstraintMaker?) in
            make?.left.equalTo()(lbAmount)
            make?.right.equalTo()(lbSymbol.mas_left)?.offset()(-3.0)
            make?.centerY.equalTo()(lbSymbol.mas_centerY)
            make?.height.mas_equalTo()(40.0)
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
