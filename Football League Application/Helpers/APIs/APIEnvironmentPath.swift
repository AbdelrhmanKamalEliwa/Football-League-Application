//
//  APIEnvironmentPath.swift
//  Football League Application
//
//  Created by Abdelrhman Eliwa on 11/12/20.
//

import Foundation

struct APIService {
    static func baseURL() -> String {
        return APIEnvironmentPath.production.scheme() + APIEnvironmentPath.production.host() + "/v2/"
    }
}

enum APIEnvironmentPath {
    
    case development
    case testing
    case production
    
    func scheme() -> String {
        switch self {
        case .development:
            return "http://"
        case .testing:
            return "http://"
        case .production:
            return "https://"
        }
    }
    
    func host() -> String {
        switch self {
        case .development:
            return "api.football-data.org"
        case .testing:
            return "api.football-data.org"
        case .production:
            return "api.football-data.org"
        }
    }
    
}
