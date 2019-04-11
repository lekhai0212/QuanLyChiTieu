//
//  WalletAccountObj.swift
//  QuanLyChiTieu
//
//  Created by lam quang quan on 4/11/19.
//  Copyright © 2019 KhaiLe. All rights reserved.
//

import UIKit

class WalletAccountObj: NSObject {
    var id:Int!
    var accountName:String!
    var accountType:Int!
    var descryption:String!
    var initialBalance:String!
    
    func updateInfo(itemId:Int, name:String, type:Int, desc:String, balance:String) {
        id = itemId
        accountName = name
        accountType = type
        descryption = desc
        initialBalance = balance
    }
}
