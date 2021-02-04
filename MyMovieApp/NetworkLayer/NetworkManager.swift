//
//  NetworkManager.swift
//  MyMovieApp
//
//  Created by Guruprasath on 03/02/2021.
//

import Foundation
import Alamofire

class NetworkManager: Requestable {
    
    func request<T>(endPoint endpoint: EndpointType, generalType: T.Type, completion: @escaping (Result<T, Error>) -> Void) where T : Decodable {
        
        guard let url = endpoint.url else { return }
        AF.request(url).responseDecodable { (response: AFDataResponse<T>) in
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

