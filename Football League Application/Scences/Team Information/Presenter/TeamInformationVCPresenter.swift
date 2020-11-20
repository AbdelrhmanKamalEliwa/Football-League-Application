//
//  TeamInformationVCPresenter.swift
//  Football League Application
//
//  Created by Abdelrhman Eliwa on 11/14/20.
//

import Foundation

// MARK: - LeaguesView Protocol
protocol TeamInformationView: class {
    var presenter: TeamInformationVCPresenter? { get set }
    func showIndicator()
    func hideIndicator()
    func fetchDataSuccess()
    func showError(error: String)
}

// MARK: - TeamInfoCellView Protocol
protocol TeamInfoCellView {
    func displayLogoImage(_ imageUrl: String?)
    func displayTeamName(_ name: String, isHidden: Bool)
    func displayTeamArea(_ name: String, isHidden: Bool)
    func displayTeamAddress(_ address: String, isHidden: Bool)
    func displayTeamPhone(_ phone: String, isHidden: Bool)
    func displayTeamWebsite(_ website: String, isHidden: Bool)
    func displayTeamEmail(_ email: String, isHidden: Bool)
    func displayTeamFounded(_ founded: String, isHidden: Bool)
    func displayTeamVenue(_ venue: String, isHidden: Bool)
}

// MARK: - PlayerCellView Protocol
protocol PlayerCellView {
    func displayPlayerName(_ name: String)
    func displayPlayerPosition(_ position: String, isHidden: Bool)
    func displayPlayerNationality(_ nationality: String, isHidden: Bool)
}

class TeamInformationVCPresenter {
    // MARK: - Properties
    private weak var view: TeamInformationView?
    private let interactor: TeamInformationInteractor
    private let router: TeamInformationRouter
    private let teamId: Int
    private var cach = false
    private var teamInfoData: TeamInfoModel?
    private var cachedTeamInfoData: TeamInfo?
    private var cachedTeamInfoPlayers: [PlayersInfo] = []
    // MARK: - init
    init(view: TeamInformationView?, interactor: TeamInformationInteractor, router: TeamInformationRouter, teamId: Int) {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.teamId = teamId
    }
    
    // MARK: - Methods
    func viewDidLoad() {
        getTeams()
    }
    
    private func getTeams() {
        view?.showIndicator()
        interactor.getTeamInfo(for: teamId) { [weak self] (teamInfo, error) in
            guard let self = self else { return }
            self.view?.hideIndicator()
            if let error = error {
                self.cach = true
                DispatchQueue.main.async {
                    self.cachedTeamInfoData = self.interactor.loadCachedTeamInfo(for: self.teamId)
                    self.cachedTeamInfoPlayers = self.interactor.loadCachedTeamPlayers(for: self.teamId)
                    guard
                        let _ = self.cachedTeamInfoData,
                        !self.cachedTeamInfoPlayers.isEmpty else {
                        self.view?.showError(error: error.localizedDescription)
                        return
                    }
                    self.view?.fetchDataSuccess()
                }
            } else {
                guard let teamInfo = teamInfo else {
                    self.view?.showError(error: "Data not founded")
                    return
                }
                self.teamInfoData = teamInfo
                self.cach = false
                self.view?.fetchDataSuccess()
                DispatchQueue.main.async {
                    self.interactor.cachData(teamInfo, self.teamId)
                }
            }
        }
    }
    
    func titleForHeaderInSection(for section: Int) -> String {
        section == 1 ? "Players Information" : ""
    }
    
    func numberOfSections() -> Int { 2 }
    
    func numberOfRowsInSection(for section: Int) -> Int {
        section == 0 ? 1 : (cach ? cachedTeamInfoPlayers.count : (teamInfoData?.squad?.count ?? 0))
    }
    
    // MARK: - TeamInfo
    func teamInfoCellConfiguration(_ cell: TeamInfoCellView, for index: Int) {
        setTeamInfo(cell, for: index)
    }
    
