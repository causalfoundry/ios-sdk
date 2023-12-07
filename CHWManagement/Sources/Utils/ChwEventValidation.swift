//
//  ChwEventValidation.swift
//
//
//  Created by khushbu on 10/11/23.
//

#if canImport(CasualFoundryCore)
import CasualFoundryCore
#endif
import Foundation

enum ChwEventValidation {
    static func verifyCounselingPlanList(eventType: ChwMgmtEventType, counselingPlanList: [CounselingPlanItem]) -> Bool {
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
}
