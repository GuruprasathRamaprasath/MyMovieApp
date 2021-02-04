//
//  FavoriteMovie+CoreDataProperties.swift
//  
//
//  Created by Guruprasath on 04/02/2021.
//
//

import Foundation
import CoreData


extension FavoriteMovie {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoriteMovie> {
        return NSFetchRequest<FavoriteMovie>(entityName: "FavoriteMovie")
    }

    @NSManaged public var movieId: String?
    @NSManaged public var movieTitle: String?
    @NSManaged public var imageUrl: String?
}
