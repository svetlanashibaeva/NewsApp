//
//  News+CoreDataProperties.swift
//  
//
//  Created by Света Шибаева on 23.05.2021.
//
//

import Foundation
import CoreData


extension News {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<News> {
        return NSFetchRequest<News>(entityName: "News")
    }

    @NSManaged public var descr: String?
    @NSManaged public var publishedAt: Date?
    @NSManaged public var title: String?
    @NSManaged public var url: String?
    @NSManaged public var urlToImage: String?

}
