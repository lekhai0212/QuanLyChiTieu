//
//  ChooseAccountTypePopupView.swift
//  QuanLyChiTieu
//
//  Created by admin on 4/10/19.
//  Copyright © 2019 KhaiLe. All rights reserved.
//

import UIKit
import Masonry

protocol ChooseAccountTypePopupViewDelegate {
    func selectAccountType(type:Int)
}


class ChooseAccountTypePopupView: UIView, UITableViewDelegate, UITableViewDataSource {
    var tbContent:UITableView!
    var lbHeader:UILabel!
    var lbSepa:UILabel!
    var tapGesture:UITapGestureRecognizer!
    var curType:Int!
    var delegate:ChooseAccountTypePopupViewDelegate!
    
    func setupUIWithFrame(frame:CGRect) {
        self.frame = frame
        self.backgroundColor =  UIColor.white;
        self.clipsToBounds = true
        self.layer.cornerRadius = 6.0
        
        lbHeader =  UILabel()
        lbHeader.font = UIFont.systemFont(ofSize: 20.0, weight: .regular)
        lbHeader.textAlignment = .center;
        lbHeader.text = NSLocalizedString("Select account type", comment: "")
        lbHeader.textColor = UIColor(red: 0, green: 0.686, blue: 0.94, alpha: 1.0)
        self.addSubview(lbHeader)
        
        lbHeader.mas_makeConstraints { (make:MASConstraintMaker?) in
            make?.top.left()?.right()?.equalTo()(self)
            make?.height.mas_equalTo()(50.0)
        }
        
        tbContent = UITableView()
        
        let cellNib = UINib(nibName: "AccountTypeCell", bundle: nil)
        tbContent.register(cellNib, forCellReuseIdentifier: "AccountTypeCell")
        
        tbContent.delegate = self
        tbContent.dataSource = self
        tbContent.separatorStyle = .none
        self.addSubview(tbContent)
        tbContent.mas_makeConstraints { (make:MASConstraintMaker?) in
            make?.top.equalTo()(lbHeader.mas_bottom)
            make?.left.right()?.bottom()?.equalTo()(self)
        }
        
        lbSepa = UILabel()
        lbSepa.backgroundColor = UIColor(red: 245/255.0, green: 245/255.0, blue: 245/255.0, alpha: 1.0)
        self.addSubview(lbSepa)
        lbSepa.mas_makeConstraints { (make:MASConstraintMaker?) in
            make?.left.right()?.equalTo()(self)
            make?.top.equalTo()(lbHeader.mas_bottom)
            make?.height.mas_equalTo()(1.0)
        }
    }
    
    func showInView(aView:UIView, animated:Bool) {
        //Add transparent
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(closePopupViewWhenTagOut))
        let viewBackground:UIView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height))
        viewBackground.backgroundColor = UIColor.black
        viewBackground.alpha = 0.5
        viewBackground.tag = 20
        aView.addSubview(viewBackground)
        viewBackground.addGestureRecognizer(tapGesture)
        aView.addSubview(self)
        if (animated) {
            self.fadeIn()
        }
    }
    
    func fadeIn() {
        self.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.alpha = 0
        
        UIView.animate(withDuration: 0.35, animations: {
            self.alpha = 1.0
            self.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }) { (result) in
            self.updateScrollEnable()
        }
    }
    
    func updateScrollEnable() {
        if tbContent.frame.size.height < tbContent.contentSize.height {
            tbContent.isScrollEnabled = true
        }else{
            tbContent.isScrollEnabled = false
        }
    }
    
    func fadeOut() {
        for subView:UIView in (self.superview?.subviews)! {
            if subView.tag == 20 {
                subView.removeFromSuperview()
            }
        }
        
        UIView.animate(withDuration: 0.35, animations: {
            self.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.alpha = 0
        }) { (result) in
            NotificationCenter.default.removeObserver(self)
            self.removeFromSuperview()
        }
    }
    
    @objc func closePopupViewWhenTagOut() {
        self.fadeOut()
        self.superview?.removeGestureRecognizer(tapGesture)
    }
    
    //  MARK: Tableview
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AccountTypeCell", for: indexPath) as! AccountTypeCell
        cell.selectionStyle = .none
        
        if indexPath.row == 0 {
            cell.imgType.image = UIImage(named: "ic_money")
            cell.lbName.text = NSLocalizedString("Cash", comment: "")
            
            if curType == 1 {
                cell.imgChoose.isHidden = false
            }else{
                cell.imgChoose.isHidden = true
            }
        }else{
            cell.imgType.image = UIImage(named: "ic_bank")
            cell.lbName.text = NSLocalizedString("Bank Account", comment: "")
            
            if curType == 2 {
                cell.imgChoose.isHidden = false
            }else{
                cell.imgChoose.isHidden = true
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.fadeOut()
        if indexPath.row == 0 {
            curType = 1
        }else{
            curType = 2
        }
        delegate.selectAccountType(type: curType)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
}
