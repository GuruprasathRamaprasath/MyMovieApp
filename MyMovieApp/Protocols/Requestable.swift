//
//  Requestable.swift
//  MyMovieApp
//
//  Created by Guruprasath on 03/02/2021.
//

import Foundation

protocol Requestable {
    func request<T: Decodable>(endPoint: EndpointType, generalType: T.Type, completion: @escaping (Result<T, Error>) -> Void)
}

