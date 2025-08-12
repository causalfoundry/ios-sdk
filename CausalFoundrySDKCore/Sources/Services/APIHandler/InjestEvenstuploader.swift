//
//  InjestEvenstuploader.swift
//
//
//  Created by khushbu on 08/11/23.
//

import Foundation


enum InjestEvenstuploader {
    @available(iOS 13.0, *)
    static func uploadEvents() async throws {
        let injestAPIHandler = IngestAPIHandler()
        let filteredArray = MMKVHelper.shared.readInjectEvents().filter { !$0.isTypeOrPropsEmpty }.removingDuplicates()
        guard filteredArray.count > 0 else {
            print("No More Injest events")
            return
        }
        try await withCheckedThrowingContinuation { continuation in
            injestAPIHandler.updateEventTrack(eventArray: filteredArray) { success in
                if success {
                    MMKVHelper.shared.deleteDataEventLogs()
                    continuation.resume(with: .success(()))
                } else {
                    continuation.resume(with: .failure(NSError(domain: "InjestEvenstuploader.uploadEvents", code: 0)))
                }
            }
        }
    }
    
    
    @available(iOS 13.0, *)
    static func uploadEventsAfterRemovingSanitize(indexToRemove : Int) async throws {
        var filteredArray = MMKVHelper.shared.readInjectEvents().filter { !$0.isTypeOrPropsEmpty }.removingDuplicates()
        guard filteredArray.count > 0 else {
            print("No More Injest events")
            return
        }
        
        if indexToRemove >= 0 && indexToRemove < filteredArray.count {
            filteredArray.remove(at: indexToRemove)
        }
        MMKVHelper.shared.writeEvents(eventsArray: filteredArray)
        
        try await withCheckedThrowingContinuation { continuation in
            IngestAPIHandler().updateEventTrack(eventArray: filteredArray) { success in
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

public enum CatalogEventsUploader {
    @available(iOS 13.0, *)
    public static func uploadEvents() async throws {
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
