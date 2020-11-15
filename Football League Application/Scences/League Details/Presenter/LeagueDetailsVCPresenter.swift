//
//  LeagueDetailsVCPresenter.swift
//  Football League Application
//
//  Created by Abdelrhman Eliwa on 11/14/20.
//

import Foundation

//MARK: TeamsView Protocol
protocol TeamsView: class {
    var presenter: LeagueDetailsVCPresenter? { get set }
    func showIndicator()
    func hideIndicator()
    func fetchDataSuccess()
    func showError(error: String)
}

//MARK: TeamCellView Protocol
protocol TeamCellView {
    func displayLongName(_ name: String)
    func displayShortName(_ name: String, isHidden: Bool)
    func displayLogo(_ imageUrl: String?)
}

class LeagueDetailsVCPresenter {
    //MARK: Properties
    private weak var view: TeamsView?
    private let interactor: LeagueDetailsInteractor
    private let router: LeagueDetailsRouter
    private let leagueId: Int
    private var teamsData: [Team] = []
    
    //MARK: Init
    init(view: TeamsView?, interactor: LeagueDetailsInteractor, router: LeagueDetailsRouter, leagueId: Int) {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.leagueId = leagueId
    }
    
    //MARK: Methods
    func viewDidLoad() {
        getTeams()
    }
    
    private func getTeams() {
        view?.showIndicator()
        interactor.getLeagueTeams(for: leagueId) { [weak self] (leagueTeams, error) in
            guard let self = self else { return }
            self.view?.hideIndicator()
            if let error = error {
                self.view?.showError(error: error.localizedDescription)
            } else {
                guard let leagueTeams = leagueTeams?.teams else {
                    self.view?.showError(error: "Data not founded")
                    return
                }
                self.teamsData = leagueTeams
                self.view?.fetchDataSuccess()
            }
        }
    }
    
    func numberOfLeagues() -> Int {
        teamsData.count
    }
    
    func cellConfiguration(_ cell: TeamCellView, for item: Int) {
        let team = teamsData[item]
        cell.displayLogo(team.crestURL)
        cell.displayLongName(team.name)
        if let shortName = team.shortName {
            cell.displayShortName(shortName, isHidden: false)
        } else {
            cell.displayShortName("", isHidden: true)
        }
    }
    
    func didSelectItem(at item: Int) {
        let teamId = teamsData[item].id
        router.navigateToTeamInformationScreen(from: view, teamId: teamId)
    }
}
