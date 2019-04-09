//
//  AccountModel.swift
//  QuanLyChiTieu
//
//  Created by lam quang quan on 4/9/19.
//  Copyright © 2019 KhaiLe. All rights reserved.
//

import UIKit
import CoreData

class AccountModel: NSObject {
    var username:String!
    var password:String!
    
    func checkAccountExists(username:String) -> Bool {
        let AppDel:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Account")
        request.predicate = NSPredicate(format: "username = %@", username)
        request.returnsObjectsAsFaults = false
        do {
            
            let result = try AppDel.persistentContainer.viewContext.fetch(request)
            for data in result as! [NSManagedObject] {
                print(data.value(forKey: "username") as! String)
                return true
            }
            return false
        } catch {
            return false
        }
    }
    
    func addNewAccount(username:String, password:String) -> Bool {
        //  Refer to persistentContainer from appdelegate
        let AppDel:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        //  Create the context from persistentContainer
        let managedContext = AppDel.persistentContainer.viewContext
        
        //  Create an entity with User
        let accountEntity = NSEntityDescription.entity(forEntityName: "Account", in: managedContext)
        
        //  Create new record with this Account Entity
        let account = NSManagedObject(entity: accountEntity!, insertInto: managedContext)
        
        //  Set values for the records for each key
        account.setValue(username, forKey: "username")
        account.setValue(password, forKey: "password")
        
        //  save value
        do {
            try managedContext.save()
            return true
        } catch {
            return false
        }
    }
}
