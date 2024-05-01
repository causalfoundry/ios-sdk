//
//  CfLogSubmitMedicalReviewEvent.swift
//
//
//  Created by khushbu on 03/11/23.
//

import CausalFoundrySDKCore
import Foundation

public class CfLogSubmitMedicalReviewEvent {
    /**
     * CfLogSubmitMedicalReviewEvent is required to log events related to update to
     * medical review of the patient
     */
    var patientId: String?
    var siteId: String?
    var medicalReviewObject: MedicalReviewObject?
    var meta: Any?
    var updateImmediately: Bool = CoreConstants.shared.updateImmediately

    public init() {}

    /**
     * setPatientId is for the providing the id for the patient whose medical review
     * is in question.
     */
    @discardableResult
    public func setPatientId(patientId: String) -> CfLogSubmitMedicalReviewEvent {
        self.patientId = patientId
        return self
    }

    /**
     * setSiteId is for the providing the id for the site where  medical review
     * is concluded.
     */

    @discardableResult
    public func setSiteId(siteId: String) -> CfLogSubmitMedicalReviewEvent {
        self.siteId = siteId
        return self
    }

    /**
     * setMedicalReviewObject is for the providing one medical review element.
     * The item should be based on the medical review object or a string that can be
     * converted to the object with proper param names. in-case the names are not correct
     * the SDK will throw an exception. Below is the function for providing item as an object.
     */
    @discardableResult
    public func setMedicalReviewObject(medicalReviewObject: MedicalReviewObject) -> CfLogSubmitMedicalReviewEvent {
        self.medicalReviewObject = medicalReviewObject
        return self
    }

    /**
     * setMedicalReviewObject is for the providing one medical review element.
     * The item should be based on the medical review object or a string that can be
     * converted to the object with proper param names. in-case the names are not correct
     * the SDK will throw an exception. Below is the function for providing item as a string.
     */
    @discardableResult
    public func setMedicalReviewObject(medicalReviewObject: String) -> CfLogSubmitMedicalReviewEvent {
        if let data = medicalReviewObject.data(using: .utf8),
           let obj = try? JSONDecoder.new.decode(MedicalReviewObject.self, from: data)
        {
            self.medicalReviewObject = obj
        }
        return self
    }

    /**
     * You can pass any type of value in setMeta. It is for developer and partners to log
     * additional information with the log that they find would be helpful for logging and
     * providing more context to the log. Default value for the meta is null.
     */

    @discardableResult
    public func setMeta(meta: Any?) -> CfLogSubmitMedicalReviewEvent {
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
    public func updateImmediately(updateImmediately: Bool) -> CfLogSubmitMedicalReviewEvent {
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
         * setPatientId is for the providing the id for the patient whose medical review
         * is in question.
         */
        guard let patientId = patientId else {
            ExceptionManager.throwIsRequiredException(eventType: PatientMgmtEventType.medical_review.rawValue, elementName: "patient_id")
            return
        }

        /**
         * setSiteId is for the providing the id for the site where  medical review
         * is concluded.
         */
        guard let siteId = siteId else {
            ExceptionManager.throwIsRequiredException(eventType: PatientMgmtEventType.medical_review.rawValue, elementName: "site_id")
            return
        }
        /**
         * Will throw and exception if the action provided is null or no action is
         * provided at all.
         */
        if medicalReviewObject == nil {
            ExceptionManager.throwIsRequiredException(eventType: PatientMgmtEventType.medical_review.rawValue, elementName: "medical review object")
            return
        }
        /**
         * Parsing the values into an object and passing to the setup block to queue
         * the event based on its priority.
         */

        if medicalReviewObject?.id == nil {
            ExceptionManager.throwIsRequiredException(eventType: PatientMgmtEventType.medical_review.rawValue, elementName: "medical review id")
            return
        } 
        
        if( PatientMgmtEventValidation.verifyReviewSummaryList(eventType: PatientMgmtEventType.medical_review, medicalReviewSummary: medicalReviewObject?.reviewSummaryList ?? []) &&
            PatientMgmtEventValidation.verifyDiagnosisObjectList(eventType: PatientMgmtEventType.medical_review, diagnosisType: "diagnosis_result_item", diagnosisList: medicalReviewObject?.diagnosisResultsList ?? []) &&
            PatientMgmtEventValidation.verifyPatientStatusList(eventType: PatientMgmtEventType.medical_review, patientStatusList: medicalReviewObject?.patientStatusList ?? []) &&
            PatientMgmtEventValidation.verifyDiagnosisQuestionList(eventType: PatientMgmtEventType.medical_review, diagnosisQuestionList: medicalReviewObject?.lifestyleAssessmentList ?? []) &&
            PatientMgmtEventValidation.verifyPregnancyObject(eventType: PatientMgmtEventType.medical_review, pregnancyObject: medicalReviewObject?.pregnancyDetails)
        
        ){
            let submitMedicalReviewObject = SubmitMedicalReviewObject(
                patientId: patientId,
                siteId: siteId,
                medicalReview: medicalReviewObject!,
                meta: meta as? Encodable
            )

            CFSetup().track(
                contentBlockName: ChwConstants.contentBlockName,
                eventType: PatientMgmtEventType.medical_review.rawValue,
                logObject: submitMedicalReviewObject,
                updateImmediately: updateImmediately
            )
        }
    }
}
