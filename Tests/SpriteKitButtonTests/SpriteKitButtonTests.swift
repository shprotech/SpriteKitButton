import XCTest
@testable import SpriteKitButton

final class SpriteKitButtonTests: XCTestCase {
    #if !os(macOS)
    func testColor() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        let color = UIColor.red
        let button = SKButtonNode(size: CGSize(width: 100, height: 50), text: "test_buuton")
        button.fillColor = color
        XCTAssertNotEqual(button.highlightColor, color)
    }
    
    func testState() {
        let button = SKButtonNode(size: CGSize(width: 100, height: 50), text: "test_buuton")
        
        XCTAssertEqual(button.state, .normal)
        
        button.touchesBegan(Set(), with: nil)
        
        XCTAssertEqual(button.state, .highlighted)
        
        button.touchesEnded(Set(), with: nil)
        
        XCTAssertEqual(button.state, .normal)
        
        button.disabled = true
        
        XCTAssertEqual(button.state, .disabled)
    }
    #else
    func testColor() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        let color = NSColor.red
        let button = SKButtonNode(size: CGSize(width: 100, height: 50), text: "test_buuton")
        button.fillColor = color
        XCTAssertNotEqual(button.highlightColor, color)
    }
    
    func testState() {
        let button = SKButtonNode(size: CGSize(width: 100, height: 50), text: "test_buuton")
        
        XCTAssertEqual(button.state, .normal)
        
        button.touchesBegan(with: nil)
        
        XCTAssertEqual(button.state, .highlighted)
        
        button.touchesEnded(with: nil)
        
        XCTAssertEqual(button.state, .normal)
        
        button.disabled = true
        
        XCTAssertEqual(button.state, .disabled)
    }
    #endif

    static var allTests = [
        ("color test", testColor),
        ("state stest", testState)
    ]
}
