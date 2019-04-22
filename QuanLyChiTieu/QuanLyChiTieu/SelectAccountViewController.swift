//
//  SelectAccountViewController.swift
//  QuanLyChiTieu
//
//  Created by admin on 4/21/19.
//  Copyright © 2019 KhaiLe. All rights reserved.
//

import UIKit
import Masonry

protocol SelectAccountViewControllerDelegate {
    func selectedAccount(account:WalletAccountObj)
}

class SelectAccountViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tbAccount: UITableView!
    var walletAccModel:WalletAccountModel!
    var listAccount:Array<Any>!
    var selectedAcc:WalletAccountObj!
    var delegate:SelectAccountViewControllerDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setupUIForView()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.title = "Chọn tài khoản"
        if walletAccModel == nil {
            walletAccModel = WalletAccountModel()
        }
        
        listAccount = walletAccModel.getWalletAccountList()
    }
    
    func setupUIForView() {
        self.edgesForExtendedLayout = []
        self.automaticallyAdjustsScrollViewInsets = false
        self.view.backgroundColor = UIColor(red: (240/255.0), green: (240/255.0), blue: (240/255.0), alpha: 1.0)
        
        tbAccount.backgroundColor = UIColor.clear
        tbAccount.separatorStyle = .none
        let nibCell = UINib(nibName: "WalletAccountCell", bundle: nil)
        tbAccount.register(nibCell, forCellReuseIdentifier: "WalletAccountCell")
        tbAccount.delegate = self
        tbAccount.dataSource = self
        tbAccount.mas_makeConstraints { (make:MASConstraintMaker?) in
            make?.top.left()?.bottom()?.right()?.equalTo()(self.view)
        }
    }
    
    // MARK: - Navigation
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listAccount.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WalletAccountCell", for: indexPath) as! WalletAccountCell
        cell.selectionStyle = .none
        
        let account = listAccount[indexPath.row] as! WalletAccountObj
        cell.lbName.text = account.accountName
        cell.lbMoney.text = StringsUtil.currencyFormatting(str: account.initialBalance)
        
        if account.accountType == 1 {
            cell.imgType.image = UIImage(named: "ic_money")
            
        }else if account.accountType == 2 {
            cell.imgType.image = UIImage(named: "ic_bank")
            
        }else{
            cell.imgType.image = UIImage(named: "saving_account_bank")
        }
        cell.icMore.isHidden = true
        cell.imgChecked.isHidden = true
        if selectedAcc != nil && selectedAcc.accountName == account.accountName {
            cell.imgChecked.isHidden = false
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let account = listAccount[indexPath.row] as! WalletAccountObj
        delegate.selectedAccount(account: account)
        self.navigationController?.popViewController(animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    
}
