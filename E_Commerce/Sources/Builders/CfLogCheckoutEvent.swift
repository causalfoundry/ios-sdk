import CasualFoundryCore
import Foundation

public class CfLogCheckoutEvent {
    /**
     * CfLogCheckoutEvent is required to log checkout event for orders. You can trigger this event
     * when the order has been placed or unable to place. you need to provide orderId in both cases.
     * If you don't have the orderId in case of not being successful then you can pass cartId for
     * that order.
     */

    var order_id: String?
    var cart_id: String?
    var is_successful: Bool = true
    var price_value: Float?
    var currency_value: String?
    var shop_mode: String = ShopMode.delivery.rawValue
    var item_list: [ItemModel] = []
    var meta: Any?
    var update_immediately: Bool = CoreConstants.shared.updateImmediately

    private var checkoutObject: CheckoutObject?

    public init() {}

    /**
     * setOrderId is required to log the orderId for the order being successful or failed
     * to place. In case of not having any orderId for failed cases you can pass the cartId
     * or a corresponding value that can be used to track in the catalog about the order
     * placement details.
     */
    @discardableResult
    public func setOrderId(order_id: String) -> CfLogCheckoutEvent {
        self.order_id = order_id
        return self
    }

    /**
     * setCartId can be used to log the cartId the event is logged for. It is recommended to
     * include the unique cartId for the cart items so that they can be tracked.
     */
    @discardableResult
    public func setCartId(cart_id: String) -> CfLogCheckoutEvent {
        self.cart_id = cart_id
        return self
    }

    /**
     * isSuccessful is required to log the successful placement of the order. False in case of
     * order placement is not successful.
     */
    @discardableResult
    public func isSuccessful(is_successful: Bool) -> CfLogCheckoutEvent {
        self.is_successful = is_successful
        return self
    }

    /**
     * setPrice is required to log the total price of the order being logged. Price format
     * should be in accordance to the currency selected.
     */
    @discardableResult
    public func setPrice(price: Float) -> CfLogCheckoutEvent {
        price_value = ((price * 100.0).rounded() / 100.0)
        return self
    }

    @discardableResult
    public func setPrice(price: Int?) -> CfLogCheckoutEvent {
        price_value = price != nil ? Float(price!) : nil
        return self
    }

    @discardableResult
    public func setPrice(price: Double) -> CfLogCheckoutEvent {
        price_value = Float((price * 100.0).rounded() / 100.0)
        return self
    }

    /**
     * setCurrency is required to log the currency for the order logged. Currency should
     * be in ISO 4217 format. For ease, SDK provides the enums to log the currency so that it
     * would be easy to log. You can also use the string function to provide the currency.
     */
    @discardableResult
    public func setCurrency(currency: String) -> CfLogCheckoutEvent {
        if CoreConstants.shared.enumContains(InternalCurrencyCode.self, name: currency) {
            currency_value = currency
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
        shop_mode = shopMode.rawValue
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
            shop_mode = shopMode
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
        ECommerceConstants.isItemValueObjectValid(itemValue: itemModel, eventType: EComEventType.checkout)
        item_list.append(itemModel)
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
            item_list.append(item)
            if item.type == ItemType.blood.rawValue {
                let bloodMetaModel = try? JSONDecoder.new.decode(BloodMetaModel.self, from: data)
                item.meta = bloodMetaModel
            } else if item.type == ItemType.oxygen.rawValue {
                let oxygenMetaModel = try? JSONDecoder.new.decode(OxygenMetaModel.self, from: data)
                item.meta = oxygenMetaModel
            }
            ECommerceConstants.isItemValueObjectValid(itemValue: item, eventType: EComEventType.checkout)
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
            ECommerceConstants.isItemValueObjectValid(itemValue: item, eventType: EComEventType.checkout)
        }
        item_list.append(contentsOf: itemList)
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
            var itemList = itemModels
            for item in itemList {
                var dataItem = item
                if item.type == ItemType.blood.rawValue {
                    let bloodMetaModel = try? JSONDecoder.new.decode(BloodMetaModel.self, from: data)
                    dataItem.meta = bloodMetaModel
                } else if item.type == ItemType.oxygen.rawValue {
                    let oxygenMetaModel = try? JSONDecoder.new.decode(OxygenMetaModel.self, from: data)
                    dataItem.meta = oxygenMetaModel
                }
                ECommerceConstants.isItemValueObjectValid(itemValue: dataItem, eventType: EComEventType.checkout)
            }
            item_list.append(contentsOf: itemList)
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
    public func updateImmediately(update_immediately: Bool) -> CfLogCheckoutEvent {
        self.update_immediately = update_immediately
        return self
    }

    /**
     * build will validate all of the values provided and if passes will call the track
     * function and queue the events based on its updateImmediately value and also on the
     * user's network resources.
     */
    public func build() {
        guard let order_id = order_id, let cart_id = cart_id,
              let price_value = price_value, let currency_value = currency_value
        else {
            // Required parameters are missing.
            fatalError("Required parameters are missing.")
        }

        var checkoutObject = CheckoutObject(order_id: order_id,
                                            cart_id: cart_id,
                                            is_successful: is_successful,
                                            cart_price: price_value,
                                            currency: currency_value,
                                            shopMode: shop_mode,
                                            items: item_list,
                                            meta: meta as? Encodable)

        if currency_value == InternalCurrencyCode.USD.rawValue {
            checkoutObject.usd_rate = 1.0
            CFSetup().track(
                contentBlockName: ECommerceConstants.contentBlockName,
                eventType: EComEventType.checkout.rawValue,
                logObject: checkoutObject,
                updateImmediately: update_immediately
            )
        } else {
            CFSetup().getUSDRate(fromCurrency: currency_value) { usdRate in
                checkoutObject.usd_rate = Float(usdRate)
                CFSetup().track(
                    contentBlockName: ECommerceConstants.contentBlockName,
                    eventType: EComEventType.checkout.rawValue,
                    logObject: checkoutObject,
                    updateImmediately: self.update_immediately
                )
                return checkoutObject.usd_rate!
            }
        }
    }
}
