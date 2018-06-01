//
//  FoodModel.swift
//  PregnancyDiary
//
//  Created by Thuy Phan on 4/29/18.
//  Copyright © 2018 Beacon. All rights reserved.
//

import UIKit

class ClubModel: NSObject {
    
    var name            = ""
    var flag            = ""
    var played            = 0
    var points          = 0
    var goals           = 0
    var lost            = 0
    
    func initClubModel(club: [String : AnyObject]) {
        if club["name"] != nil {
            name = club["name"] as! String
        }
        
        if club["flag"] != nil {
            flag = club["flag"] as! String
        }
        
        if club["played"] != nil {
            played = club["played"] as! Int
        }
        
        if club["points"] != nil {
            points = club["points"] as! Int
        }
        
        if club["goals"] != nil {
            goals = club["goals"] as! Int
        }
        
        if club["lost"] != nil {
            lost = club["lost"] as! Int
        }
    }
}
