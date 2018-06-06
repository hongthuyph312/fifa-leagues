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
    }

    func setupCell(realTimeModel: RealTimeModel, team: Int) {
        if team == 1 {
            // Set up team 1
            team1ContentLabel.text  = realTimeModel.content
            team1TimeLabel.text     = realTimeModel.time
            switch realTimeModel.type {
            case 0:
                // Goals
                team1ImageView.image = UIImage.init(named: "goals")
            case 1:
                // exchange player
                team1ImageView.image = UIImage.init(named: "exchange")
            case 2:
                // yellow card
                team1ImageView.image = UIImage.init(named: "yellowCard")
            case 3:
                // red card
                team1ImageView.image = UIImage.init(named: "redCard")
            default:
                // Injury
                team1ImageView.image = UIImage.init(named: "injuryPlayer")
            }
            
            // Re-set team 2
            team2ContentLabel.text  = ""
            team2TimeLabel.text     = ""
            team2ImageView.image = UIImage.init(named: "")
        } else {
            // Set up team 1
            team2ContentLabel.text  = realTimeModel.content
            team2TimeLabel.text     = realTimeModel.time
            switch realTimeModel.type {
            case 0:
                // Goals
                team2ImageView.image = UIImage.init(named: "goals")
            case 1:
                // exchange player
                team2ImageView.image = UIImage.init(named: "exchange")
            case 2:
                // yellow card
                team2ImageView.image = UIImage.init(named: "yellowCard")
            case 3:
                // red card
                team2ImageView.image = UIImage.init(named: "redCard")
            default:
                // injury
                team2ImageView.image = UIImage.init(named: "injuryPlayer")
            }
            
            // Re-set team 1
            team1ContentLabel.text  = ""
            team1TimeLabel.text     = ""
            team1ImageView.image = UIImage.init(named: "")
        }
    }
}
