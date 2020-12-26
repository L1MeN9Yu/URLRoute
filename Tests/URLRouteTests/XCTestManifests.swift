import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    [
        testCase(URLRouteTests.allTests),
    ]
}
#endif
