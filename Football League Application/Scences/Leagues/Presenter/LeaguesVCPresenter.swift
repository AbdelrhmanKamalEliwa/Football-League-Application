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
    private var leagues: [Competition] = []
    private var cachedLeagues: [Leagues] = []
    private var availableLeagues: [Competition] = []
    private var availableCachedLeagues: [Leagues] = []
    private var cach = false
    private var available = false
    private let availableLeaguesIDs = AvailableLeagues().availableLeaguesIDs
    
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
            
            if let error = error {
                self.cach = true
                DispatchQueue.main.async {
                    self.cachedLeagues = self.interactor.loadCachedData()
                    self.setAvailableCachedLeagues()
                    self.view?.hideIndicator()
                    guard !self.cachedLeagues.isEmpty else {
                        self.view?.showError(error: error.localizedDescription)
                        return
                    }
                    self.view?.fetchDataSuccess()
                }
            } else {
                guard let leagues = leagues else { return }
                self.leagues = leagues.competitions
                self.setAvailableLeagues()
                self.view?.hideIndicator()
                self.cach = false
                self.view?.fetchDataSuccess()
                DispatchQueue.main.async {
                    self.interactor.cachData(leagues.competitions)
                }
            }
        }
    }
    
    func setAvailableStatus(_ segmentedControlIndex: Int) {
        segmentedControlIndex == 0 ? (available = false) : (available = true)
        view?.fetchDataSuccess()
    }
    
    private func setAvailableLeagues() {
        for league in leagues {
            if availableLeaguesIDs.contains(league.id) {
                availableLeagues.append(league)
            }
        }
    }
    
    private func setAvailableCachedLeagues() {
        for league in cachedLeagues {
            if availableLeaguesIDs.contains(Int(league.leagueId)) {
                availableCachedLeagues.append(league)
            }
        }
    }
    
    func numberOfLeagues() -> Int {
        if available {
            return cach ? availableCachedLeagues.count : availableLeagues.count
        } else {
            return cach ? cachedLeagues.count : leagues.count
        }
    }
    
    func cellConfiguration(_ cell: LeaguesCellView, for index: Int) {
        if cach {
            let league = available ? availableCachedLeagues[index] : cachedLeagues[index]
            cell.displayName(league.leagueName ?? "")
            if let areaName = league.areaName {
                cell.displayArea(areaName, isHidden: false)
            } else {
                cell.displayArea("", isHidden: true)
            }
            cell.displayStartDate(league.startDate ?? "")
            cell.displayEndDate(league.endDate ?? "")
            let isHidden = availableLeaguesIDs.contains(Int(league.leagueId))
            cell.setChevronIconStatus(isHidden: !isHidden)
            
        } else {
            let league = available ? availableLeagues[index] : leagues[index]
            cell.displayName(league.name)
            if let shortName = league.code {
                cell.displayArea(shortName, isHidden: false)
            } else {
                cell.displayArea("", isHidden: true)
            }
            cell.displayStartDate(league.currentSeason?.startDate ?? "")
            cell.displayEndDate(league.currentSeason?.endDate ?? "")
            let isHidden = availableLeaguesIDs.contains(league.id)
            cell.setChevronIconStatus(isHidden: !isHidden)
        }
    }
    
    func didSelectRow(at index: Int) {
        if available {
            let leagueId = cach ? Int(availableCachedLeagues[index].leagueId) : availableLeagues[index].id
            router.navigateToLeagueDetailsScreen(from: view, leagueId: leagueId)
        } else {
            let leagueId = cach ? Int(cachedLeagues[index].leagueId) : leagues[index].id
            if availableLeaguesIDs.contains(leagueId) {
                router.navigateToLeagueDetailsScreen(from: view, leagueId: leagueId)
            } else {
                view?.showError(error: "This competition is unavailable")
            }
        }
        
    }
}
