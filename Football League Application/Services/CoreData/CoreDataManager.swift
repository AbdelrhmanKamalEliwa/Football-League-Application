//
//  CoreDataManager.swift
//  Football League Application
//
//  Created by Abdelrhman Eliwa on 11/18/20.
//

import UIKit
import CoreData

class CoreDataManager {
    // MARK: - Properties
    private let defaults = UserDefaults.standard
    final var managedContext: NSManagedObjectContext? {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            let managedContext = appDelegate.persistentContainer.viewContext
            return managedContext
        } else {
            return nil
        }
    }
}

// MARK: - Leagues Queries
extension CoreDataManager {
    // MARK: Load Leagues
    func loadLeagues() -> [Leagues]? {
        guard let managedContext = managedContext else { return nil }
        let fetchRequest = NSFetchRequest<Leagues>(entityName: "Leagues")
        do {
            let leagues = try managedContext.fetch(fetchRequest)
            return leagues
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return nil
    }
    
    // MARK: Cach Leagues Data
    func cachLeaguesData(_ leagues: [Competition]) {
        if let leaguesCachStatus = defaults.object(forKey: "LeaguesCachingStatus") as? Bool {
            if leaguesCachStatus {
                updateLeagues(leagues)
                defaults.setValue(true, forKey: "LeaguesCachingStatus")
            } else {
                saveLeagues(leagues)
                defaults.setValue(true, forKey: "LeaguesCachingStatus")
            }
        } else {
            saveLeagues(leagues)
            defaults.setValue(true, forKey: "LeaguesCachingStatus")
        }
    }
    
    // MARK: Save Leagues
    func saveLeagues(_ leagues: [Competition]) {
        guard let managedContext = managedContext else { return }
        for league in leagues {
            let newLeague = NSEntityDescription.insertNewObject(forEntityName: "Leagues", into: managedContext)
            newLeague.setValue(league.id, forKeyPath: "leagueId")
            newLeague.setValue(league.name, forKeyPath: "leagueName")
            newLeague.setValue(league.code, forKeyPath: "areaName")
            newLeague.setValue(league.currentSeason?.startDate, forKeyPath: "startDate")
            newLeague.setValue(league.currentSeason?.endDate, forKeyPath: "endDate")
        }
        do {
            try managedContext.save()
        } catch {
            print(error)
        }
    }
    
    // MARK: Update Leagues
    func updateLeagues(_ leagues: [Competition]) {
        guard let managedContext = managedContext else { return }
        let request = NSFetchRequest<Leagues>(entityName: "Leagues")
        do {
            if let result = try? managedContext.fetch(request) {
                for i in 0...result.count - 1 {
                    result[i].setValue(leagues[i].id, forKeyPath: "leagueId")
                    result[i].setValue(leagues[i].name, forKeyPath: "leagueName")
                    result[i].setValue(leagues[i].code, forKeyPath: "areaName")
                    result[i].setValue(leagues[i].currentSeason?.startDate, forKeyPath: "startDate")
                    result[i].setValue(leagues[i].currentSeason?.endDate, forKeyPath: "endDate")
                }
            }
            try managedContext.save()
        } catch {
            print(error)
        }
    }
}

// MARK: - Teams Queries
extension CoreDataManager {
    // MARK: Load Teams
    func loadTeams(for leagueId: Int) -> [Teams] {
        var teams: [Teams] = []
        guard let managedContext = managedContext else { return teams }
        let fetchRequest = NSFetchRequest<Teams>(entityName: "Teams")
        do {
            let fetchedTeams = try managedContext.fetch(fetchRequest)
            for team in fetchedTeams {
                if team.leagueId == leagueId {
                    teams.append(team)
                }
            }
            teams.sort { (team1, team2) -> Bool in
                team1.teamId < team2.teamId
            }
            return teams
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return teams
    }
    
    // MARK: Cach Leagues Data
    func cachTeamsData(_ teams: [Team], _ leagueId: Int) {
        if let teamsCachStatus = defaults.object(forKey: "TeamsCachingStatus\(leagueId)") as? Bool {
            if teamsCachStatus {
                updateTeams(teams, for: leagueId)
                defaults.setValue(true, forKey: "TeamsCachingStatus\(leagueId)")
            } else {
                saveTeams(teams, for: leagueId)
                defaults.setValue(true, forKey: "TeamsCachingStatus\(leagueId)")
            }
        } else {
            saveTeams(teams, for: leagueId)
            defaults.setValue(true, forKey: "TeamsCachingStatus\(leagueId)")
        }
    }
    
    // MARK: Save Teams
    func saveTeams(_ teams: [Team], for leagueId: Int) {
        guard let managedContext = managedContext else { return }
        for team in teams {
            let newTeam = NSEntityDescription.insertNewObject(forEntityName: "Teams", into: managedContext)
            newTeam.setValue(leagueId, forKeyPath: "leagueId")
            newTeam.setValue(team.id, forKeyPath: "teamId")
            newTeam.setValue(team.name, forKeyPath: "teamName")
            newTeam.setValue(team.shortName, forKeyPath: "teamShortName")
            newTeam.setValue(team.crestURL, forKeyPath: "teamLogo")
        }
        do {
            try managedContext.save()
        } catch {
            print(error)
        }
    }
    
    // MARK: Update Teams
    func updateTeams(_ teams: [Team], for leagueId: Int) {
        var fetchedTeams: [Teams] = []
        guard let managedContext = managedContext else { return }
        let request = NSFetchRequest<Teams>(entityName: "Teams")
        do {
            if let result = try? managedContext.fetch(request) {
                for i in 0...result.count - 1 {
                    if result[i].leagueId == leagueId {
                        fetchedTeams.append(result[i])
                    }
                }
                for i in 0...fetchedTeams.count - 1 {
                    result[i].setValue(teams[i].id, forKeyPath: "teamId")
                    result[i].setValue(teams[i].name, forKeyPath: "teamName")
                    result[i].setValue(teams[i].shortName, forKeyPath: "teamShortName")
                    result[i].setValue(teams[i].crestURL, forKeyPath: "teamLogo")
                }
            }
            try managedContext.save()
        } catch {
            print(error)
        }
    }
}

// MARK: - Team Info Queries
extension CoreDataManager {
    // MARK: Load Team Info
    func loadTeamInfo(for teamId: Int) -> TeamInfo? {
        var teamInfo: TeamInfo?
        guard let managedContext = managedContext else { return teamInfo }
        let fetchRequest = NSFetchRequest<TeamInfo>(entityName: "TeamInfo")
        do {
            let fetchedTeamsInfo = try managedContext.fetch(fetchRequest)
            for info in fetchedTeamsInfo {
                if info.teamId == teamId {
                    teamInfo = info
                }
            }
            return teamInfo
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        return teamInfo
    }
    
    // MARK: Cach Team Info
    func cachTeamInfoData(_ teamInfo: TeamInfoModel, _ teamId: Int) {
        if let teamsInfoCachStatus = defaults.object(forKey: "TeamsInfoCachingStatus\(teamId)") as? Bool {
            if teamsInfoCachStatus {
                updateTeamsInfo(teamInfo, for: teamId)
                defaults.setValue(true, forKey: "TeamsInfoCachingStatus\(teamId)")
            } else {
                saveTeamsInfo(teamInfo)
                defaults.setValue(true, forKey: "TeamsInfoCachingStatus\(teamId)")
            }
        } else {
            saveTeamsInfo(teamInfo)
            defaults.setValue(true, forKey: "TeamsInfoCachingStatus\(teamId)")
        }
    }
    
    // MARK: Save Team Info
    func saveTeamsInfo(_ teamInfo: TeamInfoModel) {
        guard let managedContext = managedContext else { return }
        let newTeamInfo = NSEntityDescription.insertNewObject(forEntityName: "TeamInfo", into: managedContext)
        newTeamInfo.setValue(teamInfo.id, forKeyPath: "teamId")
        newTeamInfo.setValue(teamInfo.name, forKeyPath: "teamName")
        newTeamInfo.setValue(teamInfo.area?.name, forKeyPath: "teamArea")
        newTeamInfo.setValue(teamInfo.crestURL, forKeyPath: "teamImageLogo")
        newTeamInfo.setValue(teamInfo.address, forKeyPath: "teamAddress")
        newTeamInfo.setValue(teamInfo.email, forKeyPath: "teamEmail")
        newTeamInfo.setValue(teamInfo.phone, forKeyPath: "teamPhone")
        newTeamInfo.setValue(teamInfo.website, forKeyPath: "teamWebsite")
        newTeamInfo.setValue(teamInfo.founded, forKeyPath: "teamFounded")
        newTeamInfo.setValue(teamInfo.venue, forKeyPath: "teamVenue")
        saveTeamsPlayers(teamInfo.squad, for: teamInfo.id)
        do {
            try managedContext.save()
        } catch {
            print(error)
        }
    }
    
    // MARK: Update Team Info
    func updateTeamsInfo(_ teamInfo: TeamInfoModel, for teamId: Int) {
        var fetchedTeamInfo: TeamInfo?
        guard let managedContext = managedContext else { return }
        let request = NSFetchRequest<TeamInfo>(entityName: "TeamInfo")
        do {
            if let result = try? managedContext.fetch(request) {
                for i in 0...result.count - 1 {
                    if result[i].teamId == teamId {
                        fetchedTeamInfo = result[i]
                    }
                }
                fetchedTeamInfo?.setValue(teamInfo.id, forKeyPath: "teamId")
                fetchedTeamInfo?.setValue(teamInfo.name, forKeyPath: "teamName")
                fetchedTeamInfo?.setValue(teamInfo.area?.name, forKeyPath: "teamArea")
                fetchedTeamInfo?.setValue(teamInfo.crestURL, forKeyPath: "teamImageLogo")
                fetchedTeamInfo?.setValue(teamInfo.address, forKeyPath: "teamAddress")
                fetchedTeamInfo?.setValue(teamInfo.email, forKeyPath: "teamEmail")
                fetchedTeamInfo?.setValue(teamInfo.phone, forKeyPath: "teamPhone")
                fetchedTeamInfo?.setValue(teamInfo.website, forKeyPath: "teamWebsite")
                fetchedTeamInfo?.setValue(teamInfo.founded, forKeyPath: "teamFounded")
                fetchedTeamInfo?.setValue(teamInfo.venue, forKeyPath: "teamVenue")
                updateTeamsPlayers(teamInfo.squad, for: teamInfo.id)
            }
            try managedContext.save()
        } catch {
            print(error)
        }
    }
}

// MARK: - Team Players Queries
extension CoreDataManager {
    // MARK: Load Team Players
    func loadTeamPlayers(for teamId: Int) -> [PlayersInfo] {
        var players: [PlayersInfo] = []
        guard let managedContext = managedContext else { return players }
        let fetchRequest = NSFetchRequest<PlayersInfo>(entityName: "PlayersInfo")
        do {
            let fetchedPlayers = try managedContext.fetch(fetchRequest)
            for player in fetchedPlayers {
                if player.teamInfoId == teamId {
                    players.append(player)
                }
            }
            return players
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return players
    }
    
    // MARK: Save Team Players
    private func saveTeamsPlayers(_ squad: [Squad]?, for teamInfoId: Int) {
        guard let managedContext = managedContext else { return }
        guard let squad = squad else { return }
        for player in squad {
            let newPlayer = NSEntityDescription.insertNewObject(forEntityName: "PlayersInfo", into: managedContext)
            newPlayer.setValue(teamInfoId, forKeyPath: "teamInfoId")
            newPlayer.setValue(player.id, forKeyPath: "playerId")
            newPlayer.setValue(player.name, forKeyPath: "playerName")
            newPlayer.setValue(player.position, forKeyPath: "playerPosition")
            newPlayer.setValue(player.nationality, forKeyPath: "playerNationality")
        }
        do {
            try managedContext.save()
        } catch {
            print(error)
        }
    }
    
    // MARK: Update Team Players
    private func updateTeamsPlayers(_ squad: [Squad]?, for teamInfoId: Int) {
        var fetchedSquad: [PlayersInfo] = []
        guard let managedContext = managedContext else { return }
        let request = NSFetchRequest<PlayersInfo>(entityName: "PlayersInfo")
        do {
            if let result = try? managedContext.fetch(request) {
                for i in 0...result.count - 1 {
                    if result[i].teamInfoId == teamInfoId {
                        fetchedSquad.append(result[i])
                    }
                }
                guard let squad = squad else { return }
                for i in 0...fetchedSquad.count - 1 {
                    result[i].setValue(squad[i].id, forKeyPath: "playerId")
                    result[i].setValue(squad[i].name, forKeyPath: "playerName")
                    result[i].setValue(squad[i].position, forKeyPath: "playerPosition")
                    result[i].setValue(squad[i].nationality, forKeyPath: "playerNationality")
                }
            }
            try managedContext.save()
        } catch {
            print(error)
        }
    }
}
