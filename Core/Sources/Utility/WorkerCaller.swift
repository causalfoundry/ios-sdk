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
            print("Background task handler called...")
            WorkerCaller.handleBackgroundTask(task: task as! BGProcessingTask)
            task.setTaskCompleted(success: true)
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
        print("Handling background task...")
        self.performAPICalls()
        task.setTaskCompleted(success: true)
    }
    
    public static  func performAPICalls() {
        Task {
            do {
//                InjestEvenstuploader.uploadEvents()
//                ExceptionEventsUploader.uploadEvents()
                catalogEventsUploader.uploadEvents()
                
            } catch(let error) {
                // Handle errors
                print("Error: \(error)")
            }
        }
    }
    
    
}
