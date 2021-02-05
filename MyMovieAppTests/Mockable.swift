//
//  Mockable.swift
//  MyMovieAppTests
//
//  Created by Guruprasath on 04/02/2021.
//

import Foundation

protocol Mockable {
    func getMockData<T: Decodable>(fileName: String) throws -> T
}

extension Mockable {
    
    public func getMockData<T: Decodable>(fileName: String) throws -> T {
        let filePath = Bundle.main.path(forResource: "movieList", ofType: "json") 
        let path = Bundle.main.path(forResource: fileName, ofType: "json")
        let data = try Data(contentsOf: URL(fileURLWithPath: path!), options: .alwaysMapped)
        return try JSONDecoder().decode(T.self, from: data)
    }
}
