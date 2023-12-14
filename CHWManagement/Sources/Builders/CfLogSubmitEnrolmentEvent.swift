//
//  CfLogSubmitEnrolmentEvent.swift
//
//
//  Created by khushbu on 03/11/23.
//

import CausalFoundrySDKCore
import Foundation

public class CfLogSubmitEnrolmentEvent {
    /**
     * CfLogSubmitEnrolmentEvent is required to log events related to performing enrolment for
     * the patient in question.
     */

    var patientId: String?
    var siteId: String?
    var action: String?
    var patientStatusList: [PatientStatusItem] = []
    var diagnosisValuesList: [DiagnosisItem] = []
    var diagnosisResultList: [DiagnosisItem] = []
    var treatmentPlanList: [TreatmentPlanItem] = []
    var meta: Any?
    var updateImmediately: Bool = CoreConstants.shared.updateImmediately

    public init() {}

    /**
     * setPatientId is for the providing the id for the patient whose Enrollment is done.
     */
    @discardableResult
    public func setPatientId(_ patientId: String) -> CfLogSubmitEnrolmentEvent {
        self.patientId = patientId
        return self
    }

    /**
     * setSiteId is for the providing the id for the where Enrollment is done.
     */

    @discardableResult
    public func setSiteId(_ siteId: String) -> CfLogSubmitEnrolmentEvent {
        self.siteId = siteId
        return self
    }

    /**
     * setAction is for the providing the type for the action as for which the
     * enrolment is being performed. This should be the same as selected on the initial screen.
     * Below is the function with string as the param. Value should match with the
     * enum provided.
     */

    @discardableResult
    public func setAction(_ action: String) -> CfLogSubmitEnrolmentEvent {
        if !CoreConstants.shared.enumContains(ItemAction.self, name: action) {
            ExceptionManager.throwEnumException(eventType: ChwMgmtEventType.submitEnrolment.rawValue, className: String(describing: ItemAction.self))
        } else {
            self.action = action
        }
        return self
    }

    /**
     * setAction is for the providing the type for the action as for which the
     * enrolment is being performed. This should be the same as selected on the initial screen.
     * This should be the same as selected on the initial screen.
     * Below is the function with enum as the param. Value should match with the
     * enum provided.
     */
    @discardableResult
    public func setAction(_ action: ItemAction) -> CfLogSubmitEnrolmentEvent {
        self.action = action.rawValue
        return self
    }

    /**
     * addDiagnosisValueItem is for the providing one diagnosis value item at a time.
     * The item should be based on the DiagnosisItem item object or a string that can be
     * converted to the object with proper param names. in-case the names are not correct
     * the SDK will throw an exception. Below is the function for providing item as an object.
     */
    @discardableResult
    public func addDiagnosisValueItem(_ diagnosisValueItem: DiagnosisItem) -> CfLogSubmitEnrolmentEvent {
        diagnosisValuesList.append(diagnosisValueItem)
        return self
    }

    /**
     * addDiagnosisValueItem is for the providing one diagnosis value item at a time.
     * The item should be based on the DiagnosisItem item object or a string that can be
     * converted to the object with proper param names. in-case the names are not correct
     * the SDK will throw an exception. Below is the function for providing item as a string.
     */

    @discardableResult
    public func addDiagnosisValueItem(_ diagnosisValueItem: String) -> CfLogSubmitEnrolmentEvent {
        if let item = try? JSONDecoder.new.decode(DiagnosisItem.self, from: Data(diagnosisValueItem.utf8)) {
            diagnosisValuesList.append(item)
        }
        return self
    }

    /**
     * setDiagnosisValueList is for the providing one diagnosis value items list.
     * The item should be based on the DiagnosisItem item object or a string that can be
     * converted to the object with proper param names. in-case the names are not correct
     * the SDK will throw an exception. Below is the function for providing item as an object.
     */
    @discardableResult
    public func setDiagnosisValueList(_ diagnosisValuesList: [DiagnosisItem]) -> CfLogSubmitEnrolmentEvent {
        self.diagnosisValuesList = diagnosisValuesList
        return self
    }

