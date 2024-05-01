//
//  CfLogSubmitScreeningEvent.swift
//
//
//  Created by khushbu on 03/11/23.
//
import CausalFoundrySDKCore
import Foundation

public class CfLogSubmitScreeningEvent {
    /**
     * CfLogSubmitScreeningEvent is required to log events related to performing screening for
     * the patient in question.
     */

    var eventTimeValue: Int64 = 0
    var patientId: String?
    var siteId: String?
    var category: String?
    var type: String?
    var referredForAssessment: Bool?
    var diagnosisVitalsList: [DiagnosisItem] = []
    var diagnosisQuestionnaireList: [DiagnosisQuestionnaireObject] = []
    var diagnosisSymptomsList: [DiagnosisSymptomItem] = []
    var diagnosisValuesList: [DiagnosisItem] = []
    var diagnosisResultList: [DiagnosisItem] = []
    var pregnancyDetailsValue: PregnancyDetailObject? = nil
    private var meta: Any?
    private var updateImmediately: Bool = CoreConstants.shared.updateImmediately

    public init() {}

    /**
     * setEventTime is for the providing the time in millis for the event to be used in case
     * of submit screening event is triggered offline and any parameter such as patient id
     * is not available.
     */

    @discardableResult
    public func setEventTime(eventTimeValue: Int64) -> CfLogSubmitScreeningEvent {
        let builder = self
        builder.eventTimeValue = eventTimeValue
        return builder
    }

    /**
     * setPatientId is for the providing the id for the patient whose screening
     * are in question.
     */
    @discardableResult
    public func setPatientId(patientId: String) -> CfLogSubmitScreeningEvent {
        let builder = self
        builder.patientId = patientId
        return builder
    }

    /**
     * setSiteId is for the providing the id for the screening site where the patient is
     * being screened. This should be the same as selected on the initial screen.
     */
    @discardableResult
    public func setSiteId(siteId: String) -> CfLogSubmitScreeningEvent {
        let builder = self
        builder.siteId = siteId
        return builder
    }

    /**
     * setSiteCategory is for the providing the category for the screening site where the
     * patient is being screened. This should be the same as selected on the initial screen.
     * Below is the function with string as the param. Value should match with the
     * enum provided.
     */

    @discardableResult
    public func setSiteCategory(category: String) -> CfLogSubmitScreeningEvent {
        if !CoreConstants.shared.enumContains(HcwSiteType.self, name: category) {
            ExceptionManager.throwEnumException(eventType: PatientMgmtEventType.submit_screening.rawValue, className: String(describing: HcwSiteType.self))
        } else {
            self.category = category
        }
        return self
    }

    /**
     * setSiteCategory is for the providing the category for the screening site where the
     * patient is being screened. This should be the same as selected on the initial screen.
     * Below is the function with enum as the param. Value should match with the
     * enum provided.
     */
    @discardableResult
    public func setSiteCategory(category: HcwSiteType) -> CfLogSubmitScreeningEvent {
        self.category = category.rawValue
        return self
    }

    /**
     * setScreeningType is for the providing the type for the screening as for which the
     * patient is being screened. This should be the same as selected on the initial screen.
     * Below is the function with string as the param. Value should match with the
     * enum provided.
     */

    @discardableResult
    public func setScreeningType(type: String) -> CfLogSubmitScreeningEvent {
        if !CoreConstants.shared.enumContains(ScreeningType.self, name: type) {
            ExceptionManager.throwEnumException(eventType: PatientMgmtEventType.submit_screening.rawValue, className: String(describing: ScreeningType.self))
        } else {
            self.type = type
        }
        return self
    }

    /**
     * setScreeningType is for the providing the type for the screening as for which the
     * patient is being screened. This should be the same as selected on the initial screen.
     * This should be the same as selected on the initial screen.
     * Below is the function with enum as the param. Value should match with the
     * enum provided.
     */

