//
//  TeamInformationVCPresenter.swift
//  Football League Application
//
//  Created by Abdelrhman Eliwa on 11/14/20.
//

import Foundation

//MARK: LeaguesView Protocol
protocol TeamInformationView: class {
    var presenter: TeamInformationVCPresenter? { get set }
    func showIndicator()
    func hideIndicator()
    func fetchDataSuccess()
    func showError(error: String)
}

//MARK: TeamInfoCellView Protocol
protocol TeamInfoCellView {
    func displayLogoImage(_ imageUrl: String?)
    func displayTeamName(_ name: String, isHidden: Bool)
    func displayTeamShortName(_ shortName: String, isHidden: Bool)
    func displayTeamAddress(_ address: String, isHidden: Bool)
    func displayTeamPhone(_ phone: String, isHidden: Bool)
    func displayTeamWebsite(_ website: String, isHidden: Bool)
    func displayTeamEmail(_ email: String, isHidden: Bool)
    func displayTeamFounded(_ founded: String, isHidden: Bool)
    func displayTeamVenue(_ venue: String, isHidden: Bool)
}

//MARK: PlayerCellView Protocol
protocol PlayerCellView {
    func displayPlayerName(_ name: String)
    func displayPlayerPosition(_ position: String, isHidden: Bool)
    func displayPlayerNationality(_ nationality: String, isHidden: Bool)
}

class TeamInformationVCPresenter {
    //MARK: Properties
    private weak var view: TeamInformationView?
    private let interactor: TeamInformationInteractor
    private let router: TeamInformationRouter
    private let teamId: Int
    private var teamInfoData: TeamInfoModel?
    
    //MARK: Init
    init(view: TeamInformationView?, interactor: TeamInformationInteractor, router: TeamInformationRouter, teamId: Int) {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.teamId = teamId
    }
    
    //MARK: Methods
    func viewDidLoad() {
        getTeams()
    }
    
    private func getTeams() {
        view?.showIndicator()
        interactor.getTeamInfo(for: teamId) { [weak self] (teamInfo, error) in
            guard let self = self else { return }
            self.view?.hideIndicator()
            if let error = error {
                self.view?.showError(error: error.localizedDescription)
            } else {
                guard let teamInfo = teamInfo else {
                    self.view?.showError(error: "Data not founded")
                    return
                }
                self.teamInfoData = teamInfo
                self.view?.fetchDataSuccess()
            }
        }
    }
    
    func titleForHeaderInSection(for section: Int) -> String {
        if section == 1 {
            return "Players Information"
        } else {
            return ""
        }
    }
    
    func numberOfSections() -> Int { 2 }
    
    func numberOfRowsInSection(for section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return teamInfoData?.squad?.count ?? 0
        }
    }
    
    func teamInfoCellConfiguration(_ cell: TeamInfoCellView, for index: Int) {
        guard let teamInfo = teamInfoData else { return }
        cell.displayLogoImage(teamInfo.crestURL)
        
        if let name = teamInfo.name {
            cell.displayTeamName(name, isHidden: false)
        } else {
            cell.displayTeamName("", isHidden: true)
        }
        
        if let shortName = teamInfo.shortName {
            cell.displayTeamShortName(shortName, isHidden: false)
        } else {
            cell.displayTeamShortName("", isHidden: true)
        }
        
        if let address = teamInfo.address {
            cell.displayTeamAddress(address, isHidden: false)
        } else {
            cell.displayTeamAddress("", isHidden: true)
        }
        
        if let phone = teamInfo.phone {
            cell.displayTeamPhone(phone, isHidden: false)
        } else {
            cell.displayTeamPhone("", isHidden: true)
        }
        
        if let email = teamInfo.email {
            cell.displayTeamEmail(email, isHidden: false)
        } else {
            cell.displayTeamEmail("", isHidden: true)
        }
        
        if let founded = teamInfo.founded {
            cell.displayTeamFounded(String(founded), isHidden: false)
        } else {
            cell.displayTeamFounded("", isHidden: true)
        }
        
        if let venue = teamInfo.venue {
            cell.displayTeamVenue(venue, isHidden: false)
        } else {
            cell.displayTeamVenue("", isHidden: true)
        }
    }
    
    func playerCellConfiguration(_ cell: PlayerCellView, for index: Int) {
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
}
