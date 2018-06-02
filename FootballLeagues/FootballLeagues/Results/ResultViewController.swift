//
//  ResultViewController.swift
//  FootballLeagues
//
//  Created by Thuy Phan on 6/2/18.
//  Copyright © 2018 Thuy Phan. All rights reserved.
//

import UIKit

class ResultViewController: OriginalViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    let cellHeight: CGFloat     = 50.0
    let headerHeight: CGFloat   = 50.0
    let tableArray = ["Hôm nay", "Ngày mai"]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
    func getClubList() {
        self.showActivityIndicator()
        app_delegate.firebaseObject.getResultList(onCompletionHandler: {array in
            app_delegate.resultArray = array
            self.tableView.reloadData()
            self.hideActivityIndicator()
        })
    }
    
    //MARK: - UITableView Delegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return tableArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let resultInSectionArray = app_delegate.resultArray.filter{$0.table == section}
        
        return resultInSectionArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return headerHeight
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResultTableViewCell") as! ResultTableViewCell
        
        let resultSectionArray = app_delegate.resultArray.filter{$0.table == indexPath.section}
        
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
        groupNameButton.setTitle(tableArray[section], for: .normal)
        
        headerView.addSubview(groupNameButton)
        return headerView
    }
    
}
