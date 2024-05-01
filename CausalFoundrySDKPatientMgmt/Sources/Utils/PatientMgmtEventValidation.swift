//
//  PatientMgmtEventValidation.swift
//
//
//  Created by Moiz Hassan Khan on 30/04/24.
//

import CausalFoundrySDKCore
import Foundation

enum PatientMgmtEventValidation {
    
    static func verifyCounselingPlanList(eventType: PatientMgmtEventType, counselingPlanList: [CounselingPlanItem]) -> Bool {
        for item in counselingPlanList {
            if item.name.isEmpty {
                ExceptionManager.throwIsRequiredException(eventType: eventType.rawValue, elementName: "name")
                return false
            } else if !CoreConstants.shared.enumContains(ItemAction.self, name: item.action) {
                ExceptionManager.throwEnumException(eventType: eventType.rawValue, className: String(describing: ItemAction.self))
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
            } else if !CoreConstants.shared.enumContains(ItemAction.self, name: item.action) {
                ExceptionManager.throwIsRequiredException(eventType: eventType.rawValue, elementName: String(describing: ItemAction.self))
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
            } else if item.value == nil {
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
    
    static func verifyPregnancyObject(eventType: PatientMgmtEventType, pregnancyObject: PregnancyDetailObject?) -> Bool {
        
        if let pregnancyDetailsList = pregnancyObject?.pregnancyDetailsList {
            for item in pregnancyDetailsList {
                if !CoreConstants.shared.enumContains(PregnancyDetailItemType.self, name: item.type) {
                    ExceptionManager.throwEnumException(eventType: eventType.rawValue, className: "pregnancy detail item type")
                    return false
                } else if item.value == nil {
                    ExceptionManager.throwEnumException(eventType: eventType.rawValue, className: "pregnancy detail item value")
                    return false
                } else if let value = item.value as? String, value.isEmpty {
                    ExceptionManager.throwIsRequiredException(eventType: eventType.rawValue, elementName: "pregnancy detail item value")
                    return false
                } else if item.observationDate == nil {
                    ExceptionManager.throwEnumException(eventType: eventType.rawValue, className: "pregnancy detail item observation date")
                    return false
                }
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
    
    static func verifyReviewSummaryList(eventType: PatientMgmtEventType, medicalReviewSummary: [MedicalReviewSummaryObject]) -> Bool {
        for item in medicalReviewSummary {
            if !CoreConstants.shared.enumContains(ReviewSummaryItem.self, name: item.type) {
                ExceptionManager.throwEnumException(eventType: eventType.rawValue, className: String(describing: ReviewSummaryItem.self))
                return false
            } else if item.value.isEmpty {
                ExceptionManager.throwIsRequiredException(eventType: eventType.rawValue, elementName: "\(item.type) values")
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
            }
        }
        return true
    }
    
    static func verifyTreatmentPlantList(eventType: PatientMgmtEventType, treatmentPlanList: [TreatmentPlanItem]) -> Bool {
        for item in treatmentPlanList {
            guard CoreConstants.shared.enumContains(TreatmentType.self, name: item.type) else {
                ExceptionManager.throwEnumException(eventType: eventType.rawValue, className: String(describing: TreatmentType.self))
                return false
            }

            guard CoreConstants.shared.enumContains(TreatmentFrequency.self, name: item.frequency) else {
                ExceptionManager.throwEnumException(eventType: eventType.rawValue, className: String(describing: TreatmentFrequency.self))
                return false
            }

            guard CoreConstants.shared.enumContains(ItemAction.self, name: item.action) else {
                ExceptionManager.throwEnumException(eventType: eventType.rawValue, className: String(describing: ItemAction.self))
                return false
            }

            guard item.value != 0 else {
                ExceptionManager.throwIsRequiredException(eventType: eventType.rawValue, elementName: "value")
                return false
            }

            guard item.isApproved != nil else {
                ExceptionManager.throwIsRequiredException(
                    eventType: eventType.rawValue,
                    elementName: "is_approved"
                )
                return false
            }
        }
        return true
    }
    
    static func verifyPatientStatusList(eventType: PatientMgmtEventType, patientStatusList: [PatientStatusItem]) -> Bool {
        for item in patientStatusList {
            if !CoreConstants.shared.enumContains(DiagnosisSymptomType.self, name: item.type) {
                ExceptionManager.throwEnumException(eventType: eventType.rawValue, className: String(describing: DiagnosisSymptomType.self))
                return false
            } else if !CoreConstants.shared.enumContains(PatientStatusValueType.self, name: item.value) {
                ExceptionManager.throwEnumException(eventType: eventType.rawValue, className: String(describing: PatientStatusValueType.self))
                return false
            }
        }
        return true
    }
    
    static func verifyDiagnosisQuestionnaireList(eventType: PatientMgmtEventType, diagnosisQuestionnaireList: [DiagnosisQuestionnaireObject]) -> Bool {
        for item in diagnosisQuestionnaireList {
            if !CoreConstants.shared.enumContains(DiagnosisQuestionnaireType.self, name: item.type) {
                ExceptionManager.throwEnumException(eventType: eventType.rawValue, className: String(describing: DiagnosisQuestionnaireType.self))
                return false
            } else if item.questions.isEmpty {
                ExceptionManager.throwIsRequiredException(eventType: eventType.rawValue, elementName: "diagnosis questionnaire questions")
                return false
            } else if !item.questions.isEmpty {
                return verifyDiagnosisQuestionList(eventType: eventType, diagnosisQuestionList: item.questions)
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
            } else if !CoreConstants.shared.enumContains(ItemAction.self, name: item.action) {
                ExceptionManager.throwEnumException(eventType: eventType.rawValue, className: String(describing: ItemAction.self))
                return false
            } else if item.dosageValue < 0.0 {
                ExceptionManager.throwInvalidException(eventType: eventType.rawValue, paramName: "dosage_value", className: String(describing: CfLogPrescriptionEvent.self))
                return false
            } else if item.dosageUnit.isEmpty {
                ExceptionManager.throwIsRequiredException(eventType: eventType.rawValue, elementName: "dosage_unit")
                return false
            } else if item.prescribedDays < 0 {
                ExceptionManager.throwInvalidException(eventType: eventType.rawValue, paramName: "prescribed_days", className: String(describing: CfLogPrescriptionEvent.self))
                return false
            }
        }
        return true
    }
    
}
