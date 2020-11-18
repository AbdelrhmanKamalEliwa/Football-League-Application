//
//  TeamsCoreDataManager.swift
//  Football League Application
//
//  Created by Abdelrhman Eliwa on 11/16/20.
//

import UIKit
import CoreData

class TeamsCoreDataManager {
    
    func loadTeams(for leagueId: Int) -> [Teams] {
        var teams: [Teams] = []
        var fetchedTeams: [Teams] = []
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            let persistentContainer = appDelegate.persistentContainer
            let managedContext = persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<Teams>(entityName: "Teams")
            do {
                fetchedTeams = try managedContext.fetch(fetchRequest)
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
        }
        return teams
    }
    
    func saveTeams(_ teams: [Team], for leagueId: Int) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
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
    
    func updateTeams(_ teams: [Team], for leagueId: Int) {
        var fetchedTeams: [Teams] = []
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
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