    /**
     * setDiagnosisValueList is for the providing one diagnosis value items list.
     * The item should be based on the DiagnosisItem item object or a string that can be
     * converted to the object with proper param names. in-case the names are not correct
     * the SDK will throw an exception. Below is the function for providing item as a string.
     */
    @discardableResult
    public func setDiagnosisValueList(_ diagnosisValuesList: String) -> CfLogSubmitEnrolmentEvent {
        if let data = diagnosisValuesList.data(using: .utf8),
           let items = try? JSONDecoder.new.decode([DiagnosisItem].self, from: data)
        {
            self.diagnosisValuesList = items
        }
        return self
    }

    /**
     * addDiagnosisResultItem is for providing one diagnosis result item at a time.
     * The item should be based on the DiagnosisItem item object or a string that can be
     * converted to the object with proper param names. In case the names are not correct,
     * the SDK will throw an exception. Below is the function for providing the item as an object.
     */
    @discardableResult
    public func addDiagnosisResultItem(_ diagnosisResultItem: DiagnosisItem) -> CfLogSubmitEnrolmentEvent {
        diagnosisResultList.append(diagnosisResultItem)
        return self
    }

    /**
     * addDiagnosisResultItem is for providing one diagnosis result item at a time.
     * The item should be based on the DiagnosisItem item object or a string that can be
     * converted to the object with proper param names. In case the names are not correct,
     * the SDK will throw an exception. Below is the function for providing the item as a string.
     */
    @discardableResult
    public func addDiagnosisResultItem(_ diagnosisResultItem: String) -> CfLogSubmitEnrolmentEvent {
        if let diagnosisItem = try? JSONDecoder.new.decode(DiagnosisItem.self, from: diagnosisResultItem.data(using: .utf8)!) {
            diagnosisResultList.append(diagnosisItem)
        }
        return self
    }

    /**
     * setDiagnosisResultList is for providing one diagnosis result items list.
     * The item should be based on the DiagnosisItem item object or a string that can be
     * converted to the object with proper param names. In case the names are not correct,
     * the SDK will throw an exception. Below is the function for providing the item as an object.
     */
    @discardableResult
    public func setDiagnosisResultList(_ diagnosisResultList: [DiagnosisItem]) -> CfLogSubmitEnrolmentEvent {
        self.diagnosisResultList = diagnosisResultList
        return self
    }

    /**
     * setDiagnosisResultList is for providing one diagnosis result items list.
     * The item should be based on the DiagnosisItem item object or a string that can be
     * converted to the object with proper param names. In case the names are not correct,
     * the SDK will throw an exception. Below is the function for providing the item as a string.
     */
    @discardableResult
    public func setDiagnosisResultList(_ diagnosisResultList: String) -> CfLogSubmitEnrolmentEvent {
        if let data = diagnosisResultList.data(using: .utf8),
           let itemsList = try? JSONDecoder.new.decode([DiagnosisItem].self, from: data)
        {
            self.diagnosisResultList = itemsList
        }
        return self
    }

    /**
     * addPatientStatusItem is for the providing one patient status item at a time.
     * The item should be based on the PatientStatusItem item object or a string that can be
     * converted to the object with proper param names. in-case the names are not correct
     * the SDK will throw an exception. Below is the function for providing item as an object.
     */
    @discardableResult
    public func addPatientStatusItem(patient_status_item: PatientStatusItem) -> CfLogSubmitEnrolmentEvent {
        patientStatusList.append(patient_status_item)
        return self
    }

    /**
     * addPatientStatusItem is for the providing one patient status item at a time.
     * The item should be based on the PatientStatusItem item object or a string that can be
     * converted to the object with proper param names. in-case the names are not correct
     * the SDK will throw an exception. Below is the function for providing item as a string.
     */
    @discardableResult
    public func addPatientStatusItem(patient_status_item: String) -> CfLogSubmitEnrolmentEvent {
        if let item = try? JSONDecoder.new.decode(PatientStatusItem.self, from: Data(patient_status_item.utf8)) {
            patientStatusList.append(item)
        }
        return self
    }

    /**
     * setPatientStatusList is for the providing one patient status items list.
     * The item should be based on the PatientStatusItem item object or a string that can be
     * converted to the object with proper param names. in-case the names are not correct
     * the SDK will throw an exception. Below is the function for providing item as an object.
     */

