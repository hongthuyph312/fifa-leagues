//
//  Define.swift
//  PregnancyDiary
//
//  Created by Hai Dang Nguyen on 3/5/18.
//  Copyright © 2018 Beacon. All rights reserved.
//

import Foundation
import UIKit

let app_delegate            = UIApplication.shared.delegate as! AppDelegate
let main_storyboard         = UIStoryboard(name: "Main", bundle: nil)
let comment_max             = 1000
let title_max               = 20

//MARK: - Size
let SCREEN_WIDTH            = UIScreen.main.bounds.size.width
let SCREEN_HEIGHT           = UIScreen.main.bounds.size.height
let kBOTTOM_BAR_iPHONEX: CGFloat = 34.0
let kUUID                   = (UIDevice.current.identifierForVendor?.uuidString)!

//MARK: - Identifier
// App identifier
let APP_ID                  = 1188956958

// MARK: - Match detail type
let kGOAL                   = 0
let kEXCHANGE_PLAYER        = 1
let kYELLOW_CARD            = 2
let kRED_CARD               = 3
let kINJURY                 = 4

//Toast tag
let kIS_TOAST: Int          = 243

// Admob
let kBannerAdUnitId         = "ca-app-pub-4981657393585558/7558966645"
let kInterstitialAdUnitID   = "ca-app-pub-4981657393585558/3805330566"
let kApplicationId          = "ca-app-pub-4981657393585558~4839759371"

//MARK: - Define Object

func IMAGE(_ imageName: String) -> UIImage {
    return UIImage(named: imageName) ?? UIImage()
}


