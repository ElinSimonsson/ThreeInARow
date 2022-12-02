
import UIKit

class Game {
    private var players = [Player]()
    
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
