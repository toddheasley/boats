import Testing
@testable import BoatsWeb

struct ColorTests {
    @Test func name() {
        #expect(Color(255).name == "white")
        #expect(Color(201, 223, 238).name == nil)
        #expect(Color(204, alpha: 0.25).name == nil)
    }
    
    @Test func rgbInit() {
        #expect(Color(-23, 487, 77, alpha: 0.9).red == 0)
        #expect(Color(-23, 487, 77, alpha: 0.9).green == 255)
        #expect(Color(-23, 487, 77, alpha: 0.9).blue == 77)
        #expect(Color(-23, 487, 77, alpha: 0.9).alpha == 0.9)
        #expect(Color(-23, 487, 77, alpha: 0.9).alpha == 0.9)
        #expect(Color(-23, 487, 77, alpha: 100).alpha == 1.0)
        #expect(Color(-23, 487, 77, alpha: -1).alpha == 0.0)
        #expect(Color(201, 223, 238).red == 201)
        #expect(Color(201, 223, 238).green == 223)
        #expect(Color(201, 223, 238).blue == 238)
        #expect(Color(201, 223, 238).alpha == 1.0)
    }
    
    @Test func whiteInit() {
        #expect(Color(204, alpha: 0.25).red == 204)
        #expect(Color(204, alpha: 0.25).green == 204)
        #expect(Color(204, alpha: 0.25).blue == 204)
        #expect(Color(204, alpha: 0.25).alpha == 0.25)
    }
    
    // MARK: CustomStringConvertible
    @Test func description() {
        #expect(Color.aqua.description == "rgb(201, 223, 238)")
        #expect(Color.gold.description == "rgb(241, 185, 77)")
        #expect(Color.haze.description == "rgba(204, 204, 204, 0.25)")
        #expect(Color.link.description == "rgb(44, 103, 212)")
        #expect(Color.navy.description == "rgb(32, 61, 83)")
    }
}

extension ColorTests {
    
    // MARK: CaseIterable
    @Test func allCases() {
        #expect(Color.allCases == [.aqua, .gold, .haze, .link, .navy])
    }
}
