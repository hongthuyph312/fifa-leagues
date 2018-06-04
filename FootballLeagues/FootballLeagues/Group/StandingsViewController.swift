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
    
    // MARK: - Action
    @objc func tappedTableName(sender: UIButton) {
        let table = sender.tag
        let matchOfTableViewController = main_storyboard.instantiateViewController(withIdentifier: "MatchOfTableViewController") as! MatchOfTableViewController
        matchOfTableViewController.table = table
            self.present(matchOfTableViewController, animated: true, completion: nil)

        print("\(table)")
    }
    
    // MARK: - Set up UI
    func setupUI() {
        tableView.tableFooterView = UIView.init(frame: CGRect.zero)
    }
    
    // MARK: - Get data
    func getClubList() {
        self.showActivityIndicator()
        app_delegate.firebaseObject.getClubList(onCompletionHandler: {array in
            app_delegate.clubArray = array
            self.tableView.reloadData()
            self.hideActivityIndicator()
        })
    }
    
    //MARK: - UITableView Delegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return tableArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let clubInSectionArray = app_delegate.clubArray.filter{$0.table == section}
        
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
        
        var clubSectionArray = app_delegate.clubArray.filter{$0.table == indexPath.section}
        clubSectionArray = clubSectionArray.sorted(by: {$0.point > $1.point})
        clubSectionArray = clubSectionArray.sorted(by: {($0.goals - $0.lost) > ($1.goals - $1.lost)})
        
        let club = clubSectionArray[indexPath.row]
        cell.setupCell(clubModel: club)
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: headerHeight))
        let groupNameButton = UIButton.init(type: UIButtonType.custom)
        groupNameButton.frame = CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: headerHeight)
        groupNameButton.tag = section
        groupNameButton.addTarget(self, action: #selector(tappedTableName(sender:)), for: .touchUpInside)
        groupNameButton.setTitleColor(.white, for: .normal)
        groupNameButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        groupNameButton.setTitle(tableArray[section], for: .normal)
        
        headerView.addSubview(groupNameButton)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var clubSectionArray = app_delegate.clubArray.filter{$0.table == indexPath.section}
        let club = clubSectionArray[indexPath.row]

        let resultViewController = main_storyboard.instantiateViewController(withIdentifier: "MatchOfClubViewController") as! MatchOfClubViewController
        resultViewController.clubModel = club
        self.present(resultViewController, animated: true, completion: nil)
    }
}

