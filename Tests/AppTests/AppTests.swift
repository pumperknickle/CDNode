import App
import XCTest
import Vapor
import Redis
import CryptoStarterPack

final class AppTests: XCTestCase {
    var app: Application!
    let input = "Hello world".data(using: .utf8)!.toBoolArray()
    var digest: [Bool]! { return HashDelegate.hash(input)! }
    
    override func setUp() {
        app = try! Application.testable()
    }
    
    override func tearDown() {
        try? app.syncShutdownGracefully()
    }
    
    func testAPIPostAndGet() throws {
        let response = try app.sendRequest(to: "put/" + input.literal(), method: .PUT)
        XCTAssertTrue(response.http.status == .ok)
        let otherResponse = try app.sendRequest(to: "get/" + digest.literal(), method: .GET)
        XCTAssertTrue(otherResponse.http.status == .ok)
        XCTAssertTrue(otherResponse.http.body.description == input.literal())
    }
}
