//
//  Main.swift
//  NewTestApp
//
//  Created by khushbu on 26/10/23.
//

import UIKit
import CasualFoundryCHWManagement
import CasualFoundryCore
import CasualFoundryEcommerce

class MainVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func action_CHW_Managements_Events(_ sender: Any) {
        testCHW_ManagementEvents()
        
    }
    
    @IBAction func test_EcommerceEvents(_ sender: Any) {
        testEcommerceEvents()
    }
    func testCHW_ManagementEvents () {
        CfLogChwModuleEventBuilder().setChwModuleEvent(.enrolment)
            .updateImmediately(true)
            .setMeta("Test")
            .build()
        
        
        let ordered_date = Date().timeIntervalSince1970 * 1000
        let tested_date = Date().timeIntervalSince1970 * 1000
        
        
        
        let investigationItem  = InvestigationItem(name: "someItem2",
                                                   testValue: "22.3f",
                                                   testUnit: "mg",
                                                   orderedDate: Int64(ordered_date),
                                                   testedDate: Int64(tested_date),
                                                   action: ItemAction.add.rawValue,
                                                   remarks: "Hello World")
        CfLogInvestigationEvent()
            .setPatientId("123")
            .setSiteId("345")
            .setInvestigationId("45454")
            .setInvestigationList([investigationItem])
            .build()
        
        
        let lifestylePlanItem = LifestylePlanItem(name:"LifeStypePlan1", action:ItemAction.update.rawValue, remarks: "LifeStyle Plan1 Added")
        
        
        
        CfLogLifestyleEvent()
            .addLifestylePlanItem(lifestylePlanItem)
            .setPatientId("343434")
            .setSiteId("676767")
            .setLifestyleId("565656")
            .build()
    }
    
    
    func testEcommerceEvents () {
        
        var itemModel = ItemModel(id: "testItemId",
                                  quantity: 10, price: 1900,
                                  currency: CurrencyCode.AED.rawValue,
                                  type: ItemType.misc.rawValue,
                                  stockStatus: "",
                                  promoId: "",
                                  facilityId: "test facilityId")
        
        
        var drugProperties  = DrugCatalogModel(name: "Aciton",
                                               marketId: "232323",
                                               description: "Testing proupose for alcolhol",
                                               supplierId: "76565",
                                               supplierName: "Zydus",
                                               producer: "Zydus",
                                               packaging: "12/23/2023",
                                               activeIngredients: ["dsded","sddsd","sdsdsds"],
                                               drugForm: "Cadila",
                                               drugStrength: "23434",
                                               atcAnatomicalGroup: "parimal",
                                               otcOrEthical: "34343")
        
        //        CfLogDeliveryEvent()
        //            .setOrderId(orderId: "83473843")
        //            .setDeliveryAction(action:DeliveryAction.delivered.rawValue)
        //            .setDeliveryId(deliveryId:"56509605")
        //            .setMeta(meta:["TestData":"Testting1"])
        //            .build()
        
        
        
        // Have some issue need to fix
        //        CfLogItemEvent()
        //                    .setItemAction(ItemAction.view)
        //                    .setItemId("TestItemId")
        //                    .setItemPrice(200)
        //                    .setItemQuantity(1)
        //                    .setItemCurrency(CurrencyCode.AMD.rawValue)
        //                    .setItemType(ItemType.drug)
        //                    .setCatalogProperties(drugProperties)
        //                    .build()
        
        //
        //        CfLogCancelCheckoutEvent()
        //            .setCheckoutId(checkoutId: "testCartId")
        //            .setMeta(meta:  12.0)
        //            .setCancelType(cancelType: CancelType.cart)
        //            .setCancelReason(reason: "testreason")
        //            .addItem(itemModel: ItemTypeModel(item_id: "ItemID1", item_type: ItemType.drug.rawValue))
        //            .addItem(itemModel: ItemTypeModel(item_id: "ItemID2", item_type: ItemType.drug.rawValue))
        //            .build()
        
        
        //
        //        CfLogItemReportEvent()
        //            .setItem(item_object:
        //                        ItemTypeModel(item_id: "itemId", item_type: ItemType.drug.rawValue))
        //            .setStoreObject(store_object: StoreObject(id: "33434", lat: 23.67676, lon:76.67676 ))
        //            .setReportObject(report_object: ReportObject(id: "reportId", short_desc: "short  Value", remarks: "large Value"))
        //            .build()
        //
        //        CfLogItemRequestEvent()
        //                    .setItemRequestId("881")
        //                    .setItemName("Request2")
        //                    .setMeta("12/03/2023")
        //                    .setItemManufacturer("Zydus")
        //                    .build()
        
        
//        CfLogItemVerificationEvent()
//            .setScanChannel(ScanChannel.app)
//            .setScanType(ScanType.pin)
//            .isSuccessful(true)
//            .setItemInfo(
//                ItemInfoObject(id: "12121", type: ItemType.drug.rawValue, batchId: "batch000", surveyId: "survey_id0", rewardId: "reward_id0",isFeatured: false,productionDate: 232323232,expiryDate: 3438438643)
//            ).build()
////        
//        CfLogScheduleDeliveryEvent()
//                   .setOrderId("testOrderId")
//                   .isUrgent(true)
//                   .setScheduleDeliveryAction(ScheduleDeliveryAction.schedule)
//                   .setDeliveryDateTime("1972527600000")
//                   .build()
//        
//        CfLogCartEvent()
//            .setCartId(cartId: "testCartId")
//            .setCartAction(CartAction.addItem.rawValue)
//            .setItem(item: itemModel)
//            .setCurrency(currencyCode:CurrencyCode.AED.rawValue)
//            .setCartPrice(cartPrice: 1900)
//            .build()
        
        
        CfLogCheckoutEvent()
            .setOrderId("testOrderId")
            .setCartId("testCartId")
            .setPrice(900f)
            .setCurrency(CurrencyCode.USD.name)
            .setShopMode(ShopMode.pickup)
            .addItem(itemModel)
            .build()

        CfLogCheckoutEvent()
            .setOrderId("testOrderIdDelivery")
            .setCartId("testCartId")
            .setPrice(900f)
            .setCurrency(CurrencyCode.USD.name)
            .addItem(itemModel)
            .build()
        
    }
}
