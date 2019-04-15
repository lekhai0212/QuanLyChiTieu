//
//  ActionMenuCell.swift
//  QuanLyChiTieu
//
//  Created by admin on 4/15/19.
//  Copyright © 2019 KhaiLe. All rights reserved.
//

import UIKit
import Masonry

class ActionMenuCell: UITableViewCell {
    @IBOutlet weak var imgArrow: UIImageView!
    @IBOutlet weak var imgType: UIImageView!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbSepa: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        lbName.textAlignment = .left
        lbName.textColor = UIColor(red: 80/255.0, green: 80/255.0, blue: 80/255.0, alpha: 1.0)
        lbName.font = UIFont.systemFont(ofSize: 16.0, weight: .regular)
        
        lbSepa.text = ""
        lbSepa.backgroundColor = UIColor(red: 240/255.0, green: 240/255.0, blue: 240/255.0, alpha: 1.0)
        lbSepa.mas_makeConstraints { (make:MASConstraintMaker?) in
            make?.left.right()?.bottom()?.equalTo()(self)
            make?.height.mas_equalTo()(1.0)
        }
        
        imgArrow.mas_makeConstraints { (make:MASConstraintMaker?) in
            make?.centerY.equalTo()(self.mas_centerY)
            make?.left.equalTo()(self)?.offset()(10.0)
            make?.width.height()?.mas_equalTo()(15.0)
        }
        
        imgType.mas_makeConstraints { (make:MASConstraintMaker?) in
            make?.centerY.equalTo()(self.mas_centerY)
            make?.left.equalTo()(imgArrow.mas_right)?.offset()(5.0)
            make?.width.height()?.mas_equalTo()(38.0)
        }
        
        lbName.mas_makeConstraints { (make:MASConstraintMaker?) in
            make?.top.bottom().equalTo()(self)
            make?.left.equalTo()(imgType.mas_right)?.offset()(5.0)
            make?.right.equalTo()(self)?.offset()(-5.0)
        }
    }
    
    func setFrameForParent(isParent:Bool) {
        if isParent {
            imgArrow.mas_remakeConstraints { (make:MASConstraintMaker?) in
                make?.centerY.equalTo()(self.mas_centerY)
                make?.left.equalTo()(self)?.offset()(10.0)
                make?.width.height()?.mas_equalTo()(15.0)
            }
            
            imgType.mas_remakeConstraints { (make:MASConstraintMaker?) in
                make?.centerY.equalTo()(self.mas_centerY)
                make?.left.equalTo()(imgArrow.mas_right)?.offset()(5.0)
                make?.width.height()?.mas_equalTo()(30.0)
            }
            
            lbName.mas_remakeConstraints { (make:MASConstraintMaker?) in
                make?.top.bottom().equalTo()(self)
                make?.left.equalTo()(imgType.mas_right)?.offset()(5.0)
                make?.right.equalTo()(self)?.offset()(-5.0)
            }
        }else{
            imgArrow.mas_remakeConstraints { (make:MASConstraintMaker?) in
                make?.centerY.equalTo()(self.mas_centerY)
                make?.left.equalTo()(self)?.offset()(10.0)
                make?.width.height()?.mas_equalTo()(15.0)
            }
            
            imgType.mas_remakeConstraints { (make:MASConstraintMaker?) in
                make?.centerY.equalTo()(self.mas_centerY)
                make?.left.equalTo()(imgArrow.mas_right)?.offset()(50.0)
                make?.width.height()?.mas_equalTo()(38.0)
            }
            
            lbName.mas_remakeConstraints { (make:MASConstraintMaker?) in
                make?.top.bottom().equalTo()(self)
                make?.left.equalTo()(imgType.mas_right)?.offset()(5.0)
                make?.right.equalTo()(self)?.offset()(-5.0)
            }
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
