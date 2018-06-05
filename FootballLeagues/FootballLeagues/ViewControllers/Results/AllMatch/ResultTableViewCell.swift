//
//  ResultTableViewCell.swift
//  FootballLeagues
//
//  Created by Thuy Phan on 6/2/18.
//  Copyright © 2018 Thuy Phan. All rights reserved.
//

import UIKit

class ResultTableViewCell: UITableViewCell {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var team1Label: UILabel!
    @IBOutlet weak var team2Label: UILabel!
    @IBOutlet weak var flag1ImageView: UIImageView!
    @IBOutlet weak var flag2ImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func setupCell(resultModel: ResultModel) {
        let team1 = app_delegate.clubArray.filter{$0.id == resultModel.team1Id}.first
        let team2 = app_delegate.clubArray.filter{$0.id == resultModel.team2Id}.first
        
        resultLabel.text = resultModel.result
        timeLabel.text = Common.stringFromTimeInterval(timeInterval: resultModel.time, format: "HH:mm")
        team1Label.text = team1?.name
        flag1ImageView.image = UIImage.init(named: (team1?.flag)!)

        team2Label.text = team2?.name
        flag2ImageView.image = UIImage.init(named: (team2?.flag)!)
    }
}
