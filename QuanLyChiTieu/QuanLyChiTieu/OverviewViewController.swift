//
//  OverviewViewController.swift
//  QuanLyChiTieu
//
//  Created by lam quang quan on 4/10/19.
//  Copyright © 2019 KhaiLe. All rights reserved.
//

import UIKit
import Masonry
class OverviewViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tbContent: UITableView!
    var walletAccModel:WalletAccountModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.automaticallyAdjustsScrollViewInsets = false
        
        self.title = NSLocalizedString("Overview", comment: "")
        self.navigationController?.navigationBar.barTintColor = UIColor.init(red: 0, green: 0.686, blue: 0.94, alpha: 1.0)
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        
        self.setupUIForView()
    }
    override func viewWillAppear(_ animated: Bool) {
        if walletAccModel == nil {
            walletAccModel = WalletAccountModel()
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func setupUIForView() {
        self.edgesForExtendedLayout = []
        
        tbContent.delegate = self
        tbContent.dataSource = self
        tbContent.separatorStyle = .none
        
        let walletInfoNib = UINib(nibName: "WalletInfoCell", bundle: nil)
        let receiptAndExpenseNib = UINib(nibName: "ReceiptAndExpenseCell", bundle: nil)
        let actionNib = UINib(nibName: "ActionCell", bundle: nil)
        
        tbContent.register(walletInfoNib, forCellReuseIdentifier: "WalletInfoCell")
        tbContent.register(receiptAndExpenseNib, forCellReuseIdentifier: "ReceiptAndExpenseCell")
        tbContent.register(actionNib, forCellReuseIdentifier: "ActionCell")
        tbContent.sectionHeaderHeight = UITableViewAutomaticDimension
        tbContent.sectionFooterHeight = UITableViewAutomaticDimension
        tbContent.mas_makeConstraints { (make:MASConstraintMaker?) in
            make?.top.left()?.bottom()?.right()?.equalTo()(self.view)
        }
    }
    
    //  MARK: UITableview delegate
    func checkWalletAccountForCell(cell:WalletInfoCell) {
        let walletAccModel:WalletAccountModel = WalletAccountModel()
        let listAccount = walletAccModel.getWalletAccountList()
        if listAccount.count > 0 {
            var totalBalance:String =  walletAccModel.getTotalBalance()
            totalBalance = StringsUtil.currencyFormatting(str: totalBalance)
            cell.lbMoney.text = totalBalance
        }else{
            cell.lbMoney.text = "Bạn chưa có ví"
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 || section == 1 {
            return 1
        }else {
            return 3
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let identifier:String = "WalletInfoCell"
            let cell:WalletInfoCell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! WalletInfoCell
            cell.selectionStyle = .none
            self.checkWalletAccountForCell(cell: cell)
            cell.updateFrameForCell()
            
            return cell
            
        }else if indexPath.section == 1 {
            let identifier:String = "ReceiptAndExpenseCell"
            let cell:ReceiptAndExpenseCell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! ReceiptAndExpenseCell
            return cell
            
        }else {
            let identifier:String = "ActionCell"
            let cell:ActionCell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! ActionCell
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 60.0
        }else if indexPath.section == 1 {
            return 140.0
        }
        return 70.0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40.0
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView:UIView = UIView.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 40.0))
        
        let lbTitle:UILabel = UILabel(frame: CGRect(x: 10, y: 0, width: headerView.frame.size.width-20, height: headerView.frame.size.height))
        lbTitle.font = UIFont.systemFont(ofSize: 17.0, weight: .semibold)
        lbTitle.textColor = UIColor(red: 80.0/255.0, green: 80.0/255.0, blue: 80.0/255.0, alpha: 1.0)
        headerView.addSubview(lbTitle)
        
        if section == 0 {
            lbTitle.text = NSLocalizedString("Financial statement", comment: "").uppercased()
        }else if section == 1 {
            lbTitle.text = NSLocalizedString("Expense vs income", comment: "").uppercased()
        }else{
            lbTitle.text = NSLocalizedString("Recent transactions", comment: "").uppercased()
        }
        return headerView
    }
}
