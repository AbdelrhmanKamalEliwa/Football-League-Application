//
//  PlayerCell.swift
//  Football League Application
//
//  Created by Abdelrhman Eliwa on 11/14/20.
//

import UIKit

class PlayerCell: UITableViewCell {
    // MARK: Properties
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var positionLabel: UILabel!
    @IBOutlet private weak var nationalityLabel: UILabel!
    @IBOutlet private weak var positionStackView: UIStackView!
    @IBOutlet private weak var nationalityStackView: UIStackView!
    
    // MARK: Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

// MARK: - Display Cell Data
extension PlayerCell: PlayerCellView {
    func displayPlayerName(_ name: String) {
        nameLabel.text = name
    }
    
    func displayPlayerPosition(_ position: String, isHidden: Bool) {
        positionStackView.isHidden = isHidden
        positionLabel.text = position
    }
    
    func displayPlayerNationality(_ nationality: String, isHidden: Bool) {
        nationalityStackView.isHidden = isHidden
        nationalityLabel.text = nationality
    }
}
