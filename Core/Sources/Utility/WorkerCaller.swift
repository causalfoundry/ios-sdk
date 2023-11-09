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
    static func updateAppEvents(application:UIApplication) {
        // Register a background task identifier
        let backgroundTaskIdentifier = "com.causalFoundry.updateAppEvents"
        
        BGTaskScheduler.shared.register(forTaskWithIdentifier: backgroundTaskIdentifier, using: nil) { task in
            // Perform the work inside the background task
            self.handleBackgroundTask(task: task as! BGAppRefreshTask)
        }
        
        // Create a background task request
        let request = BGAppRefreshTaskRequest(identifier: backgroundTaskIdentifier)
        request.earliestBeginDate = Date(timeIntervalSinceNow: 60 * 15) // Start the task in 15 minutes
        
        // Schedule the background task
        do {
            try BGTaskScheduler.shared.submit(request)
        } catch {
            // Handle any errors when scheduling the task
        }
    }
    
    static func handleBackgroundTask(task: BGAppRefreshTask) {
       
        task.setTaskCompleted(success: true)
    }
}
