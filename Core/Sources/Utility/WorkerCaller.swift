//
//  WorkerCaller.swift
//
//
//  Created by khushbu on 08/11/23.
//

import BackgroundTasks
import UIKit

public class WorkerCaller {
    // Method to update events at session end
   public var backgroundTaskIdentifier = "com.causalFoundry.updateAppEvents"
    
    public static func registerBackgroundTask() {
        
        BGTaskScheduler.shared.register(forTaskWithIdentifier:WorkerCaller().backgroundTaskIdentifier, using: nil) { task in
           self.handleBackgroundTask(task: task as! BGProcessingTask)
        }
        
        let request = BGProcessingTaskRequest(identifier: WorkerCaller().backgroundTaskIdentifier)
        request.requiresNetworkConnectivity = true // Set as needed
        request.requiresExternalPower = false // Set as needed
        if #available(iOS 15, *) {
            request.earliestBeginDate = .now
        } else {
            // Fallback on earlier versions
        }

        do {
            try BGTaskScheduler.shared.submit(request)
        } catch {
            print("Unable to schedule background task: \(error)")
        }
    }

    public static func handleBackgroundTask(task: BGProcessingTask) {
        self.performAPICalls()
        task.setTaskCompleted(success: true)
    }
    
    public static  func performAPICalls() {
        Task {
            do {
               let result1: () = try await InjestEvenstuploader.uploadEvents()
               let result2: () = try await ExceptionEventsUploader.uploadEvents()
                
                
                // Process the API responses
                print("API Response 1: \(result1)")
                print("API Response 2: \(result2)")
                
                // Continue with any further processing...
            } catch {
                // Handle errors
                print("Error: \(error)")
            }
        }
    }
    
    
}
