//
//  File.swift
//  
//
//  Created by MOIZ HASSAN KHAN on 28/8/24.
//

import CausalFoundrySDKCore
import Foundation

public class EcomEventValidator {
    
    static func validateViewItemEvent<T: Codable>(logObject: T?) -> ViewItemObject? {
        guard let eventObject = logObject as? ViewItemObject else {
            ExceptionManager.throwInvalidException(
                eventType: EComEventType.Item.rawValue,
                paramName: "ViewItemObject",
                className: "ViewItemObject"
            )
            return nil
        }
        
        guard CoreConstants.shared.enumContains(EComItemAction.self, name: eventObject.action) else {
            ExceptionManager.throwEnumException(
                eventType: EComEventType.Item.rawValue,
                className: String(describing: EComItemAction.self)
            )
            return nil
        }
        
        if(ECommerceConstants.isItemValueObjectValid(itemValue: eventObject.item, eventType: EComEventType.Item)){
            return eventObject
        }
        
        return nil
    }
    
    
    static func validateCartEvent<T: Codable>(logObject: T?) -> CartObject? {
        guard let eventObject = logObject as? CartObject else {
            ExceptionManager.throwInvalidException(
                eventType: EComEventType.Cart.rawValue,
                paramName: "CartObject",
                className: "CartObject"
            )
            return nil
        }
        
        guard !eventObject.cartId.isEmpty else {
            ExceptionManager.throwIsRequiredException(eventType: EComEventType.Cart.rawValue, elementName: "cartId")
            return nil
        }
        
        if(ECommerceConstants.isItemValueObjectValid(itemValue: eventObject.item, eventType: EComEventType.Cart)){
            return eventObject
        }
        
        return nil
    }
    
    
    static func validateCheckoutEvent<T: Codable>(logObject: T?) -> [InternalCheckoutObject]? {
        guard let eventObject = logObject as? CheckoutObject else {
            ExceptionManager.throwInvalidException(
                eventType: EComEventType.Checkout.rawValue,
                paramName: "CheckoutObject",
                className: "CheckoutObject"
            )
            return nil
        }
        
        guard !eventObject.orderId.isEmpty else {
            ExceptionManager.throwIsRequiredException(eventType: EComEventType.Checkout.rawValue, elementName: "orderId")
            return nil
        }
        
        guard !eventObject.cartId.isEmpty else {
            ExceptionManager.throwIsRequiredException(eventType: EComEventType.Checkout.rawValue, elementName: "cartId")
            return nil
        }
        
        guard eventObject.cartPrice >= 0 else {
            ExceptionManager.throwIsRequiredException(eventType: EComEventType.Checkout.rawValue, elementName: "cartPrice")
            return nil
        }
        
        guard !eventObject.itemList.isEmpty else {
            ExceptionManager.throwIsRequiredException(eventType: EComEventType.Checkout.rawValue, elementName: "itemList")
            return nil
        }
        
        for item in eventObject.itemList {
            if(!ECommerceConstants.isItemValueObjectValid(itemValue: item, eventType: EComEventType.Checkout)){
                return nil
            }
        }
        
        return eventObject.itemList.map { item in
            InternalCheckoutObject(
                orderId: eventObject.orderId,
                cartId: eventObject.cartId,
                isSuccessful: eventObject.isSuccessful,
                cartPrice: eventObject.cartPrice,
                shopMode: eventObject.shopMode,
                itemObject: item,
                meta: eventObject.meta
            )
        }
        
    }
    
