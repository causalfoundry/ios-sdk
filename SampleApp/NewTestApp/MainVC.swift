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
        CfLogDeliveryEvent()
            .setOrderId(orderId: "83473843")
            .setDeliveryAction(action:ScheduleDeliveryAction.schedule.rawValue)
            .setDeliveryId(deliveryId:"56509605")
            .setMeta(meta:["TestData":"Testting1"])
                    .build()
        
        
        CfLogItemEvent().
                    .setItemAction(ItemAction.view)
                    .setItemId("TestItemId")
                    .setItemPrice(200)
                    .setItemQuantity(1)
                    .setItemCurrency(CurrencyCode.PKR.name)
                    .setItemType(ItemType.drug)
                    .setCatalogProperties(drugProperties)
                    .build()
        
    }
}
