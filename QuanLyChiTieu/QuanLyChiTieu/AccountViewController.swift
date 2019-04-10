//
//  AccountViewController.swift
//  QuanLyChiTieu
//
//  Created by lam quang quan on 4/10/19.
//  Copyright © 2019 KhaiLe. All rights reserved.
//

import UIKit

class AccountViewController: UIViewController {

    @IBOutlet weak var tbContent: UITableView!
    @IBOutlet weak var lbNoData: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = NSLocalizedString("Account", comment: "")
        self.navigationController?.navigationBar.barTintColor = UIColor.init(red: 0, green: 0.686, blue: 0.94, alpha: 1.0)
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        
        self.createRightBarButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
