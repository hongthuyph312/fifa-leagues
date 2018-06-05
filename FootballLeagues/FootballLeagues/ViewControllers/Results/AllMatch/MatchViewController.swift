//
//  ResultViewController.swift
//  FootballLeagues
//
//  Created by Thuy Phan on 6/2/18.
//  Copyright © 2018 Thuy Phan. All rights reserved.
//

import UIKit

class MatchViewController: OriginalViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    let cellHeight: CGFloat     = 50.0
    let headerHeight: CGFloat   = 50.0
    var dateArray = [String]()
    var resultModelArray = [[ResultModel]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.getMatchList()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Action
    @objc func tappedTableName(sender: UIButton) {
        let table = sender.tag
        print("\(table)")
    }
    
    // MARK: - Set up UI
    func setupUI() {
        tableView.tableFooterView = UIView.init(frame: CGRect.zero)
    }
    
    // MARK: - Get data
    func getMatchList() {
        self.showActivityIndicator()
        for result in app_delegate.allMatchArray {
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
        return resultModelArray.count
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResultTableViewCell") as! ResultTableViewCell
        
        let resultSectionArray = resultModelArray[indexPath.section]
        
        let result = resultSectionArray[indexPath.row]
        cell.setupCell(resultModel: result)
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: headerHeight))
        let groupNameButton = UIButton.init(type: UIButtonType.custom)
        groupNameButton.frame = CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: headerHeight)
        groupNameButton.tag = section
        groupNameButton.addTarget(self, action: #selector(tappedTableName(sender:)), for: .touchUpInside)
        groupNameButton.setTitleColor(Common.mainColor(), for: .normal)
        if dateArray.count > section {
            groupNameButton.setTitle(dateArray[section], for: .normal)
        }
        
        headerView.addSubview(groupNameButton)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let resultSectionArray = resultModelArray[indexPath.section]
        let result = resultSectionArray[indexPath.row]

        let matchDetailViewController = main_storyboard.instantiateViewController(withIdentifier: "MatchDetailViewController") as! MatchDetailViewController
        matchDetailViewController.result = result
        self.present(matchDetailViewController, animated: true, completion: nil)
    }
}
