//
//  CfLogCartEvent.swift

//  Created by khushbu on 01/11/23.
//

import Foundation
import CasualFoundryCore


public class CfLogCartEvent {
    /**
     * CfLogCartEvent is used to log the events related to cart. You can use this event to log
     * when an item was added or removed form the cart.
     */
    var cartId: String? = ""
    var cartAction: String? =  ""
    var itemValue: ItemModel = ItemModel(id: "", type: "", quantity: 1, price: -1.0, currency: "",  stockStatus: "", promoId: "", facilityId: nil)
    var cartPrice: Float?
    var currencyValue: String? = ""
    var meta: Any?
    var updateImmediately: Bool = CoreConstants.shared.updateImmediately
    
    private var cartObject: CartObject?
    
    public init() {
        
    }
    
    /**
     * setCartId can be used to log the cartId the event is logged for. It is recommended to
     * include the unique cartId for the cart items so that they can be tracked.
     */
    
    @discardableResult
    public func setCartId(cartId: String) -> CfLogCartEvent {
        self.cartId = cartId
        return self
    }
    /**
     * setCartAction is required to pass the actions for cart the logged is triggered on. By
     * default the SDK provides 2 main list actions for e-commerce apps. Which includes
     * addItem and removeItem
     * setCartAction provides 2 approaches for logging list events, one is with enums and the
     * other is with string. Below is the @discardableResult
     publiction to log cartAction event using enum type.
     */
    
    @discardableResult
    public func setCartAction(cartAction: CartAction) -> CfLogCartEvent {
        self.cartAction = cartAction.rawValue
        return self
    }
    /**
     * setCartAction is required to pass the actions for cart the logged is triggered on. By
     * default the SDK provides 2 main list actions for e-commerce apps. Which includes
     * addItem and removeItem.
     * setCartAction provides 2 approaches for logging list events, one is with enums and the
     * other is with string. Below is the @discardableResult
     publiction to log listAction event using string type.
     * Remember to note that with string type, you need to pass the values as provided
     * in the enum or else the events will be discarded
     */
    @discardableResult
    public func setCartAction(_ cartAction: String) -> CfLogCartEvent {
        if CoreConstants.shared.enumContains(CartAction.self, name: cartAction) {
            self.cartAction = cartAction
        } else {
            ExceptionManager.throwEnumException(eventType: EComEventType.cart.rawValue, className: String(describing:CartAction.self))
        }
        return self
    }
    /**
     * setItemId is required to log the Id for item the events are being logged. Details
     * about the item are to be provided in the catalog for more details about the item.
     */
    
    @discardableResult
    public func setItemId(itemId: String) -> CfLogCartEvent {
        self.itemValue.id = itemId
        return self
    }
    /**
     * setItemQuantity is required to log the quantity for item the events are being logged. Details
     * about the item are to be provided in the catalog for more details about the item.
     */
    @discardableResult
    public func setItemQuantity(itemQuantity: Int) -> CfLogCartEvent {
        self.itemValue.quantity = itemQuantity
        return self
    }
    /**
     * setItemPrice is required to log the price for item the events are being logged. Details
     * about the item are to be provided in the catalog for more details about the item.
     */
    @discardableResult
    public func setItemPrice(itemPrice: Float) -> CfLogCartEvent {
        self.itemValue.price = (itemPrice * 100).rounded() / 100
        return self
    }
    
    /**
     * setItemCurrency is required to log the currency for item the events are being logged. Details
     * about the item are to be provided in the catalog for more details about the item.
     */
    @discardableResult
    public func setItemCurrency(currencyCode: String) -> CfLogCartEvent {
        self.itemValue.currency = currencyCode
        return self
    }
    
    /**
     * setItemCurrency is required to log the currency for item the events are being logged. Details
     * about the item are to be provided in the catalog for more details about the item.
     */
    //        fun setItemCurrency(currency_code: CurrencyCode) = apply { this.item_currency = currency_code.name }
    @discardableResult
    public func setItemCurrency(_ currencyCode: String) -> CfLogCartEvent {
        if CoreConstants.shared.enumContains(InternalCurrencyCode.self, name: currencyCode) {
            self.itemValue.currency = currencyCode
        } else {
            ExceptionManager.throwEnumException(eventType: EComEventType.cart.rawValue, className: String(describing: InternalCurrencyCode.self))
        }
        return self
    }
    /**
     * setItemType is required to log the type for item the events are being
     * logged. Details about the item are to be provided in the catalog for more details about
     * the item.
     */
    
    @discardableResult
    public func setItemType(itemType: ItemType) -> CfLogCartEvent {
        self.itemValue.type = itemType.rawValue
        return self
    }
    /**
     * setItemStockStatus is required to log the stock status for item the events are being
     * logged. Details about the item are to be provided in the catalog for more details about
     * the item.
     */
    
    
    @discardableResult
    public func setItemStockStatus(stockStatus: ItemStockStatus) -> CfLogCartEvent {
        self.itemValue.stockStatus = stockStatus.rawValue
        return self
    }
    
    
    @discardableResult
    public func setItemStockStatus(_ stockStatus: String) -> CfLogCartEvent {
        if CoreConstants.shared.enumContains(ItemStockStatus.self, name: stockStatus) {
            self.itemValue.stockStatus = stockStatus
        } else {
            ExceptionManager.throwEnumException(eventType: EComEventType.cart.rawValue, className: String(describing: ItemStockStatus.self))
        }
        return self
    }
    
