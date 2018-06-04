//
//  MainTabBarViewController.swift
//  PregnancyDiary
//
//  Created by Hai Dang Nguyen on 4/4/18.
//  Copyright © 2018 Beacon. All rights reserved.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.addTabBarViewController()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: - Function
    func addTabBarViewController() {
        // Pregnancy
        let standingsViewController = main_storyboard.instantiateViewController(withIdentifier: "StandingsViewController") as! StandingsViewController
        let tabBar1 = self.setupController(standingsViewController,
                                               tabName: "Standings",
                                               image: IMAGE("standings"),
                                               selectedImage: IMAGE("standings"))
        
        let resultViewController = main_storyboard.instantiateViewController(withIdentifier: "MatchViewController") as! MatchViewController
        let tabBar2 = self.setupController(resultViewController,
                                           tabName: "Result",
                                           image: IMAGE("standings"),
                                           selectedImage: IMAGE("standings"))


        self.viewControllers = [tabBar1, tabBar2]
    }
    
    func setupController(_ viewController: UIViewController, tabName: String, image: UIImage, selectedImage: UIImage) -> UIViewController {
        let normalAttributes = [ NSAttributedStringKey.foregroundColor : UIColor.black,
                                 NSAttributedStringKey.font :UIFont.systemFont(ofSize: 12) ]
        
        let tabbarItem = UITabBarItem(title: tabName,
                                      image: image.withRenderingMode(.alwaysOriginal),
                                      selectedImage: selectedImage.withRenderingMode(.alwaysOriginal))
        tabbarItem.setTitleTextAttributes(normalAttributes, for: .normal)
        tabbarItem.imageInsets = UIEdgeInsetsMake(-2, 0, 2, 0)
        tabbarItem.titlePositionAdjustment = UIOffsetMake(0, -2)
        tabBar.tintColor = Common.mainColor()
        viewController.tabBarItem = tabbarItem
        return viewController
    }
}
