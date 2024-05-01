//
// CfLogSubmitAssessmentEvent.swift
//
//
//  Created by khushbu on 03/11/23.
//

import CausalFoundrySDKCore
import Foundation

public class CfLogSubmitAssessmentEvent {
    /**
     * CfLogSubmitAssessmentEvent is required to log events related to performing an assessment for
     * the patient in question.
     */
    var patientId: String?
    var siteId: String?
    var category: String?
    var type: String?
    var referredForAssessment: Bool?
    var medicationAdherence: MedicationAdherenceObject?
    var diagnosisVitalsList: [DiagnosisItem] = []
    var diagnosisQuestionnaireList: [DiagnosisQuestionnaireObject] = []
    var diagnosisValuesList: [DiagnosisItem] = []
    var diagnosisResultList: [DiagnosisItem] = []
    var diagnosisSymptomsList: [DiagnosisSymptomItem] = []
    var pregnancyDetailsValue: PregnancyDetailObject? = nil
    var meta: Any?
    var isUpdateImmediately: Bool = CoreConstants.shared.updateImmediately

    public init() {}

    /**
     * setPatientId is for providing the ID for the patient whose assessment is concluded.
     */
    @discardableResult
    public func setPatientId(patientId: String) -> CfLogSubmitAssessmentEvent {
        self.patientId = patientId
        return self
    }

    /**
     * setSiteId is for providing the ID for the site where the assessment is concluded.
     */
    @discardableResult
    public func setSiteId(siteId: String) -> CfLogSubmitAssessmentEvent {
        self.siteId = siteId
        return self
    }

    /**
     * setSiteCategory is for the providing the category for the screening site where the
     * patient is being screened. This should be the same as selected on the initial screen.
     * Below is the function with enum as the param. Value should match with the
     * enum provided.
     */
    
    @discardableResult
    public func setSiteCategory(category: HcwSiteType) -> CfLogSubmitAssessmentEvent {
        self.category = category.rawValue
        return self
    }
    
    @discardableResult
    public func setSiteCategory(category: String?) -> CfLogSubmitAssessmentEvent {
        self.category = category
        return self
    }
    
    /**
     * setSiteId is for providing the ID for the site where the assessment is concluded.
     */
    @discardableResult
    public func setScreeningType(type: ScreeningType) -> CfLogSubmitAssessmentEvent {
        self.type = type.rawValue
        return self
    }
    @discardableResult
    public func setScreeningType(type: String?) -> CfLogSubmitAssessmentEvent {
        self.type = type
        return self
    }
    
    /**
     * setMedicationAdherence is for providing the treatment adherence values for the
     * patient in question.
     */
    @discardableResult
    public func setMedicationAdherence(medicationAdherence: MedicationAdherenceObject) -> CfLogSubmitAssessmentEvent {
        self.medicationAdherence = medicationAdherence
        return self
    }
    @discardableResult
    public func setMedicationAdherence(medicationAdherence: String?) -> CfLogSubmitAssessmentEvent {
        if let data = medicationAdherence?.data(using: .utf8),
           let item = try? JSONDecoder.new.decode(MedicationAdherenceObject.self, from: data)
        {
            setMedicationAdherence(medicationAdherence: item)
        }
        return self
    }

    /**
     * addDiagnosisValueItem is for providing one diagnosis value item at a time.
     */
    @discardableResult
    public func addDiagnosisValueItem(diagnosisValueItem: DiagnosisItem) -> CfLogSubmitAssessmentEvent {
        diagnosisValuesList.append(diagnosisValueItem)
        return self
    }

    /**
     * addDiagnosisValueItem is for providing one diagnosis value item at a time as a JSON string.
     */
    @discardableResult
    public func addDiagnosisValueItem(diagnosisValueItem: String) -> CfLogSubmitAssessmentEvent {
        if let item = try? JSONDecoder.new.decode(DiagnosisItem.self, from: Data(diagnosisValueItem.utf8)) {
            diagnosisValuesList.append(item)
        }
        return self
    }

