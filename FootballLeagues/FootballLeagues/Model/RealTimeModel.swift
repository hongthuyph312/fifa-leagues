//
//  RealTimeModel.swift
//  FootballLeagues
//
//  Created by Thuy Phan on 6/5/18.
//  Copyright © 2018 Thuy Phan. All rights reserved.
//

import UIKit

class RealTimeModel: NSObject {
    var time          = ""
    var content       = ""
    var type          = 0
    var team          = ""

    func initRealTimeModel(realTimeDict: [String : AnyObject]) {
        if realTimeDict["time"] != nil {
            time = realTimeDict["time"] as! String
        }
        
        if realTimeDict["content"] != nil {
            content = realTimeDict["content"] as! String
        }
        
        if realTimeDict["type"] != nil {
            type = realTimeDict["type"] as! Int
        }
        
        if realTimeDict["team"] != nil {
            team = realTimeDict["team"] as! String
        }
    }
}
