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
    var clubArray               = [ClubModel]()
    let cellHeight: CGFloat     = 50.0
    let headerHeight: CGFloat   = 50.0
    let tableArray = ["Bảng A", "Bảng B", "Bảng C", "Bảng D", "Bảng E", "Bảng F", "Bảng G", "Bảng H"]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.getClubList()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Get data
    
    func setupUI() {
        tableView.tableFooterView = UIView.init(frame: CGRect.zero)
        
    }
    
    // MARK: - Get data
    
    func getClubList() {
        self.showActivityIndicator()
        app_delegate.firebaseObject.getClubList(onCompletionHandler: {array in
            self.clubArray = array
            self.tableView.reloadData()
            self.hideActivityIndicator()
        })
    }
    
    //MARK: - UITableView Delegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return tableArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let clubInSectionArray = clubArray.filter{$0.table == section}
        
        return clubInSectionArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return headerHeight
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StandingsTableViewCell") as! StandingsTableViewCell
        
        let clubSectionArray = clubArray.filter{$0.table == indexPath.section}
        
        let club = clubSectionArray[indexPath.row]
        cell.setupCell(clubModel: club)
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: headerHeight))
        let groupNameLabel = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: headerHeight))
        groupNameLabel.textAlignment = .center
        groupNameLabel.text = tableArray[section]
        
        headerView.addSubview(groupNameLabel)
        return headerView
    }
}

