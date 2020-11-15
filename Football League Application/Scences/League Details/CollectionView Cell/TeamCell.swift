//
//  TeamCell.swift
//  Football League Application
//
//  Created by Abdelrhman Eliwa on 11/14/20.
//

import UIKit
import Kingfisher

class TeamCell: UICollectionViewCell {
    // MARK: Properties
    @IBOutlet private weak var teamLogoImageView: UIImageView!
    @IBOutlet private weak var teamLongNameLabel: UILabel!
    @IBOutlet private weak var teamShortNameLabel: UILabel!
    
    // MARK: Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

// MARK: - Display Cell Data
extension TeamCell: TeamCellView {
    func displayLongName(_ name: String) {
        teamLongNameLabel.text = name
    }
    
    func displayShortName(_ name: String, isHidden: Bool) {
        teamShortNameLabel.text = name
        teamShortNameLabel.isHidden = isHidden
    }
    
    func displayLogo(_ imageUrl: String?) {
        if imageUrl != nil {
            guard let url = URL(string: imageUrl!) else { return }
            teamLogoImageView.kf.indicatorType = .activity
            teamLogoImageView.kf.setImage(
            with: url, placeholder: nil,
                options: [.processor(SVGImgProcessor())], progressBlock: nil) { [weak self] (result) in
                guard let self = self else { return }
                switch result {
                case .success(let image):
                    self.teamLogoImageView.image = image.image
                case .failure:
                    self.teamLogoImageView.image = UIImage(named: "logo.not.found")?.imageFlippedForRightToLeftLayoutDirection()
                    return
                }
            }
        }
    }
}
