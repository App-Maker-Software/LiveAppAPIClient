import XCTest
@testable import LiveAppAPIClientWithAuth

// you should set "hardcoded_api_token" to the api token you want to test with
//let hardcoded_api_token = ""

final class LiveAppAPIClientTests: XCTestCase {
    
    let api: LiveAppAPI = { () -> LiveAppAPI in
        LiveAppAPI.shared.authToken = hardcoded_api_token
        return LiveAppAPI.shared
    }()
    
    func testUser() {
        let expectation = XCTestExpectation()
        api.getUser { user, error in
            if let user = user {
                XCTAssertTrue(user.uid != "")
                expectation.fulfill()
            } else {
                XCTFail()
            }
        }
        wait(for: [expectation], timeout: 3)
    }
}
