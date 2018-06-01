//
//  ViewController.swift
//  FootballLeagues
//
//  Created by Thuy Phan on 5/29/18.
//  Copyright © 2018 Thuy Phan. All rights reserved.
//

import UIKit

class StandingsViewController: OriginalViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    let cellHeight: CGFloat      = 50.0
    let headerHeight: CGFloat    = 50.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: - UITableView Delegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return groupNameArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return headerHeight
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StandingsTableViewCell") as! StandingsTableViewCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: headerHeight))
        let groupNameLabel = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: headerHeight))
        groupNameLabel.textAlignment = .center
        groupNameLabel.text = groupNameArray[section]
        
        headerView.addSubview(groupNameLabel)
        return headerView
    }
}

