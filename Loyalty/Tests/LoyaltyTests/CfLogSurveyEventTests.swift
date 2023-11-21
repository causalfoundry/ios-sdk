import XCTest

class CfLogSurveyEventTests: XCTestCase {

    func testSetActionWithEnum() {
        let cfLogSurveyEvent = CfLogSurveyEvent()
        let result = cfLogSurveyEvent.setAction(action: SurveyAction.view)
        XCTAssertEqual(result.actionValue, "view")
    }

    func testSetActionWithStringValidValue() {
        let cfLogSurveyEvent = CfLogSurveyEvent()
        let result = cfLogSurveyEvent.setAction(action: "view")
        XCTAssertEqual(result.actionValue, "view")
    }

    func testSetActionWithStringInvalidValue() {
        let cfLogSurveyEvent = CfLogSurveyEvent()
        XCTAssertThrowsError(try cfLogSurveyEvent.setAction(action: "invalidAction"))
    }

    func testSetSurveyObjectWithObject() {
        let cfLogSurveyEvent = CfLogSurveyEvent()
        let surveyObject = SurveyObject(id: "survey123", type: "feedback", isCompleted: true)
        let result = cfLogSurveyEvent.setSurveyObject(surveyObject: surveyObject)
        XCTAssertEqual(result.surveyObject, surveyObject)
    }

    func testSetSurveyObjectWithStringValidValue() {
        let cfLogSurveyEvent = CfLogSurveyEvent()
        let surveyObjectString = """
        {
            "id": "survey123",
            "type": "feedback",
            "isCompleted": true
        }
        """
        let result = cfLogSurveyEvent.setSurveyObject(surveyObject: surveyObjectString)
        XCTAssertNotNil(result.surveyObject)
    }

    func testSetSurveyObjectWithStringInvalidValue() {
        let cfLogSurveyEvent = CfLogSurveyEvent()
        let surveyObjectString = """
        {
            "id": "survey123",
            "type": "invalidType",
            "isCompleted": true
        }
        """
        XCTAssertThrowsError(try cfLogSurveyEvent.setSurveyObject(surveyObject: surveyObjectString))
    }

    func testSetResponseListWithObject() {
        let cfLogSurveyEvent = CfLogSurveyEvent()
        let responseList = [SurveyResponseItem(type: "question", id: "question123", question: "How satisfied are you?")]
        let result = cfLogSurveyEvent.setResponseList(responseList: responseList)
        XCTAssertEqual(result.responseList, responseList)
    }

    func testSetResponseListWithStringValidValue() {
        let cfLogSurveyEvent = CfLogSurveyEvent()
        let responseListString = """
        [
            {
                "type": "question",
                "id": "question123",
                "question": "How satisfied are you?"
            }
        ]
        """
        let result = cfLogSurveyEvent.setResponseList(responseList: responseListString)
        XCTAssertNotNil(result.responseList)
    }

    func testSetResponseListWithStringInvalidValue() {
        let cfLogSurveyEvent = CfLogSurveyEvent()
        let responseListString = """
        [
            {
                "type": "invalidType",
                "id": "question123",
                "question": "How satisfied are you?"
            }
        ]
        """
        XCTAssertThrowsError(try cfLogSurveyEvent.setResponseList(responseList: responseListString))
    }

    func testSetMeta() {
        let cfLogSurveyEvent = CfLogSurveyEvent()
        let result = cfLogSurveyEvent.setMeta(meta: "Additional information")
        XCTAssertEqual(result.meta as? String, "Additional information")
    }

    func testUpdateImmediately() {
        let cfLogSurveyEvent = CfLogSurveyEvent()
        let result = cfLogSurveyEvent.updateImmediately(updateImmediately: true)
        XCTAssertTrue(result.updateImmediately)
    }

    func testBuildWithValidData() {
        let cfLogSurveyEvent = CfLogSurveyEvent()
        cfLogSurveyEvent.setAction(action: "view")
        let surveyObject = SurveyObject(id: "survey123", type: "feedback", isCompleted: true)
        cfLogSurveyEvent.setSurveyObject(surveyObject: surveyObject)
        cfLogSurveyEvent.build()
    }

    func testBuildWithoutAction() {
        let cfLogSurveyEvent = CfLogSurveyEvent()
        let surveyObject = SurveyObject(id: "survey123", type: "feedback", isCompleted: true)
        cfLogSurveyEvent.setSurveyObject(surveyObject: surveyObject)
        cfLogSurveyEvent.build()
    }

    func testBuildWithoutSurveyObject() {
        let cfLogSurveyEvent = CfLogSurveyEvent()
        cfLogSurveyEvent.setAction(action: "view")
        cfLogSurveyEvent.build()
    }

    func testBuildWithoutSurveyId() {
        let cfLogSurveyEvent = CfLogSurveyEvent()
        cfLogSurveyEvent.setAction(action: "view")
        let surveyObject = SurveyObject(id: "", type: "feedback", isCompleted: true)
        cfLogSurveyEvent.setSurveyObject(surveyObject: surveyObject)
        cfLogSurveyEvent.build()
    }

    func testBuildWithInvalidSurveyType() {
        let cfLogSurveyEvent = CfLogSurveyEvent()
        cfLogSurveyEvent.setAction(action: "view")
        let surveyObject = SurveyObject(id: "survey123", type: "invalidType", isCompleted: true)
        cfLogSurveyEvent.setSurveyObject(surveyObject: surveyObject)
        cfLogSurveyEvent.build()
    }

    func testBuildWithIncompleteSurvey() {
        let cfLogSurveyEvent = CfLogSurveyEvent()
        cfLogSurveyEvent.setAction(action: "view")
        let surveyObject = SurveyObject(id: "survey123", type: "feedback", isCompleted: nil)
        cfLogSurveyEvent.setSurveyObject(surveyObject: surveyObject)
        cfLogSurveyEvent.build()
    }

    func testBuildWithoutResponseListForSubmitAction() {
        let cfLogSurveyEvent = CfLogSurveyEvent()
        cfLogSurveyEvent.setAction(action: "submit")
        let surveyObject = SurveyObject(id: "survey123", type: "feedback", isCompleted: true)
        cfLogSurveyEvent.setSurveyObject(surveyObject: surveyObject)
        cfLogSurveyEvent.build()
    }

    func testBuildWithInvalidResponseList() {
        let cfLogSurveyEvent = CfLogSurveyEvent()
        cfLogSurveyEvent.setAction(action: "submit")
        let surveyObject = SurveyObject(id: "survey123", type: "feedback", isCompleted: true)
        cfLogSurveyEvent.setSurveyObject(surveyObject: surveyObject)
        let responseList = [SurveyResponseItem(type: "invalidType", id: "", question: "")]
        cfLogSurveyEvent.setResponseList(responseList: responseList)
        cfLogSurveyEvent.build()
    }

    func testBuild() {
        let cfLogSurveyEvent = CfLogSurveyEvent()
        cfLogSurveyEvent.setAction(action: "view")
        let surveyObject = SurveyObject(id: "survey123", type: "feedback", isCompleted: true)
        cfLogSurveyEvent.setSurveyObject(surveyObject: surveyObject)
        cfLogSurveyEvent.build()
    }
}


