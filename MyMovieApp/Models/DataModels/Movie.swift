//
//  Movie.swift
//  MyMovieApp
//
//  Created by Guruprasath on 04/02/2021.
//

import Foundation

struct MovieList: Decodable {
    var results: [MovieResult]
}

struct MovieResult: Decodable {
    var id: Int
    var original_title: String
    var poster_path: String
}
