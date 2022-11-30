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
    
    var playerOneWon = false
    var playerTwoWon = false
    
    @IBOutlet weak var playerTurnLabel: UILabel!
    
    
    let game = Game()
    
    
    let playerOneSymbolCross = "X"
    let playerTwoSymbolCircle = "O"
    var checkPlayerTurn = 0
    var playerOneTotalScore = 0
    var playerTwoTotalScore = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       initializeLayout()
    }
    
    
    func initializeLayout () {
        playerTurnLabel.text = "Player 1´s turn"
        
        squareOneLabel.layer.borderWidth = 1.0
        squareTwoLabel.layer.borderWidth = 1.0
        squareThreeLabel.layer.borderWidth = 1.0
        squareFourLabel.layer.borderWidth = 1.0
        squareFiveLabel.layer.borderWidth = 1.0
        squareSixLabel.layer.borderWidth = 1.0
        squareSevenLabel.layer.borderWidth = 1.0
        squareEightLabel.layer.borderWidth = 1.0
        squareNineLabel.layer.borderWidth = 1.0
        
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
                playerTurnLabel.text = "Player 2´s turn"
            } else {
                label.textColor = UIColor.red
                label.text = playerTwoSymbolCircle
                playerTurnLabel.text = "Player 1´s turn"
            }
            checkPlayerTurn += 1
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "segueToPopUp" {
            let destinationVC = segue.destination as? PopUpViewController
            if playerOneWon {
                destinationVC?.recevingData = "Player 1 won!"
                playerOneWon = false
            } else if playerTwoWon {
                destinationVC?.recevingData = "Player 2 won!"
                playerTwoWon = false
            } else {
                destinationVC?.recevingData = "It is a tie!"
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
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                print("Async after 2 seconds")
                self.performSegue(withIdentifier: "segueToPopUp", sender: self)
                self.restartGameLayout()
            }
           // performSegue(withIdentifier: "segueToPopUp", sender: self)
            
            playerOneTotalScore += 1
            playerOneScoreLabel.text = String (playerOneTotalScore)
        }
    }
    
    
    func checkIfPlayerTwoWins () {
       let checkIfPlayer2Wins = game.checkIfPlayer2ThreeRow(label1: squareOneLabel, label2: squareTwoLabel, label3: squareThreeLabel, label4: squareFourLabel, label5: squareFiveLabel, label6: squareSixLabel, label7: squareSevenLabel, label8: squareEightLabel, label9: squareNineLabel)

        if checkIfPlayer2Wins {
            playerTwoWon = true
            performSegue(withIdentifier: "segueToPopUp", sender: self)
            restartGameLayout()
            playerTwoTotalScore += 1
            playerTwoScoreLabel.text = String(playerTwoTotalScore)
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
        boxClicked(label: squareOneLabel)
        checkIfPlayerOneWins()
        checkIfPlayerTwoWins()
        checkIfAllSquareIsFilled()
    }
    
    @IBAction func squareTwoTapped(_ sender: UITapGestureRecognizer) {
        boxClicked(label: squareTwoLabel)
        checkIfPlayerOneWins()
        checkIfPlayerTwoWins()
        checkIfAllSquareIsFilled()
    }
    
    @IBAction func squareThreeTapped(_ sender: UITapGestureRecognizer) {
        boxClicked(label: squareThreeLabel)
        checkIfPlayerOneWins()
        checkIfPlayerTwoWins()
        checkIfAllSquareIsFilled()
    }
    
    @IBAction func squareFourTapped(_ sender: UITapGestureRecognizer) {
        boxClicked(label: squareFourLabel)
        checkIfPlayerOneWins()
        checkIfPlayerTwoWins()
        checkIfAllSquareIsFilled()
    }
    
    @IBAction func squareFiveTapped(_ sender: UITapGestureRecognizer) {
        boxClicked(label: squareFiveLabel)
        checkIfPlayerOneWins()
        checkIfPlayerTwoWins()
        checkIfAllSquareIsFilled()
    }
    
    @IBAction func squareSixTapped(_ sender: UITapGestureRecognizer) {
        boxClicked(label: squareSixLabel)
        checkIfPlayerOneWins()
        checkIfPlayerTwoWins()
        checkIfAllSquareIsFilled()
    }
    
    @IBAction func squareSevenTapped(_ sender: UITapGestureRecognizer) {
        boxClicked(label: squareSevenLabel)
        checkIfPlayerOneWins()
        checkIfPlayerTwoWins()
        checkIfAllSquareIsFilled()
    }
    
    @IBAction func squareEightTapped(_ sender: UITapGestureRecognizer) {
        boxClicked(label: squareEightLabel)
        checkIfPlayerOneWins()
        checkIfPlayerTwoWins()
        checkIfAllSquareIsFilled()
    }
    
    @IBAction func squareNineTapped(_ sender: UITapGestureRecognizer) {
        boxClicked(label: squareNineLabel)
        checkIfPlayerOneWins()
        checkIfPlayerTwoWins()
        checkIfAllSquareIsFilled()
    }
    
    @IBAction func unwindToGameView(segue: UIStoryboardSegue){
        
    }
}

