//
//  StandingsTableViewCell.swift
//  FootballLeagues
//
//  Created by Thuy Phan on 5/29/18.
//  Copyright © 2018 Thuy Phan. All rights reserved.
//

import UIKit

class StandingsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var pointsLabel: UILabel!
    @IBOutlet weak var goalsDifferenceLabel: UILabel!
    @IBOutlet weak var playedLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var flagImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupCell(clubModel: ClubModel) {
        flagImageView.image = UIImage.init(named: clubModel.flag)
        countryLabel.text = clubModel.name
        playedLabel.text = "\(clubModel.played)"
        goalsDifferenceLabel.text = "\(clubModel.goals) - \(clubModel.lost)"
        pointsLabel.text = "\(clubModel.point)"
    }
}
