import XCTest

@testable import KenkaiSDKCore

/// Hosts may initialize the SDK late (e.g. after login) or never (server-side kill switch).
final class CFDelayedInitTests: XCTestCase {
    func testEventsBeforeBuildAreDroppedInsteadOfCrashing() {
        let savedKey = CoreConstants.shared.sdkKey
        CoreConstants.shared.sdkKey = ""
        defer { CoreConstants.shared.sdkKey = savedKey }

        // Previously fatalError("Access key not found").
        CFSetup().track(eventName: "app", eventProperty: "background", eventCtx: Optional<String>.none, updateImmediately: false)
    }

    func testNotificationResponseBeforeBuildIsDroppedInsteadOfCrashing() {
        let savedKey = CoreConstants.shared.sdkKey
        CoreConstants.shared.sdkKey = ""
        defer { CoreConstants.shared.sdkKey = savedKey }

        // The ingest call CFNotificationController.track makes when a Kenkai notification from an earlier
        // session is opened. (The controller itself needs UNUserNotificationCenter, unavailable in this runner.)
        CFCoreEvent.shared.logIngest(
            eventType: .ActionResponse,
            logObject: ActionRepsonseObject(response: .Open),
            isUpdateImmediately: true
        )
    }

    func testFetchActionsBeforeBuildCallsBackWithNoActions() {
        let savedKey = CoreConstants.shared.sdkKey
        CoreConstants.shared.sdkKey = ""
        defer { CoreConstants.shared.sdkKey = savedKey }

        let answered = expectation(description: "onResult")
        CFCoreEvent.shared.fetchActions(invActionType: .UIComponent, actionRenderMethodType: .InAppComponent, deliveryMode: .OneOff, actionAttr: nil) { items in
            XCTAssertTrue(items.isEmpty)
            answered.fulfill()
        }
        wait(for: [answered], timeout: 1)
    }

    func testBackgroundTasksAreNotSubmittedWithoutRegistration() {
        // Submitting without a registered handler throws an uncaught NSException in BGTaskScheduler.
        WorkerCaller.scheduleBackgroundTasks()
    }
}
