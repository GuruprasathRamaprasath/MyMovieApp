//
//  MovieListPersistanceStore.swift
//  MyMovieApp
//
//  Created by Guruprasath on 04/02/2021.
//

import Foundation
import CoreData

struct MovieListPersistanceStore {
    
    static func saveMovieList(movieList: [MovieResult]) {
        for movieItem in movieList {
            let movie = NSEntityDescription.insertNewObject(forEntityName: "Movie",
                                                            into: CoreDataManager.shared.persistentContainer.viewContext) as? Movie
            movie?.movieId = "\(movieItem.id)"
            movie?.imageUrl = movieItem.poster_path
            movie?.movieTitle = movieItem.original_title
            do {
                try CoreDataManager.shared.persistentContainer.viewContext.save()
            } catch {
                print("Storing data Failed")
            }
            
            CoreDataManager.shared.saveContext()
        }
    }
    
    static func fetchMovieList<T>() -> [T] {
        var result  = [T]()

        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: T.self))
        do {
            result = try CoreDataManager.shared.persistentContainer.viewContext.fetch(fetchRequest) as? [T] ?? []
        }
        catch let err as NSError {
            print(err.debugDescription)
        }
        
        return result
        
    }
    
    static func deleteMovieList() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Movie")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try CoreDataManager.shared.persistentContainer.viewContext.execute(deleteRequest)
        } catch let error as NSError {
            print(error.debugDescription)
        }
    }
    
    static func saveAsFavorite(movie: MovieViewModel) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: Movie.self))
        fetchRequest.predicate = NSPredicate(format: "movieId = %@", movie.movie.movieId)
        let favMovie = NSEntityDescription.insertNewObject(forEntityName: "FavoriteMovie",
                                                           into: CoreDataManager.shared.persistentContainer.viewContext) as? FavoriteMovie
        favMovie?.movieId = movie.movie.movieId
        favMovie?.movieTitle = movie.movie.movieTitle
        favMovie?.imageUrl = movie.movie.imageUrl
        do {
            try CoreDataManager.shared.persistentContainer.viewContext.save()
        } catch {
            print("Storing data Failed")
        }
    }
    
    static func isFavoriteMovies(movieId: String) -> Bool {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: FavoriteMovie.self))
        fetchRequest.predicate = NSPredicate(format: "movieId = %@", movieId)
        
        var favMovies: [FavoriteMovie] = []
        do {
          favMovies = try CoreDataManager.shared.persistentContainer.viewContext.fetch(fetchRequest) as? [FavoriteMovie] ?? []
            
        }
        catch let err as NSError {
            print(err.debugDescription)
        }
        
        return !favMovies.isEmpty
    }
    
}
