//
//  CoreDataHelper.swift
//
//
//  Created by khushbu on 10/10/23.
//

import Foundation
import UIKit
import MMKV

public class CoreDataHelper {
    
    private enum Key: String {
        case user
        case userCatalog
        case exceptionData
        case eventData
        case currency
    }
    
    private struct CatalogHelper: Codable {
        let subject: CatalogSubject
        let data: Data
    }
    
    public static let shared = CoreDataHelper()
    
    private let mmkv: MMKV
    
    public init() {
        MMKV.initialize(rootDir: nil)
        mmkv = MMKV(mmapID: "Core")!
    }
}

extension CoreDataHelper {
    
    // GET ALL EXCEPTION LOGS
    func readExceptionsData() -> [ExceptionDataObject] {
        guard let data = mmkv.data(forKey: Key.exceptionData.rawValue) else {
            return []
        }
        let decoder = JSONDecoder.new
        let result = try? decoder.decode([ExceptionDataObject].self, from: data)
        return result ?? []
    }
    
    func writeExceptionEvents(eventArray: [ExceptionDataObject]) {
        let encoder = JSONEncoder.new
        guard let data = try? encoder.encode(eventArray) else {
            return
        }
        mmkv.set(data, forKey: Key.exceptionData.rawValue)
    }
    
    
    func writeUser(user: String?) {
        if let user = user {
            mmkv.set(user, forKey: Key.user.rawValue)
        } else {
            mmkv.removeValue(forKey: Key.user.rawValue)
        }
    }
    
    
    // MARK: - Fetch User ID
    func fetchUserID() -> String {
        return mmkv.string(forKey: Key.user.rawValue) ?? ""
    }
    /**
     * To read user events from DB, default is empty list
     */
    func readInjectEvents() -> [EventDataObject] {
        guard let data = mmkv.data(forKey: Key.eventData.rawValue) else {
            return []
        }
        let decoder = JSONDecoder.new
        let result = try? decoder.decode([EventDataObject].self, from: data)
        return result ?? []
        
    }
    /**
     * To write user events in DB
     */
    func writeEvents(eventsArray: [EventDataObject]) {
        let encoder = JSONEncoder.new
        guard let data = try? encoder.encode(eventsArray) else {
            return
        }
        mmkv.set(data, forKey: Key.eventData.rawValue)
    }
    
    func readUserCatalog() -> UserCatalogModel? {
        guard let data = mmkv.data(forKey: Key.userCatalog.rawValue) else {
            return nil
        }
        let decoder = JSONDecoder.new
        let result = try? decoder.decode(UserCatalogModel.self, from: data)
        return result
    }
    
    func writeUserCatalog(userCataLogData: UserCatalogModel)  {
        let encoder = JSONEncoder.new
        guard let data = try? encoder.encode(userCataLogData) else {
            return
        }
        mmkv.set(data, forKey: Key.userCatalog.rawValue)
    }
    
    // Currency Data
    func readCurrencyObject() -> CurrencyMainObject? {
        guard let data = mmkv.data(forKey: Key.currency.rawValue) else {
            return nil
        }
        let decoder = JSONDecoder.new
        let result = try? decoder.decode(CurrencyMainObject.self, from: data)
        return result
    }
    
    
    func writeCurrencyObject(currency: CurrencyMainObject) {
        let encoder = JSONEncoder.new
        guard let data = try? encoder.encode(currency) else {
            return
        }
        mmkv.set(data, forKey: Key.currency.rawValue)
    }
    
    public func writeCatalogData(subject: CatalogSubject, data: Data) {
        let object = CatalogHelper(subject: subject, data: data)
        let encoder = JSONEncoder.new
        guard let data = try? encoder.encode(object) else {
            return
        }
        mmkv.set(data, forKey: subject.rawValue)
    }
    
   public func readCatalogData(subject: CatalogSubject) -> Data? {
       guard let data = mmkv.data(forKey: subject.rawValue) else {
           return nil
       }
       let decoder = JSONDecoder.new
       let result = try? decoder.decode(CatalogHelper.self, from: data)
       return result?.data
    }
    
    
    func deleteDataEventLogs() {
        mmkv.removeValue(forKey: Key.eventData.rawValue)
    }
}


extension Encodable {
    public func toData(using encoder: JSONEncoder = JSONEncoder.new) -> Data? {
        do {
            return try encoder.encode(self)
        } catch {
            print("Error encoding data: \(error)")
            return nil
        }
    }
}
