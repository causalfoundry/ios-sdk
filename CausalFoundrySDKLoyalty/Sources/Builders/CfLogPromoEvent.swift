//
//  CfLogPromoEvent.swift
//
//
//  Created by khushbu on 07/11/23.
//

import CausalFoundrySDKCore
import Foundation

public class CfLogPromoEvent {
    /**
     * CfLogPromoEvent is to log the events associated of the promo lists and promo items and when they are clicked on.
     */

    var promo_id: String = ""
    var promo_action: String = ""
    var promo_title: String = ""
    var promo_type: String = ""
    var promo_items_list: [PromoItemObject] = []
    private var meta: Any?
    private var update_immediately: Bool = CoreConstants.shared.updateImmediately
    public init() {}

    /**
     * setPromoId is required to set the Id of the promo
     */

    @discardableResult
    public func setPromoId(promo_id: String) -> CfLogPromoEvent {
        self.promo_id = promo_id
        return self
    }

    /**
     * setPromoAction is required to set the action for the promo
     */
    @discardableResult
    public func setPromoAction(promo_action: PromoAction) -> CfLogPromoEvent {
        self.promo_action = promo_action.rawValue
        return self
    }

    @discardableResult
    public func setPromoAction(promo_action: String) -> CfLogPromoEvent {
        if CoreConstants.shared.enumContains(PromoAction.self, name: promo_action) {
            self.promo_action = promo_action
        } else {
            ExceptionManager.throwEnumException(eventType: LoyaltyEventType.promo.rawValue, className: String(String(describing: PromoAction.self)))
        }
        return self
    }

    /**
     * setPromoTitle is required to set the title of the promo (if any)
     */
    @discardableResult
    public func setPromoTitle(promo_title: String) -> CfLogPromoEvent {
        self.promo_title = promo_title
        return self
    }

    /**
     * setPromoType is required to set the type of the promo
     */
    @discardableResult
    public func setPromoType(promo_type: PromoType) -> CfLogPromoEvent {
        self.promo_type = promo_type.rawValue
        return self
    }

    @discardableResult
    public func setPromoType(promo_type: String) -> CfLogPromoEvent {
        if CoreConstants.shared.enumContains(PromoType.self, name: promo_type) {
            self.promo_type = promo_type
        } else {
            ExceptionManager.throwEnumException(eventType: LoyaltyEventType.promo.rawValue, className: String(describing: PromoType.self))
        }
        return self
    }

    /**
     * addItem can be used to add the item promo is being applied to. This log can
     * be used to add one item to the log at a time. Promo item should be in a valid format.
     * With elements of the orderObject as:
     * PromoItemObject(itemID, type)
     */
    @discardableResult
    public func addItem(itemModel: PromoItemObject) -> CfLogPromoEvent {
        LoyaltyConstants.isItemTypeObjectValid(itemValue: itemModel, eventType: LoyaltyEventType.promo)
        promo_items_list.append(itemModel)
        return self
    }

    /**
     * setItem can be used to pass the whole item as a Json String object as well. You can use
     * the POJO ItemModel to parse the data int he required format and pass that to this
     * function as a string to log the event. You can use Gson to convert the object to string
     * but SDK will parse the Json string back to POJO so pass it in the log. This method
     * should be used with caution and is suitable for react native bridge.
     */
    @discardableResult
    public func addItem(itemJsonString: String) -> CfLogPromoEvent {
        if let item = try? JSONDecoder.new.decode(PromoItemObject.self, from: itemJsonString.data(using: .utf8)!) {
            LoyaltyConstants.isItemTypeObjectValid(itemValue: item, eventType: LoyaltyEventType.promo)
            promo_items_list.append(item)
        }
        return self
    }

    /**
     * addItemList can be used to add the whole list to the log at once, the format should be
     * ArrayList<PromoItemObject> to log the event successfully. Order item should be in a
     * valid format. With elements as:
     * PromoItemObject(itemID, type)
     */
    @discardableResult
    public func addItemList(itemList: [PromoItemObject]) -> CfLogPromoEvent {
        for promoItem in itemList {
            LoyaltyConstants.isItemTypeObjectValid(itemValue: promoItem, eventType: LoyaltyEventType.promo)
        }
        promo_items_list = itemList
        return self
    }

    /**
     * addItemList can be used to add the whole list to the log at once, the format should be
     * ArrayList<PromoItemObject> to log the event successfully. But the input param is of type
     * string , this is special use case for react native logs where list can be passed as
     * Json string and can be used to log the event. Order item should be in a valid format.
     * With elements of the orderObject as:
     * PromoItemObject(itemID, type)
     */
    @discardableResult
    public func addItemList(itemListString: String) -> CfLogPromoEvent {
        if let data = itemListString.data(using: .utf8), let itemModels = try? JSONDecoder.new.decode([PromoItemObject].self, from: data) {
            addItemList(itemList: itemModels)
        }
        return self
    }

    /**
     * You can pass any type of value in setMeta. It is for developer and partners to log
     * additional information with the log that they find would be helpful for logging and
     * providing more context to the log. Default value for the meta is null.
     */
    @discardableResult
    public func setMeta(meta: Any?) -> CfLogPromoEvent {
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
    public func updateImmediately(update_immediately: Bool) -> CfLogPromoEvent {
        self.update_immediately = update_immediately
        return self
    }

    /**
     * build will validate all of the values provided and if passes will call the track
     * function and queue the events based on it's updateImmediately value and also on the
     * user's network resources.
     */
    public func build() {
        /**
         * Will throw and exception if the promo_id provided is null or no value is
         * provided at all.
         */
        if promo_id.isEmpty {
            ExceptionManager.throwIsRequiredException(eventType: LoyaltyEventType.promo.rawValue, elementName: "promo_id")
            return
        }
        
        if promo_action.isEmpty {
            ExceptionManager.throwIsRequiredException(eventType: LoyaltyEventType.promo.rawValue, elementName: "promo_action")
            return
        }
        
        if promo_items_list.isEmpty {
            ExceptionManager.throwIsRequiredException(eventType: String(describing: LoyaltyEventType.promo.rawValue), elementName: "promo_items_list")
            return
        }
        
        if promo_title.isEmpty {
            ExceptionManager.throwIsRequiredException(eventType: String(describing: LoyaltyEventType.promo.rawValue), elementName: "promo_title")
            return
        }

        if promo_type.isEmpty {
            ExceptionManager.throwIsRequiredException(eventType: String(describing: LoyaltyEventType.promo.rawValue), elementName: "promo_type")
            return
        }
        
    
        /**
         * Parsing the values into an object and passing to the setup block to queue
         * the event based on its priority.
         */
        let promoObject = PromoObject(
            promo_id: promo_id,
            promo_action: promo_action,
            promo_title: CoreConstants.shared.checkIfNull(promo_title),
            promo_type: promo_type,
            promo_items_list: promo_items_list,
            meta: meta as? Encodable
        )
        CFSetup().track(contentBlockName: LoyaltyConstants.contentBlockName, eventType: LoyaltyEventType.promo.rawValue, logObject: promoObject, updateImmediately: update_immediately)
    }
}
