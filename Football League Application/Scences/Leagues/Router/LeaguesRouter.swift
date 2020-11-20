//
//  LeaguesRouter.swift
//  Football League Application
//
//  Created by Abdelrhman Eliwa on 11/13/20.
//

import UIKit

class LeaguesRouter {
    class func createLeaguesVC() -> UIViewController {
        let leaguesVC = LeaguesVC(navBarTitle: .Leagues)
        let interactor = LeaguesInteractor()
        let router = LeaguesRouter()
        let presenter = LeaguesVCPresenter(
            view: leaguesVC,
            interactor: interactor,
            router: router)
        leaguesVC.presenter = presenter
        return leaguesVC
    }
    
    func navigateToLeagueDetailsScreen(from view: LeaguesView?, leagueId: Int) {
        let leagueDetailsView = LeagueDetailsRouter.createLeagueDetailsVC(leagueId: leagueId)
        if let viewController = view as? UIViewController {
            viewController.navigationController?.pushViewController(leagueDetailsView, animated: true)
        }
    }
}
