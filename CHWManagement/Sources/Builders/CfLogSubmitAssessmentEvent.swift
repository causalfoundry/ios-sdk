//
// CfLogSubmitAssessmentEvent.swift
//
//
//  Created by khushbu on 03/11/23.
//

import Foundation
import CasualFoundryCore

class CfLogSubmitAssessmentEvent {
    /**
     * CfLogSubmitAssessmentEvent is required to log events related to performing an assessment for
     * the patient in question.
     */
    var patient_id: String? = nil
    var site_id: String? = nil
    var medication_adherence: String? = nil
    var referred_for_assessment: Bool? = nil
    var diagnosis_values_list: [DiagnosisItem] = []
    var diagnosis_result_list: [DiagnosisItem] = []
    var diagnosis_symptoms_list: [DiagnosisSymptomItem] = []
    var meta: Any? = nil
    var update_immediately: Bool = CoreConstants.shared.updateImmediately
    
    /**
     * setPatientId is for providing the ID for the patient whose assessment is concluded.
     */
    @discardableResult
    public func setPatientId(_ patient_id: String) -> CfLogSubmitAssessmentEvent {
        self.patient_id = patient_id
        return self
    }
    
    /**
     * setSiteId is for providing the ID for the site where the assessment is concluded.
     */
    @discardableResult
    public func setSiteId(_ site_id: String) -> CfLogSubmitAssessmentEvent {
        self.site_id = site_id
        return self
    }
    
    /**
     * setMedicationAdherence is for providing the treatment adherence values for the
     * patient in question.
     */
    @discardableResult
    public func setMedicationAdherence(_ medication_adherence: String)-> CfLogSubmitAssessmentEvent {
        self.medication_adherence = medication_adherence
        return self
    }
    
    /**
     * addDiagnosisValueItem is for providing one diagnosis value item at a time.
     */
    @discardableResult
    public func addDiagnosisValueItem(_ diagnosis_value_item: DiagnosisItem) -> CfLogSubmitAssessmentEvent {
        self.diagnosis_values_list.append(diagnosis_value_item)
        return self
    }
    
    /**
     * addDiagnosisValueItem is for providing one diagnosis value item at a time as a JSON string.
     */
    @discardableResult
    public func addDiagnosisValueItem(_ diagnosis_value_item: String) -> CfLogSubmitAssessmentEvent {
        if let item = try? JSONDecoder().decode(DiagnosisItem.self, from: Data(diagnosis_value_item.utf8)) {
            self.diagnosis_values_list.append(item)
        }
        return self
    }
    
    /**
     * setDiagnosisValueList is for providing a list of diagnosis value items.
     */
    @discardableResult
    public func setDiagnosisValueList(_ diagnosis_values_list: [DiagnosisItem]) -> CfLogSubmitAssessmentEvent {
        self.diagnosis_values_list = diagnosis_values_list
        return self
    }
    
    /**
     * setDiagnosisValueList is for providing a list of diagnosis value items as a JSON string.
     */
    @discardableResult
    public func setDiagnosisValueList(_ diagnosis_values_list: String) -> CfLogSubmitAssessmentEvent {
        if let data = diagnosis_values_list.data(using: .utf8),
           let items = try? JSONDecoder().decode([DiagnosisItem].self, from: data) {
            self.diagnosis_values_list = items
        }
        return self
    }
    
    /**
     * addDiagnosisResultItem is for providing one diagnosis result item at a time.
     */
    @discardableResult
    public func addDiagnosisResultItem(_ diagnosis_result_item: DiagnosisItem) -> CfLogSubmitAssessmentEvent {
        self.diagnosis_result_list.append(diagnosis_result_item)
        return self
    }
    
    /**
     * addDiagnosisResultItem is for providing one diagnosis result item at a time as a JSON string.
     */
    @discardableResult
    public func addDiagnosisResultItem(_ diagnosis_result_item: String)-> CfLogSubmitAssessmentEvent  {
        if let item = try? JSONDecoder().decode(DiagnosisItem.self, from: Data(diagnosis_result_item.utf8)) {
            self.diagnosis_result_list.append(item)
        }
        return self
    }
    
