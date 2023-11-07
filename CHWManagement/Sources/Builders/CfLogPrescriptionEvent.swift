//
//  CfLogPrescriptionEvent.swift
//
//
//  Created by khushbu on 03/11/23.
//

import Foundation
import CasualFoundryCore


public class CfLogPrescriptionEvent {
    /**
     * CfLogPrescriptionEvent is required to log events related to view, add, update, or removing
     * the prescription items value for the patient in question.
     */
    var patientId: String? = nil
    var siteId: String? = nil
    var prescriptionId: String? = nil
    var prescriptionList: [PrescriptionItem] = []
    var meta: Any? = nil
    var updateImmediately: Bool = CoreConstants.shared.updateImmediately
    
    public init(){
        
    }
    
    
    /**
     * setPatientId is for providing the id for the patient whose treatment plan elements
     * are in question.
     */
    @discardableResult
    public func setPatientId(_ patientId: String) -> CfLogPrescriptionEvent {
        self.patientId = patientId
        return self
    }
    
    /**
     * setSiteId is for providing the id for the site where treatment plan elements
     * are concluded.
     */
    @discardableResult
    public func setSiteId(_ siteId: String) -> CfLogPrescriptionEvent {
        self.siteId = siteId
        return self
    }
    
    /**
     * setPrescriptionId is for providing the id for the prescription if there
     * is more than one values in the app database. In case there is nothing available for
     * prescription id, you can use the following id as the
     * prescription id: prescription_<patient_id>
     */
    @discardableResult
    public func setPrescriptionId(_ prescriptionId: String) -> CfLogPrescriptionEvent {
        self.prescriptionId = prescriptionId
        return self
    }
    
    /**
     * addPrescriptionItem is for providing one prescription item at a time.
     * The item should be based on the prescription item object or a string that can be
     * converted to the object with proper parameter names. In case the names are not correct,
     * the SDK will throw an exception. Below is the function for providing an item as an object.
     */
    @discardableResult
    public func addPrescriptionItem(_ prescriptionItem: PrescriptionItem) -> CfLogPrescriptionEvent {
        self.prescriptionList.append(prescriptionItem)
        return self
    }
    
    /**
     * addPrescriptionItem is for providing one prescription item at a time.
     * The item should be based on the prescription item object or a string that can be
     * converted to the object with proper parameter names. In case the names are not correct,
     * the SDK will throw an exception. Below is the function for providing an item as a string.
     */
    @discardableResult
    public func addPrescriptionItem(_ prescriptionItem: String) -> CfLogPrescriptionEvent {
        if let item = try? JSONDecoder().decode(PrescriptionItem.self, from: Data(prescriptionItem.utf8)) {
            self.prescriptionList.append(item)
        }
        return self
    }
    
    /**
     * setPrescriptionList is for providing prescription items as a list.
     * The items should be based on the prescription item object or a string that can be
     * converted to the object with proper parameter names. In case the names are not correct,
     * the SDK will throw an exception. Below is the function for providing items as objects.
     */
    @discardableResult
    public func setPrescriptionList(_ prescriptionList: [PrescriptionItem]) -> CfLogPrescriptionEvent {
        self.prescriptionList = prescriptionList
        return self
    }
    
    /**
     * setPrescriptionList is for providing prescription items as a list in a string.
     * The items should be based on the prescription object or a string that can
     * be converted to the object with proper parameter names. In case the names are not correct,
     * the SDK will throw an exception. Below is the function for providing items as strings.
     */
    @discardableResult
    public func setPrescriptionList(_ prescriptionList: String) -> CfLogPrescriptionEvent {
        if !prescriptionList.isEmpty {
            
            if let data = prescriptionList.data(using: .utf8),
               let items = try? JSONDecoder().decode([PrescriptionItem].self, from: data) {
                self.prescriptionList = items
            }
            
        }
        return self
    }
    
    /**
     * You can pass any type of value in setMeta. It is for developers and partners to log
     * additional information with the log that they find would be helpful for logging and
     * providing more context to the log. The default value for meta is nil.
     */
    @discardableResult
    public func setMeta(_ meta: Any?) -> CfLogPrescriptionEvent {
        self.meta = meta
        return self
    }
    
