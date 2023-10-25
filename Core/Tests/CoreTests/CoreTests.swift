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
        
        let cfLog = CFLog(applicationState:.active,showInAppBudge: true, updateImmediately: true, pauseSDK: false)
            
        
        XCTAssertEqual(cfLog.applicationState, .active)
        XCTAssertEqual(cfLog.showInAppBudge, true)
        XCTAssertEqual(cfLog.updateImmediately, true)
        XCTAssertEqual(cfLog.pauseSDK, false)
    }

    func testCFLogBuilderInitialization() {
            
            let cfLogBuilder = CFLogBuilder()
            
            XCTAssertNotNil(cfLogBuilder)
        }

    func testSetLifecycleEvent() {
           
            let cfLogBuilder = CFLogBuilder()
            
            // Set the application state to active
           _ =  cfLogBuilder.setLifecycleEvent(event: .active)
            
            // Check if the application state is set correctly
            XCTAssertEqual(cfLogBuilder.applicationState, .active)
        }
    
    func testSetPauseSDK() {
           
           let cfLogBuilder = CFLogBuilder()
                                .setPauseSDK(pauseSDK: true)
        
           XCTAssertTrue(cfLogBuilder.pauseSDK)
           
    }
}
