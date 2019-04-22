//
//  ActionViewController.swift
//  QuanLyChiTieu
//
//  Created by lam quang quan on 4/12/19.
//  Copyright © 2019 KhaiLe. All rights reserved.
//

import UIKit
import Masonry

class ActionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, SelectCategoryViewControllerDelegate, SelectAccountViewControllerDelegate {

    @IBOutlet weak var tbContent: UITableView!
    var curAction:ActionMenuObj!
    var walletAccModel:WalletAccountModel!
    var selectedAcc:WalletAccountObj!
    
    var listAccount:Array<Any>!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = NSLocalizedString("Add note", comment: "")
        self.navigationController?.navigationBar.barTintColor = UIColor.init(red: 0, green: 0.686, blue: 0.94, alpha: 1.0)
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        
        self.setupUIForView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if walletAccModel == nil {
            walletAccModel = WalletAccountModel()
        }
        listAccount = walletAccModel.getWalletAccountList()
        if selectedAcc == nil && listAccount.count > 0 {
            selectedAcc = listAccount.first as? WalletAccountObj
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func setupUIForView() {
        self.edgesForExtendedLayout = []
        self.automaticallyAdjustsScrollViewInsets = false
        self.view.backgroundColor = UIColor(red: 235/255.0, green: 235/255.0, blue: 235/255.0, alpha: 1.0)
        
        let nibBalance = UINib(nibName: "BalanceCell", bundle: nil)
        let nibDetail = UINib(nibName: "AmountDetailCell", bundle: nil)
        
        tbContent.sectionHeaderHeight = UITableViewAutomaticDimension;
        tbContent.sectionFooterHeight = UITableViewAutomaticDimension;
        tbContent.register(nibBalance, forCellReuseIdentifier: "BalanceCell")
        tbContent.register(nibDetail, forCellReuseIdentifier: "AmountDetailCell")
        tbContent.delegate = self
        tbContent.dataSource = self
        tbContent.mas_makeConstraints { (make:MASConstraintMaker?) in
            make?.top.left()?.bottom().right()?.equalTo()(self.view)
        }
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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "BalanceCell", for: indexPath) as! BalanceCell
            cell.selectionStyle = .none
            cell.lbAmount.text = "Số tiền"
            
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "AmountDetailCell", for: indexPath) as! AmountDetailCell
            cell.selectionStyle = .none
            if indexPath.row == 0 {
                cell.setupCellWithLargeIcon(large: true)
            }else{
                cell.setupCellWithLargeIcon(large: false)
            }
            cell.tfContent.isEnabled = false
            
            switch indexPath.row {
                case 0:do {
                    if curAction != nil {
                        cell.tfContent.text = curAction.menuName
                        cell.imgType.image = UIImage(named: curAction.menuCode)
                    }else{
                        cell.tfContent.text = "Chọn hạng mục"
                        cell.imgType.image = UIImage(named: "question")
                    }
                    
                    cell.imgArrow.isHidden = false
                    break
                }
                
                case 1: do {
                    cell.tfContent.placeholder = "Mô tả"
                    cell.imgType.image = UIImage(named: "three_line_blue")
                    cell.imgArrow.isHidden = true
                    cell.tfContent.isEnabled = true
                    break
                }
                
                case 2: do {
                    cell.tfContent.text = "Thời gian"
                    cell.imgType.image = UIImage(named: "calendar")
                    cell.imgArrow.isHidden = false
                    break
                }
                case 3: do {
                    if selectedAcc == nil {
                        cell.tfContent.text = "Chưa có tài khoản"
                        cell.imgType.image = UIImage(named: "sad_face")
                        cell.imgArrow.isHidden = false
                    }else{
                        cell.tfContent.text = selectedAcc.accountName
                        if selectedAcc.accountType == 1 {
                            cell.imgType.image = UIImage(named: "ic_money")
                            
                        }else if selectedAcc.accountType == 2 {
                            cell.imgType.image = UIImage(named: "ic_bank")
                        }else{
                            cell.imgType.image = UIImage(named: "saving_account_bank")
                        }
                        cell.imgArrow.isHidden = false
                    }
                    
                    break
                }
                default:do {
                    break
                }
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 && indexPath.row == 0 {
            
            let categoryVC = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SelectCategoryViewController") as! SelectCategoryViewController
            categoryVC.delegate = self
            categoryVC.hidesBottomBarWhenPushed = true
            if curAction != nil {
                categoryVC.selectedMenu = curAction
            }
            self.navigationController?.pushViewController(categoryVC, animated: true)
        }else if indexPath.section == 1 && indexPath.row == 3 {
            let selectAccVC = UIStoryboard.init(name: "Main", bundle:
                Bundle.main).instantiateViewController(withIdentifier: "SelectAccountViewController") as! SelectAccountViewController
            selectAccVC.delegate = self
            selectAccVC.hidesBottomBarWhenPushed = true
            if selectedAcc != nil {
                selectAccVC.selectedAcc = selectedAcc
            }
            self.navigationController?.pushViewController(selectAccVC, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 95.0
        }else{
            return 60.0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10.0
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    func selectMenuAction(action: ActionMenuObj) {
        curAction = action
        tbContent.reloadData()
    }
    
    func selectedAccount(account: WalletAccountObj) {
        selectedAcc = account
        tbContent.reloadData()
    }
}
