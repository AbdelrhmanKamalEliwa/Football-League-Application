//
//  LeaguesInteractor.swift
//  Football League Application
//
//  Created by Abdelrhman Eliwa on 11/13/20.
//

import Foundation

class LeaguesInteractor {
    private let networkManager = NetworkManager()
    private let leaguesCoreDataManager = LeaguesCoreDataManager()
    private let defaults = UserDefaults.standard
    
    func getLeagues(completionHandler: @escaping (LeaguesModel?, Error?) -> ()) {
        _ = networkManager.request(
            url: EndPointRouter.getLeagues, httpMethod: .get,
            parameters: nil, headers: nil) { (result: APIResult<LeaguesModel>) in
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
    
    func cachData(_ leagues: [Competition]) {
        if let leaguesCachStatus = defaults.object(forKey: "LeaguesCachingStatus") as? Bool {
            if leaguesCachStatus {
                leaguesCoreDataManager.updateLeagues(leagues)
                defaults.setValue(true, forKey: "LeaguesCachingStatus")
            } else {
                leaguesCoreDataManager.saveLeagues(leagues)
                defaults.setValue(true, forKey: "LeaguesCachingStatus")
            }
        } else {
            leaguesCoreDataManager.saveLeagues(leagues)
            defaults.setValue(true, forKey: "LeaguesCachingStatus")
        }
    }
    
    func loadCachedData() -> [Leagues] {
        leaguesCoreDataManager.loadLeagues()
    }
//    func getLeagueMatches(for leagueId: Int, completionHandler: @escaping (LeaguesModel?, Error?) -> ()) {
//        let headers = ["X-Auth-Token": EndPointRouter.APIKey]
//        _ = networkManager.request(
//            url: EndPointRouter.getMatchs(for: String(leagueId)),httpMethod: .get,
//            parameters: nil, headers: headers) { (result: APIResult<LeaguesModel>) in
//            switch result {
//            case .success(let data):
//                completionHandler(data, nil)
//            case .failure(let error):
//                completionHandler(nil, error)
//            case .decodingFailure(let error):
//                completionHandler(nil, error)
//            case .badRequest(let error):
//                completionHandler(nil, error)
//            }
//        }
//    }
//    
//    func getLeagueTeams(for leagueId: Int, completionHandler: @escaping (LeaguesModel?, Error?) -> ()) {
//        let headers = ["X-Auth-Token": EndPointRouter.APIKey]
//        _ = networkManager.request(
//            url: EndPointRouter.getTeams(for: String(leagueId)),httpMethod: .get,
//            parameters: nil, headers: headers) { (result: APIResult<LeaguesModel>) in
//            switch result {
//            case .success(let data):
//                completionHandler(data, nil)
//            case .failure(let error):
//                completionHandler(nil, error)
//            case .decodingFailure(let error):
//                completionHandler(nil, error)
//            case .badRequest(let error):
//                completionHandler(nil, error)
//            }
//        }
//    }
}
