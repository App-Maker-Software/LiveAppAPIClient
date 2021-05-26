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
                XCTFail(error?.localizedDescription ?? "")
            }
        }
        wait(for: [expectation], timeout: 3)
    }
    
    func testCreationReadingAndDeletingOfALiveApp() {
        // create it
        let expectation1 = XCTestExpectation()
        let liveApp = NewLiveAppModel(
            name: "Test",
            bundle_id: "com.org.test"
        )
        api.addLiveApp(liveApp: liveApp) { success, error in
            if success {
                XCTAssertTrue(success)
                expectation1.fulfill()
            } else {
                XCTFail(error?.localizedDescription ?? "")
            }
        }
        wait(for: [expectation1], timeout: 3)
        // try to create it a second time (should fail)
        let expectation2 = XCTestExpectation()
        api.addLiveApp(liveApp: liveApp) { success, error in
            if success {
                XCTFail("should not be able to add the same live app a second time")
            } else {
                XCTAssertTrue(true)
                expectation2.fulfill()
            }
        }
        wait(for: [expectation2], timeout: 3)
        // find it
        let expectation3 = XCTestExpectation()
        var liveAppId: String!
        api.getAllLiveApps { liveApps, error in
            if let liveApps = liveApps {
                if let match = liveApps.first(where: {
                    $0.bundle_id == liveApp.bundle_id && $0.name == liveApp.name
                }) {
                    liveAppId = match.id
                    XCTAssertTrue(true)
                    expectation3.fulfill()
                } else {
                    XCTFail("couldn't find \(liveApp.bundle_id)")
                }
            } else {
                XCTFail(error?.localizedDescription ?? "")
            }
        }
        wait(for: [expectation3], timeout: 3)
        // read it
        let expectation4 = XCTestExpectation()
        api.getLiveApp(liveAppId: liveAppId) { liveApp, error in
            if let liveApp = liveApp {
                XCTAssertTrue(liveApp.id == liveAppId)
                expectation4.fulfill()
            } else {
                XCTFail(error?.localizedDescription ?? "")
            }
        }
        wait(for: [expectation4], timeout: 3)
        // delete it
        let expectation5 = XCTestExpectation()
        api.deleteLiveApp(liveAppId: liveAppId) { success, error in
            if success {
                XCTAssertTrue(success)
                expectation5.fulfill()
            } else {
                XCTFail(error?.localizedDescription ?? "")
            }
        }
        wait(for: [expectation5], timeout: 3)
    }
    
    func testCreationReadingAndDeletingOfAView() {
//        let expectation = XCTestExpectation()
//        let view = NewViewModel(
//            name: "Test",
//            source_code: "// test",
//            view_data: Data("Test data".data(using: .utf8)!).base64EncodedString(),
//            init_checksum: "test_checksum",
//            static_dependency_ids: ["1","2","3"],
//            minimum_ios_version: "v13.5", // todo, should work for osx. watch, etc.
//            minimum_swift_interpreter_version: "1.0",
//            swift_ast_version: "1.0",
//            live_app_id: "testliveapp"
//        )
//        api.addView(view: view) { success, error in
//            if success {
//                XCTAssertTrue(success)
//                expectation.fulfill()
//            } else {
//                XCTFail(error?.localizedDescription ?? "")
//            }
//        }
//        wait(for: [expectation], timeout: 3)
    }
}
