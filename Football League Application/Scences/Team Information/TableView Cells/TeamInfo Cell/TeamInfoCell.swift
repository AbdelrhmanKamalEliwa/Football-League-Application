//
//  TeamInfoCell.swift
//  Football League Application
//
//  Created by Abdelrhman Eliwa on 11/15/20.
//

import UIKit
import Kingfisher

class TeamInfoCell: UITableViewCell {
    // MARK: - Properties
    @IBOutlet weak var teamLogoImageView: UIImageView!
    @IBOutlet private weak var nameStackView: UIStackView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var shortNameStacklView: UIStackView!
    @IBOutlet private weak var shortNameLabel: UILabel!
    @IBOutlet private weak var addressStackView: UIStackView!
    @IBOutlet private weak var addressLabel: UILabel!
    @IBOutlet private weak var phoneStackView: UIStackView!
    @IBOutlet private weak var phoneLabel: UILabel!
    @IBOutlet private weak var websiteStackView: UIStackView!
    @IBOutlet private weak var websiteLabel: UILabel!
    @IBOutlet private weak var emailStackView: UIStackView!
    @IBOutlet private weak var emailLabel: UILabel!
    @IBOutlet private weak var foundedStackView: UIStackView!
    @IBOutlet private weak var foundedLabel: UILabel!
    @IBOutlet private weak var venueStackView: UIStackView!
    @IBOutlet private weak var venueLabel: UILabel!
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

// MARK: - Display Cell Data
extension TeamInfoCell: TeamInfoCellView {
    func displayLogoImage(_ imageUrl: String?) {
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
    
    func displayTeamName(_ name: String, isHidden: Bool) {
        nameStackView.isHidden = isHidden
        nameLabel.text = name
    }
    
    func displayTeamShortName(_ shortName: String, isHidden: Bool) {
        shortNameStacklView.isHidden = isHidden
        shortNameLabel.text = shortName
    }
    
    func displayTeamAddress(_ address: String, isHidden: Bool) {
        addressStackView.isHidden = isHidden
        addressLabel.text = address
    }
    
    func displayTeamPhone(_ phone: String, isHidden: Bool) {
        phoneStackView.isHidden = isHidden
        phoneLabel.text = phone
    }
    
    func displayTeamWebsite(_ website: String, isHidden: Bool) {
        websiteStackView.isHidden = isHidden
        websiteLabel.text = website
    }
    
    func displayTeamEmail(_ email: String, isHidden: Bool) {
        emailStackView.isHidden = isHidden
        emailLabel.text = email
    }
    
    func displayTeamFounded(_ founded: String, isHidden: Bool) {
        foundedStackView.isHidden = isHidden
        foundedLabel.text = founded
    }
    
    func displayTeamVenue(_ venue: String, isHidden: Bool) {
        venueStackView.isHidden = isHidden
        venueLabel.text = venue
    }
}
