//
//  File.swift
//  
//
//  Created by khushbu on 25/09/23.
//

import Foundation
import Combine


/// All of the CHW endpoints return a [String : Any] json object
typealias JSONCompletionHandler = (Result<[String : Any]>)->()

/// The base URL for connecting to the CHW json endpoint
let baseURL = CoreConstants.shared.devUrl

/// Types that conform to this can return results from the CHW JSON API
protocol CHWJSONClient {
    
    static func handle(result: Result<Any>, completionHandler: JSONCompletionHandler)
    static func handleSuccessfulAPICall(for json: Any, completionHandler: JSONCompletionHandler)
    static func handleFailedAPICall(for error: Error, completionHandler: JSONCompletionHandler)
}

extension CHWJSONClient {
    
    static func handle(result: Result<Any>, completionHandler: JSONCompletionHandler) {
        switch result {
        case .success(let json):
            self.handleSuccessfulAPICall(for: json, completionHandler: completionHandler)
        case .failure(let error):
            self.handleFailedAPICall(for: error, completionHandler: completionHandler)
        }
    }
    
    static func handleSuccessfulAPICall(for json: Any, completionHandler: JSONCompletionHandler) {
        guard let json = json as? [String : Any] else {
            let error = NetworkingError.badJSON
            handleFailedAPICall(for: error, completionHandler: completionHandler)
            return
        }
        completionHandler(Result.success(json))
    }
    
    static func handleFailedAPICall(for error: Error, completionHandler: JSONCompletionHandler) {
        completionHandler(Result.failure(error))
    }
}
