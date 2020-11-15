//
//  LeagueMatchsModel.swift
//  Football League Application
//
//  Created by Abdelrhman Eliwa on 11/14/20.
//

import Foundation

// MARK: - LeagueMatchsModel
struct LeagueMatchsModel: Codable {
    let count: Int
    let filters: Filters
    let competition: LeagueMatchsCompetition
    let matches: [Match]
}

// MARK: - Competition
struct LeagueMatchsCompetition: Codable {
    let id: Int
    let area: LeagueMatchsArea
    let name, code, plan: String
    let lastUpdated: String?
}

// MARK: - Area
struct LeagueMatchsArea: Codable {
    let id: Int
    let name: String
}

// MARK: - Match
struct Match: Codable {
    let id: Int
    let season: LeagueMatchsSeason
    let utcDate: String?
    let status: Status
    let matchday: Int?
    let stage: Stage
    let group: String?
    let lastUpdated: String?
    let odds: Odds
    let score: Score
    let homeTeam, awayTeam: Area
    let referees: [Referee]
}

// MARK: - Odds
struct Odds: Codable {
    let msg: Msg
}

enum Msg: String, Codable {
    case activateOddsPackageInUserPanelToRetrieveOdds = "Activate Odds-Package in User-Panel to retrieve odds."
}

// MARK: - Referee
struct Referee: Codable {
    let id: Int
    let name, nationality: String?
}

// MARK: - Score
struct Score: Codable {
    let winner: LeagueMatchsWinner?
    let duration: Duration
    let fullTime, halfTime, extraTime, penalties: ExtraTime
}

enum Duration: String, Codable {
    case extraTime = "EXTRA_TIME"
    case penaltyShootout = "PENALTY_SHOOTOUT"
    case regular = "REGULAR"
}

// MARK: - ExtraTime
struct ExtraTime: Codable {
    let homeTeam, awayTeam: Int?
}

enum LeagueMatchsWinner: String, Codable {
    case awayTeam = "AWAY_TEAM"
    case draw = "DRAW"
    case homeTeam = "HOME_TEAM"
}

// MARK: - Season
struct LeagueMatchsSeason: Codable {
    let id: Int
    let startDate, endDate: String
    let currentMatchday: Int
}

enum Stage: String, Codable {
    case groupStage = "GROUP_STAGE"
    case playOffRound = "PLAY_OFF_ROUND"
    case preliminaryFinal = "PRELIMINARY_FINAL"
    case preliminarySemiFinals = "PRELIMINARY_SEMI_FINALS"
    case the1StQualifyingRound = "1ST_QUALIFYING_ROUND"
    case the2NdQualifyingRound = "2ND_QUALIFYING_ROUND"
    case the3RDQualifyingRound = "3RD_QUALIFYING_ROUND"
}

enum Status: String, Codable {
    case awarded = "AWARDED"
    case finished = "FINISHED"
    case scheduled = "SCHEDULED"
}
