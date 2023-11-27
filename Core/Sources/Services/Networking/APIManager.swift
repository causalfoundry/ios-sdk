//
//  APIManager.swift
//
//
//  Created by khushbu on 25/09/23.
//

import Foundation

    
final class APIManager:NSObject {
    
    static let shared = APIManager()
    
    func getAPIDetails(url:String,params:[String:Any],_ strMethod :String,headers:[String:Any]? , completion: @escaping (_ success: Bool) -> Void) {
        // Check Internet is available or not
        
        let request = BackgroundRequestController()
        request.request(params, url, "POST") { error, response in
            if error != nil {
                ExceptionManager.throwAPIFailException(apiName:url, response: response as? HTTPURLResponse, responseBody: nil)
            }
            completion(error == nil)
          }
    }
    
    
    func postUpdateCatelogEvents(url:String,params:Any,_ strMethod :String,headers:[String:Any]? , completion: @escaping (_ success: Bool) -> Void) {
        let request = BackgroundRequestController()
        request.request(params, url, "POST") { error, response  in
            completion(error != nil)
        }
    }
    
}
