//
//  Teams+CoreDataProperties.swift
//  Football League Application
//
//  Created by Abdelrhman Eliwa on 11/19/20.
//
//

import Foundation
import CoreData


extension Teams {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Teams> {
        return NSFetchRequest<Teams>(entityName: "Teams")
    }

    @NSManaged public var leagueId: Int64
    @NSManaged public var teamId: Int64
    @NSManaged public var teamLogo: String?
    @NSManaged public var teamName: String?
    @NSManaged public var teamShortName: String?
    @NSManaged public var league: Leagues?
    @NSManaged public var teamInfo: TeamInfo?

}

extension Teams : Identifiable {

}
