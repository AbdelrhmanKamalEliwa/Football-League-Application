//
//  TeamInfoCoreData.swift
//  Football League Application
//
//  Created by Abdelrhman Eliwa on 11/17/20.
//

import UIKit
import CoreData

class TeamInfoCoreDataManager {
    
    func loadTeamInfo(for teamId: Int) -> TeamInfo? {
        var teamInfo: TeamInfo?
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            let persistentContainer = appDelegate.persistentContainer
            let managedContext = persistentContainer.viewContext
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
        }
        return teamInfo
    }
    
    func loadTeamPlayers(for teamId: Int) -> [PlayersInfo] {
        var players: [PlayersInfo] = []
        var fetchedPlayers: [PlayersInfo] = []
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            let persistentContainer = appDelegate.persistentContainer
            let managedContext = persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<PlayersInfo>(entityName: "PlayersInfo")
            do {
                fetchedPlayers = try managedContext.fetch(fetchRequest)
                for player in fetchedPlayers {
                    if player.teamInfoId == teamId {
                        players.append(player)
                    }
                }
                return players
            } catch let error as NSError {
                print("Could not fetch. \(error), \(error.userInfo)")
            }
        }
        return players
    }
    
    func saveTeamsInfo(_ teamInfo: TeamInfoModel) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
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
    
    private func saveTeamsPlayers(_ squad: [Squad]?, for teamInfoId: Int) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
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
    
    func updateTeamsInfo(_ teamInfo: TeamInfoModel, for teamId: Int) {
        var fetchedTeamInfo: TeamInfo?
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
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
    
    private func updateTeamsPlayers(_ squad: [Squad]?, for teamInfoId: Int) {
        var fetchedSquad: [PlayersInfo] = []
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
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