    /**
     * setDiagnosisResultList is for providing a list of diagnosis result items.
     */
    @discardableResult
    public func setDiagnosisResultList(_ diagnosis_result_list: [DiagnosisItem]) -> CfLogSubmitAssessmentEvent  {
        self.diagnosis_result_list = diagnosis_result_list
        return self
    }
    
    /**
     * setDiagnosisResultList is for providing a list of diagnosis result items as a JSON string.
     */
    @discardableResult
    public func setDiagnosisResultList(_ diagnosis_result_list: String)-> CfLogSubmitAssessmentEvent  {
        if let data = diagnosis_result_list.data(using: .utf8),
           let items = try? JSONDecoder().decode([DiagnosisItem].self, from: data) {
            self.diagnosis_result_list = items
        }
        return self
    }
    
    /**
     * addDiagnosisSymptomItem is for providing one diagnosis symptom item at a time.
     */
    @discardableResult
    public func addDiagnosisSymptomItem(_ diagnosis_symptom_item: DiagnosisSymptomItem) -> CfLogSubmitAssessmentEvent {
        self.diagnosis_symptoms_list.append(diagnosis_symptom_item)
        return self
    }
    
    /**
     * addDiagnosisSymptomItem is for providing one diagnosis symptom item at a time as a JSON string.
     */
    @discardableResult
    public func addDiagnosisSymptomItem(_ diagnosis_symptom_item: String) -> CfLogSubmitAssessmentEvent {
        if let item = try? JSONDecoder().decode(DiagnosisSymptomItem.self, from: Data(diagnosis_symptom_item.utf8)) {
            self.diagnosis_symptoms_list.append(item)
        }
        return self
    }
    
    /**
     * setDiagnosisSymptomList is for providing a list of diagnosis symptom items.
     */
    @discardableResult
    public func setDiagnosisSymptomList(_ diagnosis_symptoms_list: [DiagnosisSymptomItem]) -> CfLogSubmitAssessmentEvent  {
        self.diagnosis_symptoms_list = diagnosis_symptoms_list
        return self
    }
    
    /**
     * setDiagnosisSymptomList is for providing a list of diagnosis symptom items as a JSON string.
     */
    @discardableResult
    public func setDiagnosisSymptomList(_ diagnosis_symptoms_list: String) -> CfLogSubmitAssessmentEvent {
        if let data = diagnosis_symptoms_list.data(using: .utf8),
           let items = try? JSONDecoder().decode([DiagnosisSymptomItem].self, from: data) {
            self.diagnosis_symptoms_list = items
        }
        return self
    }
    
    /**
     * isReferredForAssessment is for providing a boolean to check if the
     * patient is further referred for assessment.
     */
    @discardableResult
    public func isReferredForAssessment(_ referred_for_assessment: Bool) -> CfLogSubmitAssessmentEvent {
        self.referred_for_assessment = referred_for_assessment
        return self
    }
    
    /**
     * You can pass any type of value in setMeta. It is for developers and partners to log
     * additional information with the log that they find would be helpful for logging and
     * providing more context to the log. The default value for meta is nil.
     */
    @discardableResult
    public func setMeta(_ meta: Any?) -> CfLogSubmitAssessmentEvent {
        self.meta = meta
        return self
    }
    
    /**
     * updateImmediately is responsible for updating the values to the backend immediately.
     * By default, this is set to false or whatever the developer has set in the SDK
     * initialization block. This affects the timing of when the logs will be sent.
     */
    @discardableResult
    public func updateImmediately(_ update_immediately: Bool) -> CfLogSubmitAssessmentEvent {
        self.update_immediately = update_immediately
        return self
    }
    
