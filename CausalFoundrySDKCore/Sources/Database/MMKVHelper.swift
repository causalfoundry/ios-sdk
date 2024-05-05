//
//  MMKVHelper.swift
//
//
//  Created by khushbu on 10/10/23.
//

import Foundation
import MMKV
import UIKit

public class MMKVHelper {
    private enum Key: String {
        case user
        case userBackup
        case userCatalog
        case exceptionData
        case eventData
        case currency
        case nudges
    }

    private struct CatalogHelper: Codable {
        let subject: CatalogSubject
        let data: Data
    }

    public static let shared = MMKVHelper()

    private let mmkv: MMKV

    public init() {
        MMKV.initialize(rootDir: nil)
        mmkv = MMKV(mmapID: "Core")!
    }
}

extension MMKVHelper {
    func readExceptionsData() -> [ExceptionDataObject] {
        let object: [ExceptionDataObject]? = read(for: Key.exceptionData.rawValue)
        return object ?? []
    }

    func writeExceptionEvents(eventArray: [ExceptionDataObject]) {
        write(eventArray, for: Key.exceptionData.rawValue)
    }
    
    func deleteExceptionEvents() {
        delete(for: Key.exceptionData.rawValue)
    }

    func writeUser(user: String?) {
        write(user, for: Key.user.rawValue)
    }

    func fetchUserID() -> String? {
        read(for: Key.user.rawValue)
    }
    
    func writeUserBackup(userId: String?) {
        write(userId, for: Key.userBackup.rawValue)
    }

    func fetchUserBackupID() -> String? {
        read(for: Key.userBackup.rawValue)
    }
    
    func deleteAllUserID() {
        delete(for: Key.userBackup.rawValue)
        delete(for: Key.userBackup.rawValue)
    }
    
    func readInjectEvents() -> [EventDataObject] {
        let object: [EventDataObject]? = read(for: Key.eventData.rawValue)
        return object ?? []
    }
    
    func writeEvents(eventsArray: [EventDataObject]) {
        write(eventsArray, for: Key.eventData.rawValue)
    }

    func deleteDataEventLogs() {
        delete(for: Key.eventData.rawValue)
    }

    public func writeCatalogData(subject: CatalogSubject, data: Data) {
        let object = CatalogHelper(subject: subject, data: data)
        write(object, for: subject.rawValue)
    }

    public func readCatalogData(subject: CatalogSubject) -> Data? {
        let object: CatalogHelper? = read(for: subject.rawValue)
        return object?.data
    }
    
    func deleteCatalogData(subject: CatalogSubject) {
        delete(for: subject.rawValue)
    }

    func readNudges() -> [BackendNudgeMainObject] {
        let object: [BackendNudgeMainObject]? = read(for: Key.nudges.rawValue)
        return object ?? []
    }

    func writeNudges(objects: [BackendNudgeMainObject]) {
        write(objects, for: Key.nudges.rawValue)
    }
    
    private func write<T: Codable>(_ object: T?, for key: String) {
        let encoder = JSONEncoder.new
        guard let data = try? encoder.encode(object) else {
            mmkv.removeValue(forKey: key)
            return
        }
        mmkv.set(data, forKey: key)
    }
    
    private func read<T: Codable>(for key: String) -> T? {
        guard let data = mmkv.data(forKey: key) else {
            return nil
        }
        let decoder = JSONDecoder.new
        return try? decoder.decode(T.self, from: data)
    }
    
    private func delete(for key: String) {
        mmkv.removeValue(forKey: key)
    }
}

public extension Encodable {
    func toData(using encoder: JSONEncoder = JSONEncoder.new) -> Data? {
        do {
            return try encoder.encode(self)
        } catch {
            print("Error encoding data: \(error)")
            return nil
        }
    }
}
