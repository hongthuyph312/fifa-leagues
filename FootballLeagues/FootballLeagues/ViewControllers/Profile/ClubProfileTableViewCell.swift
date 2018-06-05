//
//  ClubProfileTableViewCell.swift
//  FootballLeagues
//
//  Created by Hai Dang Nguyen on 6/5/18.
//  Copyright © 2018 Thuy Phan. All rights reserved.
//

import UIKit

class ClubProfileTableViewCell: UITableViewCell {

    @IBOutlet weak var playerImageView: UIImageView!
    @IBOutlet weak var playerPositionLabel: UILabel!
    @IBOutlet weak var playerNameLabel: UILabel!
    @IBOutlet weak var playerStatusLabel: UILabel!
    @IBOutlet weak var playerGoalsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func setupCell(playerModel: PlayerModel) {
        playerPositionLabel.text = playerModel.position
        playerNameLabel.text = playerModel.name
        playerStatusLabel.text = playerModel.status
        playerGoalsLabel.text = "\(playerModel.goals)"
    }
}
