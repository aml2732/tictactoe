public class GameBoard{
    var rows = 3;
    var cols = 3;
    var board : [[Int]];
    init(rows: Int, cols: Int){
        self.rows = rows;
        self.cols = cols;
        board = [[Int]](repeating: [Int](repeating: -1, count: cols), count: rows);
    }
    
    func canSet(_ row: Int, _ col: Int) -> Bool{
        return board[row][col] == -1;
    }
    
    func set(_ row: Int, _ col: Int, _ playerId: Int){
        board[row][col] = playerId;
    }
    
    func isMatch(_ match: Int, _ row: Int, _ col: Int) -> Bool{
        let exceedsBoardDimensions = row>=rows || col>=cols;
        guard !exceedsBoardDimensions else{
            return false;
        }
        return board[row][col] == match;
    }
}

public class Player{
    var name = "";
    var score = 0;
    var id = -1;
    
    public init(name: String){
        self.name  = name;
    }
    
    func reset(){score = 0;}
    func wonRound(){score += 1;}
    func lostRound(){score = score>0 ? score-1 : 0;}
}

public class TicTacToe{
    //ask how to make it so this is non-optional, but doesn't get defined till init
    var dimensions = (0,0);
    var gameBoard = GameBoard(rows: 0, cols: 0);
    var players = [Player]();
    var amountToWin = 0;
    var currentPlayer = 0;
    
    public init( players: [Player], rows: Int = 3, cols: Int = 3, line: Int = 3){
        dimensions.0 = rows;
        dimensions.1 = cols;
        self.amountToWin = line;
        self.gameBoard = GameBoard(rows: rows, cols: cols);
        self.players += players;
        for (index, player) in players.enumerated(){
            player.id = index;
        }
    }
    
    public func printBoard(){ print(gameBoard.board); }
    
    public func getCurrentPlayer() -> Player{ return players[currentPlayer]; }
    
    public func printScores(){
        var str = "";
        for player in players{
            str += "\(player.name) scored \(player.score) point(s); "
        }
        print(str);
    }
    
    //ask how to go up to gameBoard.board.enumerated() - amountToWin to avoid over checking needlessly
    func isAWin() -> Bool{
        let match = currentPlayer;
        for (r, _) in gameBoard.board.enumerated(){
            for (c, _) in gameBoard.board.enumerated(){
                //check <amount to win> spots from this location if possible.
                var matchHorizontalCount = 0;
                var matchDiagonalCount = 0;
                var matchVerticalCount = 0;
                for delta in 0..<amountToWin{
                    //check horizontal right.
                    if gameBoard.isMatch(match, r, c+delta){
                        matchHorizontalCount += 1;
                    }
                    //check diagonal right-down
                    if gameBoard.isMatch(match, r+delta, c+delta){
                        matchDiagonalCount += 1;
                    }
                    //check vertical down
                    if gameBoard.isMatch(match, r+delta, c){
                        matchVerticalCount += 1;
                    }
                }
                if matchHorizontalCount == amountToWin || matchDiagonalCount == amountToWin || matchVerticalCount == amountToWin {
                    return true;
                }
            }
        }
        return false;
    }
    
    public func makeAMove(_ row: Int, _ col: Int) -> Bool{
        //check if coords are valid game move ( not already marked x or O )
        let validMove = gameBoard.canSet(row, col)
        guard validMove  else{return false;}
        gameBoard.set(row, col, currentPlayer);
        //check if a win occured:
        if isAWin() {
            players[currentPlayer].score += 1;
            //reset gameboard
            gameBoard = GameBoard(rows: dimensions.0, cols: dimensions.1);
        }
        //increment the current player:
        currentPlayer = (currentPlayer + 1)%players.count;
        return true;
    }
    
}
