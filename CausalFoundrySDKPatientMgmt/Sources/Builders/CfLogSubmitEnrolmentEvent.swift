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

    var patientId: String = ""
    var siteId: String = ""
    var action: String = ""
    var isFromGhoValue: Bool = false
    var diagnosisVitalsList: [DiagnosisItem] = []
    var patientStatusList: [PatientStatusItem] = []
    var diagnosisValuesList: [DiagnosisItem] = []
    var diagnosisResultList: [DiagnosisItem] = []
    var treatmentPlanList: [TreatmentPlanItem] = []
    var diagnosisQuestionnaireList: [DiagnosisQuestionnaireObject] = []
    var pregnancyDetailsValue: PregnancyDetailObject? = nil
    
    var meta: Any?
    var updateImmediately: Bool = CoreConstants.shared.updateImmediately

    public init() {}

    /**
     * setPatientId is for the providing the id for the patient whose Enrollment is done.
     */
    @discardableResult
    public func setPatientId(patientId: String) -> CfLogSubmitEnrolmentEvent {
        self.patientId = patientId
        return self
    }

    /**
     * setSiteId is for the providing the id for the where Enrollment is done.
     */

    @discardableResult
    public func setSiteId(siteId: String) -> CfLogSubmitEnrolmentEvent {
        self.siteId = siteId
        return self
    }
    
    /**
     * isFromGHO is for the providing the value if the daa is fetched from GHO
     */

    @discardableResult
    public func isFromGHO(isFromGho: Bool) -> CfLogSubmitEnrolmentEvent {
        self.isFromGhoValue = isFromGho
        return self
    }

    /**
     * setAction is for the providing the type for the action as for which the
     * enrolment is being performed. This should be the same as selected on the initial screen.
     * Below is the function with string as the param. Value should match with the
     * enum provided.
     */

    @discardableResult
    public func setAction(action: String) -> CfLogSubmitEnrolmentEvent {
        if !CoreConstants.shared.enumContains(ItemAction.self, name: action) {
            ExceptionManager.throwEnumException(eventType: PatientMgmtEventType.submit_enrolment.rawValue, className: String(describing: ItemAction.self))
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
    public func setAction(action: ItemAction) -> CfLogSubmitEnrolmentEvent {
        self.action = action.rawValue
        return self
    }

    
    /**
     * addDiagnosisValueItem is for providing one diagnosis value item at a time.
     */
    @discardableResult
    public func addDiagnosisValueItem(diagnosisValueItem: DiagnosisItem) -> CfLogSubmitEnrolmentEvent {
        diagnosisValuesList.append(diagnosisValueItem)
        return self
    }

    /**
     * addDiagnosisValueItem is for providing one diagnosis value item at a time as a JSON string.
     */
    @discardableResult
    public func addDiagnosisValueItem(diagnosisValueItem: String) -> CfLogSubmitEnrolmentEvent {
        if let item = try? JSONDecoder.new.decode(DiagnosisItem.self, from: Data(diagnosisValueItem.utf8)) {
            diagnosisValuesList.append(item)
        }
        return self
    }

    /**
     * setDiagnosisValueList is for providing a list of diagnosis value items.
     */
    @discardableResult
    public func setDiagnosisValueList(diagnosisValuesList: [DiagnosisItem]) -> CfLogSubmitEnrolmentEvent {
        self.diagnosisValuesList = diagnosisValuesList
        return self
    }

    /**
     * setDiagnosisValueList is for providing a list of diagnosis value items as a JSON string.
     */
    @discardableResult
    public func setDiagnosisValueList(diagnosisValuesList: String) -> CfLogSubmitEnrolmentEvent {
        if let data = diagnosisValuesList.data(using: .utf8),
           let items = try? JSONDecoder.new.decode([DiagnosisItem].self, from: data)
        {
            self.diagnosisValuesList = items
        }
        return self
    }

    /**
     * addDiagnosisResultItem is for providing one diagnosis result item at a time.
     */
    @discardableResult
    public func addDiagnosisResultItem(diagnosisResultItem: DiagnosisItem) -> CfLogSubmitEnrolmentEvent {
        diagnosisResultList.append(diagnosisResultItem)
        return self
    }

    /**
     * addDiagnosisResultItem is for providing one diagnosis result item at a time as a JSON string.
     */
    @discardableResult
    public func addDiagnosisResultItem(diagnosisResultItem: String) -> CfLogSubmitEnrolmentEvent {
        if let item = try? JSONDecoder.new.decode(DiagnosisItem.self, from: Data(diagnosisResultItem.utf8)) {
            diagnosisResultList.append(item)
        }
        return self
    }

    /**
     * setDiagnosisResultList is for providing a list of diagnosis result items.
     */
    @discardableResult
    public func setDiagnosisResultList(diagnosisResultList: [DiagnosisItem]) -> CfLogSubmitEnrolmentEvent {
        self.diagnosisResultList = diagnosisResultList
        return self
    }

    /**
     * setDiagnosisResultList is for providing a list of diagnosis result items as a JSON string.
     */
    @discardableResult
    public func setDiagnosisResultList(diagnosisResultList: String) -> CfLogSubmitEnrolmentEvent {
        if let data = diagnosisResultList.data(using: .utf8),
           let items = try? JSONDecoder.new.decode([DiagnosisItem].self, from: data)
        {
            self.diagnosisResultList = items
        }
        return self
    }


    /**
     * addDiagnosisVitalsItem is for providing one diagnosis vital item at a time.
     */
    @discardableResult
    public func addDiagnosisVitalsItem(diagnosisVitalsItem: DiagnosisItem) -> CfLogSubmitEnrolmentEvent {
        diagnosisVitalsList.append(diagnosisVitalsItem)
        return self
    }

    /**
     * addDiagnosisVitalsItem is for providing one diagnosis vital item at a time as a JSON string.
     */
    @discardableResult
    public func addDiagnosisVitalsItem(diagnosisVitalsItem: String) -> CfLogSubmitEnrolmentEvent {
        if let item = try? JSONDecoder.new.decode(DiagnosisItem.self, from: Data(diagnosisVitalsItem.utf8)) {
            diagnosisVitalsList.append(item)
        }
        return self
    }

    /**
     * setDiagnosisVitalsList is for providing a list of diagnosis vital items.
     */
    @discardableResult
    public func setDiagnosisVitalsList(diagnosisVitalsList: [DiagnosisItem]) -> CfLogSubmitEnrolmentEvent {
        self.diagnosisVitalsList = diagnosisVitalsList
        return self
    }

    /**
     * setDiagnosisVitalsList is for providing a list of diagnosis vital items as a JSON string.
     */
    @discardableResult
    public func setDiagnosisVitalsList(diagnosisVitalsList: String) -> CfLogSubmitEnrolmentEvent {
        if let data = diagnosisVitalsList.data(using: .utf8),
           let items = try? JSONDecoder.new.decode([DiagnosisItem].self, from: data)
        {
            self.diagnosisVitalsList = items
        }
        return self
    }

    
    
    /**
     * addDiagnosisQuestionnaireItem is for providing one diagnosis questionnaire item at a time.
     */
    @discardableResult
    public func addDiagnosisQuestionnaireItem(diagnosisQuestionnaireItem: DiagnosisQuestionnaireObject) -> CfLogSubmitEnrolmentEvent {
        diagnosisQuestionnaireList.append(diagnosisQuestionnaireItem)
        return self
    }

    /**
     * addDiagnosisQuestionnaireItem is for providing one diagnosis questionnaire item at a time as a JSON string.
     */
    @discardableResult
    public func addDiagnosisQuestionnaireItem(diagnosisQuestionnaireItem: String) -> CfLogSubmitEnrolmentEvent {
        if let item = try? JSONDecoder.new.decode(DiagnosisQuestionnaireObject.self, from: Data(diagnosisQuestionnaireItem.utf8)) {
            diagnosisQuestionnaireList.append(item)
        }
        return self
    }

    /**
     * setDiagnosisQuestionnaireList is for providing a list of diagnosis questionnaire items.
     */
    @discardableResult
    public func setDiagnosisQuestionnaireList(diagnosisQuestionnaireList: [DiagnosisQuestionnaireObject]) -> CfLogSubmitEnrolmentEvent {
        self.diagnosisQuestionnaireList = diagnosisQuestionnaireList
        return self
    }

    /**
     * setDiagnosisQuestionnaireList is for providing a list of diagnosis questionnaire items as a JSON string.
     */
    @discardableResult
    public func setDiagnosisQuestionnaireList(diagnosisQuestionnaireList: String) -> CfLogSubmitEnrolmentEvent {
        if let data = diagnosisQuestionnaireList.data(using: .utf8),
           let items = try? JSONDecoder.new.decode([DiagnosisQuestionnaireObject].self, from: data)
        {
            self.diagnosisQuestionnaireList = items
        }
        return self
    }

    
    
    /**
     * setPregnancyObject is for providing the pregnancy object values for the patient in question.
     */
    @discardableResult
    public func setPregnancyObject(pregnancyDetails: PregnancyDetailObject) -> CfLogSubmitEnrolmentEvent {
        self.pregnancyDetailsValue = pregnancyDetails
        return self
    }
    @discardableResult
    public func setPregnancyObject(pregnancyDetails: String?) -> CfLogSubmitEnrolmentEvent {
        if let data = pregnancyDetails?.data(using: .utf8),
           let item = try? JSONDecoder.new.decode(PregnancyDetailObject.self, from: data)
        {
            setPregnancyObject(pregnancyDetails: item)
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
    public func addPatientStatusItem(patientStatusItem: PatientStatusItem) -> CfLogSubmitEnrolmentEvent {
        patientStatusList.append(patientStatusItem)
        return self
    }

    /**
     * addPatientStatusItem is for the providing one patient status item at a time.
     * The item should be based on the PatientStatusItem item object or a string that can be
     * converted to the object with proper param names. in-case the names are not correct
     * the SDK will throw an exception. Below is the function for providing item as a string.
     */
    @discardableResult
    public func addPatientStatusItem(patientStatusItem: String) -> CfLogSubmitEnrolmentEvent {
        if let item = try? JSONDecoder.new.decode(PatientStatusItem.self, from: Data(patientStatusItem.utf8)) {
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
    public func setPatientStatusList(patientStatusList: [PatientStatusItem]) -> CfLogSubmitEnrolmentEvent {
        self.patientStatusList = patientStatusList
        return self
    }

    @discardableResult
    public func setPatientStatusList(patientStatusList: String) -> CfLogSubmitEnrolmentEvent {
        if let data = patientStatusList.data(using: .utf8),
           let items = try? JSONDecoder.new.decode([PatientStatusItem].self, from: data)
        {
            self.patientStatusList = items
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
    public func addTreatmentPlanItem(treatmentPlanItem: TreatmentPlanItem) -> CfLogSubmitEnrolmentEvent {
        treatmentPlanList.append(treatmentPlanItem)
        return self
    }

    /**
     * addTreatmentPlanItem is for the providing one treatment plan item at a time.
     * The item should be based on the treatment item object or a string that can be
     * converted to the object with proper param names. in-case the names are not correct
     * the SDK will throw an exception. Below is the function for providing item as a string.
     */

    @discardableResult
    public func addTreatmentPlanItem(treatmentPlanItem: String) -> CfLogSubmitEnrolmentEvent {
        if let item = try? JSONDecoder.new.decode(TreatmentPlanItem.self, from: Data(treatmentPlanItem.utf8)) {
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
    public func setTreatmentPlanList(treatmentPlanList: [TreatmentPlanItem]) -> CfLogSubmitEnrolmentEvent {
        self.treatmentPlanList = treatmentPlanList
        return self
    }

    /**
     * setTreatmentPlanList is for the providing one treatment plan items as a list
     * in a string. The item should be based on the treatment item object or a string that
     * can be converted to the object with proper param names. in-case the names are not correct
     * the SDK will throw an exception. Below is the function for providing item as a string.
     */

    @discardableResult
    public func setTreatmentPlanList(treatmentPlanList: String) -> CfLogSubmitEnrolmentEvent {
        if let data = treatmentPlanList.data(using: .utf8),
           let items = try? JSONDecoder.new.decode([TreatmentPlanItem].self, from: data)
        {
            self.treatmentPlanList = items
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
    public func updateImmediately(updateImmediately: Bool) -> CfLogSubmitEnrolmentEvent {
        self.updateImmediately = updateImmediately
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
        if patientId.isEmpty {
            ExceptionManager.throwIsRequiredException(eventType: PatientMgmtEventType.submit_enrolment.rawValue, elementName: "patient_id")
            return
        }
        /**
         * Will throw and exception if the site_id provided is null or no action is
         * provided at all.
         */
        if siteId.isEmpty {
            ExceptionManager.throwIsRequiredException(eventType: PatientMgmtEventType.submit_enrolment.rawValue, elementName: "site_id")
            return
        }

        /**
         * Will throw and exception if the action provided is null or no action is
         * provided at all.
         */

        if action.isEmpty {
            ExceptionManager.throwIsRequiredException(eventType: PatientMgmtEventType.submit_enrolment.rawValue, elementName: "action")
            return
        }
        
        
        if !CoreConstants.shared.enumContains(ItemAction.self, name: action) {
            ExceptionManager.throwEnumException(eventType: PatientMgmtEventType.submit_enrolment.rawValue, className:  String(describing: ItemAction.self))
            return
        }
        
        /**
         * Parsing the values into an object and passing to the setup block to queue
         * the event based on its priority.
         */
        if( PatientMgmtEventValidation.verifyDiagnosisObjectList(eventType: PatientMgmtEventType.submit_enrolment, diagnosisType: "diagnosis_value_item", diagnosisList: diagnosisValuesList) &&
            PatientMgmtEventValidation.verifyDiagnosisObjectList(eventType: PatientMgmtEventType.submit_enrolment, diagnosisType: "diagnosis_result_item", diagnosisList: diagnosisResultList) &&
            PatientMgmtEventValidation.verifyDiagnosisObjectList(eventType: PatientMgmtEventType.submit_enrolment, diagnosisType: "diagnosis_vitals_item", diagnosisList: diagnosisVitalsList) &&
            PatientMgmtEventValidation.verifyDiagnosisQuestionnaireList(eventType: PatientMgmtEventType.submit_enrolment, diagnosisQuestionnaireList: diagnosisQuestionnaireList) &&
            PatientMgmtEventValidation.verifyPregnancyObject(eventType: PatientMgmtEventType.submit_enrolment, pregnancyObject: pregnancyDetailsValue) &&
            PatientMgmtEventValidation.verifyPatientStatusList(eventType: PatientMgmtEventType.submit_enrolment, patientStatusList: patientStatusList) &&
            PatientMgmtEventValidation.verifyTreatmentPlantList(eventType: PatientMgmtEventType.submit_enrolment, treatmentPlanList: treatmentPlanList)
        
        ){
            
            let submitEnrolmentEventObject = SubmitEnrolmentEventObject(
                patientId: patientId,
                siteId: siteId,
                action: action,
                isFromGho: isFromGhoValue,
                vitalsList: diagnosisVitalsList,
                diagnosisValuesList: diagnosisValuesList, 
                diagnosisResultsList: diagnosisResultList,
                patientStatusList: patientStatusList,
                diagnosisQuestionnaireList: diagnosisQuestionnaireList,
                pregnancyDetails: pregnancyDetailsValue,
                treatmentPlanList: treatmentPlanList,
                meta: meta as? Encodable
            )
            CFSetup().track(
                contentBlockName: PatientMgmtConstants.contentBlockName,
                eventType: PatientMgmtEventType.submit_enrolment.rawValue,
                logObject: submitEnrolmentEventObject,
                updateImmediately: updateImmediately
            )
        }
        
    }
}