    @discardableResult
    public func setPatientStatusList(patient_status_list: [PatientStatusItem]) -> CfLogSubmitEnrolmentEvent {
        patientStatusList = patient_status_list
        return self
    }

    @discardableResult
    public func setPatientStatusList(patient_status_list: String) -> CfLogSubmitEnrolmentEvent {
        if let data = patient_status_list.data(using: .utf8),
           let items = try? JSONDecoder.new.decode([PatientStatusItem].self, from: data)
        {
            patientStatusList = items
        }
        return self
    }

    /**
     * addTreatmentPlanItem is for the providing one treatment plan item at a time.
     * The item should be based on the treatment item object or a string that can be
     * converted to the object with proper param names. in-case the names are not correct
     * the SDK will throw an exception. Below is the function for providing item as an object.
     */
    @discardableResult
    public func addTreatmentPlanItem(treatment_plan_item: TreatmentPlanItem) -> CfLogSubmitEnrolmentEvent {
        treatmentPlanList.append(treatment_plan_item)
        return self
    }

    /**
     * addTreatmentPlanItem is for the providing one treatment plan item at a time.
     * The item should be based on the treatment item object or a string that can be
     * converted to the object with proper param names. in-case the names are not correct
     * the SDK will throw an exception. Below is the function for providing item as a string.
     */

    @discardableResult
    public func addTreatmentPlanItem(treatment_plan_item: String) -> CfLogSubmitEnrolmentEvent {
        if let item = try? JSONDecoder.new.decode(TreatmentPlanItem.self, from: Data(treatment_plan_item.utf8)) {
            treatmentPlanList.append(item)
        }
        return self
    }

    /**
     * setTreatmentPlanList is for the providing one treatment plan items as a list.
     * The item should be based on the treatment plan item object or a string that can be
     * converted to the object with proper param names. in-case the names are not correct
     * the SDK will throw an exception. Below is the function for providing item as an object.
     */

    @discardableResult
    public func setTreatmentPlanList(treatment_plan_list: [TreatmentPlanItem]) -> CfLogSubmitEnrolmentEvent {
        treatmentPlanList = treatment_plan_list
        return self
    }

    /**
     * setTreatmentPlanList is for the providing one treatment plan items as a list
     * in a string. The item should be based on the treatment item object or a string that
     * can be converted to the object with proper param names. in-case the names are not correct
     * the SDK will throw an exception. Below is the function for providing item as a string.
     */

    @discardableResult
    public func setTreatmentPlanList(treatment_plan_list: String) -> CfLogSubmitEnrolmentEvent {
        if let data = treatment_plan_list.data(using: .utf8),
           let items = try? JSONDecoder.new.decode([TreatmentPlanItem].self, from: data)
        {
            treatmentPlanList = items
        }
        return self
    }

    /**
     * You can pass any type of value in setMeta. It is for developer and partners to log
     * additional information with the log that they find would be helpful for logging and
     * providing more context to the log. Default value for the meta is null.
     */

