//
//  Evenstuploader.swift
//
//
//  Created by khushbu on 08/11/23.
//

import Foundation

class InjestEvenstuploader {
    static func uploadEvents() {
        let injestAPIHandler  = IngestAPIHandler()
        
        let events = CoreDataHelper.shared.readEvents()
        if events.count > 0  {
            injestAPIHandler.updateEventTrack(eventArray: events) { success in
                CoreDataHelper.shared.deleteDataEventLogs()
            }
        }else {
            print("No More Injest events")
        }
    }
}



class ExceptionEventsUploader {
    static func uploadEvents() {
        let exceptionManager  = ExceptionAPIHandler()
        
        let events = CoreDataHelper.shared.readExceptionsData()
        if events.count > 0 {
            exceptionManager.updateExceptionEvents(eventArray:events)
        }else {
            print("No More Exception events")
        }
        
        
    }
}



