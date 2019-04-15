//
//  ActionMenuObj.swift
//  QuanLyChiTieu
//
//  Created by admin on 4/14/19.
//  Copyright © 2019 KhaiLe. All rights reserved.
//

import UIKit

class ActionMenuObj: NSObject {
    var menuId:Int!
    var menuName:String!
    var menuCode:String!
    var parentId:Int!
    
    class func initWithInfo(id:Int, name:String, code:String, superId:Int) -> ActionMenuObj {
        let object:ActionMenuObj = ActionMenuObj()
        object.menuId = id
        object.menuName = name
        object.menuCode = code
        object.parentId = superId
        
        return object
    }
}
