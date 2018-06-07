//
//  UserModel.swift
//  FootballLeagues
//
//  Created by Thuy Phan on 6/7/18.
//  Copyright © 2018 Thuy Phan. All rights reserved.
//

import UIKit

class UserModel: NSObject {
    var id              = ""
    var point           = 0
    var nickName        = ""
    
    func initUserModel(userDict: [String : AnyObject]) {
        if userDict["id"] != nil {
            id = userDict["id"] as! String
        }
        
        if userDict["point"] != nil {
            point = userDict["point"] as! Int
        }
        
        if userDict["nickName"] != nil {
            nickName = userDict["nickName"] as! String
        }
    }
}
