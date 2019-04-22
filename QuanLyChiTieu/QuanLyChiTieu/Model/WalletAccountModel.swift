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
    
    func saveWalletAccount(name:String, type:Int, initialBalance:String, descryption: String) -> Bool {
        let AppDel:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        //  Create the context from persistentContainer
        let managedContext = AppDel.persistentContainer.viewContext
        
        //  Create an entity with WalletAccount
        let newEntity = NSEntityDescription.entity(forEntityName: "WalletAccount", in: managedContext)
        
        //  create ManagedObject
        var walletId:Int = 1
        let curId = UserDefaults.standard.value(forKey: key_wallet_account_id)
        if curId != nil {
            walletId = (curId as! Int) + 1
        }
        UserDefaults.standard.setValue(walletId, forKey: key_wallet_account_id)
        UserDefaults.standard.synchronize()
        
        //  Set values for the records for each key
        let walletAccount = NSManagedObject(entity: newEntity!, insertInto: managedContext)
        walletAccount.setValue(name, forKey: "account_name")
        walletAccount.setValue(type, forKey: "account_type")
        walletAccount.setValue(descryption, forKey: "descryption")
        walletAccount.setValue(initialBalance, forKey: "initial_balance")
        walletAccount.setValue(walletId, forKey: "id")
        
        do {
            try managedContext.save()
            return true
        } catch {
            return false
        }
    }
    
    func getWalletAccountList() -> Array<Any> {
        let AppDel:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "WalletAccount")
        do {
            var rsArr = Array<Any>()
            let result = try AppDel.persistentContainer.viewContext.fetch(request)
            for data in result as! [NSManagedObject] {
                let name = data.value(forKey: "account_name") as! String
                let type = data.value(forKey: "account_type") as! Int
                let desc = data.value(forKey: "descryption") as! String
                let balance = data.value(forKey: "initial_balance") as! String
                let idObj = data.value(forKey: "id") as! Int
                
                let accObj = WalletAccountObj.init()
                accObj.updateInfo(itemId: idObj, name: name, type: type, desc: desc, balance: balance)
                rsArr.append(accObj)
            }
            return rsArr
        } catch {
            return []
        }
    }
    
    func getTotalBalance() -> String {
        var totalBalance:Int = 0
        
        let listAccount = self.getWalletAccountList()
        for item in listAccount {
            let object:WalletAccountObj = item as! WalletAccountObj
            totalBalance = totalBalance + Int(object.initialBalance)!
        }
        return String(totalBalance)
    }
    
}
