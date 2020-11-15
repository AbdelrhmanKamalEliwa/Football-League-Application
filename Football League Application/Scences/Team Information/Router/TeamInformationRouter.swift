//
//  TeamInformationRouter.swift
//  Football League Application
//
//  Created by Abdelrhman Eliwa on 11/14/20.
//

import UIKit

class TeamInformationRouter {
    private enum Constants {
        static let nibName = "TeamInformationVC"
    }
    
    class func createTeamInformationVC(teamId: Int) -> UIViewController {
        let teamInformationVC = TeamInformationVC(nibName: Constants.nibName, bundle: nil)
        let interactor = TeamInformationInteractor()
        let router = TeamInformationRouter()
        let presenter = TeamInformationVCPresenter(
            view: teamInformationVC,
            interactor: interactor,
            router: router,
            teamId: teamId)
        teamInformationVC.presenter = presenter
        return teamInformationVC
    }
}
