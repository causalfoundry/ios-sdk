import XCTest

// Plain import on purpose: this file only compiles if the fetched-action API is public.
import KenkaiSDKCore

final class CFFetchedActionPublicAPITests: XCTestCase {
    func testFetchedActionIsReadableByHostApps() throws {
        let json = """
        {"payload":{"type":"ui-component","render_method":"in_app_component","content":{"title":"Hi"},"attr":{"cta_id":"42"},"internal":{"inv_id":62,"action_id":33,"ref_time":"2026-11-06T14:27:00Z"}},"error":null}
        """
        let item = try JSONDecoder().decode(NudgeResponseItem.self, from: Data(json.utf8))
        let payload = try XCTUnwrap(item.payload)

        XCTAssertEqual(payload.type, "ui-component")
        XCTAssertEqual(payload.renderMethod, "in_app_component")
        XCTAssertEqual(payload.content?["title"], "Hi")
        XCTAssertEqual(payload.attr?["cta_id"], "42")
        XCTAssertEqual(payload.internalObject?["action_id"], .int(33))
        XCTAssertNil(item.error)

        // The wire keys (including "internal") must survive a round trip, since hosts may persist actions.
        let encoded = try JSONSerialization.jsonObject(with: JSONEncoder().encode(item)) as? [String: Any]
        let encodedPayload = try XCTUnwrap(encoded?["payload"] as? [String: Any])
        XCTAssertEqual(encodedPayload["render_method"] as? String, "in_app_component")
        XCTAssertEqual((encodedPayload["internal"] as? [String: Any])?["action_id"] as? Int, 33)
    }

    func testActionResponseCanBeBuiltFromAFetchedAction() throws {
        // Hosts that render actions themselves build the ActionResponse event from the fetched payload.
        let internalObject: [String: CodableValue] = ["action_id": .int(33), "ref_time": .string("2026-11-06T14:27:00Z")]
        let event = ActionRepsonseObject(response: ActionRepsonse.Shown, internalObject: internalObject)
        XCTAssertEqual(event.response, "shown")
        XCTAssertEqual(event.details, "")

        let encoded = try JSONSerialization.jsonObject(with: JSONEncoder().encode(event)) as? [String: Any]
        XCTAssertEqual(encoded?["response"] as? String, "shown")
        XCTAssertEqual((encoded?["internal"] as? [String: Any])?["action_id"] as? Int, 33)

        // Both entry points for sending it are public; before build() the event is dropped, not crashed.
        CFCoreEvent.shared.logIngest(eventType: .ActionResponse, logObject: event)
        let log: (NudgeResponseItem, ActionRepsonse, String) -> Void = CFCoreEvent.shared.logActionResponse
        XCTAssertNotNil(log)
    }
}
