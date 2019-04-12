//
//  HomeViewController.swift
//  QuanLyChiTieu
//
//  Created by admin on 4/10/19.
//  Copyright © 2019 KhaiLe. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    var tabBarVC:UITabBarController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tabBarVC = UITabBarController()
        
        // Do any additional setup after loading the view.
        let overviewVC = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "OverviewViewController") as! OverviewViewController
        overviewVC.tabBarItem = UITabBarItem.init(title: NSLocalizedString("Overview", comment: ""), image: UIImage(named: "tabbar_overview"), tag: 0)
        
        let accountVC = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "AccountViewController") as! AccountViewController
        accountVC.tabBarItem = UITabBarItem.init(title: NSLocalizedString("Account", comment: ""), image: UIImage(named: "tabbar_wallet"), tag: 1)
        
        let createActionVC = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ActionViewController") as! ActionViewController
        createActionVC.tabBarItem = UITabBarItem(title: NSLocalizedString("Add note", comment: ""), image: UIImage(named: "tabbar_add"), tag: 2)
        
        let savingAccVC = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SavingAccountViewController") as! SavingAccountViewController
        savingAccVC.tabBarItem = UITabBarItem(title: NSLocalizedString("Saving Account", comment: ""), image: UIImage(named: "tabbar_saving"), tag: 3)
        
        let moreVC = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MoreViewController") as! MoreViewController
        moreVC.tabBarItem = UITabBarItem.init(title: NSLocalizedString("More", comment: ""), image: UIImage(named: "tabbar_more"), tag: 4)
        
        
        let controllerArray = [overviewVC, accountVC, createActionVC, savingAccVC, moreVC]
        tabBarVC.viewControllers = controllerArray.map{ UINavigationController.init(rootViewController: $0)}
        self.view.addSubview(tabBarVC.view)
    }
}
