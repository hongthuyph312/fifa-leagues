//
//  MatchDetailTableViewCell.swift
//  FootballLeagues
//
//  Created by Thuy Phan on 6/5/18.
//  Copyright © 2018 Thuy Phan. All rights reserved.
//

import UIKit

class MatchDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var team2ContentLabel: UILabel!
    @IBOutlet weak var team1ContentLabel: UILabel!
    @IBOutlet weak var team1TimeLabel: UILabel!
    @IBOutlet weak var team2TimeLabel: UILabel!
    @IBOutlet weak var team1ImageView: UIImageView!
    @IBOutlet weak var team2ImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
