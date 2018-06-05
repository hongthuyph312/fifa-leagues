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
                team1ImageView.image = UIImage.init(named: "")
            case 1:
                // yellow
                team1ImageView.image = UIImage.init(named: "")
            case 2:
                // red
                team1ImageView.image = UIImage.init(named: "")
            case 3:
                // change people
                team1ImageView.image = UIImage.init(named: "")
            default:
                // Injury
                team1ImageView.image = UIImage.init(named: "")
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
                team2ImageView.image = UIImage.init(named: "")
            case 1:
                // yellow
                team2ImageView.image = UIImage.init(named: "")
            case 2:
                // red
                team2ImageView.image = UIImage.init(named: "")
            case 3:
                // change people
                team2ImageView.image = UIImage.init(named: "")
            default:
                // Injury
                team2ImageView.image = UIImage.init(named: "")
            }
            
            // Re-set team 1
            team1ContentLabel.text  = ""
            team1TimeLabel.text     = ""
            team1ImageView.image = UIImage.init(named: "")
        }
    }
}
