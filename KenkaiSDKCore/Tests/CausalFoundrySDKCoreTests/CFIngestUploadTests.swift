import XCTest

@testable import KenkaiSDKCore

final class CFIngestUploadTests: XCTestCase {
    func testUploadWithoutUserCallsBackSoEventsStayStored() {
        let savedUser = MMKVHelper.shared.fetchUserID()
        let savedBackup = MMKVHelper.shared.fetchUserBackupID()
        let savedAllowed = CoreConstants.shared.isAnonymousUserAllowed
        let savedInfo = CoreConstants.shared.internalInfoObject
        MMKVHelper.shared.deleteAllUserID()
        CoreConstants.shared.isAnonymousUserAllowed = false
        CoreConstants.shared.internalInfoObject = InternalInfoObject(
            s_id: "", sdk: "test", app_id: "test", app_version: "1", device_id: "device", device_os: "iOS")
        defer {
            MMKVHelper.shared.writeUser(user: savedUser)
            MMKVHelper.shared.writeUserBackup(userId: savedBackup)
            CoreConstants.shared.isAnonymousUserAllowed = savedAllowed
            CoreConstants.shared.internalInfoObject = savedInfo
        }

        // Previously returned without calling back: the uploader's continuation leaked and an
        // immediately-logged event was lost instead of stored.
        let answered = expectation(description: "callback")
        IngestAPIHandler().updateEventTrack(eventArray: []) { success in
            XCTAssertFalse(success)
            answered.fulfill()
        }
        wait(for: [answered], timeout: 1)
    }

    func testCatalogUploadBeforeBuildKeepsItemsStored() async throws {
        let savedKey = CoreConstants.shared.sdkKey
        let savedItems = MMKVHelper.shared.readCatalogData()
        CoreConstants.shared.sdkKey = ""
        MMKVHelper.shared.writeCatalogData(data: [CatalogItemModel(id: "user-1", type: "user", keyValues: ["name": "x"])])
        defer {
            CoreConstants.shared.sdkKey = savedKey
            MMKVHelper.shared.writeCatalogData(data: savedItems)
        }

        // Previously posted without an SDK key, got 401, and deleted the items as if uploaded.
        try await CatalogEventsUploader.uploadEvents()
        XCTAssertEqual(MMKVHelper.shared.readCatalogData().map(\.id), ["user-1"])
    }
}
