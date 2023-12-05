//
//  APIManager.swift
//
//
//  Created by khushbu on 25/09/23.
//

import Foundation

final class APIManager: NSObject {
    static let shared = APIManager()

    func getAPIDetails(url: String, params: [String: Any], _ strMethod: String, headers _: [String: Any]?, completion: @escaping (_ success: Bool) -> Void) {
        // Check Internet is available or not
        let url = URL(string: url)!
        BackgroundRequestController.shared.request(url: url, httpMethod: strMethod, params: params) { error, response, _ in
            if error != nil {
                ExceptionManager.throwAPIFailException(apiName: url.absoluteString, response: response as? HTTPURLResponse, responseBody: nil)
            }
            completion(error == nil)
        }
    }

    func postUpdateCatelogEvents(url: String, params: Any, _ strMethod: String, headers _: [String: Any]?, completion: @escaping (_ success: Bool) -> Void) {
        let url = URL(string: url)!
        BackgroundRequestController.shared.request(url: url, httpMethod: strMethod, params: params) { error, _, _ in
            completion(error != nil)
        }
    }
}
