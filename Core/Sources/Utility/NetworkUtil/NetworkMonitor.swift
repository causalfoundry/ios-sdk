//
//  NetworkMonitor.swift
//
//
//  Created by khushbu on 21/09/23.
//

import Combine
import Foundation
import Network

enum ConnectivityStatus {
    case connected
    case disconnected
    case requiresConnection
}

@available(iOS 13.0, *)
final class NetworkMonitor {
    static let shared = NetworkMonitor()

    var uploadSpeed: Int64 = 0
    var downloadSpeed: Int64 = 0

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
        guard let url = URL(string: "https://cdn.cocoacasts.com/cc00ceb0c6bff0d536f25454d50223875d5c79f1/above-the-clouds.jpg") else {
            print("Invalid URL")
            completionHandler(nil)
            return
        }

        let configuration = URLSessionConfiguration.ephemeral
        configuration.timeoutIntervalForResource = 10
        let session = URLSession(configuration: configuration)

        let startTime = CFAbsoluteTimeGetCurrent()

        let downloadTask = session.dataTask(with: url) { data, response, error in

            if let error = error {
                print("Download failed with error: \(error.localizedDescription)")
                completionHandler(nil)
                return
            }

            guard let data = data else {
                print("No data received")
                completionHandler(nil)
                return
            }

            guard let httpResponse = response as? HTTPURLResponse else {
                print("Invalid HTTP response")
                completionHandler(nil)
                return
            }

            let elapsed = CFAbsoluteTimeGetCurrent() - startTime
            guard elapsed != 0 else {
                print("Invalid elapsed time")
                completionHandler(nil)
                return
            }

            let speed = (Double(data.count) / elapsed) / 1024.0 / 1024.0
            completionHandler(speed)
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
        #warning("set upload url and use kbps as in download speed!")

        guard let uploadURL = URL(string: "YOUR_UPLOAD_URL_HERE") else {
            print("Invalid upload URL")
            completionHandler(nil)
            return
        }

        var request = URLRequest(url: uploadURL)
        request.httpMethod = "POST"

        let uploadTask = URLSession.shared.uploadTask(with: request, from: data) { _, _, error in
            if let error = error {
                print("Upload failed with error: \(error.localizedDescription)")
                completionHandler(nil)
                return
            }

            // Calculate the upload speed in Mbps
            let fileSizeInBytes = Double(data.count)
            let uploadTimeInSeconds = Date().timeIntervalSinceNow * -1
            let uploadSpeedMbps = (fileSizeInBytes / uploadTimeInSeconds) / 1_000_000
            completionHandler(uploadSpeedMbps)
        }

        uploadTask.resume()
    }

    // Usage: Measure download and upload speeds
}

func convertHTTPDateToTimeInterval(httpDate: String) -> TimeInterval? {
    // Create a date formatter for the HTTP date format
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: "en_US_POSIX")
    dateFormatter.dateFormat = "E, dd MMM yyyy HH:mm:ss z"
    dateFormatter.timeZone = TimeZone(abbreviation: "GMT")

    // Attempt to convert the HTTP date string to a Date object
    if let date = dateFormatter.date(from: httpDate) {
        // Calculate the time interval from the current time to the HTTP date
        let currentTimeInterval = Date().timeIntervalSince1970
        let httpDateTimeInterval = date.timeIntervalSince1970

        // Calculate the time interval difference
        let timeDifference = currentTimeInterval - httpDateTimeInterval

        return timeDifference
    }

    return nil
}
