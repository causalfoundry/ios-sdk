//
//  File.swift
//
//
//  Created by khushbu on 21/11/23.
//

import Foundation
import CasualFoundryCore


public class CfLogCounselingEvent {
    
    
    /**
     * CfLogCounselingEvent is required to log events related to view, add, update or removing
     * the counseling value for the patient in question.
     */
    var patientId: String?
    var siteId: String?
    var counselingId: String?
    var counselingType: String?
    var counselingPlanList: [CounselingPlanItem] = []
    var meta: Any?
    var updateImmediately: Bool = CoreConstants.shared.updateImmediately
    
    /**
     * setPatientId is for the providing the id for the patient whose counseling
     * review is shown on screen.
     */
    @discardableResult
    public func setPatientId(_ patientId: String) -> CfLogCounselingEvent {
        self.patientId = patientId
        return self
    }
    
    /**
     * setSiteId is for the providing the id for the site where counseling
     * review is being done.
     */
    @discardableResult
    public func setSiteId(_ siteId: String) -> CfLogCounselingEvent {
        self.siteId = siteId
        return self
    }
    /**
     * setCounselingId is for the providing the id for the counseling if there is more then
     * one values in the app database. In case of there is nothing available for
     * counseling id, you can use the following id as the counseling id: Counseling_<patient_id>
     */
    
    @discardableResult
    public func setCounselingId(_ counselingId: String) -> CfLogCounselingEvent {
        self.counselingId = counselingId
        return self
    }
    /**
     * setCounselingType is for the providing the type for the counseling.
     * The item should be based on the CounselingType item object or a string that can be
     * converted to the object with proper param names. in-case the names are not correct
     * the SDK will throw an exception. Below is the function for providing item as a string.
     */
    @discardableResult
    public func setCounselingType(_ counselingType: String) -> CfLogCounselingEvent {
        if !CoreConstants.shared.enumContains(CounselingType.self, name:counselingType ) {
            ExceptionManager.throwEnumException(eventType: ChwMgmtEventType.counseling.rawValue, className:String(describing:counselingType) )
        } else {
            self.counselingType = counselingType
        }
        return self
    }
    
    /**
     * addCounselingPlanItem is for the providing pne counseling plan item at a time.
     * The item should be based on the counseling item object or a string that can be
     * converted to the object with proper param names. in-case the names are not correct
     * the SDK will throw an exception. Below is the function for providing item as an object.
     */
    @discardableResult
    public func addCounselingPlanItem(_ counselingPlanItem: CounselingPlanItem) -> CfLogCounselingEvent {
        self.counselingPlanList.append(counselingPlanItem)
        return self
    }
    
    /**
     * addCounselingPlanItem is for the providing pne counseling plan item at a time.
     * The item should be based on the counseling item object or a string that can be
     * converted to the object with proper param names. in-case the names are not correct
     * the SDK will throw an exception. Below is the function for providing item as a string.
     */
    @discardableResult
    public func addCounselingPlanItem(_ counselingPlanItem: String) -> CfLogCounselingEvent {
        if let diagnosisItem = try? JSONDecoder.new.decode(CounselingPlanItem.self, from: counselingPlanItem.data(using: .utf8)!) {
            counselingPlanList.append(diagnosisItem)
        }
        return self
    }
    
    /**
     * setCounselingPlanList is for the providing pne counseling plan items as a list.
     * The item should be based on the counseling item object or a string that can be
     * converted to the object with proper param names. in-case the names are not correct
     * the SDK will throw an exception. Below is the function for providing item as an object.
     */
    @discardableResult
    public func setCounselingPlanList(_ counselingPlanList: [CounselingPlanItem]) -> CfLogCounselingEvent {
        self.counselingPlanList = counselingPlanList
        return self
    }
    
    /**
     * setCounselingPlanList is for the providing pne counseling plan items as a list in a string.
     * The item should be based on the counseling item object or a string that can be
     * converted to the object with proper param names. in-case the names are not correct
     * the SDK will throw an exception. Below is the function for providing item as a string.
     */
    @discardableResult
    public func setCounselingPlanList(_ counselingPlanList: String) -> CfLogCounselingEvent {
        if !counselingPlanList.isEmpty {
            
            if let data = counselingPlanList.data(using: .utf8),
               let itemsList = try? JSONDecoder.new.decode([CounselingPlanItem].self, from: data) {
                self.counselingPlanList = itemsList
            }
        }
        return self
    }
    
    /**
     * You can pass any type of value in setMeta. It is for developer and partners to log
     * additional information with the log that they find would be helpful for logging and
     * providing more context to the log. Default value for the meta is null.
     */
    @discardableResult
    public func setMeta(_ meta: Any?) -> CfLogCounselingEvent {
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
    public func updateImmediately(_ updateImmediately: Bool) -> CfLogCounselingEvent {
        self.updateImmediately = updateImmediately
        return self
    }
    /**
     * build will validate all of the values provided and if passes will call the track
     * function and queue the events based on it's updateImmediately value and also on the
     * user's network resources.
     */
    
    func build() {
        
        /**
         * Will throw and exception if the patient_id provided is null or no action is
         * provided at all.
         */
        guard let patientID = patientId else {
            ExceptionManager.throwIsRequiredException(eventType: ChwMgmtEventType.counseling.rawValue, elementName: "patient_id")
            return
        }
        guard let siteID = siteId else {
            ExceptionManager.throwIsRequiredException(eventType: ChwMgmtEventType.counseling.rawValue, elementName: "site_id")
            return
        }
        
        guard let counselingID = counselingId else {
            ExceptionManager.throwIsRequiredException(eventType: ChwMgmtEventType.counseling.rawValue, elementName: "counseling_id")
            return
        }
        guard let counseling_Type = counselingType else {
            ExceptionManager.throwIsRequiredException(eventType: ChwMgmtEventType.counseling.rawValue, elementName: "counseling_type")
            return
        }
        if counselingPlanList.isEmpty {
            ExceptionManager.throwIsRequiredException(eventType: ChwMgmtEventType.counseling.rawValue, elementName: "counseling_plan_list")
            return
        }else {
            
            if ChwEventValidation.verifyCounselingPlanList(eventType: ChwMgmtEventType.counseling, counselingPlanList: counselingPlanList) {
                let counselingEventObject = CounselingEventObject(
                    patientId: patientID,
                    siteId: siteID,
                    counselingId: counselingID,
                    counselingType: counseling_Type,
                    counselingPlanList: counselingPlanList,
                    meta: meta as? Encodable
                )
                CFSetup().track(
                    contentBlockName: ChwConstants.contentBlockName,
                    eventType: ChwMgmtEventType.counseling.rawValue,
                    logObject: counselingEventObject,
                    updateImmediately: updateImmediately
                )
            }
        }
    }
    
}

