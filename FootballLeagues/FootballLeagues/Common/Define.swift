//
//  Define.swift
//  PregnancyDiary
//
//  Created by Hai Dang Nguyen on 3/5/18.
//  Copyright © 2018 Beacon. All rights reserved.
//

import Foundation
import UIKit

let app_delegate    = UIApplication.shared.delegate as! AppDelegate
let main_storyboard = UIStoryboard(name: "Main", bundle: nil)
let comment_max     = 1000
let title_max       = 20

//MARK: - Size
let SCREEN_WIDTH    = UIScreen.main.bounds.size.width
let SCREEN_HEIGHT   = UIScreen.main.bounds.size.height
let kBOTTOM_BAR_iPHONEX: CGFloat = 34.0
let kUUID           = (UIDevice.current.identifierForVendor?.uuidString)!
//MARK: - Identifier
// App identifier
let APP_ID          = 1188956958

//Toast tag
let kIS_TOAST: Int = 243

// Admob
let kBannerAdUnitId       = "ca-app-pub-4981657393585558/2603567830"
let kInterstitialAdUnitID = "ca-app-pub-4981657393585558/4986188592"
let kApplicationId        = "ca-app-pub-4981657393585558~3561426285"

//MARK: - Define Object

func IMAGE(_ imageName: String) -> UIImage {
    return UIImage(named: imageName) ?? UIImage()
}

//MARK: Baby Index
let weekArray = ["7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","37","38","39","40"]

let bdpArray = ["","","","","","","21","25","29","32","36","39","43","46","50","53","56","59","62","65","68","71","73","76","78","81","83","85","87","89","90","92","93","94"]

let flArray = ["","","","","","","","14","17","20","23","25","28","31","34","36","39","42","44","47","49","52","54","56","59","61","63","65","67","68","70","71","73","74"]

let efwArray = ["0,5-2","1-3","3-5","5-7","12-15","18-25","35-50","60-80","90-110","121-171","150-212","185-261","227-319","275-387","399","478","568","679","785","913","1055","1210","1379","1559","1751","1953","2162","2377","2595","2813","3028","3236","3435","3619"]
