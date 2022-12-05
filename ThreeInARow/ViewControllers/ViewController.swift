//
//  ViewController.swift
//  ThreeInARow
//
//  Created by Elin Simonsson on 2022-11-29.
//

import UIKit

class ViewController: UIViewController, CanReceive {
    func passDataBack(gameIsRestarted: Bool) {
        let playAgain = gameIsRestarted
        print("inne i spelet: \(playAgain)")
        game.clearClickedSquares()
        restartGameLayout()
        player1Won = false
        playerOneWon = false
        playerTwoWon = false
        gameIsOver = false
        computerTurn = false
    }
    

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
    
    @IBOutlet weak var playerOneNameLabel: UILabel!
    
    @IBOutlet weak var playerTwoNameLabel: UILabel!
    
    var playerOne : Player?
    var playerTwo : Player?
    var playerOneWon = false
    var playerTwoWon = false
    var gameIsOver = false
    var playingTowardComputer = false //default
    var computerTurn = false
    var player1Won = false
    
    let game = Game()

    
    let playerOneSymbolCross = "X"
    let playerTwoSymbolCircle = "O"
    var checkPlayerTurn = 0
//    var playerOneTotalScore = 0
//    var playerTwoTotalScore = 0
    let segueToPopUp = "segueToPopUp"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("playingTowardCompiter: \(playingTowardComputer)")
        
       initializeLayout()
        
