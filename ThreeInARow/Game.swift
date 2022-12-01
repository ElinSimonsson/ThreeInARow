
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
    
    func getPlayerScore (player: Player) -> Int {
        return player.score
    }
    
    func count () -> Int {
        return players.count
    }
    
    func player(index: Int) -> Player {
        return players[index]
    }
    
    func checkIfPlayer2ThreeRow (label1 box1: UILabel, label2 box2: UILabel, label3 box3: UILabel,
                                 label4 box4: UILabel, label5 box5: UILabel, label6 box6: UILabel,
                                 label7 box7: UILabel, label8 box8: UILabel, label9 box9: UILabel) -> Bool {
        
        if box1.text == "O" && box2.text == "O" && box3.text == "O" ||
            box1.text == "O" && box4.text == "O" && box7.text == "O" ||
            box1.text == "O" && box5.text == "O" && box9.text == "O" ||
            box4.text == "O" && box5.text == "O" && box6.text == "O" ||
            box7.text == "O" && box8.text == "O" && box9.text == "O" ||
            box2.text == "O" && box5.text == "O" && box8.text == "O" ||
            box3.text == "O" && box6.text == "O" && box9.text == "O" ||
            box3.text == "O" && box5.text == "O" && box7.text == "O" {
            return true
        }
        return false
    }
    
    func checkIfPlayer1ThreeRow (label1 box1: UILabel, label2 box2: UILabel, label3 box3: UILabel,
                                 label4 box4: UILabel, label5 box5: UILabel, label6 box6: UILabel,
                                 label7 box7: UILabel, label8 box8: UILabel, label9 box9: UILabel) -> Bool {
        
        if box1.text == "X" && box2.text == "X" && box3.text == "X" ||
            box1.text == "X" && box4.text == "X" && box7.text == "X" ||
            box1.text == "X" && box5.text == "X" && box9.text == "X" ||
            box4.text == "X" && box5.text == "X" && box6.text == "X" ||
            box7.text == "X" && box8.text == "X" && box9.text == "X" ||
            box2.text == "X" && box5.text == "X" && box8.text == "X" ||
            box3.text == "X" && box6.text == "X" && box9.text == "X" ||
            box3.text == "X" && box5.text == "X" && box7.text == "X" {
            return true
        }
        return false
    }
    
}
