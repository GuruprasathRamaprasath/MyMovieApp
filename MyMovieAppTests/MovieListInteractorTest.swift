//
//  MovieListInteractorTest.swift
//  MyMovieAppTests
//
//  Created by Guruprasath on 05/02/2021.
//

import XCTest
@testable import MyMovieApp


class MovieListInteractorTest: XCTestCase {
    
    var interactor: MovieListInteractorMock = MovieListInteractorMock()
    var presenter: MovieListPresenterMock = MovieListPresenterMock()
    
    override func setUp() {
        super.setUp()
        setupInteractor()
    }
    
    private func setupInteractor() {
        interactor.output = presenter
    }
    
    func testFetchMovieList() {
        interactor.fetchMovieList()
        XCTAssertTrue(self.presenter.isMovieListFetched)
    }
    
    func testFetchMovieListCount() {
        interactor.fetchMovieList()
        XCTAssertEqual(20, self.presenter.movieListCount)
    }
    
    func testSaveFavoriteMovie() {
        interactor.saveFavorities(movie: MovieListViewModel(movies: [Movie()]))
        XCTAssertTrue(self.presenter.isFavoriteMovieSaved)
    }

}

class MovieListInteractorMock: MovieListInteractorInput {
    
    let networkManager: Requestable = NetworkManagerMock()
    var output: MovieListInteractorOutput? = nil
    
    func fetchMovieList() {
        let endpoint = MovieListEndpoint()
        networkManager.request(endPoint: endpoint, generalType: MovieList.self) { result in
            switch result {
            case .success(let movieList):
                self.output?.updateMovieList(movieList.results)
            case .failure: break;
                self.output?.updateMovieListInOffline(MovieListPersistanceStore.fetchMovieList())
            }
        }
    }
    
    func saveFavorities(movie: MovieListViewModel) {
        output?.saveFavoriteMovieSuccess()
    }
}

class MovieListPresenterMock: MovieListInteractorOutput {
    
    var isMovieListFetched = false
    
    var isMovieListUpdatedFromOffline = false
    
    var isFavoriteMovieSaved = false
    
    var movieListCount: Int = 0
    
    var movieResult: MovieListViewModel?
    
    func updateMovieList(_ movieList: [MovieResult]) {
        movieListCount = movieList.count
        isMovieListFetched = !movieList.isEmpty
    }
    
    func updateMovieListInOffline(_ movieList: [Movie]) {
        isMovieListUpdatedFromOffline = !movieList.isEmpty
    }
    
    func saveFavoriteMovieSuccess() {
        isFavoriteMovieSaved = true
    }
    
}

class NetworkManagerMock: Requestable, Mockable {
    
    func request<T>(endPoint: EndpointType, generalType: T.Type, completion: @escaping (Result<T, Error>) -> Void) where T : Decodable {
        
        do {
            let movieList: T = try getMockData(fileName: "movieList")
            completion(.success(movieList))
        }
        catch let error {
            completion(.failure(error))
        }
    }
}
