//
//  ViewController.swift
//  ThreeInARow
//
//  Created by Elin Simonsson on 2022-11-29.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var boxOneLabel: UILabel!
    @IBOutlet weak var boxTwoLabel: UILabel!
    @IBOutlet weak var boxThreeLabel: UILabel!
    @IBOutlet weak var boxFourLabel: UILabel!
    @IBOutlet weak var boxFiveLabel: UILabel!
    @IBOutlet weak var boxSixLabel: UILabel!
    @IBOutlet weak var boxSevenLabel: UILabel!
    @IBOutlet weak var boxEightLabel: UILabel!
    @IBOutlet weak var boxNineLabel: UILabel!
    
    let game = Game()
    
    
    let playerOneSymbol = "X"
    let playerTwoSymbol = "O"
    var number = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setBorders()
      
        
        
    }
    
    func setBorders () {
        boxOneLabel.layer.borderWidth = 1.0
        boxTwoLabel.layer.borderWidth = 1.0
        boxThreeLabel.layer.borderWidth = 1.0
        boxFourLabel.layer.borderWidth = 1.0
        boxFiveLabel.layer.borderWidth = 1.0
        boxSixLabel.layer.borderWidth = 1.0
        boxSevenLabel.layer.borderWidth = 1.0
        boxEightLabel.layer.borderWidth = 1.0
        boxNineLabel.layer.borderWidth = 1.0
    }
    

    func playGame (label : UILabel) {
        if label.text != "X" && label.text != "O" {
            if number % 2 == 0 {
                label.textColor = UIColor.black
                label.text = playerOneSymbol
            } else {
                label.textColor = UIColor.red
                label.text = playerTwoSymbol
            }
            number += 1
        }
    }
    
//    func checkIfThreeInARow () {
//        let checkIfPlayer1Wins = game.checkThreeInRow(label1: boxOneLabel, label2: boxTwoLabel, label3: boxThreeLabel, label4: boxFourLabel, label5: boxFiveLabel, label6: boxSixLabel, label7: boxSevenLabel, label8: boxEightLabel, label9: boxNineLabel)
//
//        if checkIfPlayer1Wins {
//            restartGameLayout()
//        }
//    }
    
    func checkIfPlayerOneWins () {
        let checkPlayerOneWins = game.checkIfPlayer1ThreeRow(label1: boxOneLabel, label2: boxTwoLabel, label3: boxThreeLabel, label4: boxFourLabel, label5: boxFiveLabel, label6: boxSixLabel, label7: boxSevenLabel, label8: boxEightLabel, label9: boxNineLabel)
        
        if checkPlayerOneWins {
            print("spelare 1 vann")
            restartGameLayout()
        }
    }
    
    func checkPlayerTwoThreeInARow () {
       let checkIfPlayer2Wins = game.checkIfPlayer2ThreeRow(label1: boxOneLabel, label2: boxTwoLabel, label3: boxThreeLabel, label4: boxFourLabel, label5: boxFiveLabel, label6: boxSixLabel, label7: boxSevenLabel, label8: boxEightLabel, label9: boxNineLabel)

        if checkIfPlayer2Wins {
            restartGameLayout()
            print("spelare 2 vann")

        }
    }
    
    func restartGameLayout () {
        boxOneLabel.text = ""
        boxTwoLabel.text = ""
        boxThreeLabel.text = ""
        boxFourLabel.text = ""
        boxFiveLabel.text = ""
        boxSixLabel.text = ""
        boxSevenLabel.text = ""
        boxEightLabel.text = ""
        boxNineLabel.text = ""
        number = 0
    }

    
    
    @IBAction func BoxOneTapped(_ sender: UITapGestureRecognizer) {
       // game.playGame(label: boxOneLabel)
        playGame(label: boxOneLabel)
        checkIfPlayerOneWins()
        checkPlayerTwoThreeInARow()
    }
    @IBAction func boxTwoTapped(_ sender: UITapGestureRecognizer) {
        //game.playGame(label: boxTwoLabel)
        playGame(label: boxTwoLabel)
        checkIfPlayerOneWins()
        checkPlayerTwoThreeInARow()
    }
    
    @IBAction func boxThreeTaped(_ sender: UITapGestureRecognizer) {
        //game.playGame(label: boxThreeLabel)
        playGame(label: boxThreeLabel)
        checkIfPlayerOneWins()
        checkPlayerTwoThreeInARow()
    }
    
    @IBAction func boxFourTapped(_ sender: UITapGestureRecognizer) {
        //game.playGame(label: boxFourLabel)
        playGame(label: boxFourLabel)
        checkIfPlayerOneWins()
        checkPlayerTwoThreeInARow()
    }
    @IBAction func boxFiveTapped(_ sender: UITapGestureRecognizer) {
       // game.playGame(label: boxFiveLabel)
        playGame(label: boxFiveLabel)
        checkIfPlayerOneWins()
        checkPlayerTwoThreeInARow()
    }
    @IBAction func boxSixTapped(_ sender: UITapGestureRecognizer) {
        //game.playGame(label: boxSixLabel)
        playGame(label: boxSixLabel)
        checkIfPlayerOneWins()
        checkPlayerTwoThreeInARow()
    }
    @IBAction func boxSevenTapped(_ sender: UITapGestureRecognizer) {
        //game.playGame(label: boxSevenLabel)
        playGame(label: boxSevenLabel)
        checkIfPlayerOneWins()
        checkPlayerTwoThreeInARow()
    }
    @IBAction func boxEightTapped(_ sender: UITapGestureRecognizer) {
        //game.playGame(label: boxEightLabel)
        playGame(label: boxEightLabel)
        checkIfPlayerOneWins()
        checkPlayerTwoThreeInARow()
    }
    @IBAction func boxNineTapped(_ sender: UITapGestureRecognizer) {
        //game.playGame(label: boxNineLabel)
        playGame(label: boxNineLabel)
        checkIfPlayerOneWins()
        checkPlayerTwoThreeInARow()
    }
}

