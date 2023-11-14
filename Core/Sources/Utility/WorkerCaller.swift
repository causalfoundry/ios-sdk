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
    
    
    func scheduleBackgroundTask() {
            // Register the background task
        BGTaskScheduler.shared.register(forTaskWithIdentifier: WorkerCaller().backgroundTaskIdentifier, using: nil) { task in
                // Perform the upload task
            WorkerCaller.handleBackgroundTask(task: task as! BGProcessingTask)
        }

            // Create and schedule the background task request
            let request = BGProcessingTaskRequest(identifier: WorkerCaller().backgroundTaskIdentifier)
            request.requiresNetworkConnectivity = true // Set as needed
            request.requiresExternalPower = false // Set as needed

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
