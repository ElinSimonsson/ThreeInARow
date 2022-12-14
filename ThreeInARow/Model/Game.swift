

class Game {
    
    private var players = [Player]()
    private var cells = [Cell]()
    private var usedCells = [Cell]()
    var checkCellNotEmpty = false
    var playerOneWin = false
    var playerTwoWin = false
    var gameover = false
    var playingTowardsComputer = false //default
    
    enum Turn {
        case p1
        case p2
    }
    
    var firstTurn = Turn.p1
    var currentTurn = Turn.p1
    
    func clearUsedCells () {
        usedCells.removeAll()
    }

    func randomEmptyCell () -> Int {
        if cells.count == usedCells.count {
            gameover = true
            return 0
        }
        var cell : Cell?
        let countCells = cells.count
        repeat {
            let random = Int.random(in: 0..<countCells)
            cell = cells[random]
            if let cell = cell {
                checkCellNotEmpty = checkContainsUsedCells(usedCell: cell)
            }
        } while checkCellNotEmpty
        if let newCell = cell {
            usedCells.append(newCell)
            currentTurn = Turn.p1
        }
        return cell?.rowAndColumn ?? 0
    }
    
    func checkContainsUsedCells (usedCell: Cell ) -> Bool {
        for cell in usedCells {
            if cell.rowAndColumn == usedCell.rowAndColumn {
                return true
            }
        }
        return false
    }
    
    func checkIfBoardIsNotEmpty() -> Bool {
        if playerOneWin == false && playerTwoWin == false {
            return usedCells.count == cells.count
        }
        return false
    }
    
    func initCells () {
        cells.append(Cell(rowAndColumn: 11))
        cells.append(Cell(rowAndColumn: 12))
        cells.append(Cell(rowAndColumn: 13))
        cells.append(Cell(rowAndColumn: 21))
        cells.append(Cell(rowAndColumn: 22))
        cells.append(Cell(rowAndColumn: 23))
        cells.append(Cell(rowAndColumn: 31))
        cells.append(Cell(rowAndColumn: 32))
        cells.append(Cell(rowAndColumn: 33))
    }
    
    func makeTurn (cell: Cell) {
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
        usedCells.append(cell)
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
    
    func checkForWin (playerOne: Player, playerTwo: Player, playerSymbol symbol: Character, row1Lab1 row1C1: String, row1Lab2 row1C2: String, row1Lab3 row1C3: String, row2Lab1 row2C1: String, row2Lab2 row2C2: String, row2Lab3 row2C3: String,
                          row3Lab1 row3C1: String, row3Lab2 row3C2: String, row3Lab3 row3C3: String) -> Bool {

        let symbolAsString = String(symbol)
        
        // C = column
        if row1C1 == symbolAsString && row1C2 == symbolAsString && row1C3 == symbolAsString ||
            row1C1 == symbolAsString && row2C1 == symbolAsString && row3C1 == symbolAsString ||
            row1C1 == symbolAsString && row2C2 == symbolAsString && row3C3 == symbolAsString ||
            row2C1 == symbolAsString && row2C2 == symbolAsString && row2C3 == symbolAsString ||
            row3C1 == symbolAsString && row3C2 == symbolAsString && row3C3 == symbolAsString ||
            row1C2 == symbolAsString && row2C2 == symbolAsString && row3C2 == symbolAsString ||
            row1C3 == symbolAsString && row2C3 == symbolAsString && row3C3 == symbolAsString ||
            row1C3 == symbolAsString && row2C2 == symbolAsString && row3C1 == symbolAsString {
            
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
        usedCells.removeAll()
        playerOneWin = false
        playerTwoWin = false
        gameover = false
        
        if firstTurn == Turn.p1 {
            firstTurn = Turn.p2
            currentTurn = Turn.p2
        } else if firstTurn == Turn.p2 {
            firstTurn = Turn.p1
            currentTurn = Turn.p1
        }
    }
}
