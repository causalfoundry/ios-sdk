//
//  InjestEvenstuploader.swift
//
//
//  Created by khushbu on 08/11/23.
//

import Foundation

enum InjestEvenstuploader {
    static func uploadEvents() async throws {
        if #available(iOS 13.0, *) {
            let injestAPIHandler = IngestAPIHandler()
            let events = MMKVHelper.shared.readInjectEvents()
            guard events.count > 0 else {
                print("No More Injest events")
                return
            }
            try await withCheckedThrowingContinuation { continuation in
                injestAPIHandler.updateEventTrack(eventArray: events) { success in
                    if success {
                        MMKVHelper.shared.deleteDataEventLogs()
                        continuation.resume(with: .success(()))
                    } else {
                        continuation.resume(with: .failure(NSError(domain: "InjestEvenstuploader.uploadEvents", code: 0)))
                    }
                }
            }
        }
    }
}

enum ExceptionEventsUploader {
    static func uploadEvents() async throws {
        if #available(iOS 13.0, *) {
            let exceptionManager = ExceptionAPIHandler()
            let events = MMKVHelper.shared.readExceptionsData()
            guard events.count > 0 else {
                print("No More Exception events")
                return
            }
            try await withCheckedThrowingContinuation { continuation in
                exceptionManager.updateExceptionEvents(eventArray: events) { success in
                    if success {
                        continuation.resume(with: .success(()))
                    } else {
                        continuation.resume(with: .failure(NSError(domain: "ExceptionEventsUploader.uploadEvents", code: 0)))
                    }
                }
            }
        }
    }
}

public enum CatalogEventsUploader {
    public static func uploadEvents() async throws {
        if #available(iOS 13.0, *) {
            guard !CoreConstants.shared.pauseSDK else { return }
            let catalogAPIHandler = CatalogAPIHandler()
            await withThrowingTaskGroup(of: Void.self) { group in
                for value in CatalogSubject.allCases {
                    guard let eventData = MMKVHelper.shared.readCatalogData(subject: value) else { continue }
                    group.addTask {
                        let catalogMainObject = try? JSONSerialization.jsonObject(with: eventData, options: []) as? [Any]
                        try await withCheckedThrowingContinuation { continuation in
                            catalogAPIHandler.callCatalogAPI(catalogMainObject: catalogMainObject ?? [], catalogSubject: value.rawValue) { success in
                                if success {
                                    MMKVHelper.shared.deleteCatalogData(subject: value)
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
}
