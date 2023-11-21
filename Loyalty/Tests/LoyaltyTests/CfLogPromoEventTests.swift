import XCTest

class CfLogPromoEventTests: XCTestCase {

    func testSetPromoId() {
        let cfLogPromoEvent = CfLogPromoEvent()
        let result = cfLogPromoEvent.setPromoId(promo_id: "promo123")
        XCTAssertEqual(result.promo_id, "promo123")
    }

    func testSetPromoActionWithEnum() {
        let cfLogPromoEvent = CfLogPromoEvent()
        let result = cfLogPromoEvent.setPromoAction(promo_action: PromoAction.clicked)
        XCTAssertEqual(result.promo_action, "clicked")
    }

    func testSetPromoActionWithStringValidValue() {
        let cfLogPromoEvent = CfLogPromoEvent()
        let result = cfLogPromoEvent.setPromoAction(promo_action: "clicked")
        XCTAssertEqual(result.promo_action, "clicked")
    }

    func testSetPromoActionWithStringInvalidValue() {
        let cfLogPromoEvent = CfLogPromoEvent()
        XCTAssertThrowsError(try cfLogPromoEvent.setPromoAction(promo_action: "invalidAction"))
    }

    func testSetPromoTitle() {
        let cfLogPromoEvent = CfLogPromoEvent()
        let result = cfLogPromoEvent.setPromoTitle(promo_title: "Special Promo")
        XCTAssertEqual(result.promo_title, "Special Promo")
    }

    func testSetPromoTypeWithEnum() {
        let cfLogPromoEvent = CfLogPromoEvent()
        let result = cfLogPromoEvent.setPromoType(promo_type: PromoType.discount)
        XCTAssertEqual(result.promo_type, "discount")
    }

    func testSetPromoTypeWithStringValidValue() {
        let cfLogPromoEvent = CfLogPromoEvent()
        let result = cfLogPromoEvent.setPromoType(promo_type: "discount")
        XCTAssertEqual(result.promo_type, "discount")
    }

    func testSetPromoTypeWithStringInvalidValue() {
        let cfLogPromoEvent = CfLogPromoEvent()
        XCTAssertThrowsError(try cfLogPromoEvent.setPromoType(promo_type: "invalidType"))
    }

    func testAddItem() {
        let cfLogPromoEvent = CfLogPromoEvent()
        let promoItem = PromoItemObject(itemID: "item123", type: "typeA")
        let result = cfLogPromoEvent.addItem(itemModel: promoItem)
        XCTAssertEqual(result.promo_items_list.count, 1)
        XCTAssertEqual(result.promo_items_list.first?.itemID, "item123")
        XCTAssertEqual(result.promo_items_list.first?.type, "typeA")
    }

    func testAddItemList() {
        let cfLogPromoEvent = CfLogPromoEvent()
        let promoItem1 = PromoItemObject(itemID: "item123", type: "typeA")
        let promoItem2 = PromoItemObject(itemID: "item456", type: "typeB")
        let itemList = [promoItem1, promoItem2]
        let result = cfLogPromoEvent.addItemList(itemList: itemList)
        XCTAssertEqual(result.promo_items_list.count, 2)
        XCTAssertEqual(result.promo_items_list.first?.itemID, "item123")
        XCTAssertEqual(result.promo_items_list.first?.type, "typeA")
        XCTAssertEqual(result.promo_items_list.last?.itemID, "item456")
        XCTAssertEqual(result.promo_items_list.last?.type, "typeB")
    }

    func testSetMeta() {
        let cfLogPromoEvent = CfLogPromoEvent()
        let result = cfLogPromoEvent.setMeta(meta: "Additional information")
        XCTAssertEqual(result.meta as? String, "Additional information")
    }

    func testUpdateImmediately() {
        let cfLogPromoEvent = CfLogPromoEvent()
        let result = cfLogPromoEvent.updateImmediately(update_immediately: true)
        XCTAssertTrue(result.update_immediately)
    }

    func testBuildWithValidData() {
        let cfLogPromoEvent = CfLogPromoEvent()
        cfLogPromoEvent.setPromoId(promo_id: "promo123")
        cfLogPromoEvent.setPromoAction(promo_action: "clicked")
        cfLogPromoEvent.setPromoTitle(promo_title: "Special Promo")
        cfLogPromoEvent.setPromoType(promo_type: "discount")
        cfLogPromoEvent.addItem(itemModel: PromoItemObject(itemID: "item123", type: "typeA"))
        cfLogPromoEvent.setMeta(meta: "Additional information")
        cfLogPromoEvent.updateImmediately(update_immediately: true)

        cfLogPromoEvent.build()
    }

    func testBuildWithoutPromoId() {
        let cfLogPromoEvent = CfLogPromoEvent()
        cfLogPromoEvent.setPromoAction(promo_action: "clicked")
        cfLogPromoEvent.setPromoTitle(promo_title: "Special Promo")
        cfLogPromoEvent.setPromoType(promo_type: "discount")
        cfLogPromoEvent.addItem(itemModel: PromoItemObject(itemID: "item123", type: "typeA"))
        cfLogPromoEvent.setMeta(meta: "Additional information")
        cfLogPromoEvent.updateImmediately(update_immediately: true)

        cfLogPromoEvent.build()
    }

    func testBuildWithoutPromoAction() {
        let cfLogPromoEvent = CfLogPromoEvent()
        cfLogPromoEvent.setPromoId(promo_id: "promo123")
        cfLogPromoEvent.setPromoTitle(promo_title: "Special Promo")
        cfLogPromoEvent.setPromoType(promo_type: "discount")
        cfLogPromoEvent.addItem(itemModel: PromoItemObject(itemID: "item123", type:

