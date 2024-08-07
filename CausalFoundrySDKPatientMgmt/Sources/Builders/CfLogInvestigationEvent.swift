//
//  CfLogInvestigationEvent.swift
//
//
//  Created by khushbu on 26/10/23.
//

import CausalFoundrySDKCore
import Foundation

/**
 * CfLogInvestigationEvent is required to log events related to view, add, update, or removing
 * the Prescribed Tests value for the patient in question.
 */

public class CfLogInvestigationEvent {
    var patientId: String?
    var siteId: String?
    var investigationId: String?
    var prescribedTestsList: [InvestigationItem] = []
    var meta: Any?
    var updateImmediately: Bool = CoreConstants.shared.updateImmediately

    public init() {}

    /**
     * setPatientId is for providing the ID for the patient whose Investigation tests
     * are in question.
     */
    @discardableResult
    public func setPatientId(patientId: String) -> CfLogInvestigationEvent {
        self.patientId = patientId
        return self
    }

    /**
     * setSiteId is for providing the ID for the site where Investigation tests
     * are being done.
     */
    @discardableResult
    public func setSiteId(siteId: String) -> CfLogInvestigationEvent {
        self.siteId = siteId
        return self
    }

    /**
     * setInvestigationId is for providing the ID for the investigation if there
     * is more than one value in the app database. In case there is nothing available for
     * investigation ID, you can use the following ID as the
     * investigation ID: investigation_<patientId>
     */
    @discardableResult
    public func setInvestigationId(investigationId: String) -> CfLogInvestigationEvent {
        self.investigationId = investigationId
        return self
    }

    /**
     * addInvestigationItem is for providing one investigation test item at a time.
     * The item should be based on the investigation item object or a string that can be
     * converted to the object with proper parameter names. In case the names are not correct,
     * the SDK will throw an exception.
     */
    @discardableResult
    public func addInvestigationItem(investigationItem: InvestigationItem) -> CfLogInvestigationEvent {
        prescribedTestsList.append(investigationItem)
        return self
    }

    /**
     * addInvestigationItem is for providing one investigation test item at a time.
     * The item should be based on the investigation item object or a string that can be
     * converted to the object with proper parameter names. In case the names are not correct,
     * the SDK will throw an exception.
     */
    @discardableResult
    public func addInvestigationItem(investigationItem: String) -> CfLogInvestigationEvent {
        if let item = try? JSONDecoder.new.decode(InvestigationItem.self, from: Data(investigationItem.utf8)) {
            prescribedTestsList.append(item)
        }
        return self
    }

    /**
     * setInvestigationList is for providing one investigation test items as a list.
     * The item should be based on the investigation item object or a string that can be
     * converted to the object with proper parameter names. In case the names are not correct,
     * the SDK will throw an exception.
     */
    @discardableResult
    public func setInvestigationList(prescribedTestsList: [InvestigationItem]) -> CfLogInvestigationEvent {
        self.prescribedTestsList = prescribedTestsList
        return self
    }

    /**
     * setInvestigationList is for providing one investigation test items as a list
     * in a string. The item should be based on the investigation item object or a string that
     * can be converted to the object with proper parameter names. In case the names are not correct,
     * the SDK will throw an exception.
     */
    @discardableResult
    public func setInvestigationList(prescribedTestsList: String) -> CfLogInvestigationEvent {
        if let data = prescribedTestsList.data(using: .utf8),
           let itemsList = try? JSONDecoder.new.decode([InvestigationItem].self, from: data)
        {
            self.prescribedTestsList = itemsList
        }
        return self
    }

    /**
     * You can pass any type of value in setMeta. It is for developers and partners to log
     * additional information with the log that they find would be helpful for logging and
     * providing more context to the log. The default value for meta is nil.
     */
    @discardableResult
    public func setMeta(meta: Any?) -> Self {
        self.meta = meta
        return self
    }

    /**
     * updateImmediately is responsible for updating the values to the backend immediately.
     * By default, this is set to false or whatever the developer has set in the SDK
     * initialization block. This differs the time for which the logs will be logged. If true,
     * the SDK will log the content instantly, and if false, it will wait until the end of the user's
     * session, which is whenever the app goes into the background.
     */
    @discardableResult
    public func updateImmediately(updateImmediately: Bool) -> CfLogInvestigationEvent {
        self.updateImmediately = updateImmediately
        return self
    }

    /**
     * build will validate all the values provided and, if successful, will call the track
     * function and queue the events based on its updateImmediately value and also on the
     * user's network resources.
     */
    public func build() {
        /**
         * Will throw and exception if the patient_id provided is null or no action is
         * provided at all.
         */
        guard let patientId = patientId, !patientId.isEmpty else {
            ExceptionManager.throwIsRequiredException(eventType: PatientMgmtEventType.investigation.rawValue, elementName: "patient_id")
            return
        }
        /**
         * Will throw and exception if the site_id provided is null or no action is
         * provided at all.
         */
        guard let siteId = siteId, !siteId.isEmpty else {
            ExceptionManager.throwIsRequiredException(eventType: PatientMgmtEventType.investigation.rawValue, elementName: "site_id")
            return
        }

        /**
         * Will throw and exception if the action provided is null or no action is
         * provided at all.
         */
        guard let investigationId = investigationId, !investigationId.isEmpty else {
            ExceptionManager.throwIsRequiredException(eventType: PatientMgmtEventType.investigation.rawValue, elementName: "investigation_id")
            return
        }
        /**
         * Will throw and exception if the action provided is null or no action is
         * provided at all.
         */
//        guard !prescribedTestsList.isEmpty else {
//            ExceptionManager.throwIsRequiredException(eventType: PatientMgmtEventType.investigation.rawValue, elementName: "prescribed_tests_list")
//            return
//        }

        /**
         * Parsing the values into an object and passing to the setup block to queue
         * the event based on its priority.
         */
        
        if(PatientMgmtEventValidation.verifyPrescriptionTestList(eventType: PatientMgmtEventType.investigation,
                                                                 prescribedTestsList: prescribedTestsList)){
            let investigationEventObject = InvestigationEventObject(
                patientId: patientId,
                siteId: siteId,
                investigationId: investigationId,
                prescribedTestsList: prescribedTestsList,
                meta: meta
            )

            CFSetup().track(
                contentBlockName: PatientMgmtConstants.contentBlockName,
                eventType: PatientMgmtEventType.investigation.rawValue,
                logObject: investigationEventObject,
                updateImmediately: updateImmediately
            )
        }

    }
}
