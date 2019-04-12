//
//  ActionViewController.swift
//  QuanLyChiTieu
//
//  Created by lam quang quan on 4/12/19.
//  Copyright © 2019 KhaiLe. All rights reserved.
//

import UIKit
import Masonry

class ActionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tbContent: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = NSLocalizedString("Account", comment: "")
        self.navigationController?.navigationBar.barTintColor = UIColor.init(red: 0, green: 0.686, blue: 0.94, alpha: 1.0)
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        
        self.setupUIForView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func setupUIForView() {
        self.automaticallyAdjustsScrollViewInsets = false
        self.view.backgroundColor = UIColor(red: 235/255.0, green: 235/255.0, blue: 235/255.0, alpha: 1.0)
        
        let originY:CGFloat = UIApplication.shared.statusBarFrame.size.height + (self.navigationController?.navigationBar.frame.size.height)!
        let tabHeight:CGFloat = (self.tabBarController?.tabBar.frame.size.height)!
        
        let nibBalance = UINib(nibName: "BalanceCell", bundle: nil)
        let nibDetail = UINib(nibName: "AmountDetailCell", bundle: nil)
        
        tbContent.register(nibBalance, forCellReuseIdentifier: "BalanceCell")
        tbContent.register(nibDetail, forCellReuseIdentifier: "AmountDetailCell")
        tbContent.delegate = self
        tbContent.dataSource = self
        tbContent.mas_makeConstraints { (make:MASConstraintMaker?) in
            make?.top.equalTo()(self.view)?.offset()(originY)
            make?.left.right().bottom().offset()(tabHeight)
            make?.left.right().equalTo()(self.view)
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
            var cell = tableView.dequeueReusableCell(withIdentifier: "BalanceCell", for: indexPath) as! BalanceCell
            
            
            return cell
        }else{
            var cell = tableView.dequeueReusableCell(withIdentifier: "AmountDetailCell", for: indexPath) as! AmountDetailCell
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 95.0
        }else{
            return 55.0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30.0
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat {
        return 1.0
    }
}
