//
//  ViewController.swift
//  MyMovieApp
//
//  Created by Guruprasath on 03/02/2021.
//

import UIKit
import CoreData

/**
 Movie List ViewController displays list of latest Movies played
 */


final class MovieListViewController: UIViewController {
    
    // MARK:- CONSTANTS
    
    enum ReuseIdentifier {
        static let movieListReuseIdentifer = "MovieListTableViewCell"
    }
    
    enum Constants {
        static let tableViewHeight: CGFloat = 100.0
        static let navTitle = "Now Playing"
        static let favoriteViewControllerIdentifier = "FavoritesViewController"
    }
    
    // MARK:- IBOUTLETS
    
    @IBOutlet weak var movieListTableView: UITableView?
    @IBOutlet weak var favoriteButton: UIBarButtonItem?
    
    // MARK:- VARIABLES
    
    private var presenter: MovieListPresenterInput?
    
    private var movieListViewModel: MovieListViewModel? {
        didSet {
            movieListTableView?.reloadData()
        }
    }
    
    // MARK:- VIEW LIFECYCLE

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        title = Constants.navTitle
        setupPresenter()
    }
    
    // MARK:- IBACTIONS

    @IBAction private func didTapFavourite(_ sender: Any) {
       presentFavoriteViewController()
    }
    
    // MARK:- METHODS
    
    private func setupPresenter() {
        presenter = MovieListRouter.createMovieListPresenter(self)
        presenter?.fetchMovieList()
    }
    
    private func presentFavoriteViewController() {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        guard let favoriteViewController = storyBoard.instantiateViewController(identifier: Constants.favoriteViewControllerIdentifier) as? FavoritesViewController else { return }
        let favNavigationController = UINavigationController(rootViewController: favoriteViewController)
        navigationController?.present(favNavigationController, animated: true, completion: nil)
    }
    
    
}

extension MovieListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return movieListViewModel?.numberOfSections ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieListViewModel?.numberOfRows ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.tableViewHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard  let cell = tableView.dequeueReusableCell(withIdentifier: ReuseIdentifier.movieListReuseIdentifer , for: indexPath) as? MovieListTableViewCell else {
            return UITableViewCell()
        }
        cell.delegate = self
        if let movie = movieListViewModel?.moviesAtIndex(indexPath.row) {
            cell.setup(movie, index: indexPath.row)
        }
        return cell
    }
}

extension MovieListViewController: MovieListTableViewCellDelegate {
    
    func saveAsFavorite(index: Int) {
        guard let movie = movieListViewModel?.moviesAtIndex(index) else { return  }
        presenter?.saveFavorities(movie: movie)
    }
}

extension MovieListViewController: MovieListPresenterOutput {
    
    func displayMovieViewModel(_ vm: MovieListViewModel) {
        movieListViewModel = vm
    }
    
    func displayFavouriteMovieSuccess(_ vm: MovieListViewModel) {
        movieListViewModel = vm
    }
}

