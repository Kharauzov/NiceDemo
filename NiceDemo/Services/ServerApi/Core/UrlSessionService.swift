//
//  UrlSessionService.swift
//  NiceDemo
//
//  Created by Serhii Kharauzov on 3/14/18.
//  Copyright © 2018 Serhii Kharauzov. All rights reserved.
//

import Foundation

/// Responsible for performing network requests, using `URLSession`.
///
/// You shouldn't call its methods explicitly! Please use it as an abstract layer in
/// server services via protocols.
class UrlSessionService: ServerService {
 
    // MARK: Private properties
    
    private let session: URLSession
    
    // MARK: Public methods
    
    init(session: URLSession = URLSession(configuration: .default)) {
        self.session = session
    }
    
    func performRequest<T>(_ request: URLRequestable, completion: ServerRequestResponseCompletion<T>?) {
        session.dataTask(with: request.asURLRequest()) { (data, response, error) in
            let result: Result<T>
            defer {
                DispatchQueue.main.async {
                    completion?(result)
                }
            }
            if let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode {
                guard let data = data as? T else { return result = .failure(HTTPRequestError.invalidResponseDataType) }
                result = .success(data)
            } else {
                result = .failure(self.getFormattedError(responseData: data, defaultError: error))
            }
        }.resume()
    }
    
    // MARK: Private methods
    
    private func getFormattedError(responseData: Data?, defaultError: Error?) -> Error {
        if let data = responseData {
            if let baseResponse = try? JSONDecoder().decode(BaseResponse.self, from: data),
                let errorString = baseResponse.error {
                return HTTPRequestError.custom(errorString)
            }
        }
        return defaultError ?? HTTPRequestError.invalidResponse
    }
}

extension UrlSessionService {
    enum HTTPRequestError: Error {
        case invalidResponseDataType
        case invalidResponse
        case custom(String)
        
        var localizedDescription: String {
            switch self {
            case .invalidResponseDataType:
                return "Response's data format is different from expected."
            case .invalidResponse:
                return "Invalid response."
            case .custom(let value):
                return value
            }
        }
    }
}

