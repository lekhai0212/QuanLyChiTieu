//
//  TransferFeeCell.swift
//  QuanLyChiTieu
//
//  Created by admin on 4/24/19.
//  Copyright © 2019 KhaiLe. All rights reserved.
//

import UIKit
import Masonry

class TransferFeeCell: UITableViewCell {

    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var icSwitch: UISwitch!
    @IBOutlet weak var lbSepa: UILabel!
    @IBOutlet weak var lbMoney: UILabel!
    @IBOutlet weak var tfMoney: UITextField!
    @IBOutlet weak var lbSymbol: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let padding:CGFloat = 10.0
        lbTitle.font = UIFont.systemFont(ofSize: 16.0, weight: .regular)
        lbTitle.mas_makeConstraints { (make:MASConstraintMaker?) in
            make?.left.equalTo()(self)?.offset()(padding)
            make?.top.equalTo()(self)
            make?.height.mas_equalTo()(45.0)
        }
        
        icSwitch.mas_makeConstraints { (make:MASConstraintMaker?) in
            make?.right.equalTo()(self)?.offset()(-padding)
            make?.centerY.equalTo()(lbTitle.mas_centerY)
            make?.width.mas_equalTo()(49.0)
            make?.height.mas_equalTo()(31.0)
        }
        
        lbSepa.backgroundColor = UIColor(red: 240/255.0, green: 240/255.0, blue: 240/255.0, alpha: 1.0)
        lbSepa.mas_makeConstraints { (make:MASConstraintMaker?) in
            make?.right.equalTo()(self)
            make?.top.equalTo()(lbTitle.mas_bottom)
            make?.left.equalTo()(self)?.offset()(padding)
            make?.height.mas_equalTo()(1.0)
        }
        
        lbMoney.font = UIFont.systemFont(ofSize: 13.0, weight: .thin)
        lbMoney.mas_makeConstraints { (make:MASConstraintMaker?) in
            make?.left.equalTo()(self)?.offset()(padding)
            make?.top.equalTo()(lbSepa.mas_bottom)
            make?.height.mas_equalTo()(20.0)
        }
        
        lbSymbol.font = UIFont.systemFont(ofSize: 24.0, weight: .regular)
        lbSymbol.textColor = UIColor(red: 80/255.0, green: 80/255.0, blue: 80/255.0, alpha: 1.0)
        lbSymbol.mas_makeConstraints { (make:MASConstraintMaker?) in
            make?.right.equalTo()(self)?.offset()(-padding)
            make?.top.equalTo()(lbMoney.mas_bottom)
            make?.height.mas_equalTo()(60.0)
        }
        
        tfMoney.text = "0"
        tfMoney.textAlignment = .right
        tfMoney.borderStyle = .none
        tfMoney.font = UIFont.systemFont(ofSize: 34.0, weight: .bold)
        tfMoney.textColor = UIColor(red: 0, green: 0.686, blue: 0.94, alpha: 1.0)
        tfMoney.mas_makeConstraints { (make:MASConstraintMaker?) in
            make?.left.equalTo()(self)?.offset()(padding)
            make?.right.equalTo()(lbSymbol.mas_left)
            make?.top.bottom().equalTo()(lbSymbol)
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
