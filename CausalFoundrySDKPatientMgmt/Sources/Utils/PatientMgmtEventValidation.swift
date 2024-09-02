//
//  PatientMgmtEventValidation.swift
//
//
//  Created by Moiz Hassan Khan on 30/04/24.
//

import CausalFoundrySDKCore
import Foundation

enum PatientMgmtEventValidation {
    
    static func verifyCounselingPlanList(eventType: PatientMgmtEventType, counselingPlanList: [CounselingPlanItem]?) -> Bool {
        
        if(counselingPlanList == nil){
            return true
        }
        
        for item in counselingPlanList! {
            if item.name.isEmpty {
                ExceptionManager.throwIsRequiredException(eventType: eventType.rawValue, elementName: "name")
                return false
            } else if !CoreConstants.shared.enumContains(HcwItemAction.self, name: item.action) {
                ExceptionManager.throwEnumException(eventType: eventType.rawValue, className: String(describing: HcwItemAction.self))
                return false
            }
        }
        return true
    }
    
    
    static func verifyPrescriptionTestList(eventType: PatientMgmtEventType, prescribedTestsList: [InvestigationItem]) -> Bool {
        for item in prescribedTestsList {
            if item.name.isEmpty {
                ExceptionManager.throwIsRequiredException(eventType: eventType.rawValue, elementName: "name")
                return false
            } else if !CoreConstants.shared.enumContains(HcwItemAction.self, name: item.action) {
                ExceptionManager.throwIsRequiredException(eventType: eventType.rawValue, elementName: String(describing: HcwItemAction.self))
                return false
            }
        }
        return true
    }
    
    
    static func verifyDiagnosisObjectList(eventType: PatientMgmtEventType, diagnosisType: String, diagnosisList: [DiagnosisItem]) -> Bool {
        for item in diagnosisList {
            if !CoreConstants.shared.enumContains(DiagnosisType.self, name: item.type) {
                ExceptionManager.throwEnumException(eventType: eventType.rawValue, className: String(describing: DiagnosisType.self))
                return false
            } else if !CoreConstants.shared.enumContains(DiagnosisSubType.self, name: item.subType) {
                ExceptionManager.throwEnumException(eventType: eventType.rawValue, className: String(describing: DiagnosisSubType.self))
                return false
            } else if !CoreConstants.shared.enumContains(DiagnosisCategory.self, name: item.category) {
                ExceptionManager.throwEnumException(eventType: eventType.rawValue, className: String(describing: DiagnosisCategory.self))
                return false
            } else if item.value == nil {
                print("Item Value \(item)")
                ExceptionManager.throwIsRequiredException(eventType: eventType.rawValue, elementName: "\(diagnosisType) diagnosis_item value")
                return false
            } else if let value = item.value as? String, value.isEmpty {
                ExceptionManager.throwIsRequiredException(eventType: eventType.rawValue, elementName: "\(diagnosisType) diagnosis_item value")
                return false
            } else if item.unit.isEmpty {
                ExceptionManager.throwIsRequiredException(eventType: eventType.rawValue, elementName: "\(diagnosisType) diagnosis_item unit")
                return false
            }
        }
        return true
    }
    
    static func verifyDiagnosisSymptomList(eventType: PatientMgmtEventType, diagnosisSymptomList: [DiagnosisSymptomItem]) -> Bool {
        for item in diagnosisSymptomList {
            if !CoreConstants.shared.enumContains(DiagnosisSymptomType.self, name: item.type) {
                ExceptionManager.throwEnumException(eventType: eventType.rawValue, className: String(describing: DiagnosisSymptomType.self))
                return false
            } else if item.symptoms.isEmpty {
                ExceptionManager.throwIsRequiredException(eventType: eventType.rawValue, elementName: "diagnosis symptom")
                return false
            }
        }
        return true
    }
    
    static func verifyTreatmentAdherenceList(eventType: PatientMgmtEventType, treatmentAdherenceList: [TreatmentAdherenceItem]) -> Bool {
        
        for item in treatmentAdherenceList {
            if item.medicationAdherence.isEmpty {
                ExceptionManager.throwEnumException(eventType: eventType.rawValue, className: "medication adherence")
                return false
            }
        }
        return true
    }
    
    
    
    static func verifyDiagnosisQuestionList(eventType: PatientMgmtEventType, diagnosisQuestionList: [DiagnosisQuestionItem]) -> Bool {
        for questionObject in diagnosisQuestionList {
            if !CoreConstants.shared.enumContains(QuestionType.self, name: questionObject.type) {
                ExceptionManager.throwEnumException(eventType: eventType.rawValue, className: "diagnosis question type")
                return false
            } else if questionObject.question.isEmpty {
                ExceptionManager.throwIsRequiredException(eventType: eventType.rawValue, elementName: "diagnosis question text")
                return false
            }else if questionObject.reply.isEmpty {
                ExceptionManager.throwIsRequiredException(eventType: eventType.rawValue, elementName: "diagnosis question reply")
                return false
            } else if(questionObject.fullScore != nil && questionObject.score != nil && (questionObject.fullScore! < questionObject.score!)){
                return false
            }
        }
        return true
    }
    
