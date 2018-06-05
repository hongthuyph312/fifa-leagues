//
//  MatchDetailViewController.swift
//  FootballLeagues
//
//  Created by Hai Dang Nguyen on 6/5/18.
//  Copyright © 2018 Thuy Phan. All rights reserved.
//

import UIKit

class MatchDetailViewController: OriginalViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var team2Label: UILabel!
    @IBOutlet weak var team1Label: UILabel!
    @IBOutlet weak var team2ImageView: UIImageView!
    @IBOutlet weak var team1ImageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    var result      = ResultModel()
    let cellHeight: CGFloat     = 50.0

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
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
    
    // MARK: - UITableView Delegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return result.realTimeArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MatchDetailTableViewCell") as! MatchDetailTableViewCell
        
        let realTime = result.realTimeArray[indexPath.row]
        let team = realTime.team == result.team1Id ? 1 : 2
        cell.setupCell(realTimeModel: realTime, team: team)
        return cell
    }
}
