//
//  LeaguesModel.swift
//  Football League Application
//
//  Created by Abdelrhman Eliwa on 11/13/20.
//

import Foundation

struct LeaguesModel: Codable {
    let count: Int
    let filters: Filters?
    let competitions: [Competition]
}

struct Filters: Codable {}

struct Competition: Codable {
    let id: Int
    let area: Area?
    let name: String
    let code: String?
    let emblemUrl: String?
    let plan: String?
    let currentSeason: CurrentSeason?
    let numberOfAvailableSeasons: Int
    let lastUpdated: String?
}

struct Area: Codable {
    let id: Int?
    let name: String?
    let countryCode: String?
    let ensignUrl: String?
}

struct CurrentSeason: Codable {
    let id: Int?
    let startDate: String?
    let endDate: String?
    let currentMatchday: Int?
    let winner: Winner?
}

struct Winner: Codable {
    let id: Int?
    let name: String?
    let shortName: String?
    let tla: String?
    let crestUrl: String?
}
