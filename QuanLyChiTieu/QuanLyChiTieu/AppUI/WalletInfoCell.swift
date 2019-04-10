//
//  WalletInfoCell.swift
//  QuanLyChiTieu
//
//  Created by lam quang quan on 4/10/19.
//  Copyright © 2019 KhaiLe. All rights reserved.
//

import UIKit
import Masonry

class WalletInfoCell: UITableViewCell {

    @IBOutlet weak var lbMoney: UILabel!
    @IBOutlet weak var imgArrow: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        lbMoney.textAlignment = .right
        lbMoney.font = UIFont.systemFont(ofSize: 20.0, weight: .semibold)
        lbMoney.textColor = UIColor.init(red: 0, green: 0.686, blue: 0.94, alpha: 1.0)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateFrameForCell() {
        let textSize:CGFloat = StringsUtil.getSizeOfText(content:lbMoney.text!, font:UIFont.systemFont(ofSize: 20.0, weight: .bold))
        let originX:CGFloat = (self.frame.size.width - (textSize + 5.0 + 22.0))/2
        
        lbMoney.mas_makeConstraints { (make:MASConstraintMaker?) in
            make?.top.bottom().equalTo()(self)
            make?.left.equalTo()(self)?.offset()(originX)
            make?.width.mas_equalTo()(textSize)
        }
        
        imgArrow.mas_makeConstraints { (make:MASConstraintMaker?) in
            make?.centerY.equalTo()(self.mas_centerY)
            make?.left.equalTo()(lbMoney.mas_right)?.offset()(5.0)
            make?.width.height().mas_equalTo()(22.0)
        }
    }
    
}
