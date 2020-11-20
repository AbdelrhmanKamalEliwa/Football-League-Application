//
//  LeagueDetailsRouter.swift
//  Football League Application
//
//  Created by Abdelrhman Eliwa on 11/14/20.
//

import UIKit

class LeagueDetailsRouter {
    class func createLeagueDetailsVC(leagueId: Int) -> UIViewController {
        let leagueDetailsVC = LeagueDetailsVC(navBarTitle: .LeagueDetails)
        let interactor = LeagueDetailsInteractor()
        let router = LeagueDetailsRouter()
        let presenter = LeagueDetailsVCPresenter(
            view: leagueDetailsVC,
            interactor: interactor,
            router: router,
            leagueId: leagueId)
        leagueDetailsVC.presenter = presenter
        return leagueDetailsVC
    }
    
    func navigateToTeamInformationScreen(from view: TeamsView?, teamId: Int) {
        let teamInformationView = TeamInformationRouter.createTeamInformationVC(teamId: teamId)
        if let viewController = view as? UIViewController {
            viewController.navigationController?.pushViewController(teamInformationView, animated: true)
        }
    }
}
