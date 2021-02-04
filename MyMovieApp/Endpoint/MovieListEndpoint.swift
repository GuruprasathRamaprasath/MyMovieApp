//
//  MovieListEndpoint.swift
//  MyMovieApp
//
//  Created by Guruprasath on 04/02/2021.
//

import Foundation
import Alamofire

struct MovieListEndpoint: EndpointType {
    
    var url: URL? = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=34c902e6393dc8d970be5340928602a7&language=en-US&page=1")
    
    var httpMethod: HTTPMethod = .get
    var parameters: [String: Any]?
    var encoding: URLEncodedFormParameterEncoder.Destination = .httpBody
}
