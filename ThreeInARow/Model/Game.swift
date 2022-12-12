

class Game {
    private var players = [Player]()
    private var boards = [Board]()
    private var clickedBoards = [Board]()
    var checkBoardIsNotEmpty = false
    var playerOneWin = false
    var playerTwoWin = false
    var gameover = false
    var playingTowardsComputer = false //default
    var player1Turn = true
    
    enum Turn {
        case p1
        case p2
    }
    
    var firstTurn = Turn.p1
    var currentTurn = Turn.p1
    
    func clearClickedBoards () {
        clickedBoards.removeAll()
    }

    func randomEmptyBoard () -> Int {
        if boards.count == clickedBoards.count {
            gameover = true
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
            player1Turn = true
            currentTurn = Turn.p1
        }
        return board?.rowAndColumn ?? 0
    }
    
    func checkContainsClickedBoards (clickedBoard: Board ) -> Bool {
        for board in clickedBoards {
            if board.rowAndColumn == clickedBoard.rowAndColumn {
                return true
            }
        }
        return false
    }
    
    func checkIfAllBoardIsNotEmpty() -> Bool {
        if playerOneWin == false && playerTwoWin == false {
            return clickedBoards.count == boards.count
        }
        return false
    }
    
    func initBoards () {
        boards.append(Board(rowAndColumn: 11))
        boards.append(Board(rowAndColumn: 12))
        boards.append(Board(rowAndColumn: 13))
        boards.append(Board(rowAndColumn: 21))
        boards.append(Board(rowAndColumn: 22))
        boards.append(Board(rowAndColumn: 23))
        boards.append(Board(rowAndColumn: 31))
        boards.append(Board(rowAndColumn: 32))
        boards.append(Board(rowAndColumn: 33))
    }
    
    func makeTurn (board: Board) {
        if playingTowardsComputer {
            if currentTurn == Turn.p1 {
                currentTurn = Turn.p2
            }
        } else {
            if (currentTurn == Turn.p1) {
                currentTurn = Turn.p2
            } else if (currentTurn == Turn.p2) {
                currentTurn = Turn.p1
            }
        }
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
    
    func checkIfThreeRow (playerOne: Player, playerTwo: Player, playerSymbol symbol: Character, label1 board1: String, label2 board2: String, label3 board3: String,
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
            if playerOne.symbol == symbol {
                playerOneWin = true
            } else if playerTwo.symbol == symbol {
                playerTwoWin = true
            }
            gameover = true
            return gameover
        }
        return false
    }
    
    func checkIfPlayingComputer(playerTwo: Player) {
        if playerTwo.name == "Computer" {
            playingTowardsComputer = true
        } else {
            playingTowardsComputer = false
        }
    }
    
    func restartGame () {
        clickedBoards.removeAll()
        playerOneWin = false
        playerTwoWin = false
        gameover = false
        player1Turn = true
        
        if firstTurn == Turn.p1 {
            firstTurn = Turn.p2
            currentTurn = Turn.p2
        } else if firstTurn == Turn.p2 {
            firstTurn = Turn.p1
            currentTurn = Turn.p1
        }
    }
}
