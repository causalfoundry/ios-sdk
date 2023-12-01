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
        scheduleNudgeDownloadTask()
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
                    scheduleEventUploadTask(earliestBeginDate: Date(timeIntervalSinceNow: 30 * 60)) // try again in 30 minutes
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
                    let objects = try await CFNudgeListener.shared.fetchNudges()
                    objects.forEach { object in
                        CFNotificationController.shared.triggerNudgeNotification(object: object)
                    }
                    print("Background task \(task.identifier) completed")
                    task.setTaskCompleted(success: true)
                } catch {
                    print("Background task error: \(error.localizedDescription)")
                    task.setTaskCompleted(success: false)
                }
                scheduleNudgeDownloadTask()
            }
        }
    }
    
    private static func scheduleEventUploadTask(earliestBeginDate: Date? = nil) {
        let request = BGProcessingTaskRequest(identifier: WorkerCaller.eventUploadTaskIdentifier)
        request.requiresNetworkConnectivity = true // Set as needed
        request.requiresExternalPower = false // Set as needed
        request.earliestBeginDate = earliestBeginDate
        do {
            try BGTaskScheduler.shared.submit(request)
            print("Submitted background task: \(request.identifier)")
            // add breakpoint to print statement above and execute command:
            // e -l objc -- (void)[[BGTaskScheduler sharedScheduler] _simulateLaunchForTaskWithIdentifier:@"com.causalFoundry.updateAppEvents"]
        } catch {
            print("Unable to schedule background task: \(error)")
        }
    }
    
    private static func scheduleNudgeDownloadTask(earliestBeginDate: Date = Date(timeIntervalSinceNow: 20 * 60)) {
        let request = BGProcessingTaskRequest(identifier: WorkerCaller.nudgeDownloadTaskIdentifier)
        request.requiresNetworkConnectivity = true // Set as needed
        request.requiresExternalPower = false // Set as needed
        request.earliestBeginDate = earliestBeginDate
        do {
            try BGTaskScheduler.shared.submit(request)
            print("Submitted background task: \(request.identifier)")
            // add breakpoint to print statement above and execute command:
            // e -l objc -- (void)[[BGTaskScheduler sharedScheduler] _simulateLaunchForTaskWithIdentifier:@"com.causalFoundry.downloadNudges"]
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
