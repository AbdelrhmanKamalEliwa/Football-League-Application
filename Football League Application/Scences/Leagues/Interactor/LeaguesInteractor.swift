//
//  LeaguesInteractor.swift
//  Football League Application
//
//  Created by Abdelrhman Eliwa on 11/13/20.
//

import Foundation

class LeaguesInteractor {
    private let networkManager = NetworkManager()
    private let coreDataManager = CoreDataManager()
    
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
        coreDataManager.cachLeaguesData(leagues)
    }
    
    func loadCachedData() -> [Leagues] {
        coreDataManager.loadLeagues() ?? []
    }
}
