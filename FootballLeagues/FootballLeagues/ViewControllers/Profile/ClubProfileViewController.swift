//
//  ClubProfileViewController.swift
//  FootballLeagues
//
//  Created by Hai Dang Nguyen on 6/4/18.
//  Copyright © 2018 Thuy Phan. All rights reserved.
//

import UIKit

class ClubProfileViewController: OriginalViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var playedLabel: UILabel!
    @IBOutlet weak var pointLabel: UILabel!
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var gdLabel: UILabel!
    @IBOutlet weak var clubNameLabel: UILabel!
    @IBOutlet weak var flagImageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    var clubModel               = ClubModel()
    var playerArray             = [PlayerModel]()
    var rank                    = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.setupData()
        self.getPlayerList()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Set up
    func setupUI() {
        tableView.tableFooterView = UIView.init(frame: CGRect.zero)
    }
    
    func setupData() {
        rankLabel.text      = "\(rank + 1)"
        clubNameLabel.text  = clubModel.name
        pointLabel.text     = "\(clubModel.point)"
        gdLabel.text        = "\(clubModel.goals)-\(clubModel.lost)"
        playedLabel.text    = "\(clubModel.played)"
        flagImageView.image = UIImage.init(named: clubModel.flag)
    }
    
    //MARK: - Action
    @IBAction func tappedClose(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Get data
    func getPlayerList() {
        self.showActivityIndicator()
        app_delegate.firebaseObject.getPlayerList(clubId: clubModel.id, onCompletionHandler: {array in
            self.playerArray = array
            self.tableView.reloadData()
            self.hideActivityIndicator()
        })
    }
    
    //MARK: - UITableView Delegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playerArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ClubProfileTableViewCell") as! ClubProfileTableViewCell
        
        let player = playerArray[indexPath.row]
        cell.setupCell(playerModel: player)
        return cell
    }
}
