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
    var diagnosisValuesList: [DiagnosisItem] = []
    var diagnosisResultList: [DiagnosisItem] = []
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
        if !CoreConstants.shared.enumContains(ChwSiteType.self, name: category) {
            ExceptionManager.throwEnumException(eventType: ChwMgmtEventType.submitScreening.rawValue, className: String(describing: ChwSiteType.self))
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
    public func setSiteCategory(category: ChwSiteType) -> CfLogSubmitScreeningEvent {
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
            ExceptionManager.throwEnumException(eventType: ChwMgmtEventType.submitScreening.rawValue, className: String(describing: ScreeningType.self))
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
     * addDiagnosisValueItem is for the providing one diagnosis value item at a time.
     * The item should be based on the DiagnosisItem item object or a string that can be
     * converted to the object with proper param names. in-case the names are not correct
     * the SDK will throw an exception. Below is the function for providing item as an object.
     */

    @discardableResult
    public func addDiagnosisValueItem(diagnosisValueItem: DiagnosisItem) -> CfLogSubmitScreeningEvent {
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
    public func addDiagnosisValueItem(diagnosisValueItem: String) -> CfLogSubmitScreeningEvent {
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
    public func setDiagnosisValueList(diagnosisValuesList: [DiagnosisItem]) -> CfLogSubmitScreeningEvent {
        let builder = self
        builder.diagnosisValuesList = diagnosisValuesList
        return builder
    }

    /**
     * setDiagnosisValueList is for the providing one diagnosis value items list.
     * The item should be based on the DiagnosisItem item object or a string that can be
     * converted to the object with proper param names. in-case the names are not correct
     * the SDK will throw an exception. Below is the function for providing item as a string.
     */

    @discardableResult
    public func setDiagnosisValueList(diagnosisValuesList: String) -> CfLogSubmitScreeningEvent {
        self.diagnosisValuesList.removeAll()
        if let item = try? JSONDecoder.new.decode(DiagnosisItem.self, from: Data(diagnosisValuesList.utf8)) {
            self.diagnosisValuesList.append(item)
        }
        return self
    }

    /**
     * addDiagnosisResultItem is for the providing one diagnosis result item at a time.
     * The item should be based on the DiagnosisItem item object or a string that can be
     * converted to the object with proper param names. in-case the names are not correct
     * the SDK will throw an exception. Below is the function for providing item as an object.
     */
    @discardableResult
    public func addDiagnosisResultItem(diagnosisResultItem: DiagnosisItem) -> CfLogSubmitScreeningEvent {
        diagnosisResultList.append(diagnosisResultItem)
        return self
    }

    /**
     * addDiagnosisResultItem is for the providing one diagnosis result item at a time.
     * The item should be based on the DiagnosisItem item object or a string that can be
     * converted to the object with proper param names. in-case the names are not correct
     * the SDK will throw an exception. Below is the function for providing item as a string.
     */
    @discardableResult
    public func addDiagnosisResultItem(diagnosisResultItem: String) -> CfLogSubmitScreeningEvent {
        if let item = try? JSONDecoder.new.decode(DiagnosisItem.self, from: Data(diagnosisResultItem.utf8)) {
            diagnosisResultList.append(item)
        }
        return self
    }

    /**
     * setDiagnosisResultList is for the providing one diagnosis result items list.
     * The item should be based on the DiagnosisItem item object or a string that can be
     * converted to the object with proper param names. in-case the names are not correct
     * the SDK will throw an exception. Below is the function for providing item as an object.
     */

    @discardableResult
    public func setDiagnosisResultList(diagnosisResultList: [DiagnosisItem]) -> CfLogSubmitScreeningEvent {
        self.diagnosisResultList = diagnosisResultList
        return self
    }

    /**
     * setDiagnosisResultList is for the providing one diagnosis result items list.
     * The item should be based on the DiagnosisItem item object or a string that can be
     * converted to the object with proper param names. in-case the names are not correct
     * the SDK will throw an exception. Below is the function for providing item as a string.
     */
    @discardableResult
    public func setDiagnosisResultList(diagnosisResultList: String) -> CfLogSubmitScreeningEvent {
        self.diagnosisResultList.removeAll()
        if let item = try? JSONDecoder.new.decode(DiagnosisItem.self, from: Data(diagnosisResultList.utf8)) {
            self.diagnosisResultList.append(item)
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
        if patientId == nil || patientId!.isEmpty {
            ExceptionManager.throwIsRequiredException(eventType: ChwMgmtEventType.submitScreening.rawValue, elementName: "patient_id")
            return
        }
        /**
         * Will throw and exception if the action provided is null or no action is
         * provided at all.
         */

        if siteId == nil || siteId!.isEmpty {
            ExceptionManager.throwIsRequiredException(eventType: ChwMgmtEventType.submitScreening.rawValue, elementName: "site_id")
            return
        }
        /**
         * Will throw and exception if the action provided is null or no action is
         * provided at all.
         */

        if category == nil || category!.isEmpty {
            ExceptionManager.throwIsRequiredException(eventType: ChwMgmtEventType.submitScreening.rawValue, elementName: "category")
            return
        }
        /**
         * Will throw and exception if the action provided is null or no action is
         * provided at all.
         */

        if type == nil || type!.isEmpty {
            ExceptionManager.throwIsRequiredException(eventType: ChwMgmtEventType.submitScreening.rawValue, elementName: "type")
            return
        }
        /**
         * Will throw and exception if the action provided is null or no action is
         * provided at all.
         */

        if referredForAssessment == nil {
            ExceptionManager.throwIsRequiredException(eventType: ChwMgmtEventType.submitScreening.rawValue, elementName: "referred_for_assessment")
            return
        }
        /**
         * Will throw and exception if the diagnosis_values_list provided is null or
         * no diagnosis_values_list is provided at all.
         */

        if diagnosisValuesList.isEmpty {
            ExceptionManager.throwIsRequiredException(eventType: ChwMgmtEventType.submitScreening.rawValue, elementName: "diagnosis_values_list")
            return
        }

        /**
         * Will throw and exception if the diagnosis_result_list provided is null
         * or no diagnosis_result_list is provided at all.
         */
        if diagnosisResultList.isEmpty {
            ExceptionManager.throwIsRequiredException(eventType: "diagnosis_values_list", elementName: "diagnosis_result_list")
            return
        } else {
            for item in diagnosisValuesList {
                if !CoreConstants.shared.enumContains(DiagnosisType.self, name: item.type) {
                    ExceptionManager.throwEnumException(eventType: ChwMgmtEventType.submitScreening.rawValue, className: String(describing: DiagnosisType.self))
                } else if item.value.isEmpty {
                    ExceptionManager.throwIsRequiredException(eventType: ChwMgmtEventType.submitScreening.rawValue, elementName: "diagnosis_item value")
                } else if item.unit.isEmpty {
                    ExceptionManager.throwIsRequiredException(eventType: ChwMgmtEventType.submitScreening.rawValue, elementName: "diagnosis_item unit")
                }
            }

            for item in diagnosisResultList {
                if !CoreConstants.shared.enumContains(DiagnosisType.self, name: item.type) {
                    ExceptionManager.throwEnumException(eventType: ChwMgmtEventType.submitScreening.rawValue, className: String(describing: DiagnosisType.self))
                } else if item.value.isEmpty {
                    ExceptionManager.throwIsRequiredException(eventType: ChwMgmtEventType.submitScreening.rawValue, elementName: "diagnosis_item value")

                } else if item.unit.isEmpty {
                    ExceptionManager.throwIsRequiredException(eventType: ChwMgmtEventType.submitScreening.rawValue, elementName: "diagnosis_item unit")
                }
            }

            let submitScreeningEventObject = SubmitScreeningEventObject(
                patientId: patientId!,
                siteId: siteId!,
                diagnosisValuesList: diagnosisValuesList,
                diagnosisResultsList: diagnosisResultList,
                category: category!,
                type: type!,
                referredForAssessment: referredForAssessment!,
                meta: meta as? Encodable
            )

            CFSetup().track(
                contentBlockName: ChwConstants.contentBlockName, eventType: ChwMgmtEventType.submitScreening.rawValue, logObject: submitScreeningEventObject,
                updateImmediately: updateImmediately,
                eventTime: eventTimeValue
            )
        }
    }
}
