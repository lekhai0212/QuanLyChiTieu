//
//  CreateAccountViewController.swift
//  QuanLyChiTieu
//
//  Created by lam quang quan on 4/10/19.
//  Copyright © 2019 KhaiLe. All rights reserved.
//

import UIKit
import Masonry
import Toast

class CreateAccountViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ChooseAccountTypePopupViewDelegate {
    
    @IBOutlet weak var tbContent: UITableView!
    var accountType:Int!
    var walletAccModel:WalletAccountModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = NSLocalizedString("Add account", comment: "")
        self.createDoneBarButtonItem()
        self.setupUIForView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        accountType = 1
        if walletAccModel == nil {
            walletAccModel = WalletAccountModel()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        walletAccModel = nil
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func closeKeyboad () {
        self.view.endEditing(true)
    }
    
    func setupUIForView() {
        self.automaticallyAdjustsScrollViewInsets = false
        self.view.backgroundColor = UIColor(red: 235/255.0, green: 235/255.0, blue: 235/255.0, alpha: 1.0)
        
        let originY:CGFloat = UIApplication.shared.statusBarFrame.size.height + (self.navigationController?.navigationBar.frame.size.height)!
        let tabHeight:CGFloat = (self.tabBarController?.tabBar.frame.size.height)!
        
        tbContent.delegate = self
        tbContent.dataSource = self
        tbContent.separatorStyle = .none
        tbContent.backgroundColor = UIColor.clear
        
        let BalanceCellNib = UINib(nibName: "BalanceCell", bundle: nil)
        let AmountDetailCellNib = UINib(nibName: "AmountDetailCell", bundle: nil)
        
        tbContent.register(BalanceCellNib, forCellReuseIdentifier: "BalanceCell")
        tbContent.register(AmountDetailCellNib, forCellReuseIdentifier: "AmountDetailCell")
        
        tbContent.mas_makeConstraints { (make:MASConstraintMaker?) in
            make?.top.equalTo()(self.view)?.offset()(originY)
            make?.left.right().equalTo()(self.view)
            make?.bottom.equalTo()(self.view)?.offset()(-tabHeight)
        }
        
        let footerView:UIView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 75.0))
        footerView.backgroundColor = UIColor.clear
        
