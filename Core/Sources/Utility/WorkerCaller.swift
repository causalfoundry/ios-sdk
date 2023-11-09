//
//  WorkerCaller.swift
//
//
//  Created by khushbu on 08/11/23.
//

import BackgroundTasks
import UIKit

class WorkerCaller {
    // Method to update events at session end
    var backgroundTaskIdentifier = "com.causalFoundry.updateAppEvents"
    
    static func registerBackgroundTask() {
        // Check if the app supports background fetch
        BGTaskScheduler.shared.register(forTaskWithIdentifier:WorkerCaller().backgroundTaskIdentifier, using: nil) { task in
            // Perform the work inside the background task
            self.handleAppRefresh(task: task as! BGAppRefreshTask)
        }
        print("Failed to register background task.")
    }
    
    
    static func updateAppEvents(application:UIApplication) {
        
        BGTaskScheduler.shared.register(forTaskWithIdentifier: WorkerCaller().backgroundTaskIdentifier, using: nil) { task in
            // Perform the work inside the background task
            self.handleAppRefresh(task: task as! BGAppRefreshTask)
        }
        
        // Create a background task request
        let request = BGAppRefreshTaskRequest(identifier: WorkerCaller().backgroundTaskIdentifier)
        request.earliestBeginDate = Date()
        
        // Schedule the background task
        do {
            try BGTaskScheduler.shared.submit(request)
        } catch {
            // Handle any errors when scheduling the task
        }
    }
    
    static func handleAppRefresh(task: BGAppRefreshTask) {
        // Schedule the next background refresh
        self.scheduleNextAppRefresh()
        
        // Create a queue to perform the background task
        let backgroundQueue = DispatchQueue.global(qos: .background)
        
        // Start the background task
        task.expirationHandler = {
            // Handle expiration if needed
        }
        
        backgroundQueue.async {
            // Perform API calls
            self.performAPICalls()
            
            // Mark the task as completed
            task.setTaskCompleted(success: true)
        }
    }
    
    static func scheduleNextAppRefresh() {
        // Calculate the next time to perform the background refresh
        let nextRefreshTime = Calendar.current.date(byAdding: .minute, value: 15, to: Date())
        
        // Create a new background task request
        let request = BGAppRefreshTaskRequest(identifier: "com.example.MyApp.backgroundTask")
        request.earliestBeginDate = nextRefreshTime
        
        // Submit the task request to the system
        do {
            try BGTaskScheduler.shared.submit(request)
        } catch {
            print("Error scheduling background task: \(error.localizedDescription)")
        }
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
