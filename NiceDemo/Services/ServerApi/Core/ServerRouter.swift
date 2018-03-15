//
//  ServerRouter.swift
//  NiceDemo
//
//  Created by Serhii Kharauzov on 3/13/18.
//  Copyright © 2018 Serhii Kharauzov. All rights reserved.
//

import Foundation

/// Types adopting the `URLRequestable` protocol can be used to construct URL requests.
protocol URLRequestable {
    /// Returns a URL request.
    func asURLRequest() -> URLRequest
}

/// A dictionary of parameters to apply to a `URLRequest`.
typealias URLRequestParameters = [String: Any]

/// Base HTTP method definitions.
enum HTTPMethod: String {
    case get     = "GET"
    case head    = "HEAD"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
}

/// `URLRequest` builder, that could be used for any HTTP(s) wrapper,
/// that supports `URLRequestable` protocol.
enum ServerRouter: URLRequestable {
    
    // MARK: Requests
    
    case getAllDogsBreeds
    
    // MARK: Interface

    /// Base url string for all endpoints in the project.
    static let baseURLString = "https://dog.ceo/api/"
    
    /// URLRequest builder method.
    func asURLRequest() -> URLRequest {
        var method: HTTPMethod {
            switch self {
            case .getAllDogsBreeds:
                return .get
            }
        }
        var params: (URLRequestParameters?) {
            switch self {
            case .getAllDogsBreeds:
                return nil
            }
        }
        let url: URL = {
            let relativePath: String
            switch self {
            case .getAllDogsBreeds:
                relativePath = "breeds/list/all"
            }
            return URL(string: ServerRouter.baseURLString)!.appendingPathComponent(relativePath)
        }()
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        if let unwrappedParams = params { // add parameters to httpBody if needed
            let jsonData = try? JSONSerialization.data(withJSONObject: unwrappedParams, options: .prettyPrinted)
            urlRequest.httpBody = jsonData
        }
        return urlRequest
    }
}
