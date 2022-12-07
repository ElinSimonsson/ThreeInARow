
import UIKit

class Game {
    private var players = [Player]()
    private var boards = [Board]()
    private var clickedBoards = [Board]()
    var checkBoardIsNotEmpty = false
    
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
    
    func addPlayer (name: String, score: Int, symbol: String) {
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
    
    func checkIfThreeRow (playerSymbol symbol: String, label1 box1: UILabel, label2 box2: UILabel, label3 box3: UILabel,
                                 label4 box4: UILabel, label5 box5: UILabel, label6 box6: UILabel,
                                 label7 box7: UILabel, label8 box8: UILabel, label9 box9: UILabel) -> Bool {
        
        if box1.text == symbol && box2.text == symbol && box3.text == symbol ||
            box1.text == symbol && box4.text == symbol && box7.text == symbol ||
            box1.text == symbol && box5.text == symbol && box9.text == symbol ||
            box4.text == symbol && box5.text == symbol && box6.text == symbol ||
            box7.text == symbol && box8.text == symbol && box9.text == symbol ||
            box2.text == symbol && box5.text == symbol && box8.text == symbol ||
            box3.text == symbol && box6.text == symbol && box9.text == symbol ||
            box3.text == symbol && box5.text == symbol && box7.text == symbol {
            return true
        }
        return false
    }
    
}
