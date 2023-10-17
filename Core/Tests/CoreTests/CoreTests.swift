import XCTest


import XCTest
@testable import CasualFoundryCore // Replace with your actual module name

final class CFLogTests: XCTestCase {
    var application: UIApplication?

    override func setUp() {
        super.setUp()
        // Initialize your application object if needed
        application = UIApplication.shared
    }

    override func tearDown() {
        // Clean up after each test
        application = nil
        super.tearDown()
    }

    func testCFLogInitialization() {
        // Test CFLog initialization
        
        let cfLog = CFLog(application:application,applicationState:.active,showInAppBudge: true, updateImmediately: true, pauseSDK: false)
            
        XCTAssertEqual(cfLog.application, application)
        XCTAssertEqual(cfLog.applicationState, .active)
        XCTAssertEqual(cfLog.showInAppBudge, true)
        XCTAssertEqual(cfLog.updateImmediately, true)
        XCTAssertEqual(cfLog.pauseSDK, false)
    }

    func testCFLogBuilderInitialization() {
            let application = UIApplication.shared
            let cfLogBuilder = CFLogBuilder(application: application)
            
            XCTAssertNotNil(cfLogBuilder)
        }

    func testSetLifecycleEvent() {
            let application = UIApplication.shared
            let cfLogBuilder = CFLogBuilder(application: application)
            
            // Set the application state to active
            cfLogBuilder.setLifecycleEvent(event: .active)
            
            // Check if the application state is set correctly
            XCTAssertEqual(cfLogBuilder.applicationState, .active)
        }
    
    func testSetPauseSDK() {
           let application = UIApplication.shared
           let cfLogBuilder = CFLogBuilder(application: application)
           
           // Set pauseSDK to true
           cfLogBuilder.setPauseSDK(pauseSDK: true)
           
           // Check if pauseSDK is set correctly to true
           XCTAssertTrue(cfLogBuilder.pauseSDK)
           
           // Set pauseSDK to false
           cfLogBuilder.setPauseSDK(pauseSDK: false)
           
           // Check if pauseSDK is set correctly to false
           XCTAssertFalse(cfLogBuilder.pauseSDK)
       }
}
