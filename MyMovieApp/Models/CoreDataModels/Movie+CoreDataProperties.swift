//
//  Movie+CoreDataProperties.swift
//  
//
//  Created by Guruprasath on 04/02/2021.
//
//

import Foundation
import CoreData


extension Movie {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Movie> {
        return NSFetchRequest<Movie>(entityName: "Movie")
    }

    @NSManaged public var movieId: String
    @NSManaged public var imageUrl: String?
    @NSManaged public var movieTitle: String?

}