        game.addAvailableSquare(numberOfSquare: 1) // tst
        game.addAvailableSquare(numberOfSquare: 2)
        game.addAvailableSquare(numberOfSquare: 3)
        game.addAvailableSquare(numberOfSquare: 4)
        game.addAvailableSquare(numberOfSquare: 5)
        game.addAvailableSquare(numberOfSquare: 6)
        game.addAvailableSquare(numberOfSquare: 7)
        game.addAvailableSquare(numberOfSquare: 8)
        game.addAvailableSquare(numberOfSquare: 9) // test
    }
    
    func testPlayingComputer () {
        
        let testAvailableSquare = game.testFindAvailable()
        computerClickedSquare(numberOfSquare: testAvailableSquare)
    }
    
    func computerClickedSquare (numberOfSquare: Int) {
        switch numberOfSquare {
        case 1:
            squareOneLabel.textColor = UIColor.red
            squareOneLabel.text = playerTwoSymbolCircle
        case 2:
            squareTwoLabel.textColor = UIColor.red
            squareTwoLabel.text = playerTwoSymbolCircle
        case 3:
            squareThreeLabel.textColor = UIColor.red
            squareThreeLabel.text = playerTwoSymbolCircle
        case 4:
            squareFourLabel.textColor = UIColor.red
            squareFourLabel.text = playerTwoSymbolCircle
        case 5:
            squareFiveLabel.textColor = UIColor.red
            squareFiveLabel.text = playerTwoSymbolCircle
        case 6:
            squareSixLabel.textColor = UIColor.red
            squareSixLabel.text = playerTwoSymbolCircle
        case 7:
            squareSevenLabel.textColor = UIColor.red
            squareSevenLabel.text = playerTwoSymbolCircle
        case 8:
            squareEightLabel.textColor = UIColor.red
            squareEightLabel.text = playerTwoSymbolCircle
        case 9:
            squareNineLabel.textColor = UIColor.red
            squareNineLabel.text = playerTwoSymbolCircle
        default: break
        }
    }
    
    
    func initializeLayout () {
        if let playerOneName = playerOne?.name,
           let playerTwoName = playerTwo?.name {
            playerTurnLabel.text = "\(playerOneName)´s turn"
            playerOneNameLabel.text = playerOneName
            playerTwoNameLabel.text = playerTwoName
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
    
    func checkWhichThreeSquareIsInRow (symbol: String) -> Int {
        if squareOneLabel.text == symbol && squareTwoLabel.text == symbol && squareThreeLabel.text == symbol {
            return 123
        } else if squareOneLabel.text == symbol && squareFourLabel.text == symbol && squareSevenLabel.text == symbol {
            return 147
        } else if squareOneLabel.text == symbol && squareFiveLabel.text == symbol && squareNineLabel.text == symbol {
            return 159
        } else if squareFourLabel.text == symbol && squareFiveLabel.text == symbol && squareSixLabel.text == symbol {
            return 456
        } else if squareSevenLabel.text == symbol && squareEightLabel.text == symbol && squareNineLabel.text == symbol {
            return 789
        } else if squareTwoLabel.text == symbol && squareFiveLabel.text == symbol && squareEightLabel.text == symbol {
            return 258
        } else if squareThreeLabel.text == symbol && squareSixLabel.text == symbol && squareNineLabel.text == symbol {
            return 369
        } else if squareThreeLabel.text == symbol && squareFiveLabel.text == symbol && squareSevenLabel.text == symbol {
            return 357
        }
        return 0
    }
    
    func setLayoutWinning (playerSymbol: String) {
        let numbersOfSquareIsInRow = checkWhichThreeSquareIsInRow(symbol: playerSymbol)
        
        switch numbersOfSquareIsInRow {
        case 123:
            squareOneLabel.backgroundColor = UIColor.green
            squareTwoLabel.backgroundColor = UIColor.green
            squareThreeLabel.backgroundColor = UIColor.green
        case 147:
            squareOneLabel.backgroundColor = UIColor.green
            squareFourLabel.backgroundColor = UIColor.green
            squareSevenLabel.backgroundColor = UIColor.green
        case 159:
            squareOneLabel.backgroundColor = UIColor.green
            squareFiveLabel.backgroundColor = UIColor.green
            squareNineLabel.backgroundColor = UIColor.green
        case 456:
            squareFourLabel.backgroundColor = UIColor.green
            squareFiveLabel.backgroundColor = UIColor.green
            squareSixLabel.backgroundColor = UIColor.green
        case 789:
            squareSevenLabel.backgroundColor = UIColor.green
            squareEightLabel.backgroundColor = UIColor.green
            squareNineLabel.backgroundColor = UIColor.green
        case 258:
            squareTwoLabel.backgroundColor = UIColor.green
            squareFiveLabel.backgroundColor = UIColor.green
            squareEightLabel.backgroundColor = UIColor.green
        case 369:
            squareThreeLabel.backgroundColor = UIColor.green
            squareSixLabel.backgroundColor = UIColor.green
            squareNineLabel.backgroundColor = UIColor.green
        case 357:
            squareThreeLabel.backgroundColor = UIColor.green
            squareFiveLabel.backgroundColor = UIColor.green
            squareSevenLabel.backgroundColor = UIColor.green
        default: break
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueToPopUp {
            let destinationVC = segue.destination as? PopUpViewController
            if playerOneWon {
                destinationVC?.player = playerOne
                destinationVC?.delegate = self
                playerOneWon = false
            } else if playerTwoWon {
                destinationVC?.player = playerTwo
                destinationVC?.delegate = self
                playerTwoWon = false
            }
        }
    }
    
    func checkIfPlayerWins () {
        let checkIfPlayerOneWins = game.checkIfThreeRow(playerSymbol: playerOneSymbolCross, label1: squareOneLabel, label2: squareTwoLabel, label3: squareThreeLabel, label4: squareFourLabel, label5: squareFiveLabel, label6: squareSixLabel, label7: squareSevenLabel, label8: squareEightLabel, label9: squareNineLabel)
        
        let checkIfPlayerTwoWins = game.checkIfThreeRow(playerSymbol: playerTwoSymbolCircle, label1: squareOneLabel, label2: squareTwoLabel, label3: squareThreeLabel, label4: squareFourLabel, label5: squareFiveLabel, label6: squareSixLabel, label7: squareSevenLabel, label8: squareEightLabel, label9: squareNineLabel)
        
        
            if checkIfPlayerOneWins {
                playerOneWon = true
                player1Won = true
                gameIsOver = true
                //print("1, \(player1Won)")
                setLayoutWinning(playerSymbol: playerOneSymbolCross)
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    //self.game.clearClickedSquares()
                    self.performSegue(withIdentifier: self.segueToPopUp, sender: self)
                    //self.restartGameLayout()
                    //self.gameIsOver = false
                }
                
                if let player1 = playerOne {
                    game.increasePlayerScore(player: player1)
                    print("player 1 score increased")
                    if let player1Score = playerOne?.score {
                        playerOneScoreLabel.text = String (player1Score)
                    }
                }
            } else if checkIfPlayerTwoWins {
                playerTwoWon = true
                gameIsOver = true
                setLayoutWinning(playerSymbol: playerTwoSymbolCircle)
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    //self.game.clearClickedSquares()
                    self.performSegue(withIdentifier: self.segueToPopUp, sender: self)
                    //self.restartGameLayout()
                    //self.gameIsOver = false
                }
                
                if let player2 = playerTwo {
                    game.increasePlayerScore(player: player2)
                    if let player2Score = playerTwo?.score {
                        playerTwoScoreLabel.text = String (player2Score)
                    }
                }
            }
        }
    
    
    func restartGameLayout () {
        initializeLayout()
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
    
    func boxClicked (label : UILabel, numberOfSquare : Int) {
        if playingTowardComputer {
            if label.text == "" {
                if computerTurn == false {
                    if player1Won == false {
                       // print("2, \(player1Won)")
                    label.textColor = UIColor.blue
                    label.text = playerOneSymbolCross
                    if let playerTwoName = playerTwo?.name {
                        playerTurnLabel.text = "\(playerTwoName)´s turn"
                    }
                        checkPlayerTurn += 1
                    
                    game.addClickedSquare(numberOfSquare: numberOfSquare)
                    computerTurn = true
                    
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            if self.gameIsOver == false {
                                self.testPlayingComputer()
                                
                                self.computerTurn = false
                                self.checkPlayerTurn += 1
                                if let playerOneName = self.playerOne?.name {
                                    self.playerTurnLabel.text = "\(playerOneName)´s turn"
                                }
                                    print("4, \(self.player1Won)")
                                    self.checkIfPlayerWins()
                                    print("inne i funktionen boxclicked. ska inte köras om player 1 vunnit")
                                    self.checkIfAllSquareIsFilled()
                            }
                        }
                    }
                }
            }
        }
        
        if label.text != "X" && label.text != "O" && playingTowardComputer == false {
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
    
    func checkIfAllSquareIsFilled () {
        if squareOneLabel.text != "" && squareTwoLabel.text != "" && squareThreeLabel.text != "" && squareFourLabel.text != "" &&
            squareFiveLabel.text != "" && squareSixLabel.text != "" && squareSevenLabel.text != "" && squareEightLabel.text != "" &&
            squareNineLabel.text != "" && gameIsOver == false {
            performSegue(withIdentifier: "segueToPopUp", sender: self)
            restartGameLayout()
        }
    }
    
    @IBAction func squareOneTapped(_ sender: UITapGestureRecognizer) {
        if gameIsOver == false {
            boxClicked(label: squareOneLabel, numberOfSquare: 1)
            checkIfPlayerWins()
            checkIfAllSquareIsFilled()
            
            
        }
    }
    
    @IBAction func squareTwoTapped(_ sender: UITapGestureRecognizer) {
        if gameIsOver == false {
            boxClicked(label: squareTwoLabel, numberOfSquare: 2)
            
                checkIfPlayerWins()
                checkIfAllSquareIsFilled()
            
        }
    }
    
    @IBAction func squareThreeTapped(_ sender: UITapGestureRecognizer) {
        if gameIsOver == false {
            boxClicked(label: squareThreeLabel, numberOfSquare: 3)
            
                checkIfPlayerWins()
                checkIfAllSquareIsFilled()
            
        }
    }
    
    @IBAction func squareFourTapped(_ sender: UITapGestureRecognizer) {
        if gameIsOver == false {
            boxClicked(label: squareFourLabel, numberOfSquare: 4)
            
                checkIfPlayerWins()
                checkIfAllSquareIsFilled()
            
        }
    }
    
    @IBAction func squareFiveTapped(_ sender: UITapGestureRecognizer) {
        if gameIsOver == false {
            boxClicked(label: squareFiveLabel, numberOfSquare: 5)
           
                checkIfPlayerWins()
                checkIfAllSquareIsFilled()
            
           
            //testPlayingComputer()
           
        }
    }
    
    @IBAction func squareSixTapped(_ sender: UITapGestureRecognizer) {
        if gameIsOver == false {
           // game.addClickedSquare(numberOfSquare: 6)
            boxClicked(label: squareSixLabel, numberOfSquare: 6)
            //checkIfPlayerOneWins()
            //checkIfPlayerTwoWins()
            checkIfPlayerWins()
            checkIfAllSquareIsFilled()
           // testPlayingComputer()
            
        }
    }
    
    @IBAction func squareSevenTapped(_ sender: UITapGestureRecognizer) {
        if gameIsOver == false {
            //game.addClickedSquare(numberOfSquare: 7)
            boxClicked(label: squareSevenLabel, numberOfSquare: 7)
            //checkIfPlayerOneWins()
            //checkIfPlayerTwoWins()
            checkIfPlayerWins()
            checkIfAllSquareIsFilled()
            //testPlayingComputer()
            
        }
    }
    
    @IBAction func squareEightTapped(_ sender: UITapGestureRecognizer) {
        if gameIsOver == false {
            //game.addClickedSquare(numberOfSquare: 8)
            boxClicked(label: squareEightLabel, numberOfSquare: 8)
            //checkIfPlayerOneWins()
            //checkIfPlayerTwoWins()
            checkIfPlayerWins()
            checkIfAllSquareIsFilled()
            //testPlayingComputer()
            
        }
    }
    
    @IBAction func squareNineTapped(_ sender: UITapGestureRecognizer) {
        if gameIsOver == false {
            //game.addClickedSquare(numberOfSquare: 9)
            boxClicked(label: squareNineLabel, numberOfSquare: 9)
            //checkIfPlayerOneWins()
            //checkIfPlayerTwoWins()
            checkIfPlayerWins()
            checkIfAllSquareIsFilled()
            //testPlayingComputer()
            
        }
    }
    
    @IBAction func unwindToGameView(segue: UIStoryboardSegue){
        
    }
}

