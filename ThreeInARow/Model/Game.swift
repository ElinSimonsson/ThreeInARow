

class Game {
    private var players = [Player]()
    private var boards = [Board]()
    private var clickedBoards = [Board]()
    var checkBoardIsNotEmpty = false
    let stringVariable0 = ""
    
    func clearClickedBoards () {
        clickedBoards.removeAll()
    }

    func randomEmptyBoard () -> Int {
        if boards.count == clickedBoards.count {
            clickedBoards.removeAll()
            return 0
        }
        var board : Board?
        let countBoards = boards.count
        repeat {
            let random = Int.random(in: 0..<countBoards)
            board = boards[random]
            if let board = board {
                checkBoardIsNotEmpty = checkContainsClickedBoards(clickedBoard: board)
            }
        } while checkBoardIsNotEmpty
        if let newBoard = board {
            clickedBoards.append(newBoard)
        }
        return board?.numberOfBoard ?? 0
    }
    
    func checkContainsClickedBoards (clickedBoard: Board ) -> Bool {
        for board in clickedBoards {
            if board.numberOfBoard == clickedBoard.numberOfBoard {
                return true
            }
        }
        return false
    }
    
    func checkIfAllBoardIsNotEmpty() -> Bool {
        return clickedBoards.count == boards.count
    }
    
    func addBoard (board: Board) {
            boards.append(board)
    }
    
    func addClickedBoard (board: Board) {
        clickedBoards.append(board)
    }
    
    func deleteAllPlayers () {
        players.removeAll()
    }
    
    func addPlayer (name: String, score: Int, symbol: Character) {
        let player = Player(name: name, score: score, symbol: symbol)
        players.append(player)
    }
    
    func increasePlayerScore (player: Player) {
        player.score += 1
    }
    
    func player(index: Int) -> Player {
        return players[index]
    }
    
    func countPlayers () -> Int {
            return players.count
        }
    
    func checkIfThreeRow (playerSymbol symbol: Character, label1 board1: String, label2 board2: String, label3 board3: String,
                                 label4 board4: String, label5 board5: String, label6 board6: String,
                          label7 board7: String, label8 board8: String, label9 board9: String) -> Bool {

        let symbolAsString = String(symbol)
        
        if board1 == symbolAsString && board2 == symbolAsString && board3 == symbolAsString ||
            board1 == symbolAsString && board4 == symbolAsString && board7 == symbolAsString ||
            board1 == symbolAsString && board5 == symbolAsString && board9 == symbolAsString ||
            board4 == symbolAsString && board5 == symbolAsString && board6 == symbolAsString ||
            board7 == symbolAsString && board8 == symbolAsString && board9 == symbolAsString ||
            board2 == symbolAsString && board5 == symbolAsString && board8 == symbolAsString ||
            board3 == symbolAsString && board6 == symbolAsString && board9 == symbolAsString ||
            board3 == symbolAsString && board5 == symbolAsString && board7 == symbolAsString {
            return true
        }
        return false
    }
}
