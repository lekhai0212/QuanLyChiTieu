//
//  CreateAccountViewController.swift
//  QuanLyChiTieu
//
//  Created by lam quang quan on 4/10/19.
//  Copyright © 2019 KhaiLe. All rights reserved.
//

import UIKit
import Masonry

class CreateAccountViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tbContent: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = NSLocalizedString("Add account", comment: "")
        self.createDoneBarButtonItem()
        self.setupUIForView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupUIForView() {
        self.automaticallyAdjustsScrollViewInsets = false
        
        let originY:CGFloat = UIApplication.shared.statusBarFrame.size.height + (self.navigationController?.navigationBar.frame.size.height)!
        let tabHeight:CGFloat = (self.tabBarController?.tabBar.frame.size.height)!
        
        tbContent.delegate = self
        tbContent.dataSource = self
        tbContent.separatorStyle = .none
        
        let BalanceCellNib = UINib(nibName: "BalanceCell", bundle: nil)
        let AmountDetailCellNib = UINib(nibName: "AmountDetailCell", bundle: nil)
        
        tbContent.register(BalanceCellNib, forCellReuseIdentifier: "BalanceCell")
        tbContent.register(AmountDetailCellNib, forCellReuseIdentifier: "AmountDetailCell")
        
        tbContent.mas_makeConstraints { (make:MASConstraintMaker?) in
            make?.top.equalTo()(self.view)?.offset()(originY)
            make?.left.right().equalTo()(self.view)
            make?.bottom.equalTo()(self.view)?.offset()(-tabHeight)
        }
    }
    
    func createDoneBarButtonItem() {
        let saveView = UIView()
        saveView.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        
        let btnSave = UIButton(type: .custom)
        btnSave.imageEdgeInsets = UIEdgeInsetsMake(8, 8, 8, 8)
        btnSave.setImage(UIImage(named: "tick_white"), for: .normal)
        btnSave.frame = CGRect(x: 15, y: 0, width: 40, height: 40)
        btnSave.addTarget(self, action: #selector(saveNewAccount), for: .touchUpInside)
        saveView.addSubview(btnSave)
        
        let saveButton = UIBarButtonItem(customView:  saveView)
        self.navigationItem.rightBarButtonItem  = saveButton
    }

    @objc func saveNewAccount(){
        
    }

    //  MARK: Tableview
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }else{
            return 4
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 0 {
            return 10.0
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let identifier:String = "BalanceCell"
            var cell:BalanceCell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! BalanceCell
            
            return cell
            
        }else{
            let identifier:String = "AmountDetailCell"
            var cell:AmountDetailCell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! AmountDetailCell
            
            if indexPath.row == 0 {
                cell.imgType.image = UIImage(named: "ic_wallet_gray")
                
            }else if indexPath.row == 1 {
                cell.imgType.image = UIImage(named: "ic_money")
                
            }else if indexPath.row == 2 {
                cell.imgType.image = UIImage(named: "ic_dollar")
            }
            
            return cell
            
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 95.0
        }else{
            return 60.0
        }
    }
    
}
