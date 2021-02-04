//
//  FavoriteMovieListViewModel.swift
//  MyMovieApp
//
//  Created by Guruprasath on 04/02/2021.
//

import Foundation

struct FavoriteMovieListViewModel {
    
    var movies: [FavoriteMovie]
    
    var numberOfSections: Int {
        return 1
    }
    
    var numberOfRows: Int {
        return movies.count
    }
    
    func moviesAtIndex(_ index: Int) -> FavoriteMovieViewModel {
        return FavoriteMovieViewModel(movie: movies[index])
    }
    
}

struct FavoriteMovieViewModel {
    
    var name: String {
        return movie.movieTitle ?? "--"
    }
    
    var image: URL? {
        return URL(string: "https://image.tmdb.org/t/p/w500/\(movie.imageUrl ?? "")")
    }
    
    var movie: FavoriteMovie
    
    init(movie: FavoriteMovie) {
        self.movie = movie
    }
}
