//
//  LeagueDetailsVCInteractor.swift
//  Football League Application
//
//  Created by Abdelrhman Eliwa on 11/14/20.
//

import Foundation

class LeagueDetailsInteractor {
    let networkManager = NetworkManager()
    
    func getLeagueTeams(for leagueId: Int, completionHandler: @escaping (LeagueTeamsModel?, Error?) -> ()) {
        let headers = ["X-Auth-Token": EndPointRouter.APIKey]
        _ = networkManager.request(
            url: EndPointRouter.getTeams(for: String(leagueId)),httpMethod: .get,
            parameters: nil, headers: headers) { (result: APIResult<LeagueTeamsModel>) in
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
}
