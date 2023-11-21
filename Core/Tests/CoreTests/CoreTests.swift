import XCTest
import UIKit

@testable import CasualFoundryCore // Replace with your actual module name

final class CFLogTests: XCTestCase {
   
    override func setUp() {
        super.setUp()
        // Initialize your application object if needed
       
      

    }
    override func tearDown() {
        // Clean up after each test
        super.tearDown()
    }
    
    func testCFLogInitialization() {
        // Test CFLog initialization
        
        let cfLog = CFLog(application: application!, applicationState:.active,showInAppBudge: true, updateImmediately: true, pauseSDK: false)
        
        
        XCTAssertEqual(cfLog.applicationState, .active)
        XCTAssertEqual(cfLog.showInAppBudge, true)
        XCTAssertEqual(cfLog.updateImmediately, true)
        XCTAssertEqual(cfLog.pauseSDK, false)
    }
    
    func testCFLogBuilderInitialization() {
        
        let cfLogBuilder = CFLogBuilder(application: application!)
        
        XCTAssertNotNil(cfLogBuilder)
    }
    
    func testSetLifecycleEvent() {
        
        let cfLogBuilder = CFLogBuilder(application: application!)
        
        // Set the application state to active
        _ =  cfLogBuilder.setLifecycleEvent(event: .active)
        
        // Check if the application state is set correctly
        XCTAssertEqual(cfLogBuilder.applicationState, .active)
    }
    
    func testSetPauseSDK() {
        
        let cfLogBuilder = CFLogBuilder(application: application!)
            .setPauseSDK(pauseSDK: true)
        
        XCTAssertTrue(cfLogBuilder.pauseSDK)
        
    }
}
