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
    
    static func verifyImmunizationList(eventType: PatientMgmtEventType, immunizationList: [ImmunizationItem]?) -> Bool {
        
        if(immunizationList == nil){
            return true
        }
        
        for item in immunizationList! {
            if item.id.isEmpty {
                ExceptionManager.throwIsRequiredException(eventType: eventType.rawValue, elementName: "id")
                return false
            } else if item.dose < 0 {
                ExceptionManager.throwIsRequiredException(eventType: eventType.rawValue, elementName: "dose")
                return false
            } else if item.type.isEmpty {
                ExceptionManager.throwIsRequiredException(eventType: eventType.rawValue, elementName: "type")
                return false
            } else if item.action.isEmpty {
                ExceptionManager.throwIsRequiredException(eventType: eventType.rawValue, elementName: "action")
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
            } else if item.symptomsList.isEmpty {
                ExceptionManager.throwIsRequiredException(eventType: eventType.rawValue, elementName: "diagnosis symptoms List")
                return false
            }
        }
        return true
    }
    
    static func verifyTreatmentAdherenceList(eventType: PatientMgmtEventType, treatmentAdherenceList: [TreatmentAdherenceItem]) -> Bool {
        
        for item in treatmentAdherenceList {
            if item.type.isEmpty {
                ExceptionManager.throwEnumException(eventType: eventType.rawValue, className: "treatment adherence type")
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
            } else if !CoreConstants.shared.enumContains(DiagnosisStatusValueType.self, name: item.status) {
                ExceptionManager.throwEnumException(eventType: eventType.rawValue, className: "diagnosis status value type")
                return false
            } else if !CoreConstants.shared.enumContains(DiagnosisStatusRiskType.self, name: item.risk) {
                ExceptionManager.throwEnumException(eventType: eventType.rawValue, className: "diagnosis status risk type")
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
        && verifyTreatmentAdherenceList(eventType: eventType, treatmentAdherenceList: diagnosticElementObject!.treatmentAdherenceList)
        && verifyDiagnosisQuestionnaireList(eventType: eventType, diagnosisQuestionnaireList: diagnosticElementObject!.healthQuestionnaireList)
        
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
            } else if !CoreConstants.shared.enumContains(PrescriptionFormulationType.self, name: item.formulation) {
                ExceptionManager.throwEnumException(eventType: eventType.rawValue, className: String(describing: PrescriptionFormulationType.self))
                return false
            } else if !CoreConstants.shared.enumContains(DiagnosisType.self, name: item.type) {
                ExceptionManager.throwEnumException(eventType: eventType.rawValue, className: String(describing: DiagnosisType.self))
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
            } else if item.dispensedDays < 0 {
                ExceptionManager.throwInvalidException(eventType: eventType.rawValue, paramName: "dispensed_days", className: "class")
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
        
        return verifyDiagnosisStatusList(eventType: eventType, diagnosisStatusList: encounterSummaryObject.prevDiagnosisStatusList)
        && verifyDiagnosisStatusList(eventType: eventType, diagnosisStatusList: encounterSummaryObject.diagnosisStatusList)
        && verifyTreatmentPlan(eventType: eventType, treatmentPlanItem: encounterSummaryObject.prevTreatmentPlan)
        && verifyTreatmentPlan(eventType: eventType, treatmentPlanItem: encounterSummaryObject.treatmentPlan)
        && verifyDiagnosticElementObject(eventType: eventType, diagnosticElementObject: encounterSummaryObject.diagnosticElements)
        && verifyCounselingPlanList(eventType: eventType, counselingPlanList: encounterSummaryObject.counselingList)
        && verifyImmunizationList(eventType: eventType, immunizationList: encounterSummaryObject.immunizationList)
    }
    
    
    static func verifyAppointmentTypeList(eventType: PatientMgmtEventType, typeList: [String]) -> Bool {
        
        if typeList.isEmpty {
            ExceptionManager.throwIsRequiredException(eventType: eventType.rawValue, elementName: "type list")
            return false
        }
        for item in typeList {
            if item.isEmpty {
                ExceptionManager.throwIsRequiredException(eventType: eventType.rawValue, elementName: "item list")
                return false
            } else  if !CoreConstants.shared.enumContains(ScheduleItemType.self, name: item) {
                ExceptionManager.throwEnumException(eventType: eventType.rawValue, className: String(describing: ScheduleItemType.self))
                return false
            }
        }
        return true
        
    }
    
    static func verifyAppointmentSubTypeList(eventType: PatientMgmtEventType, subTypeList: [String]) -> Bool {
        
        if subTypeList.isEmpty {
            ExceptionManager.throwIsRequiredException(eventType: eventType.rawValue, elementName: "sub type list")
            return false
        }
        for item in subTypeList {
            if item.isEmpty {
                ExceptionManager.throwIsRequiredException(eventType: eventType.rawValue, elementName: "sub item list")
                return false
            } else  if !CoreConstants.shared.enumContains(DiagnosisType.self, name: item) {
                ExceptionManager.throwEnumException(eventType: eventType.rawValue, className: String(describing: DiagnosisType.self))
                return false
            }
        }
        return true
        
    }
    
    
    static func verifyAppointmentUpdateItem(eventType: PatientMgmtEventType, updateItem: AppointmentUpdateItem?) -> Bool {
        
        if updateItem == nil {
            return true
        } else if updateItem!.appointmentId.isEmpty {
            ExceptionManager.throwIsRequiredException(eventType: eventType.rawValue, elementName: "update appointment Id")
            return false
        } else if updateItem!.reason.isEmpty {
            ExceptionManager.throwIsRequiredException(eventType: eventType.rawValue, elementName: "update appointment reason")
            return false
        } else if updateItem!.prevTime < 0 {
            ExceptionManager.throwIsRequiredException(eventType: eventType.rawValue, elementName: "update appointment previous time")
            return false
        }
        return true
    }
    
    
    static func verifyMissedAppointmentUpdateItem(eventType: PatientMgmtEventType, missedItem: AppointmentMissedItem?) -> Bool {
        
        if missedItem == nil {
            return true
        } else if missedItem!.appointmentId.isEmpty {
            ExceptionManager.throwIsRequiredException(eventType: eventType.rawValue, elementName: "missed appointment item Id")
            return false
        } else if missedItem!.appointmentFollowUpType.isEmpty {
            ExceptionManager.throwIsRequiredException(eventType: eventType.rawValue, elementName: "missed appointment followup type")
            return false
        } else if !CoreConstants.shared.enumContains(AppointmentFollowupType.self, name: missedItem!.appointmentFollowUpType) {
            ExceptionManager.throwEnumException(eventType: eventType.rawValue, className: String(describing: AppointmentFollowupType.self))
            return false
        }else if missedItem!.followUptime < 0 {
            ExceptionManager.throwIsRequiredException(eventType: eventType.rawValue, elementName: "missed appointment followup time")
            return false
        }else if missedItem!.response.isEmpty {
            ExceptionManager.throwIsRequiredException(eventType: eventType.rawValue, elementName: "missed appointment response")
            return false
        }
        return true
    }
    
    
}
