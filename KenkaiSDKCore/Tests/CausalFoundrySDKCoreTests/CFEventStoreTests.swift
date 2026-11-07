import XCTest
@testable import KenkaiSDKCore

/// An event logged while an upload is in flight must survive the removal of the uploaded events.
final class CFEventStoreTests: XCTestCase {
    private func event(_ name: String) -> EventDataObject {
        EventDataObject(ol: true, ts: Date(timeIntervalSince1970: 1_700_000_000), name: name, property: "p", ctx: ["k": name])
    }

    override func setUp() {
        super.setUp()
        MMKVHelper.shared.deleteDataEventLogs()
        MMKVHelper.shared.deleteCatalogData()
    }

    func testRemovingUploadedEventsKeepsLaterOnes() {
        let first = event("first")
        let second = event("second")
        MMKVHelper.shared.appendInjectEvent(first)
        MMKVHelper.shared.appendInjectEvent(second)
        let uploading = MMKVHelper.shared.readInjectEvents()
        XCTAssertEqual(uploading.count, 2)

        // Logged while the upload of `uploading` is still in flight.
        let late = event("late")
        MMKVHelper.shared.appendInjectEvent(late)

        MMKVHelper.shared.removeInjectEvents(uploading)
        XCTAssertEqual(MMKVHelper.shared.readInjectEvents(), [late])

        MMKVHelper.shared.removeInjectEvents([late])
        XCTAssertTrue(MMKVHelper.shared.readInjectEvents().isEmpty)
    }

    func testRemovingUploadedCatalogItemsKeepsLaterOnes() {
        let sent = CatalogItemModel(id: "u1", type: "user", keyValues: ["country": "SE"])
        let late = CatalogItemModel(id: "u2", type: "user", keyValues: ["country": "NO"])
        MMKVHelper.shared.appendCatalogItem(sent)
        let uploading = MMKVHelper.shared.readCatalogData()
        MMKVHelper.shared.appendCatalogItem(late)

        MMKVHelper.shared.removeCatalogData(uploading)
        XCTAssertEqual(MMKVHelper.shared.readCatalogData().map { $0.id }, ["u2"])
    }

    /// Unnamed events are never uploaded; an upload pass must still clear them or they stay in the store forever.
    func testUploadDropsUnnamedEvents() async throws {
        MMKVHelper.shared.appendInjectEvent(event(""))
        try await InjestEvenstuploader.uploadEvents()
        XCTAssertTrue(MMKVHelper.shared.readInjectEvents().isEmpty)
    }

    func testAppendsFromManyThreadsAreAllKept() {
        let group = DispatchGroup()
        for index in 0..<50 {
            group.enter()
            DispatchQueue.global().async {
                MMKVHelper.shared.appendInjectEvent(self.event("e\(index)"))
                group.leave()
            }
        }
        XCTAssertEqual(group.wait(timeout: .now() + 10), .success)
        XCTAssertEqual(MMKVHelper.shared.readInjectEvents().count, 50)
    }
}
