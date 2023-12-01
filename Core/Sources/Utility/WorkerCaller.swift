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
    
    private static var eventUploadTaskIdentifier = "com.causalFoundry.updateAppEvents"
    private static var nudgeDownloadTaskIdentifier = "com.causalFoundry.downloadNudges"
    
    static func registerBackgroundTask() {
        registerEventUploadTask()
        registerNudgeDownloadTask()
    }
    
    static func scheduleBackgroundTasks() {
        scheduleEventUploadTask()
    }
    
    private static func registerEventUploadTask() {
        BGTaskScheduler.shared.register(forTaskWithIdentifier: WorkerCaller.eventUploadTaskIdentifier, using: nil) { task in
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
    }
    
    private static func registerNudgeDownloadTask() {
        BGTaskScheduler.shared.register(forTaskWithIdentifier: WorkerCaller.nudgeDownloadTaskIdentifier, using: nil) { task in
            Task {
                do {
                    try await CFNudgeListener.shared.fetchNudges()
                    print("Background task \(task.identifier) completed")
                    task.setTaskCompleted(success: true)
                } catch {
                    print("Background task error: \(error.localizedDescription)")
                    task.setTaskCompleted(success: false)
                }
            }
        }
    }
    
    private static func scheduleEventUploadTask() {
        let request = BGProcessingTaskRequest(identifier: WorkerCaller.eventUploadTaskIdentifier)
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
    
    private static func scheduleNudgeDownloadTask() {
        let request = BGProcessingTaskRequest(identifier: WorkerCaller.nudgeDownloadTaskIdentifier)
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
    
    #if DEBUG
    public static func performUpload() async throws {
        try await InjestEvenstuploader.uploadEvents()
        try await ExceptionEventsUploader.uploadEvents()
        try await CatalogEventsUploader.uploadEvents()
    }
    #endif
}
