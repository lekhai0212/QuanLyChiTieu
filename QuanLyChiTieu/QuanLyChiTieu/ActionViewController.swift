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

    @IBOutlet weak var tbTransfer: UITableView!
    @IBOutlet weak var tbContent: UITableView!
    var curAction:ActionMenuObj!
    var walletAccModel:WalletAccountModel!
    var selectedAcc:WalletAccountObj!
    var listAccount:Array<Any>!
    var tbTypeAction:UITableView!
    var typeAction:Int!
    var lbTitle:UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = NSLocalizedString("Add note", comment: "")
        self.navigationController?.navigationBar.barTintColor = UIColor.init(red: 0, green: 0.686, blue: 0.94, alpha: 1.0)
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        
        self.setupUIForView()
        
        let attrStr:NSAttributedString = StringsUtil.createAttributedText(text: "Chi tiền  ", image: UIImage(named: "arrow_down")!, size: 14.0)
        
        lbTitle = UILabel(frame: CGRect(x: 40, y: 0, width: UIScreen.main.bounds.size.width-80, height: (self.navigationController?.navigationBar.frame.size.height)!))
        lbTitle.textAlignment = .center
        lbTitle.backgroundColor = UIColor.clear
        lbTitle.attributedText = attrStr
        lbTitle.isUserInteractionEnabled = true
        self.navigationController?.navigationBar.topItem?.titleView = lbTitle
        
        let tapOnTitle:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(whenTapOnTitle))
        lbTitle.addGestureRecognizer(tapOnTitle)
    }
    
    func closeChooseActionTableView(closed:Bool) {
        if closed {
            tbTypeAction.mas_remakeConstraints { (make:MASConstraintMaker?) in
                make?.top.left().right().equalTo()(self.view)
                make?.height.mas_equalTo()(0)
            }
        }else {
            tbTypeAction.mas_remakeConstraints { (make:MASConstraintMaker?) in
                make?.top.left()?.bottom().right().equalTo()(self.view)
            }
        }
        UIView.animate(withDuration: 0.2) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func whenTapOnTitle() {
        var closed:Bool = true
        var content:String
        var image:UIImage
        
        if tbTypeAction.frame.size.height == 0 {
            image = UIImage(named: "arrow_up")!
            closed = false
        }else{
            image = UIImage(named: "arrow_down")!
        }
        
        content = self.getContentWithTypeAction(actionType: typeAction)
        let attrStr:NSAttributedString = StringsUtil.createAttributedText(text:content, image: image, size: 14.0)
        lbTitle.attributedText = attrStr
        
        self.closeChooseActionTableView(closed: closed)
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
        
        tbContent.sectionHeaderHeight = UITableViewAutomaticDimension
        tbContent.sectionFooterHeight = UITableViewAutomaticDimension
        tbContent.register(nibBalance, forCellReuseIdentifier: "BalanceCell")
        tbContent.register(nibDetail, forCellReuseIdentifier: "AmountDetailCell")
        tbContent.delegate = self
        tbContent.dataSource = self
        tbContent.mas_makeConstraints { (make:MASConstraintMaker?) in
            make?.top.left()?.bottom().right()?.equalTo()(self.view)
        }
        
        //  transfer tableview
        let nibTransferCell = UINib(nibName: "AccountTransferCell", bundle: nil)
        tbTransfer.register(nibTransferCell, forCellReuseIdentifier: "AccountTransferCell")
        tbTransfer.sectionHeaderHeight = UITableViewAutomaticDimension
        tbTransfer.sectionFooterHeight = UITableViewAutomaticDimension
        tbTransfer.separatorStyle = .none
        tbTransfer.delegate = self
        tbTransfer.dataSource = self
        tbTransfer.mas_makeConstraints { (make:MASConstraintMaker?) in
            make?.top.left()?.bottom()?.right()?.equalTo()(self.tbContent)
        }
        
        //  create table
        typeAction = 0
        
        tbTypeAction = UITableView()
        tbTypeAction.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2)
        tbTypeAction.sectionHeaderHeight = UITableViewAutomaticDimension
        tbTypeAction.sectionFooterHeight = UITableViewAutomaticDimension
        tbTypeAction.separatorStyle = .none
        tbTypeAction.isScrollEnabled = false
        
        let nibCell = UINib(nibName: "SelectAccountCell", bundle: nil)
        tbTypeAction.register(nibCell, forCellReuseIdentifier: "SelectAccountCell")
        tbTypeAction.delegate = self
        tbTypeAction.dataSource = self
        self.view.addSubview(tbTypeAction)
        tbTypeAction.mas_makeConstraints { (make:MASConstraintMaker?) in
            make?.top.left().right().equalTo()(self.view)
            make?.height.mas_equalTo()(0)
        }
    }
    
    //  MARK: Tableview
    func numberOfSections(in tableView: UITableView) -> Int {
        if tableView == tbTypeAction {
            return 1
        }else if tableView == tbTransfer {
            return 3
        }else {
            return 2
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tbTypeAction {
            return 3
        }else if tableView == tbTransfer {
            if section == 0 {
                return 1
            }else {
                return 2
            }
        }else{
            if section == 0 {
                return 1
            }else{
                return 4
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == tbTypeAction {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SelectAccountCell", for: indexPath) as! SelectAccountCell
            cell.selectionStyle = .none
            cell.imgSelected.isHidden = true
            
            if indexPath.row == 0 {
                cell.lbName.text = "Chi tiền"
                cell.imgType.image = UIImage(named: "minus")
                
            }else if indexPath.row == 1 {
                cell.lbName.text = "Thu tiền"
                cell.imgType.image = UIImage(named: "plus")
                
            }else{
                cell.lbName.text = "Chuyển khoản"
                cell.imgType.image = UIImage(named: "transfer")
                
            }
            if typeAction == indexPath.row {
                cell.imgSelected.isHidden = false
            }
            
            return cell
        }else{
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
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == tbTypeAction {
            typeAction = indexPath.row
            let content = self.getContentWithTypeAction(actionType: typeAction)
            let attrStr:NSAttributedString = StringsUtil.createAttributedText(text:content, image: UIImage(named: "arrow_down")!, size: 14.0)
            lbTitle.attributedText = attrStr
            self.closeChooseActionTableView(closed: true)
        }else{
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
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == tbTypeAction {
            return 60.0
        }else{
            if indexPath.section == 0 {
                return 95.0
            }else{
                return 60.0
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if tableView == tbTypeAction {
            return 0.1
        }else{
            return 10.0
        }
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
    
    func getContentWithTypeAction(actionType:Int) -> String {
        if actionType == 0 {
            return "Chi tiền  "
        }else if actionType == 1 {
            return "Thu tiền  "
        }else{
            return "Chuyển khoản  "
        }
    }
}