    static func validateDeliveryEvent<T: Codable>(logObject: T?) -> DeliveryObject? {
        guard let eventObject = logObject as? DeliveryObject else {
            ExceptionManager.throwInvalidException(
                eventType: EComEventType.Delivery.rawValue,
                paramName: "DeliveryObject",
                className: "DeliveryObject"
            )
            return nil
        }
        
        guard !eventObject.orderId.isEmpty else {
            ExceptionManager.throwIsRequiredException(eventType: EComEventType.Delivery.rawValue, elementName: "orderId")
            return nil
        }
        
        guard !eventObject.deliveryId.isEmpty else {
            ExceptionManager.throwIsRequiredException(eventType: EComEventType.Delivery.rawValue, elementName: "deliveryId")
            return nil
        }
        
        return eventObject
    }
    
    
    static func validateCancelCheckoutEvent<T: Codable>(logObject: T?) -> CancelCheckoutObject? {
        guard let eventObject = logObject as? CancelCheckoutObject else {
            ExceptionManager.throwInvalidException(
                eventType: EComEventType.CancelCheckout.rawValue,
                paramName: "CancelCheckoutObject",
                className: "CancelCheckoutObject"
            )
            return nil
        }
        
        guard !eventObject.checkoutId.isEmpty else {
            ExceptionManager.throwIsRequiredException(eventType: EComEventType.CancelCheckout.rawValue, elementName: "checkoutId")
            return nil
        }
        
        guard !eventObject.itemList.isEmpty else {
            ExceptionManager.throwIsRequiredException(eventType: EComEventType.CancelCheckout.rawValue, elementName: "itemList")
            return nil
        }
        
        for item in eventObject.itemList {
            if item.isEmpty {
                ExceptionManager.throwIsRequiredException(eventType: EComEventType.CancelCheckout.rawValue, elementName: "item_id")
                return nil
            }
        }
        
        return eventObject
    }
    
    
    static func validateItemReportEvent<T: Codable>(logObject: T?) -> ItemReportObject? {
        guard let eventObject = logObject as? ItemReportObject else {
            ExceptionManager.throwInvalidException(
                eventType: EComEventType.ItemReport.rawValue,
                paramName: "ItemReportObject",
                className: "ItemReportObject"
            )
            return nil
        }
        
        if(eventObject.itemId.isEmpty){
            ExceptionManager.throwIsRequiredException(eventType: EComEventType.ItemReport.rawValue, elementName: "item id")
            return nil
        } else if(eventObject.storeId.isEmpty){
            ExceptionManager.throwIsRequiredException(eventType: EComEventType.ItemReport.rawValue, elementName: "store id")
            return nil
        } else if(eventObject.reportId.isEmpty){
            ExceptionManager.throwIsRequiredException(eventType: EComEventType.ItemReport.rawValue, elementName: "report id")
            return nil
        } else if(eventObject.reportRemarks.isEmpty){
            ExceptionManager.throwIsRequiredException(eventType: EComEventType.ItemReport.rawValue, elementName: "report remarks")
            return nil
        } else if !CoreConstants.shared.enumContains(ItemType.self, name: eventObject.itemType) {
            ExceptionManager.throwEnumException(eventType: EComEventType.ItemReport.rawValue, className: "item type")
            return nil
        }
        
        return eventObject
    }
    
    static func validateItemRequestEvent<T: Codable>(logObject: T?) -> ItemRequestObject? {
        guard let eventObject = logObject as? ItemRequestObject else {
            ExceptionManager.throwInvalidException(
                eventType: EComEventType.ItemRequest.rawValue,
                paramName: "ItemRequestObject",
                className: "ItemRequestObject"
            )
            return nil
        }
        
        if(eventObject.itemRequestId.isEmpty){
            ExceptionManager.throwIsRequiredException(eventType: EComEventType.ItemRequest.rawValue, elementName: "itemRequest id")
            return nil
        }else if(eventObject.itemName.isEmpty){
            ExceptionManager.throwIsRequiredException(eventType: EComEventType.ItemRequest.rawValue, elementName: "itemRequest name")
            return nil
        }else if(eventObject.manufacturer.isEmpty){
            ExceptionManager.throwIsRequiredException(eventType: EComEventType.ItemRequest.rawValue, elementName: "itemRequest manufacturer")
            return nil
        }
        
        return eventObject
    }
    
}
