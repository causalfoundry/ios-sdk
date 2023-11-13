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
    var backgroundTaskIdentifier = "com.causalFoundry.updateAppEvents"
    
    static func registerBackgroundTask() {
        
        BGTaskScheduler.shared.register(forTaskWithIdentifier:WorkerCaller().backgroundTaskIdentifier, using: nil) { task in
           self.handleBackgroundTask(task: task as! BGProcessingTask)
        }
    }

    static func handleBackgroundTask(task: BGProcessingTask) {
        self.performAPICalls()
        task.setTaskCompleted(success: true)
    }
    
    static  func performAPICalls() {
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
