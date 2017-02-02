import XCTest
@testable import tictactoe

class tictactoeTests: XCTestCase {
    
    func test1() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        var player1 = Player(name: "Player 1");
        var player2 = Player(name: "Player 2");
        var game = TicTacToe(players: [player1, player2]);
        XCTAssertTrue(game.makeAMove(0,0));
        XCTAssertTrue(game.makeAMove(0,1));
        XCTAssertTrue(game.makeAMove(1,1));
        XCTAssertTrue(game.makeAMove(0,2));
        XCTAssertTrue(game.makeAMove(2,2));
        XCTAssert(player1.score == 1, "player 1's score should be 1");
        XCTAssert(player2.score == 0, "player 2's score should be 2");
        
    }
    
    func test2() {
        var player1 = Player(name: "Player 1");
        var player2 = Player(name: "Player 2");
        var game = TicTacToe(players: [player1, player2]);
        XCTAssertTrue(game.makeAMove(0, 0));
        XCTAssertFalse(game.makeAMove(0, 0));
    }


    static var allTests : [(String, (tictactoeTests) -> () throws -> Void)] {
        return [
            ("test1", test1),
            ("test2", test2)
        ]
    }
}
