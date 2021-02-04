//
//  MovieListViewModel.swift
//  MyMovieApp
//
//  Created by Guruprasath on 04/02/2021.
//

import Foundation

struct MovieListViewModel {
    
    var movies: [Movie]
    
    var numberOfSections: Int {
        return 1
    }
    
    var numberOfRows: Int {
        return movies.count
    }
    
    func moviesAtIndex(_ index: Int) -> MovieViewModel {
        return MovieViewModel(movie: movies[index])
    }
    
}

struct MovieViewModel {
    
    var name: String {
        return movie.movieTitle ?? "--"
    }
    
    var image: URL? {
        return URL(string: "https://image.tmdb.org/t/p/w500/\(movie.imageUrl ?? "")")
    }
    
    var isFavorite: Bool {
        return MovieListPersistanceStore.isFavoriteMovies(movieId: movie.movieId)
    }
    
    
    var movie: Movie
    
    init(movie: Movie) {
        self.movie = movie
    }
}
