//
//  MovieListTableViewCell.swift
//  MyMovieApp
//
//  Created by Guruprasath on 04/02/2021.
//

import UIKit
import AlamofireImage

protocol MovieListTableViewCellDelegate: class {
    
    func saveAsFavorite(index: Int)
}

final class MovieListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var movieImageView: UIImageView?
    @IBOutlet weak var movieTitleLabel: UILabel?
    @IBOutlet weak var favoriteButton: UIButton?
    
    weak var delegate: MovieListTableViewCellDelegate?
    
    private var index: Int?
    
    func setup(_ movieViewModel: MovieViewModel, index: Int) {
        self.index = index
        movieTitleLabel?.text = movieViewModel.name
        guard let url = movieViewModel.image else { return }
        movieImageView?.af.setImage(withURL: url)
        let image = movieViewModel.isFavorite ? UIImage(named: "favorite_checked") : UIImage(named: "favorite_unChecked")
        favoriteButton?.setBackgroundImage(image, for: .normal)
    }
    
    func setup(_ movieViewModel: FavoriteMovieViewModel, index: Int) {
        self.index = index
        movieTitleLabel?.text = movieViewModel.name
        guard let url = movieViewModel.image else { return }
        movieImageView?.af.setImage(withURL: url)
        favoriteButton?.isHidden = true
    }
    
    @IBAction private func didTapFavorite(_ sender: Any) {
        delegate?.saveAsFavorite(index: index ?? 0)
    }

}