    @discardableResult
    public func setMeta(meta: Any?) -> CfLogSubmitEnrolmentEvent {
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
    public func updateImmediately(update_immediately: Bool) -> CfLogSubmitEnrolmentEvent {
        updateImmediately = update_immediately
        return self
    }

    /**
     * build will validate all of the values provided and if passes will call the track
     * function and queue the events based on it's updateImmediately value and also on the
     * user's network resources.
     */

    public func build() {
        /**
         * Will throw and exception if the patient_id provided is null or no action is
         * provided at all.
         */
        guard let patientID = patientId else {
            ExceptionManager.throwIsRequiredException(eventType: ChwMgmtEventType.submitEnrolment.rawValue, elementName: "patient_id")
            return
        }
        /**
         * Will throw and exception if the site_id provided is null or no action is
         * provided at all.
         */
        guard let siteID = siteId else {
            ExceptionManager.throwIsRequiredException(eventType: ChwMgmtEventType.submitEnrolment.rawValue, elementName: "site_id")
            return
        }

        /**
         * Will throw and exception if the action provided is null or no action is
         * provided at all.
         */

        guard let actionValue = action else {
            ExceptionManager.throwIsRequiredException(eventType: ChwMgmtEventType.submitEnrolment.rawValue, elementName: "action")
            return
        }
        /**
         * Will throw and exception if the patient_status_list provided is null or no
         * patient_status_list is provided at all.
         */
        if patientStatusList.isEmpty {
            ExceptionManager.throwIsRequiredException(eventType: ChwMgmtEventType.submitEnrolment.rawValue, elementName: "patient_status_list")
            return
        } else {
            /**
             * Parsing the values into an object and passing to the setup block to queue
             * the event based on its priority.
             */
            for item in diagnosisValuesList {
                if !CoreConstants.shared.enumContains(DiagnosisType.self, name: item.type) {
                    ExceptionManager.throwEnumException(eventType: ChwMgmtEventType.submitEnrolment.rawValue, className: String(describing: DiagnosisType.self))
                    return
                } else if item.value.isEmpty {
                    ExceptionManager.throwIsRequiredException(eventType: ChwMgmtEventType.submitEnrolment.rawValue, elementName: "diagnosis_item value")
                    return
                } else if item.unit.isEmpty {
                    ExceptionManager.throwIsRequiredException(eventType: ChwMgmtEventType.submitEnrolment.rawValue, elementName: "diagnosis_item unit")
                    return
                }
            }

            for item in diagnosisResultList {
                if !CoreConstants.shared.enumContains(DiagnosisType.self, name: item.type) {
                    ExceptionManager.throwEnumException(eventType: ChwMgmtEventType.submitEnrolment.rawValue, className: String(describing: DiagnosisType.self))
                    return
                } else if item.value.isEmpty {
                    ExceptionManager.throwIsRequiredException(eventType: ChwMgmtEventType.submitEnrolment.rawValue, elementName: "diagnosis_item value")
                    return
                } else if item.unit.isEmpty {
                    ExceptionManager.throwIsRequiredException(eventType: ChwMgmtEventType.submitEnrolment.rawValue, elementName: "diagnosis_item unit")
                    return
                }
            }

            for item in patientStatusList {
                if !CoreConstants.shared.enumContains(DiagnosisSymptomType.self, name: item.type) {
                    ExceptionManager.throwEnumException(eventType: ChwMgmtEventType.submitEnrolment.rawValue, className: String(describing: DiagnosisSymptomType.self))
                } else if !CoreConstants.shared.enumContains(PatientStatusValueType.self, name: item.value) {
                    ExceptionManager.throwEnumException(eventType: ChwMgmtEventType.submitEnrolment.rawValue, className: String(describing: PatientStatusValueType.self))
                }
            }

            for item in treatmentPlanList {
                if !CoreConstants.shared.enumContains(TreatmentType.self, name: item.type) {
                    ExceptionManager.throwEnumException(eventType: ChwMgmtEventType.submitEnrolment.rawValue, className: String(describing: TreatmentType.self))
                } else if !CoreConstants.shared.enumContains(TreatmentFrequency.self, name: item.frequency) {
                    ExceptionManager.throwEnumException(
                        eventType: ChwMgmtEventType.submitEnrolment.rawValue,
                        className: String(describing: TreatmentFrequency.self)
                    )
                } else if !CoreConstants.shared.enumContains(ItemAction.self, name: item.action) {
                    ExceptionManager.throwEnumException(
                        eventType: ChwMgmtEventType.submitEnrolment.rawValue,
                        className: String(describing: ItemAction.self)
                    )
                } else if item.value == 0 {
                    ExceptionManager.throwIsRequiredException(eventType: ChwMgmtEventType.submitEnrolment.rawValue, elementName: "value")
                }
            }

            let submitEnrolmentEventObject = SubmitEnrolmentEventObject(
                patientId: patientId!,
                siteId: siteId!,
                action: action!,
                patientStatusList: patientStatusList,
                diagnosisValuesList: diagnosisValuesList,
                diagnosisResultsList: diagnosisResultList,
                treatmentPlanList: treatmentPlanList,
                meta: meta as? Encodable
            )
            CFSetup().track(
                contentBlockName: ChwConstants.contentBlockName,
                eventType: ChwMgmtEventType.submitEnrolment.rawValue,
                logObject: submitEnrolmentEventObject,
                updateImmediately: updateImmediately
            )
        }
    }
}
