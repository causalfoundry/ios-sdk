import XCTest

class CfLogLevelEventTests: XCTestCase {
    
    func testSetPreviousLevel() {
        
        let cfLogLevelEvent = CfLogLevelEvent()
        let result = cfLogLevelEvent.setPreviousLevel(prevLevel: 5)
        XCTAssertEqual(result.prevLevel, 5)
    }
    
    func testSetNewLevel() {
        let cfLogLevelEvent = CfLogLevelEvent()
        let result = cfLogLevelEvent.setNewLevel(newLevel: 8)
        XCTAssertEqual(result.newLevel, 8)
    }
    
    func testSetModuleId() {
       let cfLogLevelEvent = CfLogLevelEvent()
        let result = cfLogLevelEvent.setModuleId(moduleId: "eLearningModule")
        XCTAssertEqual(result.moduleId, "eLearningModule")
    }
    
    func testSetMeta() {
      
        let cfLogLevelEvent = CfLogLevelEvent()
        let result = cfLogLevelEvent.setMeta(meta: "Additional information")
        XCTAssertEqual(result.meta as? String, "Additional information")
    }
    
    func testUpdateImmediately() {
        
        let cfLogLevelEvent = CfLogLevelEvent()
        let result = cfLogLevelEvent.updateImmediately(updateImmediately: true)
        XCTAssertTrue(result.updateImmediately)
    }
    
    func testBuildWithValidData() {
        let cfLogLevelEvent = CfLogLevelEvent()
        cfLogLevelEvent.setPreviousLevel(prevLevel: 5)
        cfLogLevelEvent.setNewLevel(newLevel: 8)
        cfLogLevelEvent.setModuleId(moduleId: "eLearningModule")
        cfLogLevelEvent.setMeta(meta: "Additional information")
        cfLogLevelEvent.updateImmediately(updateImmediately: true)
        cfLogLevelEvent.build()
        
      
    }
    
    func testBuildWithoutPreviousLevel() {
        let cfLogLevelEvent = CfLogLevelEvent()
        cfLogLevelEvent.setNewLevel(newLevel: 8)
        cfLogLevelEvent.setModuleId(moduleId: "eLearningModule")
        cfLogLevelEvent.setMeta(meta: "Additional information")
        cfLogLevelEvent.updateImmediately(updateImmediately: true)
        cfLogLevelEvent.build()
        
        
    }
    
    func testBuildWithoutNewLevel() {
        let cfLogLevelEvent = CfLogLevelEvent()
        cfLogLevelEvent.setPreviousLevel(prevLevel: 5)
        cfLogLevelEvent.setModuleId(moduleId: "eLearningModule")
        cfLogLevelEvent.setMeta(meta: "Additional information")
        cfLogLevelEvent.updateImmediately(updateImmediately: true)
        cfLogLevelEvent.build()
        
      
    }
    
    func testBuildWithNilModuleId() {
        let cfLogLevelEvent = CfLogLevelEvent()
        cfLogLevelEvent.setPreviousLevel(prevLevel: 5)
        cfLogLevelEvent.setNewLevel(newLevel: 8)
        cfLogLevelEvent.setModuleId(moduleId: nil)
        cfLogLevelEvent.setMeta(meta: "Additional information")
        cfLogLevelEvent.updateImmediately(updateImmediately: true)
        cfLogLevelEvent.build()
        
    }
}