    /**
     * setDiagnosisValueList is for providing a list of diagnosis value items.
     */
    @discardableResult
    public func setDiagnosisValueList(diagnosisValuesList: [DiagnosisItem]) -> CfLogSubmitAssessmentEvent {
        self.diagnosisValuesList = diagnosisValuesList
        return self
    }

    /**
     * setDiagnosisValueList is for providing a list of diagnosis value items as a JSON string.
     */
    @discardableResult
    public func setDiagnosisValueList(diagnosisValuesList: String) -> CfLogSubmitAssessmentEvent {
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
    public func addDiagnosisResultItem(diagnosisResultItem: DiagnosisItem) -> CfLogSubmitAssessmentEvent {
        diagnosisResultList.append(diagnosisResultItem)
        return self
    }

    /**
     * addDiagnosisResultItem is for providing one diagnosis result item at a time as a JSON string.
     */
    @discardableResult
    public func addDiagnosisResultItem(diagnosisResultItem: String) -> CfLogSubmitAssessmentEvent {
        if let item = try? JSONDecoder.new.decode(DiagnosisItem.self, from: Data(diagnosisResultItem.utf8)) {
            diagnosisResultList.append(item)
        }
        return self
    }

    /**
     * setDiagnosisResultList is for providing a list of diagnosis result items.
     */
    @discardableResult
    public func setDiagnosisResultList(diagnosisResultList: [DiagnosisItem]) -> CfLogSubmitAssessmentEvent {
        self.diagnosisResultList = diagnosisResultList
        return self
    }

    /**
     * setDiagnosisResultList is for providing a list of diagnosis result items as a JSON string.
     */
    @discardableResult
    public func setDiagnosisResultList(diagnosisResultList: String) -> CfLogSubmitAssessmentEvent {
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
    public func addDiagnosisSymptomItem(diagnosisSymptomItem: DiagnosisSymptomItem) -> CfLogSubmitAssessmentEvent {
        diagnosisSymptomsList.append(diagnosisSymptomItem)
        return self
    }

    /**
     * addDiagnosisSymptomItem is for providing one diagnosis symptom item at a time as a JSON string.
     */
    @discardableResult
    public func addDiagnosisSymptomItem(diagnosisSymptomItem: String) -> CfLogSubmitAssessmentEvent {
        if let item = try? JSONDecoder.new.decode(DiagnosisSymptomItem.self, from: Data(diagnosisSymptomItem.utf8)) {
            diagnosisSymptomsList.append(item)
        }
        return self
    }

    /**
     * setDiagnosisSymptomList is for providing a list of diagnosis symptom items.
     */
    @discardableResult
    public func setDiagnosisSymptomList(diagnosisSymptomsList: [DiagnosisSymptomItem]) -> CfLogSubmitAssessmentEvent {
        self.diagnosisSymptomsList = diagnosisSymptomsList
        return self
    }

    /**
     * setDiagnosisSymptomList is for providing a list of diagnosis symptom items as a JSON string.
     */
    @discardableResult
    public func setDiagnosisSymptomList(diagnosisSymptomsList: String) -> CfLogSubmitAssessmentEvent {
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
    public func addDiagnosisVitalsItem(diagnosisVitalsItem: DiagnosisItem) -> CfLogSubmitAssessmentEvent {
        diagnosisVitalsList.append(diagnosisVitalsItem)
        return self
    }

    /**
     * addDiagnosisVitalsItem is for providing one diagnosis vital item at a time as a JSON string.
     */
    @discardableResult
    public func addDiagnosisVitalsItem(diagnosisVitalsItem: String) -> CfLogSubmitAssessmentEvent {
        if let item = try? JSONDecoder.new.decode(DiagnosisItem.self, from: Data(diagnosisVitalsItem.utf8)) {
            diagnosisVitalsList.append(item)
        }
        return self
    }

    /**
     * setDiagnosisVitalsList is for providing a list of diagnosis vital items.
     */
    @discardableResult
    public func setDiagnosisVitalsList(diagnosisVitalsList: [DiagnosisItem]) -> CfLogSubmitAssessmentEvent {
        self.diagnosisVitalsList = diagnosisVitalsList
        return self
    }

    /**
     * setDiagnosisVitalsList is for providing a list of diagnosis vital items as a JSON string.
     */
    @discardableResult
    public func setDiagnosisVitalsList(diagnosisVitalsList: String) -> CfLogSubmitAssessmentEvent {
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
    public func addDiagnosisQuestionnaireItem(diagnosisQuestionnaireItem: DiagnosisQuestionnaireObject) -> CfLogSubmitAssessmentEvent {
        diagnosisQuestionnaireList.append(diagnosisQuestionnaireItem)
        return self
    }

    /**
     * addDiagnosisQuestionnaireItem is for providing one diagnosis questionnaire item at a time as a JSON string.
     */
    @discardableResult
    public func addDiagnosisQuestionnaireItem(diagnosisQuestionnaireItem: String) -> CfLogSubmitAssessmentEvent {
        if let item = try? JSONDecoder.new.decode(DiagnosisQuestionnaireObject.self, from: Data(diagnosisQuestionnaireItem.utf8)) {
            diagnosisQuestionnaireList.append(item)
        }
        return self
    }

    /**
     * setDiagnosisQuestionnaireList is for providing a list of diagnosis questionnaire items.
     */
    @discardableResult
    public func setDiagnosisQuestionnaireList(diagnosisQuestionnaireList: [DiagnosisQuestionnaireObject]) -> CfLogSubmitAssessmentEvent {
        self.diagnosisQuestionnaireList = diagnosisQuestionnaireList
        return self
    }

    /**
     * setDiagnosisQuestionnaireList is for providing a list of diagnosis questionnaire items as a JSON string.
     */
    @discardableResult
    public func setDiagnosisQuestionnaireList(diagnosisQuestionnaireList: String) -> CfLogSubmitAssessmentEvent {
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
    public func setPregnancyObject(pregnancyDetails: PregnancyDetailObject) -> CfLogSubmitAssessmentEvent {
        self.pregnancyDetailsValue = pregnancyDetails
        return self
    }
    @discardableResult
    public func setPregnancyObject(pregnancyDetails: String?) -> CfLogSubmitAssessmentEvent {
        if let data = pregnancyDetails?.data(using: .utf8),
           let item = try? JSONDecoder.new.decode(PregnancyDetailObject.self, from: data)
        {
            setPregnancyObject(pregnancyDetails: item)
        }
        return self
    }
    
    /**
     * isReferredForAssessment is for providing a boolean to check if the
     * patient is further referred for assessment.
     */
    @discardableResult
    public func isReferredForAssessment(referredForAssessment: Bool) -> CfLogSubmitAssessmentEvent {
        self.referredForAssessment = referredForAssessment
        return self
    }

    /**
     * You can pass any type of value in setMeta. It is for developers and partners to log
     * additional information with the log that they find would be helpful for logging and
     * providing more context to the log. The default value for meta is nil.
     */
    @discardableResult
    public func setMeta(meta: Any?) -> CfLogSubmitAssessmentEvent {
        self.meta = meta
        return self
    }

    /**
     * updateImmediately is responsible for updating the values to the backend immediately.
     * By default, this is set to false or whatever the developer has set in the SDK
     * initialization block. This affects the timing of when the logs will be sent.
     */
    @discardableResult
    public func updateImmediately(updateImmediately: Bool) -> CfLogSubmitAssessmentEvent {
        self.isUpdateImmediately = updateImmediately
        return self
    }

    /**
     * build will validate all the provided values and, if they pass validation, it will call the track
     * function and queue the events based on its updateImmediately value and the user's network resources.
     */
    public func build() {
        /**
         * Will throw and exception if the patient_id provided is null or no action is
         * provided at all.
         */
        guard let patientId = patientId else {
            ExceptionManager.throwIsRequiredException(eventType: PatientMgmtEventType.submit_assessment.rawValue, elementName: "patient_id")
            return
        }
        /**
         * Will throw and exception if the siteId provided is null or no action is
         * provided at all.
         */
        guard let siteId = siteId else {
            ExceptionManager.throwIsRequiredException(eventType: PatientMgmtEventType.submit_assessment.rawValue, elementName: "site_id")
            return
        }
        /**
         * Will throw and exception if the action provided is null or no action is
         * provided at all.
         */
        guard let referredForAssessment = referredForAssessment else {
            ExceptionManager.throwIsRequiredException(eventType: PatientMgmtEventType.submit_assessment.rawValue, elementName: "referred_for_assessment")
            return
        }
        
        if let category = category, !category.isEmpty, !CoreConstants.shared.enumContains(HcwSiteType.self, name: category) {
            ExceptionManager.throwEnumException(eventType: PatientMgmtEventType.submit_assessment.rawValue, className:  String(describing: HcwSiteType.self))
            return
        }
        
        if let type = type, !type.isEmpty, !CoreConstants.shared.enumContains(ScreeningType.self, name: type) {
            ExceptionManager.throwEnumException(eventType: PatientMgmtEventType.submit_assessment.rawValue, className:  String(describing: ScreeningType.self))
            return
        }
        
        /**
         * Parsing the values into an object and passing to the setup block to queue
         * the event based on its priority.
         */
        
        
        if( PatientMgmtEventValidation.verifyDiagnosisObjectList(eventType: PatientMgmtEventType.submit_assessment, diagnosisType: "diagnosis_value_item", diagnosisList: diagnosisValuesList) &&
            PatientMgmtEventValidation.verifyDiagnosisObjectList(eventType: PatientMgmtEventType.submit_assessment, diagnosisType: "diagnosis_result_item", diagnosisList: diagnosisResultList) &&
            PatientMgmtEventValidation.verifyDiagnosisObjectList(eventType: PatientMgmtEventType.submit_assessment, diagnosisType: "diagnosis_vitals_item", diagnosisList: diagnosisVitalsList) &&
            PatientMgmtEventValidation.verifyDiagnosisSymptomList(eventType: PatientMgmtEventType.submit_assessment, diagnosisSymptomList: diagnosisSymptomsList) &&
            PatientMgmtEventValidation.verifyDiagnosisQuestionnaireList(eventType: PatientMgmtEventType.submit_assessment, diagnosisQuestionnaireList: diagnosisQuestionnaireList) &&
            PatientMgmtEventValidation.verifyPregnancyObject(eventType: PatientMgmtEventType.submit_assessment, pregnancyObject: pregnancyDetailsValue)
        
        ){
            let submitAssessmentEventObject = SubmitAssessmentEventObject(
                patientId: patientId, siteId: siteId, category: category, type: type, medicationAdherence: medicationAdherence, vitalsList: diagnosisVitalsList, diagnosisQuestionnaireList: diagnosisQuestionnaireList, diagnosisValuesList: diagnosisValuesList, diagnosisResultsList: diagnosisResultList, diagnosisSymptomsList: diagnosisSymptomsList, pregnancyDetails: pregnancyDetailsValue, referredForAssessment: referredForAssessment, meta:  meta as? Encodable
            )

            CFSetup().track(contentBlockName: PatientMgmtConstants.contentBlockName, eventType: PatientMgmtEventType.submit_assessment.rawValue, logObject: submitAssessmentEventObject, updateImmediately: isUpdateImmediately)
        }
        
    }
}
