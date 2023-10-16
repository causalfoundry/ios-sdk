//
//  NetworkMonitor.swift
//
//
//  Created by khushbu on 21/09/23.
//

import Foundation
import Combine
import Network


enum ConnectivityStatus {
    case connected
    case disconnected
    case requiresConnection
}

@available(iOS 13.0, *)
final class NetworkMonitor {
    static let shared = NetworkMonitor()
    
    var uploadSpeed:Int64 = 0
    var downloadSpeed:Int64 = 0
    
    private let queue = DispatchQueue(label: "NetworkMonitorQueue")
    private let monitor: NWPathMonitor
   
    
    public private(set) var connectivityStatus =
    PassthroughSubject<ConnectivityStatus, Never>()
    
    private init() {
        monitor = NWPathMonitor()
        measureDownloadSpeed { downloadSpeed in
            if let downloadSpeed = downloadSpeed {
                self.downloadSpeed = Int64(downloadSpeed)
            } else {
                print("Failed to measure download speed.")
            }
        }
    }
    
    // Starts monitoring connectivity changes
    public func startMonitoring() {
        monitor.start(queue: queue)
        monitor.pathUpdateHandler = { [weak self] path in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.connectivityStatus
                    .send(self.getConnectivityFrom(status: path.status))
            }
        }
        
        let fileURL = URL(fileURLWithPath: "path/to/your/sample/file")
        measureUploadSpeed(fileURL: fileURL) { uploadSpeed in
            if let uploadSpeed = uploadSpeed {
                print("Upload speed: \(uploadSpeed) Mbps")
            } else {
                print("Failed to measure upload speed.")
            }
        }

        
        
       
    }
    
    public func stopMonitoring() {
        monitor.cancel()
    }
    
    // Converts NWPath.Status into ConnectivityStatus
    private func getConnectivityFrom(status: NWPath.Status) -> ConnectivityStatus {
        switch status {
        case .satisfied: return .connected
        case .unsatisfied: return .disconnected
        case .requiresConnection: return .requiresConnection
        @unknown default: fatalError()
        }
    }
    
   func measureDownloadSpeed(completionHandler: @escaping (Double?) -> Void) {
        guard let url = URL(string: "https://www.pixelstalk.net/wp-content/uploads/2016/06/HD-Peacock-Wallpaper.jpg") else {
            print("Invalid URL")
            completionHandler(nil)
            return
        }
        
        let downloadTask = URLSession.shared.dataTask(with: url) { (_, response, error) in
            if let error = error {
                print("Download failed with error: \(error.localizedDescription)")
                completionHandler(nil)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                print("Invalid HTTP response")
                completionHandler(nil)
                return
            }
            
            let fileSizeInBytes = Double(httpResponse.expectedContentLength)
            let downloadTimeInSeconds = httpResponse.allHeaderFields["Date"] as? TimeInterval ?? 0
            let downloadSpeedMbps = (fileSizeInBytes / downloadTimeInSeconds) * 8 / 1_000_000
            completionHandler(downloadSpeedMbps)
        }
        
        downloadTask.resume()
    }

    func measureUploadSpeed(fileURL: URL, completionHandler: @escaping (Double?) -> Void) {
        guard let data = try? Data(contentsOf: fileURL) else {
            print("Failed to load data from file.")
            completionHandler(nil)
            return
        }
        
        // Replace with your upload URL
        guard let uploadURL = URL(string: "YOUR_UPLOAD_URL_HERE") else {
            print("Invalid upload URL")
            completionHandler(nil)
            return
        }
        
        var request = URLRequest(url: uploadURL)
        request.httpMethod = "POST"
        
        let uploadTask = URLSession.shared.uploadTask(with: request, from: data) { (_, _, error) in
            if let error = error {
                print("Upload failed with error: \(error.localizedDescription)")
                completionHandler(nil)
                return
            }
            
            // Calculate the upload speed in Mbps
            let fileSizeInBytes = Double(data.count)
            let uploadTimeInSeconds = Date().timeIntervalSinceNow * -1
            let uploadSpeedMbps = (fileSizeInBytes / uploadTimeInSeconds) * 8 / 1_000_000
            completionHandler(uploadSpeedMbps)
        }
        
        uploadTask.resume()
    }

    // Usage: Measure download and upload speeds
   }