    static func verifyDiagnosisOutcomeList(eventType: PatientMgmtEventType, diagnosisOutcomeList: [DiagnosisOutcomeItem]) -> Bool {
        for questionOutcome in diagnosisOutcomeList {
            if !CoreConstants.shared.enumContains(DiagnosisQuestionnaireOutcomeType.self, name: questionOutcome.type) {
                ExceptionManager.throwEnumException(eventType: eventType.rawValue, className: "diagnosis outcome type")
                return false
            }
        }
        return true
    }
    
    static func verifyDiagnosisStatusList(eventType: PatientMgmtEventType, diagnosisStatusList: [DiagnosisStatusItem]) -> Bool {
        for item in diagnosisStatusList {
            if !CoreConstants.shared.enumContains(DiagnosisType.self, name: item.type) {
                ExceptionManager.throwEnumException(eventType: eventType.rawValue, className: "diagnosis type")
                return false
            } else if !CoreConstants.shared.enumContains(HcwItemAction.self, name: item.action) {
                ExceptionManager.throwEnumException(eventType: eventType.rawValue, className: "item action")
                return false
            } else if !CoreConstants.shared.enumContains(DiagnosisStatusValueType.self, name: item.value) {
                ExceptionManager.throwEnumException(eventType: eventType.rawValue, className: "diagnosis status value type")
                return false
            } else if item.diagnosisDate < 0 {
                ExceptionManager.throwIsRequiredException(eventType: eventType.rawValue, elementName: "diagnosis date")
                return false
            }
        }
        return true
    }
    
    static func verifyTreatmentPlan(eventType: PatientMgmtEventType, treatmentPlanItem: TreatmentPlanItem?) -> Bool {
        
        if(treatmentPlanItem == nil){
            return true
        }else if verifyScheduleObjectList(eventType: eventType, scheduleObjectList: treatmentPlanItem!.followupList)
                    && verifyPrescriptionList(eventType: eventType, prescriptionList: treatmentPlanItem!.prescriptionList)
                    && verifyPrescriptionTestList(eventType: eventType, prescribedTestsList: treatmentPlanItem!.investigationList){
            return true
        }
        return false
        
    }
    
    static func verifyScheduleObjectList(eventType: PatientMgmtEventType, scheduleObjectList: [ScheduleItem]) -> Bool {
        for item in scheduleObjectList {
            if !CoreConstants.shared.enumContains(ScheduleItemType.self, name: item.type) {
                ExceptionManager.throwEnumException(eventType: eventType.rawValue, className: "schedule item type")
                return false
            } else if !CoreConstants.shared.enumContains(DiagnosisType.self, name: item.subType) {
                ExceptionManager.throwEnumException(eventType: eventType.rawValue, className: "schedule sub type")
                return false
            } else if !CoreConstants.shared.enumContains(FrequencyType.self, name: item.frequency) {
                ExceptionManager.throwEnumException(eventType: eventType.rawValue, className: "schedule item frequency type")
                return false
            } else if !CoreConstants.shared.enumContains(HcwItemAction.self, name: item.action) {
                ExceptionManager.throwEnumException(eventType: eventType.rawValue, className: "item action")
                return false
            }
        }
        return true
    }
    
