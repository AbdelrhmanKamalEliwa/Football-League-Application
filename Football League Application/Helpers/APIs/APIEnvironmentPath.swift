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
    
    static func APIKey() -> String {
        return APIEnvironmentPath.production.APIKey()
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
    
    func APIKey() -> String {
        switch self {
        case .development:
            return "4093bfc758f041999f47b64337281f25"
        case .testing:
            return "4093bfc758f041999f47b64337281f25"
        case .production:
            return "4093bfc758f041999f47b64337281f25"
        }
    }
    
}
