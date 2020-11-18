//
//  Leagues+CoreDataProperties.swift
//  Football League Application
//
//  Created by Abdelrhman Eliwa on 11/17/20.
//
//

import Foundation
import CoreData


extension Leagues {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Leagues> {
        return NSFetchRequest<Leagues>(entityName: "Leagues")
    }

    @NSManaged public var leagueId: Int64
    @NSManaged public var leagueName: String?
    @NSManaged public var leagueShortName: String?
    @NSManaged public var numberOfGames: Int64
    @NSManaged public var numberOfTeams: Int64
    @NSManaged public var teams: NSSet?

}

// MARK: Generated accessors for teams
extension Leagues {

    @objc(addTeamsObject:)
    @NSManaged public func addToTeams(_ value: Teams)

    @objc(removeTeamsObject:)
    @NSManaged public func removeFromTeams(_ value: Teams)

    @objc(addTeams:)
    @NSManaged public func addToTeams(_ values: NSSet)

    @objc(removeTeams:)
    @NSManaged public func removeFromTeams(_ values: NSSet)

}

extension Leagues : Identifiable {

}
