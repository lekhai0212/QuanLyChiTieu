//
//  SelectCategoryViewController.swift
//  QuanLyChiTieu
//
//  Created by lam quang quan on 4/13/19.
//  Copyright © 2019 KhaiLe. All rights reserved.
//

import UIKit
import Masonry

class SelectCategoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var viewMenu: UIView!
    @IBOutlet weak var btnExpense: UIButton!
    @IBOutlet weak var btnIncome: UIButton!
    @IBOutlet weak var btnDeptLoan: UIButton!
    @IBOutlet weak var lbMenuActive: UILabel!
    
    @IBOutlet weak var tbExpense: UITableView!
    @IBOutlet weak var tbIncome: UITableView!
    @IBOutlet weak var tbDeptLoan: UITableView!
    @IBOutlet weak var tfSearch: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setupUIForView()
        tbExpense.isHidden = false
        tbIncome.isHidden = true
        tbDeptLoan.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.title = NSLocalizedString("Select category", comment: "")
    }

    @IBAction func btnExpensePress(_ sender: UIButton) {
        btnExpense.isSelected = true
        btnIncome.isSelected = false
        btnDeptLoan.isSelected = false
        
        lbMenuActive.mas_remakeConstraints({ (make:MASConstraintMaker?) in
            make?.left.right().equalTo()(btnExpense)
            make?.bottom.equalTo()(viewMenu)
            make?.height.mas_equalTo()(5.0)
        })
        
        UIView.animate(withDuration: 0.2) {
            self.view.layoutIfNeeded()
        }
    }
    
    @IBAction func btnIncomePress(_ sender: UIButton) {
        btnIncome.isSelected = true
        btnExpense.isSelected = false
        btnDeptLoan.isSelected = false
        
        lbMenuActive.mas_remakeConstraints({ (make:MASConstraintMaker?) in
            make?.left.right().equalTo()(btnIncome)
            make?.bottom.equalTo()(viewMenu)
            make?.height.mas_equalTo()(5.0)
        })
        
        UIView.animate(withDuration: 0.2) {
            self.view.layoutIfNeeded()
        }
    }
    
    @IBAction func btnDeptLoanPress(_ sender: UIButton) {
        btnDeptLoan.isSelected = true
        btnIncome.isSelected = false
        btnExpense.isSelected = false
        
        lbMenuActive.mas_remakeConstraints({ (make:MASConstraintMaker?) in
            make?.left.right().equalTo()(btnDeptLoan)
            make?.bottom.equalTo()(viewMenu)
            make?.height.mas_equalTo()(5.0)
        })
        
        UIView.animate(withDuration: 0.2) {
            self.view.layoutIfNeeded()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupUIForView() {
        let originY:CGFloat = UIApplication.shared.statusBarFrame.size.height + (self.navigationController?.navigationBar.frame.size.height)!
        let textColor:UIColor = UIColor.init(red: 0, green: 0.686, blue: 0.94, alpha: 1.0)
        
        viewMenu.backgroundColor = UIColor(red: 245/255.0, green: 245/255.0, blue: 245/255.0, alpha: 1.0)
        viewMenu.mas_makeConstraints { (make:MASConstraintMaker?) in
            make?.top.equalTo()(self.view)?.offset()(originY)
            make?.left.right().equalTo()(self.view)
            make?.height.mas_equalTo()(50.0)
        }
        
        btnExpense.setTitleColor(textColor, for: .selected)
        btnExpense.isSelected = true
        btnExpense.setTitleColor(UIColor.darkGray, for: .normal)
        btnExpense.mas_makeConstraints { (make:MASConstraintMaker?) in
            make?.left.top().bottom().equalTo()(viewMenu)
            make?.width.equalTo()(viewMenu.mas_width)?.multipliedBy()(1/3)
        }
        
        btnIncome.setTitleColor(textColor, for: .selected)
        btnIncome.setTitleColor(UIColor.darkGray, for: .normal)
        btnIncome.mas_makeConstraints { (make:MASConstraintMaker?) in
            make?.top.bottom().equalTo()(viewMenu)
            make?.left.equalTo()(btnExpense.mas_right)
            make?.width.equalTo()(btnExpense.mas_width)
        }
        
        btnDeptLoan.setTitleColor(textColor, for: .selected)
        btnDeptLoan.setTitleColor(UIColor.darkGray, for: .normal)
        btnDeptLoan.mas_makeConstraints { (make:MASConstraintMaker?) in
            make?.top.bottom().equalTo()(viewMenu)
            make?.left.equalTo()(btnIncome.mas_right)
            make?.right.equalTo()(viewMenu)
        }
        
        lbMenuActive.backgroundColor = UIColor.init(red: 0, green: 0.686, blue: 0.94, alpha: 1.0)
        lbMenuActive.mas_makeConstraints { (make:MASConstraintMaker?) in
            make?.left.right().equalTo()(btnExpense)
            make?.bottom.equalTo()(viewMenu)
            make?.height.mas_equalTo()(5.0)
        }
        
        tfSearch.mas_makeConstraints { (make:MASConstraintMaker?) in
            make?.top.equalTo()(viewMenu.mas_bottom)
            make?.left.right().equalTo()(self.view)
            make?.height.mas_equalTo()(40.0)
        }
        
        tbIncome.mas_makeConstraints { (make:MASConstraintMaker?) in
            make?.top.equalTo()(tfSearch.mas_bottom)
            make?.left.right().bottom().equalTo()(self.view)
        }
        
        tbExpense.sectionFooterHeight = UITableViewAutomaticDimension
        tbExpense.sectionHeaderHeight = UITableViewAutomaticDimension
        tbExpense.separatorStyle = .none
        tbExpense.delegate = self
        tbExpense.dataSource = self
        let menuCellNib = UINib(nibName: "ActionMenuCell", bundle: nil)
        tbExpense.register(menuCellNib, forCellReuseIdentifier: "ActionMenuCell")
        
        tbExpense.mas_makeConstraints { (make:MASConstraintMaker?) in
            make?.top.left().bottom().right().equalTo()(tbIncome)
        }
        
        tbDeptLoan.mas_makeConstraints { (make:MASConstraintMaker?) in
            make?.top.left().bottom().right().equalTo()(tbIncome)
        }
    }
    
    //  MARK: UITableview
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.getSectionCountForTableView(tableView:tableView)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let menu = self.getMenuObjetAtSection(section: section)
        return self.getRowsCountForSectionWithParentId(parentId: menu.menuId)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ActionMenuCell", for: indexPath) as! ActionMenuCell
        cell.setFrameForParent(isParent: false)
        
        let parent = self.getMenuObjetAtSection(section: indexPath.section)
        let curMenu = self.getMenuObjetAtRow(parentId: parent.menuId, row: indexPath.row)
        
        cell.lbName.text = curMenu.menuName
        cell.imgType.image = UIImage(named: curMenu.menuCode)
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView:UIView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 55.0))
        headerView.backgroundColor = UIColor.white
        
        let imgArrow:UIImageView = UIImageView(frame: CGRect(x: 15, y: (headerView.frame.size.height-20.0)/2, width: 20.0, height: 20.0))
        imgArrow.image = UIImage(named: "arrow_up_gray")
        headerView.addSubview(imgArrow)
        
        let imgType:UIImageView = UIImageView(frame: CGRect(x: (imgArrow.frame.origin.x+imgArrow.frame.size.width+10), y: (headerView.frame.size.height-38.0)/2, width: 38.0, height: 38.0))
        imgType.layer.cornerRadius = 38.0/2
        imgType.clipsToBounds = true
        headerView.addSubview(imgType)
        
        let wName:CGFloat = headerView.frame.size.width - (imgType.frame.origin.x+imgType.frame.size.width+15+5)
        let lbName:UILabel = UILabel(frame: CGRect(x: (imgType.frame.origin.x+imgType.frame.size.width+5), y: 0, width: wName, height: headerView.frame.size.height))
        headerView.addSubview(lbName)
        
        let lbSepa = UILabel(frame: CGRect(x: 0, y: headerView.frame.size.height-1, width: headerView.frame.size.width, height: 1.0))
        lbSepa.backgroundColor = UIColor(red: 240/255.0, green: 240/255.0, blue: 240/255.0, alpha: 1.0)
        headerView.addSubview(lbSepa)
        
        let menu = self.getMenuObjetAtSection(section: section)
        lbName.text = menu.menuName
        imgType.image = UIImage(named: menu.menuCode)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55.0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 55.0
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    func getSectionCountForTableView(tableView:UITableView) -> Int {
        if tableView == tbExpense {
            let AppDel:AppDelegate = UIApplication.shared.delegate as! AppDelegate
            //  let predicate:NSPredicate = NSPredicate(format: "parentId = %d", 0)
            let filteredArray = AppDel.expenseMenus.filter{($0 as! ActionMenuObj).parentId == 0}
            return filteredArray.count
        }
        return 0
    }
    
    func getRowsCountForSectionWithParentId(parentId:Int) -> Int {
        let AppDel:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let filteredArray = AppDel.expenseMenus.filter{($0 as! ActionMenuObj).parentId == parentId}
        return filteredArray.count
    }
    
    func getMenuObjetAtSection(section:Int) -> ActionMenuObj {
        let AppDel:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let filteredArray = AppDel.expenseMenus.filter{($0 as! ActionMenuObj).parentId == 0}
        if filteredArray.count > section {
            return filteredArray[section] as! ActionMenuObj
        }
        return ActionMenuObj()
    }
    
    func getMenuObjetAtRow(parentId:Int,row:Int) -> ActionMenuObj {
        let AppDel:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let filteredArray = AppDel.expenseMenus.filter{($0 as! ActionMenuObj).parentId == parentId}
        if filteredArray.count > row {
            return filteredArray[row] as! ActionMenuObj
        }
        return ActionMenuObj()
    }
    
    

}