    /**
     * build will validate all the provided values and, if they pass validation, it will call the track
     * function and queue the events based on its updateImmediately value and the user's network resources.
     */
    func build() {
        
        /**
         * Will throw and exception if the patient_id provided is null or no action is
         * provided at all.
         */
        guard let patient_id = patient_id else {
            ExceptionManager.throwIsRequiredException(eventType: ChwMgmtEventType.submitAssessment.rawValue, elementName: "patient_id")
            return
        }
        /**
         * Will throw and exception if the site_id provided is null or no action is
         * provided at all.
         */
        guard let site_id = site_id else {
            ExceptionManager.throwIsRequiredException(eventType: ChwMgmtEventType.submitAssessment.rawValue, elementName: "patient_id")
            return
        }
        /**
         * Will throw and exception if the action provided is null or no action is
         * provided at all.
         */
        guard  let referred_for_assessment = referred_for_assessment else {
            ExceptionManager.throwIsRequiredException(eventType: ChwMgmtEventType.submitAssessment.rawValue, elementName: "patient_id")
            return
        }
        /**
         * Will throw and exception if the diagnosis_values_list provided is null
         * or no diagnosis_values_list is provided at all.
         */
        if diagnosis_values_list.isEmpty {
            ExceptionManager.throwIsRequiredException(eventType: ChwMgmtEventType.submitAssessment.rawValue, elementName: "patient_id")
            return
            /**
             * Will throw and exception if the diagnosis_result_list provided is null or
             * no diagnosis_result_list is provided at all.
             */
        }else if diagnosis_result_list.isEmpty {
            ExceptionManager.throwIsRequiredException(eventType: ChwMgmtEventType.submitAssessment.rawValue, elementName: "patient_id")
            return
        }else {
            
            
            /**
             * Parsing the values into an object and passing to the setup block to queue
             * the event based on its priority.
             */
            for item in diagnosis_values_list {
                if !CoreConstants.shared.enumContains(DiagnosisType.self, name: item.type) {
                    ExceptionManager.throwEnumException(eventType:ChwMgmtEventType.submitAssessment.rawValue, className: String(describing:DiagnosisType.self))
                } else if item.value.isEmpty {
                    ExceptionManager.throwIsRequiredException(eventType: ChwMgmtEventType.submitAssessment.rawValue, elementName: "diagnosis_item value")
                } else if item.unit.isEmpty {
                    ExceptionManager.throwIsRequiredException(eventType: ChwMgmtEventType.submitAssessment.rawValue, elementName: "diagnosis_item unit")
                }
            }
            
            for item in diagnosis_result_list {
                if !CoreConstants.shared.enumContains(DiagnosisType.self, name: item.type) {
                    ExceptionManager.throwEnumException(eventType:ChwMgmtEventType.submitAssessment.rawValue, className: String(describing:DiagnosisType.self))
                } else if item.value.isEmpty {
                    ExceptionManager.throwIsRequiredException(eventType: ChwMgmtEventType.submitAssessment.rawValue, elementName: "diagnosis_item value")
                } else if item.unit.isEmpty {
                    ExceptionManager.throwIsRequiredException(eventType: ChwMgmtEventType.submitAssessment.rawValue, elementName: "diagnosis_item unit")
                }
            }
            
            for item in diagnosis_symptoms_list {
                if !CoreConstants.shared.enumContains(DiagnosisSymptomType.self, name: item.type) {
                    ExceptionManager.throwEnumException(eventType:ChwMgmtEventType.submitAssessment.rawValue, className: String(describing:DiagnosisSymptomType.self))
                }else if item.symptoms.isEmpty {
                    ExceptionManager.throwIsRequiredException(eventType: ChwMgmtEventType.submitAssessment.rawValue, elementName: "diagnosis symptom")
                }
                
                
                let submitAssessmentEventObject = SubmitAssessmentEventObject(
                    patientId: patient_id, siteId: site_id, medicationAdherence: medication_adherence ?? "",
                    diagnosisValuesList: diagnosis_values_list, diagnosisResultsList: diagnosis_result_list,
                    diagnosisSymptomsList: diagnosis_symptoms_list, referredForAssessment: referred_for_assessment,
                    meta: meta as? Encodable
                )
                
                CFSetup().track(contentBlockName: ChwConstants.contentBlockName, eventType: ChwMgmtEventType.submitAssessment.rawValue, logObject: submitAssessmentEventObject, updateImmediately: update_immediately)
            }
            
        }
        
    }
    
}
