//
//  ActionCell.swift
//  QuanLyChiTieu
//
//  Created by lam quang quan on 4/10/19.
//  Copyright © 2019 KhaiLe. All rights reserved.
//

import UIKit
import Masonry

class ActionCell: UITableViewCell {

    @IBOutlet weak var imgType: UIImageView!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbDescription: UILabel!
    @IBOutlet weak var lbDate: UILabel!
    @IBOutlet weak var lbMoney: UILabel!
    @IBOutlet weak var lbSource: UILabel!
    @IBOutlet weak var imgSourceType: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imgType.mas_makeConstraints { (make:MASConstraintMaker?) in
            make?.centerY.equalTo()(self.mas_centerY)
            make?.left.equalTo()(self)?.offset()(5.0)
            make?.width.height().mas_equalTo()(32.0)
        }
        
        lbMoney.font = UIFont.systemFont(ofSize: 16.0, weight: .regular)
        lbMoney.mas_makeConstraints { (make:MASConstraintMaker?) in
            make?.right.equalTo()(self)?.offset()(-5.0)
            make?.top.equalTo()(self)
            make?.bottom.equalTo()(self.mas_centerY)
        }
        
        lbTitle.font = UIFont.systemFont(ofSize: 16.0, weight: .regular)
        lbTitle.mas_makeConstraints { (make:MASConstraintMaker?) in
            make?.left.equalTo()(imgType.mas_right)?.offset()(5.0)
            make?.right.equalTo()(lbMoney.mas_left)?.offset()(-5.0)
            make?.top.equalTo()(self)
            make?.bottom.equalTo()(self.mas_centerY)
        }
        
        lbDescription.font = UIFont.italicSystemFont(ofSize: 13.0)
        lbDescription.mas_makeConstraints { (make:MASConstraintMaker?) in
            make?.left.right().equalTo()(lbTitle)
            make?.top.equalTo()(lbTitle.mas_bottom)
            make?.height.equalTo()(self)?.multipliedBy()(1/4)
        }
        
        lbDate.font = UIFont.systemFont(ofSize: 13.0, weight: .regular)
        lbDate.mas_makeConstraints { (make:MASConstraintMaker?) in
            make?.left.right().equalTo()(lbDescription)
            make?.top.equalTo()(lbDescription.mas_bottom)
            make?.bottom.equalTo()(self)
        }
        
        lbSource.font = UIFont.systemFont(ofSize: 13.0, weight: .regular)
        lbSource.mas_makeConstraints { (make:MASConstraintMaker?) in
            make?.right.equalTo()(lbMoney.mas_right)
            make?.top.bottom().equalTo()(lbDescription)
        }
        
        imgSourceType.mas_makeConstraints { (make:MASConstraintMaker?) in
            make?.right.equalTo()(lbSource.mas_left)?.offset()(-3.0)
            make?.centerY.equalTo()(lbSource.mas_centerY)
            make?.width.height().mas_equalTo()(16.0)
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
