//import XCTest
//
//
//import XCTest
//@testable import CasualFoundryCore // Replace with your actual module name
//
//final class CFLogTests: XCTestCase {
//    var application: UIApplication?
//
//    override func setUp() {
//        super.setUp()
//        // Initialize your application object if needed
//        application = UIApplication.shared
//    }
//
//    override func tearDown() {
//        // Clean up after each test
//        application = nil
//        super.tearDown()
//    }
//
//    func testCFLogInitialization() {
//        // Test CFLog initialization
//        let cfLog = CFLog(application: application,
//                          applicationState: .active,
//                          showInAppBudge: true,
//                          updateImmediately: true,
//                          pauseSDK: false)
//
//        XCTAssertEqual(cfLog.application, application)
//        XCTAssertEqual(cfLog.applicationState, .active)
//        XCTAssertEqual(cfLog.showInAppBudge, true)
//        XCTAssertEqual(cfLog.updateImmediately, true)
//        XCTAssertEqual(cfLog.pauseSDK, false)
//    }
//
//    func testCFLogBuilder() {
//        // Test CFLogBuilder
//        let cfLogBuilder = CFLogBuilder(application: application!)
//            .setLifecycleEvent(event: .active)
//            .setPauseSDK(pauseSDK: true)
//            // Add more configuration methods and assertions based on your requirements
//
//        // Build CFLog instance
//        let cfLog = cfLogBuilder.build()
//
//        // Add assertions for CFLog properties
//        // For example:
//        XCTAssertEqual(cfLog.application, application)
//        XCTAssertEqual(cfLog.applicationState, .active)
//        XCTAssertEqual(cfLog.showInAppBudge, true)
//        XCTAssertEqual(cfLog.updateImmediately, true)
//        XCTAssertEqual(cfLog.pauseSDK, true)
//    }
//}
