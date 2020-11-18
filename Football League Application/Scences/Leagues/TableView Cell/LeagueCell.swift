//
//  LeagueCell.swift
//  Football League Application
//
//  Created by Abdelrhman Eliwa on 11/12/20.
//

import UIKit

class LeagueCell: UITableViewCell {

    // MARK: - Properties
    @IBOutlet private weak var longNameLabel: UILabel!
    @IBOutlet private weak var shortNameLabel: UILabel!
    @IBOutlet private weak var numberOfTeamsLabel: UILabel!
    @IBOutlet private weak var numberOfGamesLabel: UILabel!
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

// MARK: - Display Cell Data
extension LeagueCell: LeaguesCellView {
    func displayLongName(_ name: String) {
        longNameLabel.text = name
    }
    
    func displayShortName(_ name: String, isHidden: Bool) {
        shortNameLabel.text = name
        shortNameLabel.isHidden = isHidden
    }
    
    func displayNumberOfTeams(_ number: String) {
        numberOfTeamsLabel.text = number
    }
    
    func displayNumberOfGames(_ number: String) {
        numberOfGamesLabel.text = number
    }
}