    private func setTeamInfo(_ cell: TeamInfoCellView, for index: Int) {
        if cach {
            guard let teamInfo = cachedTeamInfoData else { return }
            cell.displayLogoImage(teamInfo.teamImageLogo)
            setTeamName(cell, teamInfo.teamName)
            setTeamAreaName(cell, teamInfo.teamArea)
            setTeamAddress(cell, teamInfo.teamAddress)
            setTeamWebsite(cell, teamInfo.teamWebsite)
            setTeamPhone(cell, teamInfo.teamPhone)
            setTeamEmail(cell, teamInfo.teamEmail)
            setTeamFounded(cell, Int(teamInfo.teamFounded))
            setTeamVenue(cell, teamInfo.teamVenue)
        } else {
            guard let teamInfo = teamInfoData else { return }
            cell.displayLogoImage(teamInfo.crestURL)
            setTeamName(cell, teamInfo.name)
            setTeamAreaName(cell, teamInfo.area?.name)
            setTeamAddress(cell, teamInfo.address)
            setTeamWebsite(cell, teamInfo.website)
            setTeamPhone(cell, teamInfo.phone)
            setTeamEmail(cell, teamInfo.email)
            setTeamFounded(cell, teamInfo.founded)
            setTeamVenue(cell, teamInfo.venue)
        }
    }
    
    private func setTeamName(_ cell: TeamInfoCellView,_ name: String?) {
        if let name = name {
            cell.displayTeamName(name, isHidden: false)
        } else {
            cell.displayTeamName("", isHidden: true)
        }
    }
    
    private func setTeamAreaName(_ cell: TeamInfoCellView,_ shortName: String?) {
        if let shortName = shortName {
            cell.displayTeamArea(shortName, isHidden: false)
        } else {
            cell.displayTeamArea("", isHidden: true)
        }
    }
    
    private func setTeamAddress(_ cell: TeamInfoCellView,_ address: String?) {
        if let address = address {
            cell.displayTeamAddress(address, isHidden: false)
        } else {
            cell.displayTeamAddress("", isHidden: true)
        }
    }
    
    private func setTeamWebsite(_ cell: TeamInfoCellView,_ website: String?) {
        if let website = website {
            cell.displayTeamWebsite(website, isHidden: false)
        } else {
            cell.displayTeamWebsite("", isHidden: true)
        }
    }
    
    private func setTeamPhone(_ cell: TeamInfoCellView,_ phone: String?) {
        if let phone = phone {
            cell.displayTeamPhone(phone, isHidden: false)
        } else {
            cell.displayTeamPhone("", isHidden: true)
        }
    }
    
    private func setTeamEmail(_ cell: TeamInfoCellView,_ email: String?) {
        if let email = email {
            cell.displayTeamEmail(email, isHidden: false)
        } else {
            cell.displayTeamEmail("", isHidden: true)
        }
    }
    
    private func setTeamFounded(_ cell: TeamInfoCellView,_ founded: Int?) {
        if let founded = founded {
            cell.displayTeamFounded(String(founded), isHidden: false)
        } else {
            cell.displayTeamFounded("", isHidden: true)
        }
    }
    
    private func setTeamVenue(_ cell: TeamInfoCellView,_ venue: String?) {
        if let venue = venue {
            cell.displayTeamVenue(venue, isHidden: false)
        } else {
            cell.displayTeamVenue("", isHidden: true)
        }
    }
    
    // MARK: - PlayersInfo
    func playerCellConfiguration(_ cell: PlayerCellView, for index: Int) {
        cach ? setCashedPlayerData(cell, for: index) : setPlayersData(cell, for: index)
    }
    
    private func setPlayersData(_ cell: PlayerCellView, for index: Int) {
        guard let players = teamInfoData?.squad else { return }
        let player = players[index]
        cell.displayPlayerName(player.name)
        
        if let position = player.position {
            cell.displayPlayerPosition(position, isHidden: false)
        } else {
            cell.displayPlayerPosition("", isHidden: true)
        }

        if let nationality = player.nationality {
            cell.displayPlayerNationality(nationality, isHidden: false)
        } else {
            cell.displayPlayerNationality("", isHidden: true)
        }
    }
    
    private func setCashedPlayerData(_ cell: PlayerCellView, for index: Int) {
        guard !cachedTeamInfoPlayers.isEmpty else { return }
        let player = cachedTeamInfoPlayers[index]
        cell.displayPlayerName(player.playerName ?? "")
        
        if let position = player.playerPosition {
            cell.displayPlayerPosition(position, isHidden: false)
        } else {
            cell.displayPlayerPosition("", isHidden: true)
        }

        if let nationality = player.playerNationality {
            cell.displayPlayerNationality(nationality, isHidden: false)
        } else {
            cell.displayPlayerNationality("", isHidden: true)
        }
    }
}
