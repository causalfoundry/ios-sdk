//
//  Evenstuploader.swift
//
//
//  Created by khushbu on 08/11/23.
//

import Foundation

class InjestEvenstuploader {
    static func uploadEvents(events:[EventDataObject]) {
        var injestAPIHandler  = IngestAPIHandler()
        
        var events = CoreDataHelper.shared.readEvents()
        injestAPIHandler.updateEventTrack(eventArray: events)
        
    }
}
