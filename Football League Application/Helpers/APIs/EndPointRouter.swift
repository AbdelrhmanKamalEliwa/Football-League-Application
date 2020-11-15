//
//  EndPointRouter.swift
//  Football League Application
//
//  Created by Abdelrhman Eliwa on 11/12/20.
//

import Foundation

struct EndPointRouter {
    
    static var APIKey: String {
        return APIService.APIKey()
    }
    
    static var getLeagues: URL {
        return URL(string: APIService.baseURL() + "competitions/")!
    }
    
    static func getMatchs(for leagueId: String) -> URL {
        return URL(string: APIService.baseURL() + "competitions/" + "\(leagueId)" + "/matches")!
    }
    
    static func getTeams(for leagueId: String) -> URL {
        return URL(string: APIService.baseURL() + "competitions/" + "\(leagueId)" + "/teams")!
    }
    
    static func getTeamInfo(for teamId: String) -> URL {
        return URL(string: APIService.baseURL() + "teams/" + "\(teamId)")!
    }
}
