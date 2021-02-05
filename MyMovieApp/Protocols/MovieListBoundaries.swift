//
//  MovieListBoundaries.swift
//  MyMovieApp
//
//  Created by Guruprasath on 04/02/2021.
//

import Foundation

protocol MovieListPresenterInput: class {
    /**
     Fetch MovieList
     */
    func fetchMovieList()
    
    /**
     Save Favorites
     */
    func saveFavorities(movie: MovieViewModel)
}

protocol MovieListInteractorInput: class {
    /**
     Fetch MovieList
     */
    func fetchMovieList()
    
    
    /**
     Save Favorites
     */
    func saveFavorities(movie: MovieListViewModel)
}

protocol MovieListInteractorOutput: class {
    func updateMovieList(_ movieList: [MovieResult])
    func updateMovieListInOffline(_ movieList: [Movie])
    func saveFavoriteMovieSuccess()
}

protocol MovieListPresenterOutput: class {
    func displayMovieViewModel(_ vm: MovieListViewModel)
    func displayFavouriteMovieSuccess(_ vm: MovieListViewModel)
}
