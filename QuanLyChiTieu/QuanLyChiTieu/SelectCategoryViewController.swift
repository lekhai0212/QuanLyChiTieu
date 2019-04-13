//
//  SelectCategoryViewController.swift
//  QuanLyChiTieu
//
//  Created by lam quang quan on 4/13/19.
//  Copyright © 2019 KhaiLe. All rights reserved.
//

import UIKit
import Masonry

class SelectCategoryViewController: UIViewController {

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
        
        tbExpense.mas_makeConstraints { (make:MASConstraintMaker?) in
            make?.top.left().bottom().right().equalTo()(tbIncome)
        }
        
        tbDeptLoan.mas_makeConstraints { (make:MASConstraintMaker?) in
            make?.top.left().bottom().right().equalTo()(tbIncome)
        }
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
