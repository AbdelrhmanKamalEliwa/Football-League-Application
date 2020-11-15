//
//  LeagueTeamsModel.swift
//  Football League Application
//
//  Created by Abdelrhman Eliwa on 11/14/20.
//

import Foundation

// MARK: - LeagueTeamsModel
struct LeagueTeamsModel: Codable {
    let count: Int?
    let filters: Filters?
    let competition: LeagueTeamsCompetition?
    let season: LeagueTeamsSeason?
    let teams: [Team]?
}

// MARK: - Competition
struct LeagueTeamsCompetition: Codable {
    let id: Int
    let area: LeagueTeamsArea?
    let name: String
    let code: String?
    let plan: String?
    let lastUpdated: String?
}

// MARK: - Area
struct LeagueTeamsArea: Codable {
    let id: Int
    let name: String
}

// MARK: - Season
struct LeagueTeamsSeason: Codable {
    let id: Int
    let startDate, endDate: String
    let currentMatchday: Int?
    let winner: LeagueTeamsWinner?
}

// MARK: - Winner
struct LeagueTeamsWinner: Codable {
    let id: Int
    let name: String
    let shortName: String?
    let tla: String?
    let crestURL: String?

    enum CodingKeys: String, CodingKey {
        case id, name, shortName, tla
        case crestURL = "crestUrl"
    }
}

// MARK: - Team
struct Team: Codable {
    let id: Int
    let area: Area
    let name: String
    let shortName: String?
    let tla: String?
    let crestURL: String?
    let address, phone: String?
    let website: String?
    let email: String?
    let founded: Int?
    let clubColors: String?
    let venue: String?
    let lastUpdated: String?

    enum CodingKeys: String, CodingKey {
        case id, area, name, shortName, tla
        case crestURL = "crestUrl"
        case address, phone, website, email, founded, clubColors, venue, lastUpdated
    }
}
