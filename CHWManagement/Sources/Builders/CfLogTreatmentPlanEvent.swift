//
//  CfLogTreatmentPlanEvent.swift
//
//
//  Created by khushbu on 03/11/23.
//

#if canImport(CasualFoundryCore)
import CasualFoundryCore
#endif
import Foundation

public class CfLogTreatmentPlanEvent {
    /**
     * CfLogTreatmentPlanEvent is required to log events related to view, add, update, or remove
     * the Treatment Plan items value for the patient in question.
     */

    var patientId: String?
    var siteId: String?
    var treatmentPlanId: String?
    var treatmentPlanList: [TreatmentPlanItem] = []
    var meta: Any?
    var updateImmediately: Bool = CoreConstants.shared.updateImmediately

    public init() {}

    /**
     * setPatientId is for providing the ID for the patient whose treatment plan elements
     * are in question.
     */
    @discardableResult
    public func setPatientId(_ patientId: String) -> CfLogTreatmentPlanEvent {
        self.patientId = patientId
        return self
    }

    /**
     * setSiteId is for providing the ID for the site whose treatment plan elements
     * are concluded.
     */
    @discardableResult
    public func setSiteId(_ siteId: String) -> CfLogTreatmentPlanEvent {
        self.siteId = siteId
        return self
    }

    /**
     * setTreatmentPlanId is for providing the ID for the treatment plan if there
     * is more than one value in the app database. In case there is nothing available for
     * treatment plan ID, you can use the following ID as the
     * treatment ID: treatment_<patient_id>
     */
    @discardableResult
    public func setTreatmentPlanId(_ treatmentPlanId: String) -> CfLogTreatmentPlanEvent {
        self.treatmentPlanId = treatmentPlanId
        return self
    }

    /**
     * addTreatmentPlanItem is for providing one treatment plan item at a time.
     * The item should be based on the treatment item object or a string that can be
     * converted to the object with proper param names. In case the names are not correct
     * the SDK will throw an exception. Below is the function for providing an item as an object.
     */
    @discardableResult
    public func addTreatmentPlanItem(_ treatmentPlanItem: TreatmentPlanItem) -> CfLogTreatmentPlanEvent {
        treatmentPlanList.append(treatmentPlanItem)
        return self
    }

    /**
     * addTreatmentPlanItem is for providing one treatment plan item at a time.
     * The item should be based on the treatment item object or a string that can be
     * converted to the object with proper param names. In case the names are not correct
     * the SDK will throw an exception. Below is the function for providing an item as a string.
     */
    @discardableResult
    public func addTreatmentPlanItem(_ treatmentPlanItem: String) -> CfLogTreatmentPlanEvent {
        if let item = try? JSONDecoder.new.decode(TreatmentPlanItem.self, from: Data(treatmentPlanItem.utf8)) {
            treatmentPlanList.append(item)
        }
        return self
    }

    /**
     * setTreatmentPlanList is for providing one treatment plan items as a list.
     * The item should be based on the treatment plan item object or a string that can be
     * converted to the object with proper param names. In case the names are not correct
     * the SDK will throw an exception. Below is the function for providing an item as an object.
     */
    @discardableResult
    public func setTreatmentPlanList(_ treatmentPlanList: [TreatmentPlanItem]) -> CfLogTreatmentPlanEvent {
        self.treatmentPlanList = treatmentPlanList
        return self
    }

    /**
     * setTreatmentPlanList is for providing one treatment plan items as a list
     * in a string. The item should be based on the treatment item object or a string that
     * can be converted to the object with proper param names. In case the names are not correct
     * the SDK will throw an exception. Below is the function for providing an item as a string.
     */
    @discardableResult
    public func setTreatmentPlanList(_ treatmentPlanListString: String) -> CfLogTreatmentPlanEvent {
        if let data = treatmentPlanListString.data(using: .utf8),
           let itemsList = try? JSONDecoder.new.decode([TreatmentPlanItem].self, from: data)
        {
            treatmentPlanList = itemsList
        }
        return self
    }

