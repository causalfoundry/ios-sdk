import CasualFoundryCore
import Foundation

public class CfLogCheckoutEvent {
    /**
     * CfLogCheckoutEvent is required to log checkout event for orders. You can trigger this event
     * when the order has been placed or unable to place. you need to provide orderId in both cases.
     * If you don't have the orderId in case of not being successful then you can pass cartId for
     * that order.
     */

    var orderId: String = ""
    var cartId: String = ""
    var isSuccessfulValue: Bool = true
    var priceValue: Float = 0
    var currencyValue: String = ""
    var shopMode: String = ShopMode.delivery.rawValue
    var itemList: [ItemModel] = []
    var meta: Any? = nil
    var updateImmediately: Bool = CoreConstants.shared.updateImmediately

    public init() {}

    /**
     * setOrderId is required to log the orderId for the order being successful or failed
     * to place. In case of not having any orderId for failed cases you can pass the cartId
     * or a corresponding value that can be used to track in the catalog about the order
     * placement details.
     */
    @discardableResult
    public func setOrderId(orderId: String) -> CfLogCheckoutEvent {
        self.orderId = orderId
        return self
    }

    /**
     * setCartId can be used to log the cartId the event is logged for. It is recommended to
     * include the unique cartId for the cart items so that they can be tracked.
     */
    @discardableResult
    public func setCartId(cartId: String) -> CfLogCheckoutEvent {
        self.cartId = cartId
        return self
    }

    /**
     * isSuccessful is required to log the successful placement of the order. False in case of
     * order placement is not successful.
     */
    @discardableResult
    public func isSuccessful(isSuccessfulValue: Bool) -> CfLogCheckoutEvent {
        self.isSuccessfulValue = isSuccessfulValue
        return self
    }

    /**
     * setPrice is required to log the total price of the order being logged. Price format
     * should be in accordance to the currency selected.
     */
    @discardableResult
    public func setPrice(priceValue: Float) -> CfLogCheckoutEvent {
        self.priceValue = ((priceValue * 100.0).rounded() / 100.0)
        return self
    }

    /**
     * setCurrency is required to log the currency for the order logged. Currency should
     * be in ISO 4217 format. For ease, SDK provides the enums to log the currency so that it
     * would be easy to log. You can also use the string function to provide the currency.
     */
    @discardableResult
    public func setCurrency(currencyValue: String) -> CfLogCheckoutEvent {
        if CoreConstants.shared.enumContains(InternalCurrencyCode.self, name: currencyValue) {
            self.currencyValue = currencyValue
        } else {
            ExceptionManager.throwEnumException(eventType: EComEventType.checkout.rawValue, className: "CurrencyCode")
        }
        return self
    }

    /**
     * setShopMode is required to log the mode which is used by the user to shop the
     * product, either by delivery or pickup. By default, the SDK offers the shop mode
     * to be delivery. You can pass the enum as well as String as well, but that needs to
     * correspond to the enums available.
     */
    @discardableResult
    public func setShopMode(shopMode: ShopMode) -> CfLogCheckoutEvent {
        self.shopMode = shopMode.rawValue
        return self
    }

    /**
     * setShopMode is required to log the mode which is used by the user to shop the
     * product, either by delivery or pickup. By default, the SDK offers the shop mode
     * to be delivery. You can pass the enum as well as String as well, but that needs to
     * correspond to the enums available.
     */
    @discardableResult
    public func setShopMode(shopMode: String) -> CfLogCheckoutEvent {
        if CoreConstants.shared.enumContains(ShopMode.self, name: shopMode) {
            self.shopMode = shopMode
        } else {
            ExceptionManager.throwEnumException(eventType: EComEventType.checkout.rawValue, className: "ShopMode")
        }
        return self
    }

    /**
     * addItem can be used to add the item being ordered into the checkout list. This log can
     * be used to add one item to the log at a time. Order item should be in a valid format.
     * With elements of the orderObject as:
     * ItemModel(itemID, type, price, currency, stock_status, quantity, promoId) Promo Id can be an
     * empty string or no value at all if the item does not have a promo offer that is obtained
     * by the user. You can add multiple addOrder functions to one checkout event to include
     * all the items in the order.
     */
    @discardableResult
    public func addItem(itemModel: ItemModel) -> CfLogCheckoutEvent {
        if(!ECommerceConstants.isItemValueObjectValid(itemValue: itemModel, eventType: EComEventType.checkout)){
            return self
        }
        self.itemList.append(itemModel)
        return self
    }

    /**
     * setItem can be used to pass the whole item as a JSON String object as well. You can use
     * the POJO ItemModel to parse the data in the required format and pass that to this
     * function as a string to log the event. You can use JSONSerialization to convert the object to string
     * but SDK will parse the JSON string back to POJO, so pass it in the log. This method
     * should be used with caution and is suitable for react native bridge.
     */
    @discardableResult
    public func addItem(itemJsonString: String) -> CfLogCheckoutEvent {
        if let data = itemJsonString.data(using: .utf8),
           var item = try? JSONDecoder.new.decode(ItemModel.self, from: data)
        {
            if item.type == ItemType.blood.rawValue {
                let bloodMetaModel = try? JSONDecoder.new.decode(BloodMetaModel.self, from: data)
                item.meta = bloodMetaModel
            } else if item.type == ItemType.oxygen.rawValue {
                let oxygenMetaModel = try? JSONDecoder.new.decode(OxygenMetaModel.self, from: data)
                item.meta = oxygenMetaModel
            }
            if(!ECommerceConstants.isItemValueObjectValid(itemValue: item, eventType: EComEventType.checkout)){
                return self
            }
            self.itemList.append(item)
        } else {
            // Handle JSON parsing error
        }
        return self
    }

