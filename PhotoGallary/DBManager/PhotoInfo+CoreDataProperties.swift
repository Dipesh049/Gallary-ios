//
//  PhotoInfo+CoreDataProperties.swift
//  PhotoGallary
//
//  Created by Dipesh Patel on 17/10/25.
//
//

import Foundation
import CoreData


extension PhotoInfo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PhotoInfo> {
        return NSFetchRequest<PhotoInfo>(entityName: "PhotoInfo")
    }

    @NSManaged public var photoUrl: String?
    @NSManaged public var createdAt: String?
    @NSManaged public var id: Int16

}

extension PhotoInfo : Identifiable {

}
