//
//  MovieListRouter.swift
//  MyMovieApp
//
//  Created by Guruprasath on 04/02/2021.
//

import Foundation

enum MovieListRouter {
    
    static func createMovieListPresenter(_ view: MovieListPresenterOutput) -> MovieListPresenterInput {
        let interactor = MovieListInteractor()
        let presenter = MovieListPresenter(interactor: interactor)
        presenter.view = view
        interactor.output = presenter
        return presenter
    }
}
