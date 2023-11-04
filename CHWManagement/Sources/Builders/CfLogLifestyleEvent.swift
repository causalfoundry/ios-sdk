//
//  CfLogLifestyleEvent.swift
//
//
//  Created by khushbu on 26/10/23.
//

import Foundation
import CasualFoundryCore


public class CfLogLifestyleEvent {
    
    
    /**
     * CfLogLifestyleEvent is required to log events related to view, add, update or removing
     * the lifestyle value for the patient in question.
     */
    
    
    var patientId: String?
    var siteId: String?
    var lifestyleId: String?
    var lifestylePlanList: [LifestylePlanItem] = []
    var meta: Any?
    var updateImmediately: Bool = CoreConstants.shared.updateImmediately
    
    
    public init(){
        
    }
    
    /**
     * setPatientId is for the providing the id for the patient whose lifestyle
     * review is shown on screen.
     */
    @discardableResult
    public func setPatientId(_ patientId: String) -> CfLogLifestyleEvent {
        self.patientId = patientId
        return self
    }
    
    
    /**
     * setSiteId is for the providing the id for the site where lifestyle
     * review is being done.
     */
    @discardableResult
    public func setSiteId(_ siteId: String) -> CfLogLifestyleEvent {
        self.siteId = siteId
        return self
    }
    
    /**
     * setLifestyleId is for the providing the id for the lifestyle if there is more then
     * one values in the app database. In case of there is nothing available for
     * lifestyle id, you can use the following id as the lifestyle id: lifestyle_<patient_id>
     */
    @discardableResult
    public func setLifestyleId(_ lifestyleId: String) -> CfLogLifestyleEvent {
        self.lifestyleId = lifestyleId
        return self
    }
    
    /**
     * addLifestylePlanItem is for the providing pne lifestyle plan item at a time.
     * The item should be based on the lifestyle item object or a string that can be
     * converted to the object with proper param names. in-case the names are not correct
     * the SDK will throw an exception. Below is the function for providing item as an object.
     */
    @discardableResult
    public func addLifestylePlanItem(_ lifestylePlanItem: LifestylePlanItem) -> CfLogLifestyleEvent {
        self.lifestylePlanList.append(lifestylePlanItem)
        return self
    }
    /**
     * addLifestylePlanItem is for the providing pne lifestyle plan item at a time.
     * The item should be based on the lifestyle item object or a string that can be
     * converted to the object with proper param names. in-case the names are not correct
     * the SDK will throw an exception. Below is the function for providing item as a string.
     */
    
    @discardableResult
    public func addLifestylePlanItem(_ lifestylePlanItem: String) -> CfLogLifestyleEvent {
        if let item = try? JSONDecoder().decode(LifestylePlanItem.self, from: Data(lifestylePlanItem.utf8)) {
            self.lifestylePlanList.append(item)
        }
        return self
    }
    
    /**
     * setLifestylePlanList is for the providing pne lifestyle plan items as a list.
     * The item should be based on the lifestyle item object or a string that can be
     * converted to the object with proper param names. in-case the names are not correct
     * the SDK will throw an exception. Below is the function for providing item as an object.
     */
    @discardableResult
    public func setLifestylePlanList(_ lifestylePlanList: [LifestylePlanItem]) -> CfLogLifestyleEvent {
        self.lifestylePlanList = lifestylePlanList
        return self
    }
    
    /**
     * setLifestylePlanList is for the providing pne lifestyle plan items as a list in a string.
     * The item should be based on the lifestyle item object or a string that can be
     * converted to the object with proper param names. in-case the names are not correct
     * the SDK will throw an exception. Below is the function for providing item as a string.
     */
    @discardableResult
    public func setLifestylePlanList(_ lifestylePlanList: String) -> CfLogLifestyleEvent {
        if let data = lifestylePlanList.data(using: .utf8),
           let items = try? JSONDecoder().decode([LifestylePlanItem].self, from: data) {
            self.lifestylePlanList = items
        }
        return self
    }
    
    /**
     * You can pass any type of value in setMeta. It is for developer and partners to log
     * additional information with the log that they find would be helpful for logging and
     * providing more context to the log. Default value for the meta is null.
     */
    @discardableResult
    public func setMeta(_ meta: Any?) -> CfLogLifestyleEvent {
        self.meta = meta
        return self
    }
    /**
     * updateImmediately is responsible for updating the values ot the backend immediately.
     * By default this is set to false or whatever the developer has set in the SDK
     * initialisation block. This differs the time for which the logs will be logged, if true,
     * the SDK will log the content instantly and if false it will wait till the end of user
     * session which is whenever the app goes into background.
     */
    @discardableResult
    public func updateImmediately(_ updateImmediately: Bool) -> CfLogLifestyleEvent {
        self.updateImmediately = updateImmediately
        return self
    }
    
    public func build() {
        guard let patientId = patientId, !patientId.isEmpty,
              let siteId = siteId, !siteId.isEmpty,
              let lifestyleId = lifestyleId, !lifestyleId.isEmpty,
              !lifestylePlanList.isEmpty else {
            ExceptionManager.throwIsRequiredException(eventType: ChwMgmtEventType.lifestyle.rawValue, elementName:"patient_id")
            return
        }
        
        for item in lifestylePlanList {
            if item.name.isEmpty {
                ExceptionManager.throwIsRequiredException(eventType: ChwMgmtEventType.lifestyle.rawValue, elementName: "name")
                return
            } else if !CoreConstants.shared.enumContains(ItemAction.self, name: item.action) {
                ExceptionManager.throwIsRequiredException(eventType: ChwMgmtEventType.lifestyle.rawValue, elementName: String(describing: ItemAction.self))
                return
            }
        }
        
        let lifestyleEventObject = LifestyleEventObject(
            patientId: patientId,
            siteId: siteId,
            lifestyleId: lifestyleId,
            lifestylePlanList: lifestylePlanList,
            meta: meta
        )
        
        CFSetup().track(
            contentBlockName: ChwConstants.contentBlockName,
            eventType: ChwMgmtEventType.lifestyle.rawValue,
            logObject: lifestyleEventObject,
            updateImmediately: updateImmediately
        )
    }
}
