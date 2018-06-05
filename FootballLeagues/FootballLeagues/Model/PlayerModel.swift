//
//  PlayerModel.swift
//  FootballLeagues
//
//  Created by Hai Dang Nguyen on 6/4/18.
//  Copyright © 2018 Thuy Phan. All rights reserved.
//

import UIKit

class PlayerModel: NSObject {
    var id              = ""
    var clubId          = ""
    var name            = ""
    var status          = ""
    var position        = ""
    var goals           = 0

    func initPlayerModel(playerDict: [String : AnyObject]) {
        if playerDict["id"] != nil {
            id = playerDict["id"] as! String
        }
        
        if playerDict["name"] != nil {
            name = playerDict["name"] as! String
        }
        
        if playerDict["clubId"] != nil {
            clubId = playerDict["clubId"] as! String
        }
        
        if playerDict["status"] != nil {
            status = playerDict["status"] as! String
        }
        
        if playerDict["position"] != nil {
            position = playerDict["position"] as! String
        }
        
        if playerDict["goals"] != nil {
            goals = playerDict["goals"] as! Int
        }
    }
}