        let btnSave:UIButton = UIButton(type: .custom)
        btnSave.frame = CGRect(x: 15.0, y: (footerView.frame.size.height-40.0)/2, width: footerView.frame.size.width-30.0, height: 40.0)
        btnSave.titleLabel?.font = UIFont.systemFont(ofSize: 16.0, weight: .regular)
        btnSave.backgroundColor = UIColor(red: 0, green: 0.686, blue: 0.94, alpha: 1.0)
        btnSave.layer.cornerRadius = 5.0
        btnSave.setTitleColor(UIColor.white, for: .normal)
        btnSave.setTitle(NSLocalizedString("Save", comment: "").uppercased(), for: .normal)
        btnSave.addTarget(self, action: #selector(saveNewAccount), for: .touchUpInside)
        footerView.addSubview(btnSave)
        
        tbContent.tableFooterView = footerView
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
        self.closeKeyboad()
        
        //  check initial balance
        let balaneCell = tbContent.cellForRow(at: IndexPath(row: 0, section: 0)) as! BalanceCell
        let balance:String = balaneCell.tfAmount.text!
        if balance.count == 0 {
            self.view.makeToast(NSLocalizedString("Initial balance invalid. Please check again!", comment: ""), duration: 1.0, position: CSToastPositionCenter)
            return
        }
        
        //  check account name
        let accountCell = tbContent.cellForRow(at: IndexPath(row: 0, section: 1)) as! AmountDetailCell
        let accountName:String = accountCell.tfContent.text!
        if accountName.count == 0 {
            self.view.makeToast(NSLocalizedString("Account name invalid. Please check again!", comment: ""), duration: 1.0, position: CSToastPositionCenter)
            return
        }
        
        //  Description
        let descCell = tbContent.cellForRow(at: IndexPath(row: 3, section: 1)) as! AmountDetailCell
        let description:String = descCell.tfContent.text ?? ""
        
        let exists:Bool = walletAccModel.checkWalletAcountExists(accountName: accountName)
        if exists {
            self.view.makeToast(NSLocalizedString("Account name was exists. Please try with another account name!", comment: ""), duration: 1.0, position: CSToastPositionCenter)
        }else{
            let result = walletAccModel.saveWalletAccount(name: accountName, type: accountType, initialBalance: balance, descryption: description)
            if !result {
                self.view.makeToast(NSLocalizedString("Can not save your account. Please try later!", comment: ""), duration: 1.0, position: CSToastPositionCenter)
            }else{
                self.view.makeToast(NSLocalizedString("Your account has been saved successful", comment: ""), duration: 1.5, position: CSToastPositionCenter)
                self.perform(#selector(backToPreviousView), with: nil, afterDelay: 1.5)
            }
        }
    }

    @objc func backToPreviousView() {
        self.navigationController?.popViewController(animated: true)
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
            let cell:BalanceCell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! BalanceCell
            cell.selectionStyle = .none
            cell.tfAmount.keyboardType = .numberPad
            cell.tfAmount.addTarget(self, action: #selector(textfieldAmountChanged(_:)), for: .editingChanged)
            
            return cell
            
        }else{
            let identifier:String = "AmountDetailCell"
            let cell:AmountDetailCell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! AmountDetailCell
            cell.selectionStyle = .none
            
            if indexPath.row == 0 {
                cell.imgType.image = UIImage(named: "ic_wallet_gray")
                cell.tfContent.placeholder = NSLocalizedString("Account name", comment: "")
                cell.imgArrow.isHidden = true
                
            }else if indexPath.row == 1 {
                cell.tfContent.isEnabled = false
                if accountType == 1 {
                    cell.imgType.image = UIImage(named: "ic_money")
                    cell.tfContent.text = NSLocalizedString("Cash", comment: "")
                }else{
                    cell.imgType.image = UIImage(named: "ic_bank")
                    cell.tfContent.text = NSLocalizedString("Bank Account", comment: "")
                }
                cell.imgArrow.isHidden = false
                
            }else if indexPath.row == 2 {
                cell.tfContent.isEnabled = false
                
                cell.imgType.image = UIImage(named: "ic_dollar")
                cell.tfContent.text = "VND"
                cell.imgArrow.isHidden = false
                
            }else{
                cell.imgType.image = UIImage(named: "description")
                cell.tfContent.placeholder = NSLocalizedString("Description", comment: "")
                cell.imgArrow.isHidden = true
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 && indexPath.row == 1 {
            let popup:ChooseAccountTypePopupView = ChooseAccountTypePopupView()
            popup.setupUIWithFrame(frame: CGRect(x: (UIScreen.main.bounds.size.width-280)/2, y: (UIScreen.main.bounds.size.height-150)/2, width: 280, height: 150))
            popup.curType = accountType
            popup.delegate = self
            popup.showInView(aView: self.view, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 95.0
        }else{
            return 60.0
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.closeKeyboad()
    }
    
    @objc func textfieldAmountChanged (_ sender:UITextField){
        
    }
    
    //  MARK: Choose account type popup delegate
    func selectAccountType(type: Int) {
        accountType = type
        
        let curCell = tbContent.cellForRow(at: IndexPath(row: 1, section: 1)) as! AmountDetailCell
        if accountType == 1 {
            curCell.imgType.image = UIImage(named: "ic_money")
            curCell.tfContent.text = NSLocalizedString("Cash", comment: "")
        }else{
            curCell.imgType.image = UIImage(named: "ic_bank")
            curCell.tfContent.text = NSLocalizedString("Bank Account", comment: "")
        }
    }
    
}
