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
    var backgroundTask: UIBackgroundTaskIdentifier = .invalid
    
    
    func scheduleBackgroundTask() {
//            // Register the background task
//        BGTaskScheduler.shared.register(forTaskWithIdentifier: WorkerCaller().backgroundTaskIdentifier, using: nil) { task in
//                // Perform the upload task
//            print("Background task handler called...")
//            WorkerCaller.handleBackgroundTask(task: task as! BGProcessingTask)
//        }
//
//            // Create and schedule the background task request
//            let request = BGProcessingTaskRequest(identifier: WorkerCaller().backgroundTaskIdentifier)
//            request.requiresNetworkConnectivity = true // Set as needed
//            request.requiresExternalPower = false // Set as needed
//
//            do {
//                try BGTaskScheduler.shared.submit(request)
//            } catch {
//                print("Unable to schedule background task: \(error)")
//            }
            backgroundTask = UIApplication.shared.beginBackgroundTask { [weak self] in
                  self?.endBackgroundTask()
              }

              DispatchQueue.global(qos: .background).async {
                  // Your long-running API call logic goes here
                  WorkerCaller.performAPICalls()

                  // Make sure to call endBackgroundTask when your task is completed
                  
              }
        }
    
    func endBackgroundTask() {
           UIApplication.shared.endBackgroundTask(backgroundTask)
           backgroundTask = .invalid
       }
   
    public static func handleBackgroundTask(task: BGProcessingTask) {
        print("Handling background task...")
        self.performAPICalls()
        task.setTaskCompleted(success: true)
    }
    
    public static  func performAPICalls() {
        Task {
            do {
               let result1: () = try await InjestEvenstuploader.uploadEvents()
               let result2: () = try await ExceptionEventsUploader.uploadEvents()
                
                
              
            } catch {
                // Handle errors
                print("Error: \(error)")
            }
        }
    }
    
    
}