    /**
     * You can pass any type of value in setMeta. It is for developers and partners to log
     * additional information with the log that they find would be helpful for logging and
     * providing more context to the log. The default value for meta is nil.
     */
    @discardableResult
    public func setMeta(_ meta: Any?) -> CfLogTreatmentPlanEvent {
        self.meta = meta
        return self
    }

    /**
     * updateImmediately is responsible for updating the values to the backend immediately.
     * By default, this is set to false or whatever the developer has set in the SDK
     * initialization block. This differs in the time for which the logs will be logged; if true,
     * the SDK will log the content instantly, and if false, it will wait until the end of the user's
     * session, which is whenever the app goes into the background.
     */
    @discardableResult
    public func updateImmediately(_ updateImmediately: Bool) -> CfLogTreatmentPlanEvent {
        self.updateImmediately = updateImmediately
        return self
    }

    /**
     * build will validate all the values provided, and if they pass, will call the track
     * function and queue the events based on its updateImmediately value and also on the
     * user's network resources.
     */
    public func build() {
        guard let patientId = patientId, !patientId.isEmpty else {
            ExceptionManager.throwIsRequiredException(eventType: ChwMgmtEventType.treatmentPlan.rawValue, elementName: "patient_id")
            return
        }

        guard let siteId = siteId, !siteId.isEmpty else {
            ExceptionManager.throwIsRequiredException(eventType: ChwMgmtEventType.treatmentPlan.rawValue, elementName: "site_id")
            return
        }

        guard let treatmentPlanId = treatmentPlanId, !treatmentPlanId.isEmpty else {
            ExceptionManager.throwIsRequiredException(eventType: ChwMgmtEventType.treatmentPlan.rawValue, elementName: "treatment_plan_id")
            return
        }

        guard !treatmentPlanList.isEmpty else {
            ExceptionManager.throwIsRequiredException(eventType: ChwMgmtEventType.treatmentPlan.rawValue, elementName: "treatment_plan_list")
            return
        }

        for item in treatmentPlanList {
            guard CoreConstants.shared.enumContains(TreatmentType.self, name: item.type) else {
                ExceptionManager.throwEnumException(eventType: ChwMgmtEventType.treatmentPlan.rawValue, className: String(describing: TreatmentType.self))
                return
            }

            guard CoreConstants.shared.enumContains(TreatmentFrequency.self, name: item.frequency) else {
                ExceptionManager.throwEnumException(eventType: ChwMgmtEventType.treatmentPlan.rawValue, className: String(describing: TreatmentFrequency.self))
                return
            }

            guard CoreConstants.shared.enumContains(ItemAction.self, name: item.action) else {
                ExceptionManager.throwEnumException(eventType: ChwMgmtEventType.treatmentPlan.rawValue, className: String(describing: ItemAction.self))
                return
            }

            guard item.value != 0 else {
                ExceptionManager.throwIsRequiredException(eventType: ChwMgmtEventType.treatmentPlan.rawValue, elementName: "value")
                return
            }

            guard item.isApproved != nil else {
                ExceptionManager.throwIsRequiredException(
                    eventType: ChwMgmtEventType.treatmentPlan.rawValue,
                    elementName: "is_approved"
                )
                return
            }
        }

        let treatmentPlanEventObject = TreatmentPlanEventObject(
            patientId: patientId,
            siteId: siteId,
            treatmentPlanId: treatmentPlanId,
            treatmentPlanList: treatmentPlanList,
            meta: meta as? Encodable
        )

        CFSetup().track(
            contentBlockName: ChwConstants.contentBlockName,
            eventType: ChwMgmtEventType.treatmentPlan.rawValue,
            logObject: treatmentPlanEventObject,
            updateImmediately: updateImmediately
        )
    }
}