    /**
     * setItemPromoId is required to log the promo Id for item the events are being
     * logged. Details about the item are to be provided in the catalog for more details about
     * the item. If there is not promo associated with the product, you do not need to pass it.
     */
    
    
    @discardableResult
    public func setItemPromoId(promoId: String) -> CfLogCartEvent {
        self.itemValue.promoId = promoId
        return self
    } /**
       * setItemFacilityId is required to log the facility Id for item the events are being
       * logged. Details about the item are to be provided in the facility catalog for more
       * details about the item. If there is no facility associated with the product,
       * you do not need to pass it. Facility here refers to the hospital, clinic, pharmacy, etc.
       */
    
    @discardableResult
    public func setItemFacilityId(facilityId: String) -> CfLogCartEvent {
        self.itemValue.facilityId = facilityId
        return self
    }
    
    /**
     * setItem can be used to pass the whole item as an object as well. You can use the POJO
     * ItemModel to parse the data int he required format and pass that to this @discardableResult
     publiction to
     * log the event.
     */
    @discardableResult
    public func setItem(item: ItemModel) -> CfLogCartEvent {
        self.itemValue = item
        return self
    }
    /**
     * setItem can be used to pass the whole item as a Json String object as well. You can use
     * the POJO ItemModel to parse the data int he required format and pass that to this
     * @discardableResult
     publiction as a string to log the event. You can use Gson to convert the object to string
     * but SDK will parse the Json string back to POJO so pass it in the log. This method
     * should be used with caution and is suitable for react native bridge.
     */
    
    @discardableResult
    public func setItem(itemJsonString: String) -> CfLogCartEvent {
        let item = try? JSONDecoder().decode(ItemModel.self, from: Data(itemJsonString.utf8))
        self.itemValue = item!
        return self
    }
    
    @discardableResult
    public func setCartPrice(cartPrice: Float) -> CfLogCartEvent {
        self.cartPrice = (cartPrice * 100).rounded() / 100
        return self
    }
    
    /**
     * setCurrency is required to log the currency for cart price being logged. Details
     * about the cart are to be provided in the catalog.
     */
    
    @discardableResult
    public func setCurrency(currencyCode: String) -> CfLogCartEvent {
        self.currencyValue = currencyCode
        return self
    }
    /**
     * You can pass any type of value in setMeta. It is for developer and partners to log
     * additional information with the log that they find would be helpful for logging and
     * providing more context to the log. Default value for the meta is null.
     */
    
    @discardableResult
    public func setMeta(meta: Any?) -> CfLogCartEvent {
        self.meta = meta as? Encodable
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
    public func updateImmediately(updateImmediately: Bool) -> CfLogCartEvent {
        self.updateImmediately = updateImmediately
        return self
    }
    
    /**
     * build will validate all of the values provided and if passes will call the track
     * @discardableResult
     publiction and queue the events based on it's updateImmediately value and also on the
     * user's network resources.
     */
    
    
    public func build(){
        guard let id =  self.cartId else {
            ExceptionManager.throwIsRequiredException(eventType: EComEventType.cart.rawValue, elementName: "cart_id")
            return
        }
        guard let action = self.cartAction else {
            ExceptionManager.throwIsRequiredException(eventType:EComEventType.cart.rawValue, elementName: String(describing:CartAction.self))
            return
        }
        guard let price =  self.cartPrice else {
            ExceptionManager.throwIsRequiredException(eventType: EComEventType.cart.rawValue, elementName: "cart_price")
            return
        }
        guard let currencyValue = self.currencyValue else {
            ExceptionManager.throwIsRequiredException(eventType: EComEventType.cart.rawValue, elementName: String(describing:InternalCurrencyCode.self))
            return
        }
        
        ECommerceConstants.isItemValueObjectValid(itemValue: itemValue, eventType: EComEventType.cart)
        
        if self.currencyValue != itemValue.currency {
            ExceptionManager.throwCurrencyNotSameException(eventType:EComEventType.cart.rawValue, valueName: "cart")
        }
        
        self.cartObject = CartObject(cartId:id,action: action, item: itemValue, cartPrice:price, currency: currencyValue, meta: meta as? Encodable)
        
        if self.currencyValue == InternalCurrencyCode.USD.rawValue {
            cartObject?.usdRate = 1.0
            
            CFSetup().track(contentBlockName:  ECommerceConstants.contentBlockName, eventType: EComEventType.cart.rawValue, logObject:cartObject, updateImmediately: self.updateImmediately)
        } else {
            CFSetup().getUSDRate(fromCurrency: currencyValue) { [weak self] value in
                return value
            }
            
        }
    }
    
    
    func getUSDRateAndLogEvent(usdRate: Float) {
        cartObject!.usdRate = usdRate
        CFSetup().track(
            contentBlockName: ECommerceConstants.contentBlockName,
            eventType: EComEventType.cart.rawValue,
            logObject: cartObject!,
            updateImmediately:self.updateImmediately
        )
    }
}
