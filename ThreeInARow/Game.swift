
import UIKit

class Game {
    var number = 0
    
    func playGame (label : UILabel) {
        let playerOneSymbolCross = "X"
        let playerTwoSymbolCircle = "O"
        if label.text != "X" && label.text != "O" {
            if number % 2 == 0 {
                label.textColor = UIColor.black
                label.text = playerOneSymbolCross
            } else {
                label.textColor = UIColor.red
                label.text = playerTwoSymbolCircle
            }
            number += 1
        }
    }
    
    func checkThreeInRow (label1 box1: UILabel, label2 box2: UILabel, label3 box3: UILabel,
                          label4 box4: UILabel, label5 box5: UILabel, label6 box6: UILabel,
                          label7 box7: UILabel, label8 box8: UILabel, label9 box9: UILabel) -> Bool {
        if box1.text == "X" && box2.text == "X" && box3.text == "X" {
            print("spelare 1 vann")
            return true
        } else if box1.text == "X" && box4.text == "X" && box7.text == "X" {
            print("spelare 1 vann")
            return true
        } else if box1.text == "X" && box5.text == "X" && box9.text == "X" {
            print("spelare 1 vann")
            return true
        } else if box3.text == "X" && box6.text == "X" && box9.text == "X" {
            print("spelare 1 vann")
            return true
        } else if box7.text == "X" && box8.text == "X" && box9.text == "X" {
            print("spelare 1 vann")
            return true
        } else if box3.text == "X" && box5.text == "X" && box7.text == "X" {
            print("spelare 1 vann")
            return true
        } else if box1.text == "O" && box2.text == "O" && box3.text == "O" {
            print("spelare 2 vann")
            return false
        } else if box1.text == "O" && box4.text == "O" && box7.text == "O" {
            print("spelare 2 vann")
            return false
        } else if box1.text == "O" && box5.text == "O" && box9.text == "O" {
            print("spelare 2 vann")
            return false
        } else if box3.text == "O" && box6.text == "O" && box9.text == "O" {
            print("spelare 2 vann")
            return false
        } else if box7.text == "O" && box8.text == "O" && box9.text == "O" {
            print("spelare 2 vann")
            return false
        } else if box3.text == "O" && box5.text == "O" && box7.text == "O" {
            print("spelare 2 vann")
            return false
        }
        return false
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