    @discardableResult
    public func setScreeningType(type: ScreeningType) -> CfLogSubmitScreeningEvent {
        self.type = type.rawValue
        return self
    }

    
    /**
     * addDiagnosisValueItem is for providing one diagnosis value item at a time.
     */
    @discardableResult
    public func addDiagnosisValueItem(diagnosisValueItem: DiagnosisItem) -> CfLogSubmitScreeningEvent {
        diagnosisValuesList.append(diagnosisValueItem)
        return self
    }

    /**
     * addDiagnosisValueItem is for providing one diagnosis value item at a time as a JSON string.
     */
    @discardableResult
    public func addDiagnosisValueItem(diagnosisValueItem: String) -> CfLogSubmitScreeningEvent {
        if let item = try? JSONDecoder.new.decode(DiagnosisItem.self, from: Data(diagnosisValueItem.utf8)) {
            diagnosisValuesList.append(item)
        }
        return self
    }

    /**
     * setDiagnosisValueList is for providing a list of diagnosis value items.
     */
    @discardableResult
    public func setDiagnosisValueList(diagnosisValuesList: [DiagnosisItem]) -> CfLogSubmitScreeningEvent {
        self.diagnosisValuesList = diagnosisValuesList
        return self
    }

    /**
     * setDiagnosisValueList is for providing a list of diagnosis value items as a JSON string.
     */
    @discardableResult
    public func setDiagnosisValueList(diagnosisValuesList: String) -> CfLogSubmitScreeningEvent {
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
    public func addDiagnosisResultItem(diagnosisResultItem: DiagnosisItem) -> CfLogSubmitScreeningEvent {
        diagnosisResultList.append(diagnosisResultItem)
        return self
    }

    /**
     * addDiagnosisResultItem is for providing one diagnosis result item at a time as a JSON string.
     */
    @discardableResult
    public func addDiagnosisResultItem(diagnosisResultItem: String) -> CfLogSubmitScreeningEvent {
        if let item = try? JSONDecoder.new.decode(DiagnosisItem.self, from: Data(diagnosisResultItem.utf8)) {
            diagnosisResultList.append(item)
        }
        return self
    }

    /**
     * setDiagnosisResultList is for providing a list of diagnosis result items.
     */
    @discardableResult
    public func setDiagnosisResultList(diagnosisResultList: [DiagnosisItem]) -> CfLogSubmitScreeningEvent {
        self.diagnosisResultList = diagnosisResultList
        return self
    }

    /**
     * setDiagnosisResultList is for providing a list of diagnosis result items as a JSON string.
     */
    @discardableResult
    public func setDiagnosisResultList(diagnosisResultList: String) -> CfLogSubmitScreeningEvent {
        if let data = diagnosisResultList.data(using: .utf8),
           let items = try? JSONDecoder.new.decode([DiagnosisItem].self, from: data)
        {
            self.diagnosisResultList = items
        }
        return self
    }

    /**
     * addDiagnosisSymptomItem is for providing one diagnosis symptom item at a time.
     */
    @discardableResult
    public func addDiagnosisSymptomItem(diagnosisSymptomItem: DiagnosisSymptomItem) -> CfLogSubmitScreeningEvent {
        diagnosisSymptomsList.append(diagnosisSymptomItem)
        return self
    }

    /**
     * addDiagnosisSymptomItem is for providing one diagnosis symptom item at a time as a JSON string.
     */
    @discardableResult
    public func addDiagnosisSymptomItem(diagnosisSymptomItem: String) -> CfLogSubmitScreeningEvent {
        if let item = try? JSONDecoder.new.decode(DiagnosisSymptomItem.self, from: Data(diagnosisSymptomItem.utf8)) {
            diagnosisSymptomsList.append(item)
        }
        return self
    }

    /**
     * setDiagnosisSymptomList is for providing a list of diagnosis symptom items.
     */
    @discardableResult
    public func setDiagnosisSymptomList(diagnosisSymptomsList: [DiagnosisSymptomItem]) -> CfLogSubmitScreeningEvent {
        self.diagnosisSymptomsList = diagnosisSymptomsList
        return self
    }

    /**
     * setDiagnosisSymptomList is for providing a list of diagnosis symptom items as a JSON string.
     */
    @discardableResult
    public func setDiagnosisSymptomList(diagnosisSymptomsList: String) -> CfLogSubmitScreeningEvent {
        if let data = diagnosisSymptomsList.data(using: .utf8),
           let items = try? JSONDecoder.new.decode([DiagnosisSymptomItem].self, from: data)
        {
            self.diagnosisSymptomsList = items
        }
        return self
    }
    
    
    
    /**
     * addDiagnosisVitalsItem is for providing one diagnosis vital item at a time.
     */
    @discardableResult
    public func addDiagnosisVitalsItem(diagnosisVitalsItem: DiagnosisItem) -> CfLogSubmitScreeningEvent {
        diagnosisVitalsList.append(diagnosisVitalsItem)
        return self
    }

    /**
     * addDiagnosisVitalsItem is for providing one diagnosis vital item at a time as a JSON string.
     */
    @discardableResult
    public func addDiagnosisVitalsItem(diagnosisVitalsItem: String) -> CfLogSubmitScreeningEvent {
        if let item = try? JSONDecoder.new.decode(DiagnosisItem.self, from: Data(diagnosisVitalsItem.utf8)) {
            diagnosisVitalsList.append(item)
        }
        return self
    }

    /**
     * setDiagnosisVitalsList is for providing a list of diagnosis vital items.
     */
    @discardableResult
    public func setDiagnosisVitalsList(diagnosisVitalsList: [DiagnosisItem]) -> CfLogSubmitScreeningEvent {
        self.diagnosisVitalsList = diagnosisVitalsList
        return self
    }

    /**
     * setDiagnosisVitalsList is for providing a list of diagnosis vital items as a JSON string.
     */
    @discardableResult
    public func setDiagnosisVitalsList(diagnosisVitalsList: String) -> CfLogSubmitScreeningEvent {
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
    public func addDiagnosisQuestionnaireItem(diagnosisQuestionnaireItem: DiagnosisQuestionnaireObject) -> CfLogSubmitScreeningEvent {
        diagnosisQuestionnaireList.append(diagnosisQuestionnaireItem)
        return self
    }

    /**
     * addDiagnosisQuestionnaireItem is for providing one diagnosis questionnaire item at a time as a JSON string.
     */
    @discardableResult
    public func addDiagnosisQuestionnaireItem(diagnosisQuestionnaireItem: String) -> CfLogSubmitScreeningEvent {
        if let item = try? JSONDecoder.new.decode(DiagnosisQuestionnaireObject.self, from: Data(diagnosisQuestionnaireItem.utf8)) {
            diagnosisQuestionnaireList.append(item)
        }
        return self
    }

    /**
     * setDiagnosisQuestionnaireList is for providing a list of diagnosis questionnaire items.
     */
    @discardableResult
    public func setDiagnosisQuestionnaireList(diagnosisQuestionnaireList: [DiagnosisQuestionnaireObject]) -> CfLogSubmitScreeningEvent {
        self.diagnosisQuestionnaireList = diagnosisQuestionnaireList
        return self
    }

    /**
     * setDiagnosisQuestionnaireList is for providing a list of diagnosis questionnaire items as a JSON string.
     */
    @discardableResult
    public func setDiagnosisQuestionnaireList(diagnosisQuestionnaireList: String) -> CfLogSubmitScreeningEvent {
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
    public func setPregnancyObject(pregnancyDetails: PregnancyDetailObject) -> CfLogSubmitScreeningEvent {
        self.pregnancyDetailsValue = pregnancyDetails
        return self
    }
    @discardableResult
    public func setPregnancyObject(pregnancyDetails: String?) -> CfLogSubmitScreeningEvent {
        if let data = pregnancyDetails?.data(using: .utf8),
           let item = try? JSONDecoder.new.decode(PregnancyDetailObject.self, from: data)
        {
            setPregnancyObject(pregnancyDetails: item)
        }
        return self
    }
    

    /**
     * isReferredForAssessment is for the providing the boolean for the check if the
     * patient is further referred for assessment.
     */

    @discardableResult
    public func isReferredForAssessment(referredForAssessment: Bool) -> CfLogSubmitScreeningEvent {
        self.referredForAssessment = referredForAssessment
        return self
    }

    /**
     * You can pass any type of value in setMeta. It is for developer and partners to log
     * additional information with the log that they find would be helpful for logging and
     * providing more context to the log. Default value for the meta is null.
     */

    @discardableResult
    public func setMeta(meta: Any?) -> CfLogSubmitScreeningEvent {
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
    public func updateImmediately(updateImmediately: Bool) -> CfLogSubmitScreeningEvent {
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
         * Will throw and exception if the action provided is null or no action is
         * provided at all.
         */
        guard let patientId = patientId else {
            ExceptionManager.throwIsRequiredException(eventType: PatientMgmtEventType.submit_screening.rawValue, elementName: "patient_id")
            return
        }
        /**
         * Will throw and exception if the action provided is null or no action is
         * provided at all.
         */

        guard let siteId = siteId else {
            ExceptionManager.throwIsRequiredException(eventType: PatientMgmtEventType.submit_screening.rawValue, elementName: "site_id")
            return
        }
        /**
         * Will throw and exception if the action provided is null or no action is
         * provided at all.
         */

        if !CoreConstants.shared.enumContains(HcwSiteType.self, name: category) {
            ExceptionManager.throwEnumException(eventType: PatientMgmtEventType.submit_screening.rawValue, className:  String(describing: HcwSiteType.self))
            return
        }
        /**
         * Will throw and exception if the action provided is null or no action is
         * provided at all.
         */
        if !CoreConstants.shared.enumContains(ScreeningType.self, name: type) {
            ExceptionManager.throwEnumException(eventType: PatientMgmtEventType.submit_screening.rawValue, className:  String(describing: ScreeningType.self))
            return
        }
        
        /**
         * Will throw and exception if the action provided is null or no action is
         * provided at all.
         */

        if referredForAssessment == nil {
            ExceptionManager.throwIsRequiredException(eventType: PatientMgmtEventType.submit_screening.rawValue, elementName: "referred_for_assessment")
            return
        }
        
        
        if( PatientMgmtEventValidation.verifyDiagnosisObjectList(eventType: PatientMgmtEventType.submit_screening, diagnosisType: "diagnosis_value_item", diagnosisList: diagnosisValuesList) &&
            PatientMgmtEventValidation.verifyDiagnosisObjectList(eventType: PatientMgmtEventType.submit_screening, diagnosisType: "diagnosis_result_item", diagnosisList: diagnosisResultList) &&
            PatientMgmtEventValidation.verifyDiagnosisObjectList(eventType: PatientMgmtEventType.submit_screening, diagnosisType: "diagnosis_vitals_item", diagnosisList: diagnosisVitalsList) &&
            PatientMgmtEventValidation.verifyDiagnosisSymptomList(eventType: PatientMgmtEventType.submit_screening, diagnosisSymptomList: diagnosisSymptomsList) &&
            PatientMgmtEventValidation.verifyDiagnosisQuestionnaireList(eventType: PatientMgmtEventType.submit_screening, diagnosisQuestionnaireList: diagnosisQuestionnaireList) &&
            PatientMgmtEventValidation.verifyPregnancyObject(eventType: PatientMgmtEventType.submit_screening, pregnancyObject: pregnancyDetailsValue)
        
        ){
            let submitScreeningEventObject = SubmitScreeningEventObject(
                patientId: patientId,
                siteId: siteId,
                vitalsList: diagnosisVitalsList,
                diagnosisSymptomsList: diagnosisSymptomsList,
                diagnosisQuestionnaireList: diagnosisQuestionnaireList,
                diagnosisValuesList: diagnosisValuesList,
                diagnosisResultsList: diagnosisResultList,
                pregnancyDetails: pregnancyDetailsValue,
                category: category!,
                type: type!,
                referredForAssessment: referredForAssessment!,
                meta: meta as? Encodable
            )

            CFSetup().track(
                contentBlockName: ChwConstants.contentBlockName, eventType: PatientMgmtEventType.submit_screening.rawValue, logObject: submitScreeningEventObject,
                updateImmediately: updateImmediately,
                eventTime: eventTimeValue
            )
        }

    }
}
