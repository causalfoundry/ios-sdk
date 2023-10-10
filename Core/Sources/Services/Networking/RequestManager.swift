//
//  File.swift
//  
//
//  Created by khushbu on 03/10/23.
//

import Foundation
import UIKit

class RequestManager {
    
    open class var sharedManager: RequestManager {
        struct Static {
            static let instance: RequestManager = RequestManager()
        }
        return Static.instance
    }
    
    
    let POSTMETHOD = "POST"
    let GETMETHOD = "GET"
    
    var task:URLSessionDataTask!
    
    private var session: URLSession = {
        let configuration = URLSessionConfiguration.default
        configuration.allowsCellularAccess = true
        configuration.httpShouldSetCookies = true
        configuration.httpShouldUsePipelining = true
        configuration.requestCachePolicy = .useProtocolCachePolicy
        configuration.timeoutIntervalForRequest = 60.0
        configuration.urlCache = URLCache(memoryCapacity: 0, diskCapacity: 0, diskPath: nil)
        return  URLSession(configuration: configuration)
    }()
    
    
    public func getDataFromServer(_ strParams : Any,_ strUrl :String, _ strMethod :String ,completionHandler:@escaping (_ success:Bool, _ data: NSDictionary?) -> Void){
        
        let url = URL(string: strUrl)
        var request = URLRequest(url: url!,cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,timeoutInterval: 3.0 * 1000)
        
        request.httpMethod = strMethod
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(CoreConstants.shared.sdkKey, forHTTPHeaderField: "Authorization")
        
        if (strParams as AnyObject).count > 0 {
            guard let httpBody = try? JSONSerialization.data(withJSONObject: strParams, options: .prettyPrinted) else {
               return
            }
            
            if strMethod == POSTMETHOD {
                request.httpBody = httpBody
            }
            //            request.httpBody = strParams.data(using: String.Encoding.utf8.rawValue);
        }
        print(request);
        task = session.dataTask(with: request, completionHandler: {data, response, error in
            do {
                if error != nil {
                    if let dic  = error?.localizedDescription {
                       //  Show Error
                    }
                }else{
                    // Chnages related to Http response suggested by Shekhar due to unhandle 500 error form backend side
                    if let httpResponse = response as? HTTPURLResponse {
                        if httpResponse.statusCode != 200 {
                            DispatchQueue.main.async {
                               // Show Error
                                self.task.cancel()
                                completionHandler(false, nil)
                            }
                        }else{
                            guard let data = data else {
                                print(strParams)
                                print(request)
                                return
                            }
                            
                            
                            print("response", response as Any);
                            if let jsonResult = try JSONSerialization.jsonObject(with: data, options: []) as? NSArray {
                                for dictData in jsonResult {
                                    guard let dict = dictData as? NSDictionary else {
                                        print("Conversion failed")
                                        return
                                    }
                                    completionHandler(true, dict)
                                }
                                completionHandler(false, nil)
                            }else {
                                guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary else {
                                    print("Conversion failed")
                                    return
                                }
                                completionHandler(true, json)
                            }
                        }
                    }
                }
            }
//            catch let error as JSONError {
//                print(error.rawValue)
//                completionHandler(false, nil)
//            }
            catch let error as NSError {
                print(error.debugDescription)
                completionHandler(false, nil)
            }
        });
        task.resume()
        //        task.suspend()
    }
}
