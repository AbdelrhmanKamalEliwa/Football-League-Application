//
//  PlayersInfo+CoreDataProperties.swift
//  Football League Application
//
//  Created by Abdelrhman Eliwa on 11/17/20.
//
//

import Foundation
import CoreData


extension PlayersInfo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PlayersInfo> {
        return NSFetchRequest<PlayersInfo>(entityName: "PlayersInfo")
    }

    @NSManaged public var playerId: Int64
    @NSManaged public var playerName: String?
    @NSManaged public var playerNationality: String?
    @NSManaged public var playerPosition: String?
    @NSManaged public var teamInfoId: Int64

}

extension PlayersInfo : Identifiable {

}
