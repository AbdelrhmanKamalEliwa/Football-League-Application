//
//  TeamInfoModel.swift
//  Football League Application
//
//  Created by Abdelrhman Eliwa on 11/14/20.
//

import Foundation

// MARK: - TeamInfoModel
struct TeamInfoModel: Codable {
    let id: Int
    let area: TeamInfoArea?
    let activeCompetitions: [ActiveCompetition]?
    let name: String?
    let shortName: String?
    let tla: String?
    let crestURL: String
    let address: String?
    let phone: String?
    let website: String?
    let email: String?
    let founded: Int?
    let clubColors: String?
    let venue: String?
    let squad: [Squad]?
    let lastUpdated: String?

    enum CodingKeys: String, CodingKey {
        case id, area, activeCompetitions, name, shortName, tla
        case crestURL = "crestUrl"
        case address, phone, website, email, founded, clubColors, venue, squad, lastUpdated
    }
}

// MARK: - ActiveCompetition
struct ActiveCompetition: Codable {
    let id: Int
    let area: TeamInfoArea?
    let name: String?
    let code: String?
    let plan: String?
    let lastUpdated: String?
}

// MARK: - Area
struct TeamInfoArea: Codable {
    let id: Int
    let name: String?
}

// MARK: - Squad
struct Squad: Codable {
    let id: Int
    let name: String
    let position: String?
    let dateOfBirth: String?
    let countryOfBirth: String?
    let nationality: String?
    let shirtNumber: Int?
    let role: String?
}
