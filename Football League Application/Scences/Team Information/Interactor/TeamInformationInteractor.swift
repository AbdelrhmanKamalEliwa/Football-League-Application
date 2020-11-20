//
//  TeamInformationInteractor.swift
//  Football League Application
//
//  Created by Abdelrhman Eliwa on 11/14/20.
//

import Foundation

class TeamInformationInteractor {
    private let networkManager = NetworkManager()
    private let coreDataManager = CoreDataManager()
    
    func getTeamInfo(for teamId: Int, completionHandler: @escaping (TeamInfoModel?, Error?) -> ()) {
        let headers = ["X-Auth-Token": EndPointRouter.APIKey]
        _ = networkManager.request(
            url: EndPointRouter.getTeamInfo(for: String(teamId)),httpMethod: .get,
            parameters: nil, headers: headers) { (result: APIResult<TeamInfoModel>) in
            switch result {
            case .success(let data):
                completionHandler(data, nil)
            case .failure(let error):
                completionHandler(nil, error)
            case .decodingFailure(let error):
                completionHandler(nil, error)
            case .badRequest(let error):
                completionHandler(nil, error)
            }
        }
    }
    
    func cachData(_ teamInfo: TeamInfoModel, _ teamId: Int) {
        coreDataManager.cachTeamInfoData(teamInfo, teamId)
    }
    
    func loadCachedTeamInfo(for teamId: Int) -> TeamInfo? {
        coreDataManager.loadTeamInfo(for: teamId)
    }
    
    func loadCachedTeamPlayers(for teamId: Int) -> [PlayersInfo] {
        coreDataManager.loadTeamPlayers(for: teamId)
    }
}