    /**
     * addItemList can be used to add the whole list to the log at once, the format should be
     * [ItemModel] to log the event successfully. Order item should be in a valid format.
     * With elements of the orderObject as:
     * ItemModel(itemID, type, price, currency, stock_status, quantity, promoId) Promo Id can be an
     * empty string or no value at all if the item does not have a promo offer that is obtained
     * by the user. You should use only one addItemList with a checkout event or else the list
     * will only save the later one.
     */
    @discardableResult
    public func addItemList(itemList: [ItemModel]) -> CfLogCheckoutEvent {
        for item in itemList {
            if(!ECommerceConstants.isItemValueObjectValid(itemValue: item, eventType: EComEventType.checkout)){
                return self
            }
        }
        self.itemList.append(contentsOf: itemList)
        return self
    }

    /**
     * addItemList can be used to add the whole list to the log at once, the format should be
     * [ItemModel] to log the event successfully. But the input param is of type
     * String, this is a special use case for react native logs where a list can be passed as
     * a JSON string and can be used to log the event. Order item should be in a valid format.
     * With elements of the orderObject as:
     * ItemModel(itemID, type, price, currency, stock_status, quantity, promoId) Promo Id can be an
     * empty string or no value at all if the item does not have a promo offer that is obtained
     * by the user. You should use only one addItemList with a checkout event or else the list
     * will only save the later one.
     */
    @discardableResult
    public func addItemList(itemListString: String) -> CfLogCheckoutEvent {
        if let data = itemListString.data(using: .utf8),
           let itemModels = try? JSONDecoder.new.decode([ItemModel].self, from: data)
        {
            for index in itemModels.indices {
                var item = itemModels[index]
                if item.type == ItemType.blood.rawValue {
                    let bloodMetaModel = try? JSONDecoder.new.decode(BloodMetaModel.self, from: data)
                    item.meta = bloodMetaModel
                } else if item.type == ItemType.oxygen.rawValue {
                    let oxygenMetaModel = try? JSONDecoder.new.decode(OxygenMetaModel.self, from: data)
                    item.meta = oxygenMetaModel
                }
                if(!ECommerceConstants.isItemValueObjectValid(itemValue: item, eventType: EComEventType.checkout)){
                    return self
                }
            }
            self.itemList.append(contentsOf: itemModels)
        } else {
            // Handle JSON parsing error
        }
        return self
    }

    /**
     * You can pass any type of value in setMeta. It is for developers and partners to log
     * additional information with the log that they find would be helpful for logging and
     * providing more context to the log. Default value for the meta is nil.
     */
    @discardableResult
    public func setMeta(meta: Any?) -> CfLogCheckoutEvent {
        self.meta = meta
        return self
    }

    /**
     * updateImmediately is responsible for updating the values to the backend immediately.
     * By default this is set to false or whatever the developer has set in the SDK
     * initialization block. This differs the time for which the logs will be logged, if true,
     * the SDK will log the content instantly and if false it will wait until the end of the user
     * session, which is whenever the app goes into the background.
     */
    @discardableResult
    public func updateImmediately(updateImmediately: Bool) -> CfLogCheckoutEvent {
        self.updateImmediately = updateImmediately
        return self
    }

    /**
     * build will validate all of the values provided and if passes will call the track
     * function and queue the events based on its updateImmediately value and also on the
     * user's network resources.
     */
    public func build() {
        
        if orderId.isEmpty {
            ExceptionManager.throwIsRequiredException(eventType: EComEventType.checkout.rawValue, elementName: "orderId")
            return
        }else if cartId.isEmpty {
            ExceptionManager.throwIsRequiredException(eventType: EComEventType.checkout.rawValue, elementName: "cartId")
            return
        }else if priceValue < 0 {
            ExceptionManager.throwIsRequiredException(eventType: EComEventType.checkout.rawValue, elementName: "cartPrice")
            return
        }else if shopMode.isEmpty {
            ExceptionManager.throwIsRequiredException(eventType: EComEventType.checkout.rawValue, elementName: "shopMode")
            return
        }else if currencyValue.isEmpty {
            ExceptionManager.throwIsRequiredException(eventType: EComEventType.checkout.rawValue, elementName: String(describing: InternalCurrencyCode.self))
            return
        }else if(itemList.isEmpty){
            ExceptionManager.throwIsRequiredException(eventType: EComEventType.checkout.rawValue, elementName: "itemList")
            return
        }
        
        for itemValue in itemList {
            if (currencyValue != itemValue.currency) {
                ExceptionManager.throwCurrencyNotSameException(eventType: EComEventType.checkout.rawValue, valueName: "checkout")
            }
        }

        let checkoutObject = CheckoutObject(orderId: orderId,
                                            cartId: cartId,
                                            isSuccessful: isSuccessfulValue,
                                            cartPrice: priceValue,
                                            currency: currencyValue,
                                            shopMode: shopMode,
                                            items: itemList,
                                            meta: meta as? Encodable)
        
        CFSetup().track(
            contentBlockName: ECommerceConstants.contentBlockName,
            eventType: EComEventType.checkout.rawValue,
            logObject: checkoutObject,
            updateImmediately: updateImmediately
        )
    }
}
