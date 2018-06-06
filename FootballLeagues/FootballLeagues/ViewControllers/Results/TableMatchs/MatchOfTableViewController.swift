//
//  MatchOfTableViewController.swift
//  FootballLeagues
//
//  Created by Hai Dang Nguyen on 6/4/18.
//  Copyright © 2018 Thuy Phan. All rights reserved.
//

import UIKit

class MatchOfTableViewController: OriginalViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    let cellHeight: CGFloat     = 60.0
    let headerHeight: CGFloat   = 50.0
    var table                   = 0
    var dateArray = [String]()
    var resultModelArray = [[ResultModel]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.getMatchList()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Set up UI
    func setupUI() {
        tableView.tableFooterView = UIView.init(frame: CGRect.zero)
    }
    
    //MARK: - Action
    @IBAction func tappedClose(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Get data
    func getMatchList() {
        self.showActivityIndicator()
        let matchOftableArray = app_delegate.allMatchArray.filter{$0.table == table}
        for result in matchOftableArray {
            let dateString = Common.stringFromTimeInterval(timeInterval: result.time, format: "yyyy-MM-dd")
            if !self.dateArray.contains(dateString) {
                // Start new section
                self.dateArray.append(dateString)
                
                // Init array of mathch at this day
                var resultOverDateArray = [ResultModel]()
                resultOverDateArray.append(result)
                
                // Add match to this day
                self.resultModelArray.append(resultOverDateArray)
            } else {
                guard let index = self.dateArray.index(of: dateString) else {return}
                
                // Get current array of matchs at this day
                var resultOverDateArray = self.resultModelArray[index]
                
                // Add new match to this day
                resultOverDateArray.append(result)
                
                // Replace matchs at this day
                self.resultModelArray[index] = resultOverDateArray
            }
        }
        self.tableView.reloadData()
        self.hideActivityIndicator()
    }
    
    //MARK: - UITableView Delegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return dateArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let resultSectionArray = resultModelArray[section]
        
        return resultSectionArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return headerHeight
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MatchOfTableViewCell") as! MatchOfTableViewCell
        
        let resultSectionArray = resultModelArray[indexPath.section]
        
        let result = resultSectionArray[indexPath.row]
        cell.setupCell(resultModel: result)
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: headerHeight))
        headerView.backgroundColor = .white
        let groupNameButton = UIButton.init(type: UIButtonType.custom)
        groupNameButton.frame = CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: headerHeight)
        groupNameButton.tag = section
        groupNameButton.setTitleColor(Common.mainColor(), for: .normal)
        if dateArray.count > section {
            groupNameButton.setTitle(dateArray[section], for: .normal)
        }
        
        headerView.addSubview(groupNameButton)
        return headerView
    }
}
