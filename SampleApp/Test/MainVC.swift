//
//  Main.swift

//
//  Created by khushbu on 26/10/23.
//

import UIKit
import CasualFoundryCHWManagement
import CasualFoundryCore
import CasualFoundryEcommerce
import CasualFoundryPayments
import CasualFoundryElearning
import CasualFoundryLoyalty

class MainVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func action_CHW_Managements_Events(_ sender: Any) {
        testCHW_ManagementEvents()
        
    }
    
    @IBAction func testLoyaltyEvents(_ sender: Any) {
        
        testLoyaltyEvents()
    }
    @IBAction func test_EcommerceEvents(_ sender: Any) {
        testEcommerceEvents()
    }
    func testCHW_ManagementEvents () {
        //        CfLogChwModuleEventBuilder().setChwModuleEvent(.enrolment)
        //            .updateImmediately(true)
        //            .setMeta("Test")
        //            .build()
        //
        //
        //        let ordered_date = Date().timeIntervalSince1970 * 1000
        //        let tested_date = Date().timeIntervalSince1970 * 1000
        //        let investigationItem  = InvestigationItem(name: "someItem2",
        //                                                   testValue: "22.3f",
        //                                                   testUnit: "mg",
        //                                                   orderedDate: Int64(ordered_date),
        //                                                   testedDate: Int64(tested_date),
        //                                                   action: ItemAction.add.rawValue,
        //                                                   remarks: "Hello World")
        //        CfLogInvestigationEvent()
        //            .setPatientId("123")
        //            .setSiteId("345")
        //            .setInvestigationId("45454")
        //            .setInvestigationList([investigationItem])
        //            .build()
        //
        //
        //        let lifestylePlanItem = LifestylePlanItem(name:"LifeStypePlan1", action:ItemAction.update.rawValue, remarks: "LifeStyle Plan1 Added")
        //
        //
        //        CfLogLifestyleEvent()
        //            .addLifestylePlanItem(lifestylePlanItem)
        //            .setPatientId("343434")
        //            .setSiteId("676767")
        //            .setLifestyleId("565656")
        //            .build()
        //
        //
        //        let prescriptionItem = PrescriptionItem(
        //            drugId: "drug_id",
        //            name: "metaformin2",
        //            dosageValue: 3.0,
        //            dosageUnit: "mg",
        //            type: PrescriptionItemType.syrup.rawValue,
        //            frequency: PrescriptionItemFrequency.BD.rawValue,
        //            prescribedDays: 2,
        //            action: ItemAction.add.rawValue
        //        )
        //
        //
        //        CfLogPrescriptionEvent()
        //            .setPatientId("34343")
        //            .setSiteId("12333")
        //            .setPrescriptionId("84958945")
        //            .setPrescriptionList([prescriptionItem])
        //            .build()
        //
        //
        //        let diagnosisValueItem = DiagnosisItem(
        //            type: DiagnosisType.bloodPressure.rawValue,
        //            value: "120/80",
        //            unit: "mmHg"
        //        )
        //
        //        let diagnosisResultItem = DiagnosisItem(
        //            type: DiagnosisType.cvd.rawValue,
        //            value: "2",
        //            unit: "percentage"
        //        )
        //
        //        let diagnosisSymptomItem = DiagnosisSymptomItem(type: DiagnosisSymptomType.diabetes.rawValue, symptoms:["test1","test2"], remarks: "test demo")
        //
        //        let patientStatusItem = PatientStatusItem(
        //            type: DiagnosisSymptomType.diabetes.rawValue,
        //            value: PatientStatusValueType.new_patient.rawValue
        //        )
        //
        //
        //        let treatmentPlanItem = TreatmentPlanItem(
        //            type: TreatmentType.blood_glucose.rawValue,
        //            value: 22,
        //            frequency: TreatmentFrequency.days.rawValue,
        //            action: ItemAction.remove.rawValue,
        //            isApproved: false
        //        )
        //
        //        CfLogSubmitAssessmentEvent()
        //            .setPatientId("patient_id")
        //            .setSiteId("siteID")
        //            .setMedicationAdherence("took all")
        //            .setDiagnosisValueList([diagnosisValueItem])
        //            .setDiagnosisResultList([diagnosisResultItem])
        //            .addDiagnosisSymptomItem(diagnosisSymptomItem)
        //            .isReferredForAssessment(false)
        //            .build()
        //
        //
        //        CfLogSubmitEnrolmentEvent()
        //            .setPatientId("565685867")
        //            .setSiteId("06050605")
        //            .setAction(ItemAction.add.rawValue)
        //            .setDiagnosisValueList([diagnosisValueItem])
        //            .setDiagnosisResultList([diagnosisResultItem])
        //            .setPatientStatusList(patient_status_list: [patientStatusItem])
        //            .setTreatmentPlanList(treatment_plan_list:[treatmentPlanItem])
        //            .build()
        //
        //
        //        let medicalReviewSummaryObject = MedicalReviewSummaryObject(
        //            type: ReviewSummaryItem.chief_complaints.rawValue,
        //            value: ["Some Complaints List Item"]
        //        )
        //
        //        let medicalReviewObject = MedicalReviewObject(
        //            id: "wd",
        //            reviewSummaryList: [medicalReviewSummaryObject]
        //        )
        //
        //        CfLogSubmitMedicalReviewEvent()
        //            .setPatientId("patient_id")
        //            .setSiteId("siteID")
        //            .setMedicalReviewObject(medicalReviewObject)
        //            .build()
        //
        //
        //        CfLogSubmitScreeningEvent()
        //            .setEventTime(eventTimeValue: 1671464861441)
        //            .setPatientId(patientId: "patient_id")
        //            .setSiteId(siteId: "siteID")
        //            .setSiteCategory(category: ChwSiteType.community)
        //            .setScreeningType(type: ScreeningType.camp)
        //            .setDiagnosisValueList(diagnosisValuesList: [diagnosisValueItem])
        //            .setDiagnosisResultList(diagnosisResultList: [diagnosisResultItem])
        //            .isReferredForAssessment(referredForAssessment: false)
        //            .build()
        //
        //
        //        let treatmentPlanItemData = TreatmentPlanItem(
        //            type: TreatmentType.blood_glucose.rawValue,
        //            value: 22,
        //            frequency: TreatmentFrequency.days.rawValue,
        //            action: ItemAction.remove.rawValue,
        //            isApproved: false
        //        )
        //
        //        CfLogTreatmentPlanEvent()
        //            .setPatientId("patient_id")
        //            .setSiteId("siteID")
        //            .setSiteId("siteID")
        //            .setTreatmentPlanId("treatment_id")
        //            .setTreatmentPlanList([treatmentPlanItemData])
        //            .build()
        
        // CatalogEvents
        let chwCatalogModel = ChwCatalogModel (
            name: "John Doe",
            role: "Nutritionist",
            isVolunteer: false,
            rolePermissions: ["admin", "employee"],
            siteIdsList: ["site1", "site2"],
            servicesList: ["screening", "assessment", "lifestyle", "medical review"]
        )
        CfChwCatalog.updateChwCatalog(chwId: "TestUserID1", chwCatalogModel: chwCatalogModel)
        
        let chwSiteCatalogModel = ChwSiteCatalogModel(
            name: "test",
            country: CountryCode.United_Arab_Emirates.rawValue,
            regionState: "test region_state",
            city: "test city",
            zipcode: "test zipcode",
            level: "test level",
            category: "test category",
            isActive: false,
            address: "test address",
            addressType: "test address_type",
            latitude: 41.385063,
            longitude: 2.173404,
            culture: "test culture"
        )
        CfChwCatalog.updateChwSiteCatalog(siteId: "TestUserID1", chwSiteCatalogModel: chwSiteCatalogModel)
        
        
        let patientCatalog = PatientCatalogModel(
            country: CountryCode.Andorra.rawValue,
            regionState: "Barcelona",
            city: "Barcelona",
            profession: "HCW",
            educationLevel: EducationalLevel.bachelors.rawValue,
            siteIdsList: ["site1", "site2"],
            nationalId: "",
            insuranceId: "",
            insuranceType: "",
            insuranceStatus: false,
            landmark: "Some landmark",
            phoneNumberCategory: "",
            programId: "some Program Id"
        )
        CfChwCatalog.updatePatientCatalog(patientId:"3747347", patientCatalogModel: patientCatalog)
    }
    
    func testEcommerceEvents () {
    
        
        let drugProperties  = DrugCatalogModel(name: "Aciton",
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
        CfEComCatalog.updateDrugCatalog(drugId: "343436", drugCatalogModel: drugProperties)
        let groceryProperties = GroceryCatalogModel(name: "testName",
                                                    category: "Food&Drinks",
                                                    market_id: "ES",
                                                    description: "test",
                                                    supplier_id: "sup1",
                                                    supplier_name: "sup",
                                                    producer: "prod1",
                                                    packaging: "box",
                                                    packaging_size: 12.0,
                                                    packaging_units: "3",
                                                    active_ingredients: ["Seasome seeds","Good"])
        CfEComCatalog.updateGroceryCatalog(itemId: "74673745", groceryCatalogModel: groceryProperties)
        
        
        let oxygenModel = OxygenCatalogModel(marketId: "eu",packaging:"cylinder", packagingSize: 5.0,packagingUnits: "cubic_meter",supplierId: "2323232",supplierName: "Zertodha")
        CfEComCatalog.updateOxygenCatalog(itemId: "347378435", oxygenCatalogModel: oxygenModel)
       
        let bloodModel = BloodCatalogModel(
            marketId: "eu",
            bloodComponent: "platelets",
            bloodGroup: "B+",
            packaging: "pint",
            packagingSize: 1.0,
            packagingUnits: "L",
            supplierId: "",
            supplierName: ""
        )
        CfEComCatalog.updateBloodCatalog(itemId: "347378437", bloodCatalogModel: bloodModel)
        
        
        let medicalEquipmentCatalogModel = MedicalEquipmentCatalogModel(name: "Syrine 3ml",description: "", marketId: "ES",supplierId: "4833443", supplierName: "zydus",producer: "cadila",packaging: "Pacakgin1",packagingSize: 3.0,packagingUnits: "5")
        CfEComCatalog.updateMedicalEquipmentCatalog(itemId:"4477", medicalEquipmentCatalogModel:medicalEquipmentCatalogModel)
        
        
        
        let facilityCatalogModel = FacilityCatalogModel(
            name: "test site name",
            type: "pharmacy",
            country: CountryCode.United_Arab_Emirates.rawValue,
            region_state: "Barcelona",
            city: "Barcelona",
            is_active: true,
            has_delivery: false,
            is_sponsored: false
        )
        
        CfEComCatalog.updateFacilityCatalog(facilityId: "22323", facilityCatalogModel:facilityCatalogModel)
        
        //
        //        CfLogDeliveryEvent()
        //            .setOrderId(orderId: "83473843")
        //            .setDeliveryAction(action:DeliveryAction.delivered.rawValue)
        //            .setDeliveryId(deliveryId:"56509605")
        //            .setMeta(meta:["TestData":"Testting1"])
        //            .build()
        //
        //
        //
        //        // Have some issue need to fix
        //        CfLogItemEvent()
        //            .setItemAction(ItemAction.view)
        //            .setItemId("TestItemId")
        //            .setItemPrice(200)
        //            .setItemQuantity(1)
        //            .setItemCurrency(CurrencyCode.USD.rawValue)
        //            .setItemType(ItemType.drug)
        //            .setCatalogProperties(drugProperties)
        //            .build()
        //
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
        //
        //
        //        CfLogItemReportEvent()
        //            .setItem(item_object:
        //                        ItemTypeModel(item_id: "itemId", item_type: ItemType.drug.rawValue))
        //            .setStoreObject(store_object: StoreObject(id: "33434", lat: 23.67676, lon:76.67676 ))
        //            .setReportObject(report_object: ReportObject(id: "reportId", short_desc: "short  Value", remarks: "large Value"))
        //            .build()
        //
        //        CfLogItemRequestEvent()
        //            .setItemRequestId("881")
        //            .setItemName("Request2")
        //            .setMeta("12/03/2023")
        //            .setItemManufacturer("Zydus")
        //            .build()
        //
        //
        //        CfLogItemVerificationEvent()
        //            .setScanChannel(ScanChannel.app)
        //            .setScanType(ScanType.pin)
        //            .isSuccessful(true)
        //            .setItemInfo(
        //                ItemInfoObject(id: "12121", type: ItemType.drug.rawValue, batchId: "batch000", surveyId: "survey_id0", rewardId: "reward_id0",isFeatured: false,productionDate: 232323232,expiryDate: 3438438643)
        //            ).build()
        //        //
        //        CfLogScheduleDeliveryEvent()
        //            .setOrderId("testOrderId")
        //            .isUrgent(true)
        //            .setScheduleDeliveryAction(ScheduleDeliveryAction.schedule)
        //            .setDeliveryDateTime("1972527600000")
        //            .build()
        //
        //        CfLogCartEvent()
        //            .setCartId(cartId: "testCartId")
        //            .setCartAction(CartAction.addItem.rawValue)
        //            .setItem(item: itemModel)
        //            .setCurrency(currencyCode:CurrencyCode.USD.rawValue)
        //            .setCartPrice(cartPrice: 1900)
        //            .build()
        //
        //
        //        CfLogCheckoutEvent()
        //            .setOrderId(order_id: "testOrderId")
        //            .setCartId(cart_id: "testCartId")
        //            .setPrice(price: 900)
        //            .setCurrency(currency: CurrencyCode.USD.rawValue)
        //            .setShopMode(shopMode:ShopMode.pickup)
        //            .addItem(itemModel: itemModel)
        //            .build()
        
        
    }
    
    @IBAction func testPaymentsEwvents(_ sender: Any) {
        testPaymentsEvents()
    }
    
    
    @IBAction func testElearningEvents(_ sender: Any) {
        testELearningEvents()
    }
    
    
    func testPaymentsEvents() {
        CfLogDeferredPaymentEvent()
            .setPaymentMethod(PaymentMethod.bank_card)
            .setPaymentAction(PaymentAction.payment_processed)
            .setPaymentAmount(2000)
            .setPaymentId("testPaymentId")
            .setCurrency(CurrencyCode.USD.rawValue)
            .setOrderId("testOrderId")
            .setAccountBalance(3000)
            .isSuccessful(true)
            .build()
        
        CfLogPaymentMethodEvent()
            .setOrderId(order_id: "testOrderId")
            .setPaymentMethod(payment_method: PaymentMethod.bank_transfer)
            .setPaymentAmount(payment_amount: 2000)
            .setCurrency(currency: CurrencyCode.USD.rawValue)
            .build()
        
    }
    
    
    func testELearningEvents() {
        
        CfLogQuestionEvent()
            .setQuestionId("testQuestionId")
            .setQuestionAction(QuestionAction.answer)
            .setAnswerId("testAnswerId")
            .setExamId("testExamId")
            .build()
        
        CfLogExamEvent()
            .setExamAction(ExamAction.start)
            .setExamId("exam_exam_id")
            .setScore(90)
            .setDuration(100)
            .isPassed(true)
            .build()
        
        CfLogModuleEvent()
            .setModuleId("testModuleId")
            .setModuleAction(ModuleLogAction.view)
            .setModuleProgress(60)
            .build()
    }
    
    func testLoyaltyEvents() {
        //        CfLogMilestoneEvent()
//            .setMilestoneId("testMilestoneId")
//            .setAction(MilestoneAction.achieved)
//            .build()
//        
//        CfLogLevelEvent()
//            .setNewLevel(newLevel: -4)
//            .setPreviousLevel(prevLevel: -10)
//            .setModuleId(moduleId: "testModuleId")
//            .build()
//        
//        
//        var item1 = PromoItemObject(item_id: "item1", item_type: "drug1")
//        var item2 = PromoItemObject(item_id: "item2", item_type: "drug2")
//        
//        CfLogPromoEvent()
//            .setPromoId(promo_id: "testPromoId")
//            .setPromoAction(promo_action: PromoAction.apply)
//            .setPromoTitle(promo_title: "Hello World")
//            .setPromoType(promo_type: PromoType.add_to_cart)
//            .addItem(itemModel: item1)
//            .addItem(itemModel: item2)
//            .build()
//        
//        CfLogSurveyEvent()
//            .setAction(action: SurveyAction.submit)
//            .setSurveyObject(surveyObject: SurveyObject(id: "2242423", isCompleted: true, rewardId: "44342343", type: SurveyType.openEnded.rawValue))
//            .setResponseList(responseList: [SurveyResponseItem(id: "1223", question: "How are you ?", response: "Good", type :SurveyType.openEnded.rawValue)])
//            .build()
//        
//        
//        CfLogRewardEvent()
//            .setRewardId("testRewardId")
//            .setAction(RewardAction.redeem)
//            .setTotalPoints(22)
//            .setRedeemObject(RedeemObject(type: RedeemType.cash.rawValue, points_withdrawn: 0.1, converted_value: 2.3, currency: "USD", is_successful:true))
//            .build()
        
        let surveyCatalogModel = SurveyCatalogModel(
            name: "Kerri Salazar 1",
            duration: 940,
            type: "natoque",
            reward_id: "consul1",
            questions_list: ["testQ1", "testQ2"],
            description: "dolor",
            creation_date: 1680703107424,
            expiry_date: 1680703107424,
            organization_id: "feugiat",
            organization_name: "Jules Baxter"
        )

        CfLoyaltyCatalog.updateSurveyCatalog(surveyId: "surveyId1", surveyCatalogModel: surveyCatalogModel)
        
        let rewardCatalogModel = RewardCatalogModel(
            name: "Florine Kane 1",
            description: "nostrum",
            type: "consetetur",
            requiredPoints: 4.5,
            creationDate: 1680703107424,
            expiryDate: 1680703107424,
            organizationId: "legimus",
            organizationName: "Helen Vega"
        )

        CfLoyaltyCatalog.updateRewardCatalog(rewardId: "rewardId1", rewardCatalogModel: rewardCatalogModel)
        
    }
    
}
