//
//  BackgroundRequestController.swift
//
//
//  Created by khushbu on 03/10/23.
//

import Foundation
import UIKit

private final class BackgroundRequest {
    let task: URLSessionTask
    var data: Data?
    let completion: BackgroundRequestController.Completion

    init(task: URLSessionTask, completion: @escaping BackgroundRequestController.Completion) {
        self.task = task
        self.completion = completion
    }
}

class BackgroundRequestController: NSObject {
    typealias Completion = (_ error: Error?, _ response: URLResponse?, _ data: Data?) -> Void

    public static let shared = BackgroundRequestController()

    private let backgroundRequestsQueue = DispatchQueue(label: "thread-safe-obj", attributes: .concurrent)
    private var backgroundRequests = [BackgroundRequest]()
    private lazy var session: URLSession = {
        let configuration = URLSessionConfiguration.background(withIdentifier: "BackgroundRequestController.configuration")
        configuration.allowsCellularAccess = true
        configuration.httpShouldSetCookies = true
        configuration.httpShouldUsePipelining = true
        configuration.requestCachePolicy = .useProtocolCachePolicy
        configuration.timeoutIntervalForRequest = 60.0
        configuration.sharedContainerIdentifier = "BackgroundRequestController.sharedContainer"
        //  configuration.urlCache = URLCache(memoryCapacity: 0, diskCapacity: 0, diskPath: nil)
        return URLSession(configuration: configuration, delegate: self, delegateQueue: nil)
    }()

    override public init() {}

    public func request(url: URL, httpMethod: String, params: Any?, completionHandler: @escaping Completion) {
        let urlRequest = urlRequest(url: url, httpMethod: httpMethod, params: params)
        let task = session.dataTask(with: urlRequest)
        backgroundRequestsQueue.async(flags: .barrier) {
            let request = BackgroundRequest(task: task, completion: completionHandler)
            self.backgroundRequests.append(request)
        }
        task.resume()
    }

    private func urlRequest(url: URL, httpMethod: String, params: Any?) -> URLRequest {
        var urlRequest = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 3.0 * 1000)
        urlRequest.httpMethod = httpMethod
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue(CoreConstants.shared.sdkKey, forHTTPHeaderField: "Authorization")
        if let params = params, let httpBody = try? JSONSerialization.data(withJSONObject: params, options: .prettyPrinted) {
            urlRequest.httpBody = httpBody
        }
        return urlRequest
    }
}

extension BackgroundRequestController: URLSessionDelegate {
    func urlSession(_: URLSession, didBecomeInvalidWithError error: Error?) {
        print("Session didBecomeInvalidWithError: \(error?.localizedDescription ?? "No error")")
    }

    func urlSessionDidFinishEvents(forBackgroundURLSession _: URLSession) {
        // This method is called when all tasks have been completed for the background session.
        // Perform any necessary cleanup or UI updates.
        print("All tasks in the background session are complete.")
        backgroundRequestsQueue.async(flags: .barrier) {
            self.backgroundRequests.forEach { request in
                request.completion(nil, request.task.response, nil)
            }
            self.backgroundRequests.removeAll()
        }
    }

    func urlSession(_: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        // This method is called when a task completes (both successfully or with an error).
        // Handle task completion here.
        print("Task \(task.originalRequest?.url?.absoluteString ?? "-") completed with error: \(error?.localizedDescription ?? "No error")")
        backgroundRequestsQueue.async(flags: .barrier) {
            if let index = self.backgroundRequests.firstIndex(where: { $0.task.taskIdentifier == task.taskIdentifier }) {
                let request = self.backgroundRequests[index]
                request.completion(error, request.task.response, request.data)
                self.backgroundRequests.remove(at: index)
            }
        }
    }
}

extension BackgroundRequestController: URLSessionDataDelegate {
    func urlSession(_: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        print("Task \(dataTask.originalRequest?.url?.absoluteString ?? "-") didReceive data: \(String(data: data, encoding: .utf8) ?? "-")")
        backgroundRequestsQueue.async(flags: .barrier) {
            if let index = self.backgroundRequests.firstIndex(where: { $0.task.taskIdentifier == dataTask.taskIdentifier }) {
                if self.backgroundRequests[index].data == nil {
                    self.backgroundRequests[index].data = data
                } else {
                    self.backgroundRequests[index].data! += data
                }
            }
        }
    }
}
