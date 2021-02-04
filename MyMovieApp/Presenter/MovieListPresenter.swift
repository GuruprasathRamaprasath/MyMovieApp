//
//  MovieListPresenter.swift
//  MyMovieApp
//
//  Created by Guruprasath on 04/02/2021.
//

import Foundation

class MovieListPresenter {
    
    weak var view: MovieListPresenterOutput?
    var interactor: MovieListInteractorInput
    
    init(interactor: MovieListInteractorInput) {
        self.interactor = interactor
    }
}

extension MovieListPresenter: MovieListInteractorOutput {
    
    func updateMovieListInOffline(_ movieList: [Movie]) {
        view?.displayMovieViewModel(MovieListViewModel(movies: movieList))
    }
    
    
    func updateMovieList(_ movieList: [MovieResult]) {
        let movieListViewModel = MovieListViewModel(movies: MovieListPersistanceStore.fetchMovieList())
        view?.displayMovieViewModel(movieListViewModel)
    }
    
    func saveFavoriteMovieSuccess() {
        view?.displayFavouriteMovieSuccess(MovieListViewModel(movies: MovieListPersistanceStore.fetchMovieList()))
    }
    
}

extension MovieListPresenter: MovieListPresenterInput {
    
    func fetchMovieList() {
        interactor.fetchMovieList()
    }
    
    func saveFavorities(movie: MovieViewModel) {
        MovieListPersistanceStore.saveAsFavorite(movie: movie)
       let movieListViewModel = MovieListViewModel(movies: MovieListPersistanceStore.fetchMovieList())
        interactor.saveFavorities(movie: movieListViewModel)
    }
    
}

