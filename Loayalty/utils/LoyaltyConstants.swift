//
//  LoyaltyConstants.swift
//
//
//  Created by khushbu on 07/11/23.
//

import Foundation


import Foundation

struct LoyaltyConstants {
    static let contentBlockName = "loyalty"
    
    static func isItemTypeObjectValid(itemValue: PromoItemObject, eventType: LoyaltyEventType) {
        let eventName = eventType.rawValue
        
        if itemValue.item_id.isEmpty {
            ExceptionManager.throwIsRequiredException(eventType:eventName , elementName: "item_id")
            return
        } else if itemValue.item_type.rawValue.isEmpty {
            ExceptionManager.throwIsRequiredException(eventType:eventName , elementName: "item_type")
            return
        } else if CoreConstants.shared.enumContains(PromoItemType.self, name: itemValue.item_type) {
            ExceptionManager.throwIsRequiredException(eventType:eventName , elementName: "ItemType")
            return
        }
    }
    
    static func verifyCatalogForSurvey(surveyId: String, surveyCatalogModel: SurveyCatalogModel) -> InternalSurveyModel {
        let catalogName = CatalogSubject.survey.rawValue + " catalog"
        
        if surveyId.isEmpty {
            ExceptionManager.throwIsRequiredException(eventType:catalogName , elementName: "survey Id")
            return
        }else if surveyCatalogModel.name.isEmpty {
            ExceptionManager.throwIsRequiredException(eventType:catalogName , elementName: "survey name")
        }else if surveyCatalogModel.type.isEmpty {
            ExceptionManager.throwIsRequiredException(eventType:catalogName , elementName: "survey type")
        } else if surveyCatalogModel.questions_list.isEmpty {
            ExceptionManager.throwIsRequiredException(eventType:catalogName , elementName: "survey questions")
        }else {
            return InternalSurveyModel(
                id: surveyId,
                name: CoreConstants.checkIfNull(surveyCatalogModel.name),
                duration: surveyCatalogModel.duration,
                type: CoreConstants.checkIfNull(surveyCatalogModel.type),
                reward_id: CoreConstants.checkIfNull(surveyCatalogModel.reward_id),
                questions_list: surveyCatalogModel.questions_list,
                description: CoreConstants.checkIfNull(surveyCatalogModel.description),
                organization_id: CoreConstants.checkIfNull(surveyCatalogModel.organization_id),
                organization_name: CoreConstants.checkIfNull(surveyCatalogModel.organization_name),
                creation_date: getTimeConvertedToString(surveyCatalogModel.creation_date),
                expiry_date: getTimeConvertedToString(surveyCatalogModel.expiry_date)
            )
            
        }
        
        
    }
    
    static func verifyCatalogForReward(rewardId: String, rewardCatalogModel: RewardCatalogModel) -> InternalRewardModel {
        let catalogName = CatalogSubject.reward.rawValue + " catalog"
        
        if rewardId.isEmpty {
            ExceptionManager.throwIsRequiredException(eventType:catalogName , elementName: "reward Id")
            return
        }else if rewardCatalogModel.name.isEmpty {
            ExceptionManager.throwIsRequiredException(eventType:catalogName , elementName: "reward name")
            return
        } else if rewardCatalogModel.type.isEmpty {
            ExceptionManager.throwIsRequiredException(eventType:catalogName , elementName: "reward type")
            return
        } else if rewardCatalogModel.required_points < 1 {
            ExceptionManager.throwIsRequiredException(eventType:catalogName , elementName: "required_points")
            return
        }else {
            return InternalRewardModel(
                id: rewardId,
                name: CoreConstants.checkIfNull(rewardCatalogModel.name),
                description: CoreConstants.checkIfNull(rewardCatalogModel.description),
                type: CoreConstants.checkIfNull(rewardCatalogModel.type),
                required_points: rewardCatalogModel.required_points,
                creation_date: getTimeConvertedToString(rewardCatalogModel.creation_date),
                expiry_date: getTimeConvertedToString(rewardCatalogModel.expiry_date),
                organization_id: CoreConstants.checkIfNull(rewardCatalogModel.organization_id),
                organization_name: CoreConstants.checkIfNull(rewardCatalogModel.organization_name)
            )
            
        }
        
        
    }
    
    func getDateTime(milliSeconds: Int64) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        let date = Date(timeIntervalSince1970: TimeInterval(milliSeconds) / 1000)
        return dateFormatter.string(from: date)
    }
    
    private static func getTimeConvertedToString(eventTime: Int64) -> String {
        if eventTime != 0 {
            return self.getDateTime(eventTime)
        } else {
            return ""
        }
    }
}
