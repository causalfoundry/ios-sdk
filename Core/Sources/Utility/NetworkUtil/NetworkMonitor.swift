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
    }
    
    // Starts monitoring connectivity changes
    public func startMonitoring() {
        
        monitor.pathUpdateHandler = { [weak self] path in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.connectivityStatus
                    .send(self.getConnectivityFrom(status: path.status))
            }
        }
        
        monitor.start(queue: queue)
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
}

