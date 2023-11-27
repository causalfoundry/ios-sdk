//
//  File.swift
//
//
//  Created by khushbu on 03/10/23.
//

import Foundation
import UIKit

class BackgroundRequestController:NSObject,URLSessionDelegate{
    
    typealias Completion = (_ error: Error?, _ response: URLResponse?) -> Void
    
    private var completion: Completion?
    
    public override init() {  }
    
    public func request(_ strParams: Any, _ strUrl: String, _ strMethod: String, completionHandler: @escaping Completion) {
        
        completion = completionHandler
        
        let url = URL(string: strUrl)
        var urlRequest = URLRequest(url: url!,cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,timeoutInterval: 3.0 * 1000)
        
        urlRequest.httpMethod = strMethod
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue(CoreConstants.shared.sdkKey, forHTTPHeaderField: "Authorization")
        
        if strMethod == "POST",
           (strParams as AnyObject).count > 0,
           let httpBody = try? JSONSerialization.data(withJSONObject: strParams, options: .prettyPrinted) {
            urlRequest.httpBody = httpBody
        }
        
        let configuration = URLSessionConfiguration.background(withIdentifier: WorkerCaller.backgroundTaskIdentifier)
        configuration.allowsCellularAccess = true
        configuration.httpShouldSetCookies = true
        configuration.httpShouldUsePipelining = true
        configuration.requestCachePolicy = .useProtocolCachePolicy
        configuration.timeoutIntervalForRequest = 60.0
        //  configuration.urlCache = URLCache(memoryCapacity: 0, diskCapacity: 0, diskPath: nil)
        let session = URLSession(configuration: configuration, delegate: self, delegateQueue: OperationQueue.main)
        
        let task = session.downloadTask(with: urlRequest)
        print(urlRequest);
        //        task = session.dataTask(with: request, completionHandler: {data, response, error in
        //            do {
        //                if error != nil {
        //                    if let dic  = error?.localizedDescription {
        //                        print(dic)
        //                       //  Show Error
        //                    }
        //                }else{
        //                    // Chnages related to Http response suggested by Shekhar due to unhandle 500 error form backend side
        //                    if let httpResponse = response as? HTTPURLResponse {
        //                        if httpResponse.statusCode != 200 {
        //                            DispatchQueue.main.async {
        //                               // Show Error
        //                                self.task.cancel()
        //                                completionHandler(false, nil, httpResponse)
        //                            }
        //                        }else{
        //                            guard let data = data else {
        //                                print(strParams)
        //                                print(request)
        //                                return
        //                            }
        //                            print("response", response as Any);
        //                            if let jsonResult = try JSONSerialization.jsonObject(with: data, options: []) as? NSArray {
        //                                for dictData in jsonResult {
        //                                    guard let dict = dictData as? NSDictionary else {
        //                                        print("Conversion failed")
        //                                        return
        //                                    }
        //                                    completionHandler(true, dict,httpResponse)
        //                                }
        //                                completionHandler(false, nil,httpResponse)
        //                            }else {
        //                                guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary else {
        //                                    print("Conversion failed")
        //                                    return
        //                                }
        //                                completionHandler(true, json,httpResponse)
        //                            }
        //                        }
        //                    }
        //                }
        //            }
        ////            catch let error as JSONError {
        ////                print(error.rawValue)
        ////                completionHandler(false, nil)
        ////            }
        //            catch let error as NSError {
        //                print(error.debugDescription)
        //                completionHandler(false, nil,response as! HTTPURLResponse)
        //            }
        //        });
        task.resume()
        //        task.suspend()
    }
    
    func urlSession(_ session: URLSession, didBecomeInvalidWithError error: Error?) {
        print("Task with error: \(error?.localizedDescription ?? "No error")")
        completion?(error, nil)
    }
    
    func urlSessionDidFinishEvents(forBackgroundURLSession session: URLSession) {
        // This method is called when all tasks have been completed for the background session.
        // Perform any necessary cleanup or UI updates.
        print("All tasks in the background session are complete.")
    }

    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        // This method is called when a task completes (both successfully or with an error).
        // Handle task completion here.
        print("Task completed with error: \(error?.localizedDescription ?? "No error")")
        completion?(error, task.response)
    }
}
