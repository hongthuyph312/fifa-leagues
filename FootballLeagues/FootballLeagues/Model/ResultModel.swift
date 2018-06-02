//
//  ResultModel.swift
//  FootballLeagues
//
//  Created by Thuy Phan on 6/2/18.
//  Copyright © 2018 Thuy Phan. All rights reserved.
//

import UIKit

class ResultModel: NSObject {
    var team1Id         = ""
    var team2Id         = ""
    var result          = ""
    var table           = 0
    var time            = 0.0
    
    func initResultModel(resultDict: [String : AnyObject]) {
        if resultDict["team1Id"] != nil {
            team1Id = resultDict["team1Id"] as! String
        }
        
        if resultDict["team2Id"] != nil {
            team2Id = resultDict["team2Id"] as! String
        }
        
        if resultDict["result"] != nil {
            result = resultDict["result"] as! String
        }
        
        if resultDict["table"] != nil {
            table = resultDict["table"] as! Int
        }
        
        if resultDict["time"] != nil {
            time = resultDict["time"] as! Double
        }
    }
}
