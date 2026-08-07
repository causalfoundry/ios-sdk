import XCTest

@testable import KenkaiSDKCore

final class CFActionIdentityTests: XCTestCase {
    func testActionsUseOutputIdAndRemoveExactDuplicates() throws {
        let json = """
        {
          "data": [
            {"payload":{"type":"message","render_method":"in_app_message","internal":{"ref_time":"2026-08-07T15:40:00Z","output_id":"first"}},"error":null},
            {"payload":{"type":"message","render_method":"in_app_message","internal":{"ref_time":"2026-08-07T15:40:00Z","output_id":"second"}},"error":null},
            {"payload":{"type":"message","render_method":"in_app_message","internal":{"ref_time":"2026-08-07T15:40:00Z","output_id":"first"}},"error":""}
          ]
        }
        """

        let actions = try XCTUnwrap(
            JSONDecoder().decode(ActionAPIResponse.self, from: Data(json.utf8)).data
        )

        XCTAssertNotEqual(actions[0], actions[1])
        XCTAssertEqual(
            actions.removingDuplicates().compactMap { $0.payload?.ref },
            ["first", "second"]
        )
    }
}
