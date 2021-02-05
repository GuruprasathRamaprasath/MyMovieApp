//
//  FavoritesViewController.swift
//  MyMovieApp
//
//  Created by Guruprasath on 04/02/2021.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    enum ReuseIdentifier {
        static let movieListReuseIdentifer = "MovieListTableViewCell"
    }
    
    enum Constants {
        static let tableViewHeight: CGFloat = 100.0
        static let navTitle = "Favourites"
    }
    
    private var favMovieListViewModel: FavoriteMovieListViewModel? {
        didSet {
            guard let numberOfRows = favMovieListViewModel?.numberOfRows else { return }
            favoriteTableView?.isHidden = numberOfRows <= 0
            noFavouritesLabel?.isHidden = numberOfRows > 0
            favoriteTableView?.reloadData()
        }
    }
    
    // MARK:- IBOUTLETS
    @IBOutlet weak var favoriteTableView: UITableView?
    @IBOutlet weak var noFavouritesLabel: UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        title = Constants.navTitle
        fetchFavorites()
    }
    
    private func fetchFavorites() {
        let favorites: [FavoriteMovie] = MovieListPersistanceStore.fetchMovieList()
        favMovieListViewModel = FavoriteMovieListViewModel(movies: favorites)
    }
    
}

extension FavoritesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return Constants.tableViewHeight
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return favMovieListViewModel?.numberOfRows ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard  let cell = tableView.dequeueReusableCell(withIdentifier: ReuseIdentifier.movieListReuseIdentifer , for: indexPath) as? MovieListTableViewCell else {
            return UITableViewCell()
        }
        if let movie = favMovieListViewModel?.moviesAtIndex(indexPath.row) {
            cell.setup(movie, index: indexPath.row)
        }
        return cell
    }

}
