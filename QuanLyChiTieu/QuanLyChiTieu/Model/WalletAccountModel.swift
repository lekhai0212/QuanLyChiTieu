//
//  WalletAccountModel.swift
//  QuanLyChiTieu
//
//  Created by admin on 4/11/19.
//  Copyright © 2019 KhaiLe. All rights reserved.
//

import UIKit
import CoreData

class WalletAccountModel: NSObject {
    var id:Int!
    var initial_balance:String!
    var account_name:String!
    var account_type:Int!
    var descryption:String!
    
    func checkWalletAcountExists(accountName:String) -> Bool {
        let AppDel:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "WalletAccount")
        request.predicate = NSPredicate(format: "account_name = %@", accountName)
        
        do {
            let result = try AppDel.persistentContainer.viewContext.fetch(request)
            for data in result as! [NSManagedObject] {
                print(data.value(forKey: "account_name") as! String)
                return true
            }
            return false
        } catch {
            return false
        }
    }
}