    static func verifyDiagnosticElementObject(eventType: PatientMgmtEventType, diagnosticElementObject: DiagnosticElementObject?) -> Bool {
        
        if(diagnosticElementObject == nil){
            return true
        }
        
        if(diagnosticElementObject!.id.isEmpty){
            return false
        }
        return verifyPrescriptionTestList(eventType: eventType, prescribedTestsList: diagnosticElementObject!.investigationList)
        && verifyDiagnosisObjectList(eventType: eventType, diagnosisType: "Biometric", diagnosisList: diagnosticElementObject!.biometricList)
        && verifyDiagnosisSymptomList(eventType: eventType, diagnosisSymptomList: diagnosticElementObject!.signSymptomList)
        && verifyTreatmentAdherenceList(eventType: eventType, treatmentAdherenceList: diagnosticElementObject!.treatmentAdherence)
        && verifyDiagnosisQuestionnaireList(eventType: eventType, diagnosisQuestionnaireList: diagnosticElementObject!.healthQuestionnaire)
        
    }
    
    
    static func verifyDiagnosisQuestionnaireList(eventType: PatientMgmtEventType, diagnosisQuestionnaireList: [DiagnosisQuestionnaireObject]) -> Bool {
        for item in diagnosisQuestionnaireList {
            if !CoreConstants.shared.enumContains(DiagnosisType.self, name: item.type) {
                ExceptionManager.throwEnumException(eventType: eventType.rawValue, className: String(describing: DiagnosisType.self))
                return false
            } else if !CoreConstants.shared.enumContains(DiagnosisSubType.self, name: item.subType) {
                ExceptionManager.throwEnumException(eventType: eventType.rawValue, className: String(describing: DiagnosisSubType.self))
                return false
            } else if !CoreConstants.shared.enumContains(DiagnosisQuestionnaireCategory.self, name: item.category) {
                ExceptionManager.throwEnumException(eventType: eventType.rawValue, className: String(describing: DiagnosisQuestionnaireCategory.self))
                return false
            } else if item.questionList.isEmpty {
                ExceptionManager.throwIsRequiredException(eventType: eventType.rawValue, elementName: "diagnosis questionnaire questions")
                return false
            } else if !item.questionList.isEmpty {
                return verifyDiagnosisQuestionList(eventType: eventType, diagnosisQuestionList: item.questionList)
            } else if !item.outcomeList.isEmpty {
                return verifyDiagnosisOutcomeList(eventType: eventType, diagnosisOutcomeList: item.outcomeList)
            }
        }
        return true
    }
    
    static func verifyPrescriptionList(eventType: PatientMgmtEventType, prescriptionList: [PrescriptionItem]) -> Bool {
        for item in prescriptionList {
            if item.drugId.isEmpty {
                ExceptionManager.throwIsRequiredException(eventType: eventType.rawValue, elementName: "drug_id")
                return false
            } else if item.name.isEmpty {
                ExceptionManager.throwIsRequiredException(eventType: eventType.rawValue, elementName: "name")
                return false
            } else if !CoreConstants.shared.enumContains(PrescriptionItemType.self, name: item.type) {
                ExceptionManager.throwEnumException(eventType: eventType.rawValue, className: String(describing: PrescriptionItemType.self))
                return false
            } else if !CoreConstants.shared.enumContains(PrescriptionItemFrequency.self, name: item.frequency) {
                ExceptionManager.throwEnumException(eventType: eventType.rawValue, className: String(describing: PrescriptionItemFrequency.self))
                return false
            } else if !CoreConstants.shared.enumContains(HcwItemAction.self, name: item.action) {
                ExceptionManager.throwEnumException(eventType: eventType.rawValue, className: String(describing: HcwItemAction.self))
                return false
            } else if item.dosageValue < 0.0 {
                ExceptionManager.throwInvalidException(eventType: eventType.rawValue, paramName: "dosage_value", className: "class")
                return false
            } else if item.dosageUnit.isEmpty {
                ExceptionManager.throwIsRequiredException(eventType: eventType.rawValue, elementName: "dosage_unit")
                return false
            } else if item.prescribedDays < 0 {
                ExceptionManager.throwInvalidException(eventType: eventType.rawValue, paramName: "prescribed_days", className: "class")
                return false
            }
        }
        return true
    }
    
    static func verifyEncounterSummaryObject(eventType: PatientMgmtEventType, encounterSummaryObject: EncounterSummaryObject) -> Bool {
        
        if encounterSummaryObject.encounterId.isEmpty {
            ExceptionManager.throwIsRequiredException(eventType: eventType.rawValue, elementName: "encounterId")
        } else if encounterSummaryObject.encounterTime < 0 {
            ExceptionManager.throwIsRequiredException(eventType: eventType.rawValue, elementName: "encounterTime")
        }else if encounterSummaryObject.hcwIdList.isEmpty {
            ExceptionManager.throwIsRequiredException(eventType: eventType.rawValue, elementName: "hcwIdList")
        }
        
        return verifyDiagnosisStatusList(eventType: eventType, diagnosisStatusList: encounterSummaryObject.prevDiagnosisStatus)
        && verifyDiagnosisStatusList(eventType: eventType, diagnosisStatusList: encounterSummaryObject.diagnosisStatus)
        && verifyTreatmentPlan(eventType: eventType, treatmentPlanItem: encounterSummaryObject.prevTreatmentPlan)
        && verifyTreatmentPlan(eventType: eventType, treatmentPlanItem: encounterSummaryObject.treatmentPlan)
        && verifyDiagnosticElementObject(eventType: eventType, diagnosticElementObject: encounterSummaryObject.diagnosticElements)
        && verifyCounselingPlanList(eventType: eventType, counselingPlanList: encounterSummaryObject.counselingList)
    }
    
}
