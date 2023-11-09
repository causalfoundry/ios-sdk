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
        injestAPIHandler.updateEventTrack(eventArray: events)
        
    }
}



class ExceptionEventsUploader {
    static func uploadEvents() {
        let exceptionManager  = ExceptionAPIHandler()
        
        let events = CoreDataHelper.shared.readExceptionsData()
        exceptionManager.updateExceptionEvents(eventArray:events)
        
    }
}



