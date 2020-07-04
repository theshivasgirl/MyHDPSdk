import XCTest
@testable import HDP_iOS

final class HDP_iOSTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(HDP_iOS().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
