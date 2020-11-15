//
//  LeaguesVCPresenter.swift
//  Football League Application
//
//  Created by Abdelrhman Eliwa on 11/13/20.
//

import Foundation

//MARK: LeaguesView Protocol
protocol LeaguesView: class {
    var presenter: LeaguesVCPresenter? { get set }
    func showIndicator()
    func hideIndicator()
    func fetchDataSuccess()
    func showError(error: String)
}

//MARK: LeaguesCellView Protocol
protocol LeaguesCellView {
    func displayLongName(_ name: String)
    func displayShortName(_ name: String, isHidden: Bool)
    func displayNumberOfTeams(_ number: String)
    func displayNumberOfGames(_ number: String)
}

class LeaguesVCPresenter {
    //MARK: Properties
    private weak var view: LeaguesView?
    private let interactor: LeaguesInteractor
    private let router: LeaguesRouter
    private var leaguesData: [Competition] = []
    
    //MARK: Init
    init(view: LeaguesView?, interactor: LeaguesInteractor, router: LeaguesRouter) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    //MARK: Methods
    func viewDidLoad() {
        getLeagues()
    }
    
    func getLeagues() {
        view?.showIndicator()
        interactor.getLeagues { [weak self] (leagues, error) in
            guard let self = self else { return }
            self.view?.hideIndicator()
            if let error = error {
                self.view?.showError(error: error.localizedDescription)
            } else {
                guard let leagues = leagues else { return }
                self.leaguesData = leagues.competitions
                self.view?.fetchDataSuccess()
            }
        }
    }
    
    func numberOfLeagues() -> Int {
        leaguesData.count
    }
    
    func cellConfiguration(_ cell: LeaguesCellView, for index: Int) {
        let league = leaguesData[index]
        cell.displayLongName(league.name)
        
        if let shortName = league.code {
            cell.displayShortName(shortName, isHidden: false)
        } else {
            cell.displayShortName("", isHidden: true)
        }
        
        cell.displayNumberOfTeams("0")
        cell.displayNumberOfGames("0")
    }
    
    func didSelectRow(at index: Int) {
        let leagueId = leaguesData[index].id
        router.navigateToLeagueDetailsScreen(from: view, leagueId: leagueId)
    }
}
