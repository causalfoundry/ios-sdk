//
//  WorkerCaller.swift
//
//
//  Created by khushbu on 08/11/23.
//

import BackgroundTasks
import UIKit

public enum WorkerCaller {
    // Method to update events at session end
    
    public static var backgroundTaskIdentifier = "com.causalFoundry.updateAppEvents"
    
    static func scheduleBackgroundTask() {
        // Register the background task
        BGTaskScheduler.shared.register(forTaskWithIdentifier: WorkerCaller.backgroundTaskIdentifier, using: nil) { task in
            // Perform the upload task
            print("Handling background task...")
            executeBackgroundTask(task: task)
        }
    }
    
    private static func executeBackgroundTask(task: BGTask) {
        Task {
            do {
                try await InjestEvenstuploader.uploadEvents()
                try await ExceptionEventsUploader.uploadEvents()
                try await CatalogEventsUploader.uploadEvents()
                print("Background task \(task.identifier) completed")
                task.setTaskCompleted(success: true)
            } catch {
                print("Background task error: \(error.localizedDescription)")
                task.setTaskCompleted(success: false)
            }
        }
    }
    
    static func scheduleAPICalls() {
        // Create and schedule the background task request
        let request = BGProcessingTaskRequest(identifier: WorkerCaller.backgroundTaskIdentifier)
        request.requiresNetworkConnectivity = true // Set as needed
        request.requiresExternalPower = false // Set as needed
        do {
            try BGTaskScheduler.shared.submit(request)
            print("Submitted background task: \(request.identifier)")
            // add breakpoint to print statement above and execute command:
            // e -l objc -- (void)[[BGTaskScheduler sharedScheduler] _simulateLaunchForTaskWithIdentifier:@"com.causalFoundry.updateAppEvents"]
        } catch {
            print("Unable to schedule background task: \(error)")
        }
    }
}