    /**
     * updateImmediately is responsible for updating the values of the backend immediately.
     * By default, this is set to false or whatever the developer has set in the SDK
     * initialization block. This differs in the time for which the logs will be logged. If true,
     * the SDK will log the content instantly, and if false, it will wait until the end of the user
     * session, which is whenever the app goes into the background.
     */
    @discardableResult
    public func updateImmediately(_ updateImmediately: Bool) -> CfLogPrescriptionEvent {
        self.updateImmediately = updateImmediately
        return self
    }
    
    /**
     * build will validate all the values provided and, if they pass, will call the track
     * function and queue the events based on its updateImmediately value and also on the
     * user's network resources.
     */
    public func build() {
        /**
         * Will throw and exception if the patient_id provided is null or no action is
         * provided at all.
         */
        guard let patiendID =  patientId else {
            ExceptionManager.throwIsRequiredException(eventType:ChwMgmtEventType.prescription.rawValue, elementName:"patient_id")
            return
            
        }
        /**
         * Will throw and exception if the site_id provided is null or no action is
         * provided at all.
         */
        guard let siteID =  siteId else  {
            ExceptionManager.throwIsRequiredException(eventType: ChwMgmtEventType.prescription.rawValue, elementName:  "site_id")
            return
        }
        /**
         * Will throw and exception if the action provided is null or no action is
         * provided at all.
         */
        guard let presciptionID =  prescriptionId else {
            ExceptionManager.throwIsRequiredException(eventType: ChwMgmtEventType.prescription.rawValue, elementName:  "prescription_id")
            return
        }
        
        
        /**
         * Will throw and exception if the action provided is null or no action is
         * provided at all.
         */
        
        if  prescriptionList.isEmpty {
            ExceptionManager.throwIsRequiredException(eventType:ChwMgmtEventType.prescription.rawValue, elementName: "prescription_list")
        }else {
            /**
             * Parsing the values into an object and passing to the setup block to queue
             * the event based on its priority.
             */
            
            for item in prescriptionList {
                if item.drugId.isEmpty {
                    ExceptionManager.throwIsRequiredException(eventType:  ChwMgmtEventType.prescription.rawValue, elementName:  "drug_id")
                    
                } else if item.name.isEmpty {
                    ExceptionManager.throwIsRequiredException(eventType: ChwMgmtEventType.prescription.rawValue, elementName: "name")
                } else if !CoreConstants.shared.enumContains(PrescriptionItemType.self, name: item.type) {
                    ExceptionManager.throwEnumException(eventType: ChwMgmtEventType.prescription.rawValue, className:  String(describing: PrescriptionItemType.self))
                } else if !CoreConstants.shared.enumContains(PrescriptionItemFrequency.self, name: item.frequency) {
                    ExceptionManager.throwEnumException(eventType:  ChwMgmtEventType.prescription.rawValue, className: String(describing:PrescriptionItemFrequency.self))
                } else if !CoreConstants.shared.enumContains(ItemAction.self, name: item.action) {
                    ExceptionManager.throwEnumException(eventType:  ChwMgmtEventType.prescription.rawValue, className: String(describing: ItemAction.self))
                } else if item.dosageValue < 0.0 {
                    ExceptionManager.throwInvalidException(eventType:  ChwMgmtEventType.prescription.rawValue, paramName:  "dosage_value", className:String(describing:CfLogPrescriptionEvent.self))
                } else if item.dosageUnit.isEmpty {
                    ExceptionManager.throwIsRequiredException(eventType: ChwMgmtEventType.prescription.rawValue, elementName: "dosage_unit")
                } else if item.prescribedDays < 0 {
                    ExceptionManager.throwInvalidException(eventType: ChwMgmtEventType.prescription.rawValue, paramName: "prescribed_days", className:String(describing:CfLogPrescriptionEvent.self))
                }
            }
            
            let prescriptionEventObject = PrescriptionEventObject(
                patientId: patientId!,
                siteId: siteId!,
                prescriptionId: prescriptionId!,
                prescriptionList: prescriptionList,
                meta: meta as? Encodable
            )
            CFSetup().track(
                contentBlockName: ChwConstants.contentBlockName,
                eventType: ChwMgmtEventType.prescription.rawValue,
                logObject: prescriptionEventObject,
                updateImmediately: updateImmediately
            )
            
        }
        
        
        
    }
    
}
