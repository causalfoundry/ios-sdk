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
        
        let headersData = ["Authorization":CoreConstants.shared.sdkKey]
        
        RequestManager.sharedManager.getDataFromServer(params, url, "POST") { success, data in
            var data = [String:Any]()
            
            completion(data)
            
        }
    }
    
    
    func postUpdateCatelogEvents(url:String,params:Any,_ strMethod :String,headers:[String:Any]? , completion: @escaping (_ result:[String:Any]?) -> Void) {
        var headersData:[String:Any] = ["Authorization":CoreConstants.shared.sdkKey]
        
        if headers != nil {
            headersData.updateValue(headers!.values.first!, forKey: headers!.keys.first!)
        }
        RequestManager.sharedManager.getDataFromServer(params, url, "POST") { success, data in
            var data = [String:Any]()
            
            completion(data)
            
        }
    }
    
}
