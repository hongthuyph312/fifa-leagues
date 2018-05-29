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
    var points          = ""
    var goalDifferent   = ""
    
    func initClubModel(club: [String : String]) {
        if club["name"] != nil {
            name = club["name"]!
        }
        
        if club["flag"] != nil {
            flag = club["flag"]!
        }
        
        if club["points"] != nil {
            points = club["points"]!
        }
        
        if club["goalDifferent"] != nil {
            goalDifferents = club["goalDifferent"]!
        }
    }
}
