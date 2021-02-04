//
//  EndPoint.swift
//  MyMovieApp
//
//  Created by Guruprasath on 03/02/2021.
//

import Foundation
import Alamofire

protocol EndpointType {
    var url: URL? { get set }
    var httpMethod: HTTPMethod { get set }
    var parameters: [String: Any]?  { get set }
    var encoding: URLEncodedFormParameterEncoder.Destination { get set }
}
