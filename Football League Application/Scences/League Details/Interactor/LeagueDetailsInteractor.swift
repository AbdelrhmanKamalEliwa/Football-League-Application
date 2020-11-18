//
//  LeagueDetailsVCInteractor.swift
//  Football League Application
//
//  Created by Abdelrhman Eliwa on 11/14/20.
//

import Foundation

class LeagueDetailsInteractor {
    private let networkManager = NetworkManager()
    private let teamsCoreDataManager = TeamsCoreDataManager()
    private let defaults = UserDefaults.standard
    
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
    
    func cachData(_ teams: [Team], _ leagueId: Int) {
        if let teamsCachStatus = defaults.object(forKey: "TeamsCachingStatus\(leagueId)") as? Bool {
            if teamsCachStatus {
                teamsCoreDataManager.updateTeams(teams, for: leagueId)
                defaults.setValue(true, forKey: "TeamsCachingStatus\(leagueId)")
            } else {
                teamsCoreDataManager.saveTeams(teams, for: leagueId)
                defaults.setValue(true, forKey: "TeamsCachingStatus\(leagueId)")
            }
        } else {
            teamsCoreDataManager.saveTeams(teams, for: leagueId)
            defaults.setValue(true, forKey: "TeamsCachingStatus\(leagueId)")
        }
    }
    
    func loadCachedData(for leagueId: Int) -> [Teams] {
        teamsCoreDataManager.loadTeams(for: leagueId)
    }
}
