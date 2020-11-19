//
//  LeaguesVCPresenter.swift
//  Football League Application
//
//  Created by Abdelrhman Eliwa on 11/13/20.
//

import Foundation
import UIKit
import CoreData

// MARK: - LeaguesView Protocol
protocol LeaguesView: class {
    var presenter: LeaguesVCPresenter? { get set }
    func showIndicator()
    func hideIndicator()
    func fetchDataSuccess()
    func showError(error: String)
}

// MARK: - LeaguesCellView Protocol
protocol LeaguesCellView {
    func displayName(_ name: String)
    func displayArea(_ name: String, isHidden: Bool)
    func displayStartDate(_ date: String)
    func displayEndDate(_ date: String)
    func setChevronIconStatus(isHidden: Bool)
}

class LeaguesVCPresenter {
    // MARK: - Properties
    private weak var view: LeaguesView?
    private let interactor: LeaguesInteractor
    private let router: LeaguesRouter
    private var leaguesData: [Competition] = []
    private var cachedLeagues: [Leagues] = []
    private var cach = false
    
    // MARK: - Init
    init(view: LeaguesView?, interactor: LeaguesInteractor, router: LeaguesRouter) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    // MARK: - Methods
    func viewDidLoad() {
        getLeagues()
    }
    
    private func getLeagues() {
        view?.showIndicator()
        interactor.getLeagues { [weak self] (leagues, error) in
            guard let self = self else { return }
            self.view?.hideIndicator()
            if let error = error {
                self.cach = true
                DispatchQueue.main.async {
                    self.cachedLeagues = self.interactor.loadCachedData()
                    guard !self.cachedLeagues.isEmpty else {
                        self.view?.showError(error: error.localizedDescription)
                        return
                    }
                    self.view?.fetchDataSuccess()
                }
            } else {
                guard let leagues = leagues else { return }
                self.leaguesData = leagues.competitions
                self.cach = false
                self.view?.fetchDataSuccess()
                DispatchQueue.main.async {
                    self.interactor.cachData(leagues.competitions)
                }
            }
        }
    }
    
    func numberOfLeagues() -> Int {
        cach ? cachedLeagues.count : leaguesData.count
    }
    
    func cellConfiguration(_ cell: LeaguesCellView, for index: Int) {
        if cach {
            let league = cachedLeagues[index]
            cell.displayName(league.leagueName ?? "")
            
            if let areaName = league.areaName {
                cell.displayArea(areaName, isHidden: false)
            } else {
                cell.displayArea("", isHidden: true)
            }
        } else {
            let league = leaguesData[index]
            cell.displayName(league.name)
            
            if let shortName = league.code {
                cell.displayArea(shortName, isHidden: false)
            } else {
                cell.displayArea("", isHidden: true)
            }
        }
        cell.displayStartDate("0")
        cell.displayEndDate("0")
    }
    
    func didSelectRow(at index: Int) {
        let leagueId = cach ? Int(cachedLeagues[index].leagueId) : leaguesData[index].id
        router.navigateToLeagueDetailsScreen(from: view, leagueId: leagueId)
    }
}
