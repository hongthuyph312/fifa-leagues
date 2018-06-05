//
//  MatchDetailViewController.swift
//  FootballLeagues
//
//  Created by Hai Dang Nguyen on 6/5/18.
//  Copyright © 2018 Thuy Phan. All rights reserved.
//

import UIKit

class MatchDetailViewController: UIViewController {

    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var team2Label: UILabel!
    @IBOutlet weak var team1Label: UILabel!
    @IBOutlet weak var team2ImageView: UIImageView!
    @IBOutlet weak var team1ImageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
