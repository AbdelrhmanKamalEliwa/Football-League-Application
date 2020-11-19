//
//  TeamInfo+CoreDataProperties.swift
//  Football League Application
//
//  Created by Abdelrhman Eliwa on 11/19/20.
//
//

import Foundation
import CoreData


extension TeamInfo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TeamInfo> {
        return NSFetchRequest<TeamInfo>(entityName: "TeamInfo")
    }

    @NSManaged public var teamAddress: String?
    @NSManaged public var teamEmail: String?
    @NSManaged public var teamFounded: Int64
    @NSManaged public var teamId: Int64
    @NSManaged public var teamImageLogo: String?
    @NSManaged public var teamName: String?
    @NSManaged public var teamPhone: String?
    @NSManaged public var teamArea: String?
    @NSManaged public var teamVenue: String?
    @NSManaged public var teamWebsite: String?
    @NSManaged public var playersInfo: NSSet?

}

// MARK: Generated accessors for playersInfo
extension TeamInfo {

    @objc(addPlayersInfoObject:)
    @NSManaged public func addToPlayersInfo(_ value: PlayersInfo)

    @objc(removePlayersInfoObject:)
    @NSManaged public func removeFromPlayersInfo(_ value: PlayersInfo)

    @objc(addPlayersInfo:)
    @NSManaged public func addToPlayersInfo(_ values: NSSet)

    @objc(removePlayersInfo:)
    @NSManaged public func removeFromPlayersInfo(_ values: NSSet)

}

extension TeamInfo : Identifiable {

}
