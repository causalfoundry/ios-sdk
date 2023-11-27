//
//  APIManager.swift
//
//
//  Created by khushbu on 25/09/23.
//

import Foundation

    
final class APIManager:NSObject {
    
    static let shared = APIManager()
    
    func getAPIDetails(url:String,params:[String:Any],_ strMethod :String,headers:[String:Any]? , completion: @escaping (_ result:[String:Any]?) -> Void) {
        // Check Internet is available or not
        
        RequestManager.shared.request(params, url, "POST") { success, data, response in
            
            if success {
                completion(data as? [String : Any])
            } else {
                ExceptionManager.throwAPIFailException(apiName:url, response: response, responseBody: nil)
                completion(nil)
            }
          }
    }
    
    
    func postUpdateCatelogEvents(url:String,params:Any,_ strMethod :String,headers:[String:Any]? , completion: @escaping (_ result:[String:Any]?) -> Void) {
        RequestManager.shared.request(params, url, "POST") { success, data, response  in
            completion(data as? [String : Any])
            
        }
    }
    
}
