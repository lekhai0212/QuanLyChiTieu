//
//  SelectAccountCell.swift
//  QuanLyChiTieu
//
//  Created by lam quang quan on 4/22/19.
//  Copyright © 2019 KhaiLe. All rights reserved.
//

import UIKit
import Masonry

class SelectAccountCell: UITableViewCell {
    @IBOutlet weak var imgType: UIImageView!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var imgSelected: UIImageView!
    @IBOutlet weak var lbSepa: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        imgType.mas_makeConstraints { (make:MASConstraintMaker?) in
            make?.left.equalTo()(self)?.offset()(7.5)
            make?.centerY.equalTo()(self.mas_centerY)
            make?.width.height().mas_equalTo()(35.0)
        }
        
        imgSelected.mas_makeConstraints { (make:MASConstraintMaker?) in
            make?.right.equalTo()(self)?.offset()(-7.5)
            make?.centerY.equalTo()(self.mas_centerY)
            make?.width.height().mas_equalTo()(18.0)
        }
        
        lbName.textColor = UIColor(red: 80/255.0, green: 80/255.0, blue: 80/255.0, alpha: 1.0)
        lbName.font = UIFont.systemFont(ofSize: 18.0, weight: .regular)
        lbName.mas_makeConstraints { (make:MASConstraintMaker?) in
            make?.top.bottom().equalTo()(self)
            make?.left.equalTo()(imgType.mas_right)?.offset()(10.0)
            make?.right.equalTo()(imgSelected.mas_left)?.offset()(-10.0)
        }
        
        lbSepa.text = ""
        lbSepa.backgroundColor = UIColor(red: 240/255.0, green: 240/255.0, blue: 240/255.0, alpha: 1.0)
        lbSepa.mas_makeConstraints { (make:MASConstraintMaker?) in
            make?.left.right().bottom().equalTo()(self)
            make?.height.mas_equalTo()(1.0)
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
