//
//  LeagueDetailsVCPresenter.swift
//  Football League Application
//
//  Created by Abdelrhman Eliwa on 11/14/20.
//

import Foundation

// MARK: - TeamsView Protocol
protocol TeamsView: class {
    var presenter: LeagueDetailsVCPresenter? { get set }
    func showIndicator()
    func hideIndicator()
    func fetchDataSuccess()
    func showError(error: String)
    func navigateToTeamInformationScreen(with teamId: Int)
}

// MARK: - TeamCellView Protocol
protocol TeamCellView {
    func displayLongName(_ name: String)
    func displayShortName(_ name: String, isHidden: Bool)
    func displayLogo(_ imageUrl: String?)
}

class LeagueDetailsVCPresenter {
    // MARK: - Properties
    private weak var view: TeamsView?
    private let networkManager = NetworkManager()
    private let coreDataManager = CoreDataManager()
    private let leagueId: Int
    private var teamsData: [Team] = []
    private var cachedTeams: [Teams] = []
    private var cach = false
    
    // MARK: - Init
    init(view: TeamsView?, leagueId: Int) {
        self.view = view
        self.leagueId = leagueId
    }
    
    // MARK: - Methods
    func viewDidLoad() {
        getTeams()
    }
    
    private func getTeams() {
        view?.showIndicator()
        let headers = ["X-Auth-Token": EndPointRouter.APIKey]
        _ = networkManager.request(
            url: EndPointRouter.getTeams(for: String(leagueId)),httpMethod: .get,
            parameters: nil, headers: headers) { [weak self] (result: APIResult<LeagueTeamsModel>) in
            guard let self = self else { return }
            self.view?.hideIndicator()
            switch result {
            case .success(let data):
                guard let teams = data.teams else {
                    self.view?.showError(error: "Data not founded")
                    return
                }
                self.teamsData = teams
                self.cach = false
                self.view?.fetchDataSuccess()
                DispatchQueue.main.async {
                    self.coreDataManager.cachTeamsData(teams, self.leagueId)
                }
            case .failure(let error):
                self.cach = true
                DispatchQueue.main.async {
                    self.cachedTeams = self.coreDataManager.loadTeams(for: self.leagueId)
                    guard !self.cachedTeams.isEmpty else {
                        self.view?.showError(error: error?.localizedDescription ?? "")
                        return
                    }
                    self.view?.fetchDataSuccess()
                }
            case .decodingFailure(let error):
                self.view?.showError(error: error?.localizedDescription ?? "")
            case .badRequest(let error):
                self.view?.showError(error: error?.localizedDescription ?? "")
            }
        }
    }
    
    func numberOfLeagues() -> Int {
        return cach ? cachedTeams.count : teamsData.count
    }
    
    func cellConfiguration(_ cell: TeamCellView, for item: Int) {
        if cach {
            let team = cachedTeams[item]
            cell.displayLogo(team.teamLogo)
            cell.displayLongName(team.teamName ?? "")
            if let shortName = team.teamShortName {
                cell.displayShortName(shortName, isHidden: false)
            } else {
                cell.displayShortName("", isHidden: true)
            }
        } else {
            let team = teamsData[item]
            cell.displayLogo(team.crestURL)
            cell.displayLongName(team.name)
            if let shortName = team.shortName {
                cell.displayShortName(shortName, isHidden: false)
            } else {
                cell.displayShortName("", isHidden: true)
            }
        }
    }
    
    func didSelectItem(at item: Int) {
        let teamId = cach ? Int(cachedTeams[item].teamId) : teamsData[item].id
        view?.navigateToTeamInformationScreen(with: teamId)
    }
}
