//
//  CfLogCartEvent.swift

//  Created by khushbu on 01/11/23.
//

import CausalFoundrySDKCore
import Foundation

public class CfLogCartEvent {
    /**
     * CfLogCartEvent is used to log the events related to cart. You can use this event to log
     * when an item was added or removed form the cart.
     */
    var cartId: String = ""
    var cartAction: String =  ""
    var itemValue: ItemModel = ItemModel(id: "", type: "", quantity: 1, price: -1.0, currency: "")
    var cartPrice: Float = 0
    var currencyValue: String = ""
    var meta: Any? = nil
    var updateImmediately: Bool = CoreConstants.shared.updateImmediately

    public init() {}

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
    public func setCartAction(cartAction: String) -> CfLogCartEvent {
        if CoreConstants.shared.enumContains(CartAction.self, name: cartAction) {
            self.cartAction = cartAction
        } else {
            ExceptionManager.throwEnumException(eventType: EComEventType.cart.rawValue, className: String(describing: CartAction.self))
        }
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
        if(ECommerceConstants.isItemValueObjectValid(itemValue: item, eventType: EComEventType.cart)){
            itemValue = item
        }
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
        if let data = itemJsonString.data(using: .utf8),
           let item = try? JSONDecoder.new.decode(ItemModel.self, from: data)
        {
            setItem(item: item)
        }
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
        currencyValue = currencyCode
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

    public func build() {
        if cartId.isEmpty {
            ExceptionManager.throwIsRequiredException(eventType: EComEventType.cart.rawValue, elementName: "cart_id")
            return
        }else if cartAction.isEmpty {
            ExceptionManager.throwIsRequiredException(eventType: EComEventType.cart.rawValue, elementName: String(describing: CartAction.self))
            return
        }else if cartPrice < 0 {
            ExceptionManager.throwIsRequiredException(eventType: EComEventType.cart.rawValue, elementName: "cart_price")
            return
        }else if currencyValue.isEmpty {
            ExceptionManager.throwIsRequiredException(eventType: EComEventType.cart.rawValue, elementName: String(describing: CurrencyCode.self))
            return
        }

        if self.currencyValue != itemValue.currency {
            ExceptionManager.throwCurrencyNotSameException(eventType: EComEventType.cart.rawValue, valueName: "cart")
        }

        let cartObject = CartObject(cartId: cartId, action: cartAction, item: itemValue, cartPrice: cartPrice, currency: currencyValue, meta: meta as? Encodable)

        CFSetup().track(contentBlockName: ECommerceConstants.contentBlockName, eventType: EComEventType.cart.rawValue, logObject: cartObject, updateImmediately: updateImmediately)
    }

}
