//
//  AccountViewController.swift
//  QuanLyChiTieu
//
//  Created by lam quang quan on 4/10/19.
//  Copyright © 2019 KhaiLe. All rights reserved.
//

import UIKit
import Masonry

class AccountViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tbContent: UITableView!
    @IBOutlet weak var lbNoData: UILabel!
    @IBOutlet weak var lbTotalBalane: UILabel!
    var listAccount:Array<Any>!
    var walletAccModel:WalletAccountModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = NSLocalizedString("Account", comment: "")
        self.navigationController?.navigationBar.barTintColor = UIColor.init(red: 0, green: 0.686, blue: 0.94, alpha: 1.0)
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        
        self.createRightBarButtonItem()
        self.setupUIForView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        lbNoData.text = NSLocalizedString("No data", comment: "")
        if walletAccModel == nil {
            walletAccModel = WalletAccountModel()
        }
        
        listAccount = walletAccModel.getWalletAccountList()
        if listAccount.count == 0 {
            tbContent.isHidden = true
            lbTotalBalane.isHidden = true
            lbNoData.isHidden = false
        }else{
            tbContent.isHidden = false
            lbTotalBalane.isHidden = false
            lbNoData.isHidden = true
            
            var totalBalance = self.getTotalBalance()
            totalBalance = StringsUtil.currencyFormatting(str: totalBalance)
            lbTotalBalane.text = NSLocalizedString("Total banlance", comment: "") + ": " + totalBalance
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if tbContent.frame.size.height < tbContent.contentSize.height {
            tbContent.isScrollEnabled = true
        }else{
            tbContent.isScrollEnabled = false
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func currencyFormatting(str:String) -> String {
        if let value = Double(str) {
            let formatter = NumberFormatter()
            formatter.numberStyle = .currency
            formatter.maximumFractionDigits = 2
            if let str = formatter.string(for: value) {
                return str
            }
        }
        return ""
    }
    
    func getTotalBalance() -> String {
        var totalBalance:Int = 0
        
        for item in listAccount {
            let object:WalletAccountObj = item as! WalletAccountObj
            totalBalance = totalBalance + Int(object.initialBalance)!
        }
        return String(totalBalance)
    }
    
    func setupUIForView() {
        self.view.backgroundColor = UIColor(red: 235/255.0, green: 235/255.0, blue: 235/255.0, alpha: 1.0)
        self.automaticallyAdjustsScrollViewInsets = false
        
        let originY:CGFloat = UIApplication.shared.statusBarFrame.size.height + (self.navigationController?.navigationBar.frame.size.height)!
        let tabHeight:CGFloat = (self.tabBarController?.tabBar.frame.size.height)!
        
        lbTotalBalane.textAlignment = .center
        lbTotalBalane.font = UIFont.systemFont(ofSize: 20.0, weight: .semibold)
        lbTotalBalane.backgroundColor = UIColor.white
        lbTotalBalane.textColor = UIColor(red: 80/255.0, green: 80/255.0, blue: 80/255.0, alpha: 1.0)
        lbTotalBalane.mas_makeConstraints { (make:MASConstraintMaker?) in
            make?.top.equalTo()(self.view)?.offset()(originY)
            make?.left.right().equalTo()(self.view)
            make?.height.mas_equalTo()(60.0)
        }
        
        tbContent.register(UINib(nibName: "WalletAccountCell", bundle: nil), forCellReuseIdentifier: "WalletAccountCell")
        tbContent.backgroundColor = UIColor.white
        tbContent.separatorStyle = .none
        tbContent.delegate = self
        tbContent.dataSource = self
        tbContent.mas_makeConstraints { (make:MASConstraintMaker?) in
            make?.top.equalTo()(lbTotalBalane.mas_bottom)?.offset()(12.0)
            make?.left.right().equalTo()(self.view)
            make?.bottom.equalTo()(self.view)?.offset()(-tabHeight)
        }
        
        lbNoData.textAlignment = .center
        lbNoData.backgroundColor = UIColor.white
        lbNoData.textColor = UIColor(red: 80/255.0, green: 80/255.0, blue: 80/255.0, alpha: 1.0)
        lbNoData.font = UIFont.systemFont(ofSize: 20.0, weight: .regular)
        lbNoData.mas_makeConstraints { (make:MASConstraintMaker?) in
            make?.top.equalTo()(self.view)?.offset()(originY)
            make?.left.right().equalTo()(self.view)
            make?.bottom.equalTo()(self.view)?.offset()(-tabHeight)
        }
    }
    
    func createRightBarButtonItem() {
        let createView = UIView()
        createView.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        
        let btnCreate = UIButton(type: .custom)
        btnCreate.imageEdgeInsets = UIEdgeInsetsMake(8, 8, 8, 8)
        btnCreate.setImage(UIImage(named: "add_white"), for: .normal)
        btnCreate.frame = CGRect(x: 15, y: 0, width: 40, height: 40)
        btnCreate.addTarget(self, action: #selector(createNewWallet), for: .touchUpInside)
        createView.addSubview(btnCreate)
        
        let createButton = UIBarButtonItem(customView:  createView)
        self.navigationItem.rightBarButtonItem  = createButton
    }
    
    @objc func createNewWallet(){
        let createAccountVC = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "CreateAccountViewController")
        self.navigationController?.pushViewController(createAccountVC, animated: true)
    }

    // MARK: - Tableview
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listAccount.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WalletAccountCell", for: indexPath) as! WalletAccountCell
        let walletObj = listAccount?[indexPath.row] as! WalletAccountObj
        if walletObj.accountType == 1 {
            cell.imgType.image = UIImage(named: "ic_money")
        }else{
            cell.imgType.image = UIImage(named: "ic_bank")
        }

        cell.lbName.text = walletObj.accountName
        cell.lbMoney.text = StringsUtil.currencyFormatting(str: walletObj.initialBalance)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }

}
