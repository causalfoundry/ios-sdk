//
//  Evenstuploader.swift
//
//
//  Created by khushbu on 08/11/23.
//

import Foundation

class InjestEvenstuploader {
    static func uploadEvents() async throws {
        let injestAPIHandler  = IngestAPIHandler()
        let events = CoreDataHelper.shared.readInjectEvents()
        guard events.count > 0 else {
            print("No More Injest events")
            return
        }
        try await withCheckedThrowingContinuation { continuation in
            injestAPIHandler.updateEventTrack(eventArray: events) { success in
                if success {
                    CoreDataHelper.shared.deleteDataEventLogs()
                    continuation.resume(with: .success(()))
                } else {
                    continuation.resume(with: .failure(NSError(domain: "InjestEvenstuploader.uploadEvents", code: 0)))
                }
            }
        }
    }
}



class ExceptionEventsUploader {
    static func uploadEvents() async throws {
        let exceptionManager  = ExceptionAPIHandler()
        let events = CoreDataHelper.shared.readExceptionsData()
        guard events.count > 0 else {
            print("No More Exception events")
            return
        }
        try await withCheckedThrowingContinuation { continuation in
            exceptionManager.updateExceptionEvents(eventArray:events) { success in
                if success {
                    continuation.resume(with: .success(()))
                } else {
                    continuation.resume(with: .failure(NSError(domain: "ExceptionEventsUploader.uploadEvents", code: 0)))
                }
            }
        }
    }
}


public class CatalogEventsUploader {
    public static func uploadEvents() async throws {
        let catalogAPIHandler  = CatalogAPIHandler()
        await withThrowingTaskGroup(of: Void.self) { group in
            for value in  CatalogSubject.allCases {
                guard let eventData =  CoreDataHelper().readCataLogData(subject: value.rawValue) else { continue }
                group.addTask {
                    #warning("SWIFT TASK CONTINUATION MISUSE: uploadEvents() leaked its continuation!")
                    try await withCheckedThrowingContinuation { continuation in
                        catalogAPIHandler.callCatalogAPI(catalogMainObject: eventData, catalogSubject: value.rawValue) { success in
                            if success {
                                continuation.resume(with: .success(()))
                            } else {
                                continuation.resume(with: .failure(NSError(domain: "CatalogEventsUploader.uploadEvents", code: 0)))
                            }
                        }
                    }
                }
            }
        }
    }
}
