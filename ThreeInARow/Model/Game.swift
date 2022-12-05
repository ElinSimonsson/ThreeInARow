
import UIKit

class Game {
    private var players = [Player]()
    private var availableSquares = [Square]()
    private var listOfClickedSquare = [Square]()
    var checkAlreadyContainsList = false
    
    func clearClickedSquares () {
        listOfClickedSquare.removeAll()
    }

    func findAvailableSquare () -> Int {
        if availableSquares.count == listOfClickedSquare.count {
            listOfClickedSquare.removeAll()
            return 0
        }
        var square : Square?
        let countAvailableSquares = availableSquares.count
        repeat {
            let random = Int.random(in: 0..<countAvailableSquares)
            square = availableSquares[random]
            if let square = square {
                checkAlreadyContainsList = checkContainsListOfClickedSquare(square: square)
            }
        } while checkAlreadyContainsList
        if let newSquare = square {
            listOfClickedSquare.append(newSquare)
            //print("added \(newSquare.numberOfSquare)")
        }
        return square?.numberOfSquare ?? 0
    }
    
    func checkContainsListOfClickedSquare (square: Square ) -> Bool {
        for clickedSquares in listOfClickedSquare {
            if clickedSquares.numberOfSquare == square.numberOfSquare {
                return true
            }
        }
        return false
    }
    
    
    
    func addSquare (numberOfSquare: Int) {
        let square = Square(numberOfSquare: numberOfSquare)
            availableSquares.append(square)
    }
    
    func addClickedSquare (numberOfSquare: Int) {
        let clickedSquare = Square(numberOfSquare: numberOfSquare)
        listOfClickedSquare.append(clickedSquare)
    }
    
    func deleteAllPlayers () {
        players.removeAll()
    }
    
    func addPlayer (name: String, score: Int) {
        let player = Player(name: name, score: score)
        players.append(player)
    }
    
    func increasePlayerScore (player: Player) {
        player.score += 1
    }
    
    func player(index: Int) -> Player {
        return players[index]
    }
    
    func count () -> Int {
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
