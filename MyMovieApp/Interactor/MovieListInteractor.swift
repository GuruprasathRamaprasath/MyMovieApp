//
//  MovieListInteractor.swift
//  MyMovieApp
//
//  Created by Guruprasath on 04/02/2021.
//

import Foundation


class MovieListInteractor {
    var output: MovieListInteractorOutput?
}

extension MovieListInteractor: MovieListInteractorInput {
    
    func fetchMovieList() {
        let endpoint = MovieListEndpoint()
        NetworkManager().request(endPoint: endpoint, generalType: MovieList.self) { [weak self] result in
            switch result {
            case .success(let movieList):
                MovieListPersistanceStore.deleteMovieList()
                MovieListPersistanceStore.saveMovieList(movieList: movieList.results)
                self?.output?.updateMovieList(movieList.results)
              
            case .failure: break;
                self?.output?.updateMovieListInOffline(MovieListPersistanceStore.fetchMovieList())
            }
        }
    }
    
    func saveFavorities(movie: MovieListViewModel) {
        output?.saveFavoriteMovieSuccess()
    }
    
}
