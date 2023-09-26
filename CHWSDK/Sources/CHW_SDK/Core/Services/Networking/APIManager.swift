//
//  APIManager.swift
//
//
//  Created by khushbu on 25/09/23.
//

import Foundation
    
final class APIManager:NSObject {
    
   static let shared = APIManager()
    
    func getAPIDetails(url:String,params:String,isPost:Bool,headers:[String:Any]? ,completion: @escaping (_ result:[String:Any]?) -> Void) {
        
      // Check Internet is available or not
        
    }
    
}

