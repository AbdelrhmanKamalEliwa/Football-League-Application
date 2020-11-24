//
//  Router.swift
//  Football League Application
//
//  Created by Abdelrhman Eliwa on 23/11/2020.
//

import UIKit

enum Destination {
    case leagues
    case leagueDetails(leagueId: Int)
    case teamInformation(teamId: Int)
}

class Navigator: NavigatorProtocol {
    
    class func viewController(for destination: Destination) -> UIViewController {
        switch destination {
        case .leagues:
            let leaguesVC = LeaguesVC(navBarTitle: .Leagues)
            let presenter = LeaguesVCPresenter(view: leaguesVC)
            leaguesVC.presenter = presenter
            return leaguesVC
        case .leagueDetails(let leagueId):
            let leagueDetailsVC = LeagueDetailsVC(navBarTitle: .LeagueDetails)
            let presenter = LeagueDetailsVCPresenter(view: leagueDetailsVC, leagueId: leagueId)
            leagueDetailsVC.presenter = presenter
            return leagueDetailsVC
        case .teamInformation(let teamId):
            let teamInformationVC = TeamInformationVC(navBarTitle: .TeamInformation)
            let presenter = TeamInformationVCPresenter(view: teamInformationVC, teamId: teamId)
            teamInformationVC.presenter = presenter
            return teamInformationVC
        }
    }
}
