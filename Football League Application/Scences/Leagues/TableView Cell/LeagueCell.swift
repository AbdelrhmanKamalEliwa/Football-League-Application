//
//  LeagueCell.swift
//  Football League Application
//
//  Created by Abdelrhman Eliwa on 11/12/20.
//

import UIKit

class LeagueCell: UITableViewCell {

    // MARK: - Properties
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var areaLabel: UILabel!
    @IBOutlet private weak var startDateLabel: UILabel!
    @IBOutlet private weak var endDateLabel: UILabel!
    @IBOutlet private weak var chevronIcon: UIImageView!
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

// MARK: - Display Cell Data
extension LeagueCell: LeaguesCellView {
    func setChevronIconStatus(isHidden: Bool) {
        chevronIcon.isHidden = isHidden
    }
    
    func displayName(_ name: String) {
        nameLabel.text = name
    }
    
    func displayArea(_ name: String, isHidden: Bool) {
        areaLabel.text = name
        areaLabel.isHidden = isHidden
    }
    
    func displayStartDate(_ number: String) {
        startDateLabel.text = number
    }
    
    func displayEndDate(_ number: String) {
        endDateLabel.text = number
    }
}
