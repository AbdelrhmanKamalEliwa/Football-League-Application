//
//  LeaguesCoreDataManager.swift
//  Football League Application
//
//  Created by Abdelrhman Eliwa on 11/16/20.
//

import UIKit
import CoreData

class LeaguesCoreDataManager {
    
    func loadLeagues() -> [Leagues] {
        var leagues: [Leagues] = []
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            let persistentContainer = appDelegate.persistentContainer
            let managedContext = persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<Leagues>(entityName: "Leagues")
            do {
                leagues = try managedContext.fetch(fetchRequest)
                return leagues
            } catch let error as NSError {
                print("Could not fetch. \(error), \(error.userInfo)")
            }
        }
        return leagues
    }
    
    func saveLeagues(_ leagues: [Competition]) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        for league in leagues {
            let newLeague = NSEntityDescription.insertNewObject(forEntityName: "Leagues", into: managedContext)
            newLeague.setValue(league.id, forKeyPath: "leagueId")
            newLeague.setValue(league.name, forKeyPath: "leagueName")
            newLeague.setValue(league.code, forKeyPath: "leagueShortName")
            newLeague.setValue(0, forKeyPath: "numberOfGames")
            newLeague.setValue(0, forKeyPath: "numberOfTeams")
        }
        do {
            try managedContext.save()
        } catch {
            print(error)
        }
    }
    
    func updateLeagues(_ leagues: [Competition]) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<Leagues>(entityName: "Leagues")
        do {
            if let result = try? managedContext.fetch(request) {
                for i in 0...result.count - 1 {
                    result[i].setValue(leagues[i].id, forKeyPath: "leagueId")
                    result[i].setValue(leagues[i].name, forKeyPath: "leagueName")
                    result[i].setValue(leagues[i].code, forKeyPath: "leagueShortName")
                    result[i].setValue(0, forKeyPath: "numberOfGames")
                    result[i].setValue(0, forKeyPath: "numberOfTeams")
                }
            }
            try managedContext.save()
        } catch {
            print(error)
        }
    }
}
