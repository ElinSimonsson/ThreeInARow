//
//  ViewController.swift
//  ThreeInARow
//
//  Created by Elin Simonsson on 2022-11-29.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var squareOneLabel: UILabel!
    @IBOutlet weak var squareTwoLabel: UILabel!
    @IBOutlet weak var playerOneScoreLabel: UILabel!
    @IBOutlet weak var playerTwoScoreLabel: UILabel!
    @IBOutlet weak var squareThreeLabel: UILabel!
    @IBOutlet weak var squareFourLabel: UILabel!
    @IBOutlet weak var squareFiveLabel: UILabel!
    @IBOutlet weak var squareSixLabel: UILabel!
    @IBOutlet weak var squareSevenLabel: UILabel!
    @IBOutlet weak var squareEightLabel: UILabel!
    @IBOutlet weak var squareNineLabel: UILabel!
    @IBOutlet weak var playerTurnLabel: UILabel!
    
    var playerOne : Player?
    var playerTwo : Player?
    var playerOneWon = false
    var playerTwoWon = false
    var gameIsOver = false
    
    let game = Game()
    
    
    
    let playerOneName = "Player 1"
    let playerTwoName = "Player 2"

    
    let playerOneSymbolCross = "X"
    let playerTwoSymbolCircle = "O"
    var checkPlayerTurn = 0
    var playerOneTotalScore = 0
    var playerTwoTotalScore = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        game.addPlayer(name: playerOneName, score: 0)
        game.addPlayer(name: playerTwoName, score: 0)
        playerOne = game.player(index: 0)
        playerTwo = game.player(index: 1)
        print("Antal spelare: \(game.count())")
        print("Spelare 1: \(game.player(index: 1).name)")
        
       initializeLayout()
    }
    
    
    func initializeLayout () {
        if let playerOneName = playerOne?.name {
            playerTurnLabel.text = "\(playerOneName)´s turn"
        }
        
        squareOneLabel.layer.borderWidth = 1.5
        squareTwoLabel.layer.borderWidth = 1.5
        squareThreeLabel.layer.borderWidth = 1.5
        squareFourLabel.layer.borderWidth = 1.5
        squareFiveLabel.layer.borderWidth = 1.5
        squareSixLabel.layer.borderWidth = 1.5
        squareSevenLabel.layer.borderWidth = 1.5
        squareEightLabel.layer.borderWidth = 1.5
        squareNineLabel.layer.borderWidth = 1.5
        
        if let uiImage = UIImage(named: "light_wood_background") {
            squareOneLabel.backgroundColor = UIColor(patternImage: uiImage)
            squareTwoLabel.backgroundColor = UIColor(patternImage: uiImage)
            squareThreeLabel.backgroundColor = UIColor(patternImage: uiImage)
            squareFourLabel.backgroundColor = UIColor(patternImage: uiImage)
            squareFiveLabel.backgroundColor = UIColor(patternImage: uiImage)
            squareSixLabel.backgroundColor = UIColor(patternImage: uiImage)
            squareSevenLabel.backgroundColor = UIColor(patternImage: uiImage)
            squareEightLabel.backgroundColor = UIColor(patternImage: uiImage)
            squareNineLabel.backgroundColor = UIColor(patternImage: uiImage)
        }
    }

    func boxClicked (label : UILabel) {
        if label.text != "X" && label.text != "O" {
            if checkPlayerTurn % 2 == 0 {
                label.textColor = UIColor.blue
                label.text = playerOneSymbolCross
                if let playerTwoName = playerTwo?.name {
                    playerTurnLabel.text = "\(playerTwoName)´s turn"
                }
            } else {
                label.textColor = UIColor.red
                label.text = playerTwoSymbolCircle
                if let playerOneName = playerOne?.name {
                    playerTurnLabel.text = "\(playerOneName)´s turn"
                }
            }
            checkPlayerTurn += 1
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "segueToPopUp" {
            let destinationVC = segue.destination as? PopUpViewController
            if playerOneWon {
                let playerOne = game.player(index: 0)
                destinationVC?.player = playerOne
                playerOneWon = false
            } else if playerTwoWon {
                let playerTwo = game.player(index: 1)
                destinationVC?.player = playerTwo
                playerTwoWon = false
            } 
        }
    }
    
    func checkIfAllSquareIsFilled () {
        if squareOneLabel.text != "" && squareTwoLabel.text != "" && squareThreeLabel.text != "" && squareFourLabel.text != "" &&
            squareFiveLabel.text != "" && squareSixLabel.text != "" && squareSevenLabel.text != "" && squareEightLabel.text != "" &&
            squareNineLabel.text != "" {
            performSegue(withIdentifier: "segueToPopUp", sender: self)
            restartGameLayout()
        }
    }
    
    func checkIfPlayerOneWins () {
        let checkPlayerOneWins = game.checkIfPlayer1ThreeRow(label1: squareOneLabel, label2: squareTwoLabel, label3: squareThreeLabel, label4: squareFourLabel, label5: squareFiveLabel, label6: squareSixLabel, label7: squareSevenLabel, label8: squareEightLabel, label9: squareNineLabel)
        
        if checkPlayerOneWins {
            playerOneWon = true
            gameIsOver = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                print("Async after 2 seconds")
                self.performSegue(withIdentifier: "segueToPopUp", sender: self)
                self.restartGameLayout()
                self.gameIsOver = false
            }
        
            if let player1 = playerOne {
                game.increasePlayerScore(player: player1)
                playerOneTotalScore = game.getPlayerScore(player: player1)
                playerOneScoreLabel.text = String(playerOneTotalScore)
            }
        }
    }
    
    
    func checkIfPlayerTwoWins () {
       let checkIfPlayer2Wins = game.checkIfPlayer2ThreeRow(label1: squareOneLabel, label2: squareTwoLabel, label3: squareThreeLabel, label4: squareFourLabel, label5: squareFiveLabel, label6: squareSixLabel, label7: squareSevenLabel, label8: squareEightLabel, label9: squareNineLabel)

        if checkIfPlayer2Wins {
            playerTwoWon = true
            gameIsOver = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.performSegue(withIdentifier: "segueToPopUp", sender: self)
                self.restartGameLayout()
                self.gameIsOver = false
            }
            
            
            if let player2 = playerTwo {
                game.increasePlayerScore(player: player2)
                playerTwoTotalScore = game.getPlayerScore(player: player2)
                playerTwoScoreLabel.text = String(playerTwoTotalScore)
            }
        }
    }
    
    
    func restartGameLayout () {
        checkPlayerTurn = 0
        squareOneLabel.text = ""
        squareTwoLabel.text = ""
        squareThreeLabel.text = ""
        squareFourLabel.text = ""
        squareFiveLabel.text = ""
        squareSixLabel.text = ""
        squareSevenLabel.text = ""
        squareEightLabel.text = ""
        squareNineLabel.text = ""
    }
    
    
    @IBAction func squareOneTapped(_ sender: UITapGestureRecognizer) {
        if gameIsOver == false {
            boxClicked(label: squareOneLabel)
            checkIfPlayerOneWins()
            checkIfPlayerTwoWins()
            checkIfAllSquareIsFilled()
        }
    }
    
    @IBAction func squareTwoTapped(_ sender: UITapGestureRecognizer) {
        if gameIsOver == false {
            boxClicked(label: squareTwoLabel)
            checkIfPlayerOneWins()
            checkIfPlayerTwoWins()
            checkIfAllSquareIsFilled()
        }
    }
    
    @IBAction func squareThreeTapped(_ sender: UITapGestureRecognizer) {
        if gameIsOver == false {
            boxClicked(label: squareThreeLabel)
            checkIfPlayerOneWins()
            checkIfPlayerTwoWins()
            checkIfAllSquareIsFilled()
        }
    }
    
    @IBAction func squareFourTapped(_ sender: UITapGestureRecognizer) {
        if gameIsOver == false {
            boxClicked(label: squareFourLabel)
            checkIfPlayerOneWins()
            checkIfPlayerTwoWins()
            checkIfAllSquareIsFilled()
        }
    }
    
    @IBAction func squareFiveTapped(_ sender: UITapGestureRecognizer) {
        if gameIsOver == false {
            boxClicked(label: squareFiveLabel)
            checkIfPlayerOneWins()
            checkIfPlayerTwoWins()
            checkIfAllSquareIsFilled()
        }
    }
    
    @IBAction func squareSixTapped(_ sender: UITapGestureRecognizer) {
        if gameIsOver == false {
            boxClicked(label: squareSixLabel)
            checkIfPlayerOneWins()
            checkIfPlayerTwoWins()
            checkIfAllSquareIsFilled()
        }
    }
    
    @IBAction func squareSevenTapped(_ sender: UITapGestureRecognizer) {
        if gameIsOver == false {
            boxClicked(label: squareSevenLabel)
            checkIfPlayerOneWins()
            checkIfPlayerTwoWins()
            checkIfAllSquareIsFilled()
        }
    }
    
    @IBAction func squareEightTapped(_ sender: UITapGestureRecognizer) {
        if gameIsOver == false {
            boxClicked(label: squareEightLabel)
            checkIfPlayerOneWins()
            checkIfPlayerTwoWins()
            checkIfAllSquareIsFilled()
        }
    }
    
    @IBAction func squareNineTapped(_ sender: UITapGestureRecognizer) {
        if gameIsOver == false {
            boxClicked(label: squareNineLabel)
            checkIfPlayerOneWins()
            checkIfPlayerTwoWins()
            checkIfAllSquareIsFilled()
        }
    }
    
    @IBAction func unwindToGameView(segue: UIStoryboardSegue){
        
    }
}

