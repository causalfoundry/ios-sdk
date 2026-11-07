import XCTest
@testable import KenkaiSDKCore

final class CFDecodeTests: XCTestCase {
    /// `meta` is stored as Data holding JSON; decoding it used to force-cast the parsed NSDictionary to Encodable and trap.
    func testDecodingEventObjectWithMetaDoesNotCrash() throws {
        let json = #"{"action":"open","start_time":1,"meta":"eyJhIjoxfQ=="}"#.data(using: .utf8)!
        let object = try JSONDecoder().decode(AppObject.self, from: json)
        XCTAssertEqual(object.action, "open")
    }
}
