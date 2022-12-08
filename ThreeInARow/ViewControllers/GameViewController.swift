import UIKit

class GameViewController: UIViewController, CanReceive {
    func passDataBack(gameIsRestarted: Bool) {
        let _ = gameIsRestarted
        game.clearClickedBoards()
        print("inne i spelet körs")
        restartGameLayout()
        playerOneWon = false
        playerTwoWon = false
        gameIsOver = false
        player1Turn = true
    }
    
    @IBOutlet weak var playerOneScoreLabel: UILabel!
    @IBOutlet weak var playerTwoScoreLabel: UILabel!
    @IBOutlet weak var boardOneLabel: UILabel!
    @IBOutlet weak var boardTwoLabel: UILabel!
    @IBOutlet weak var boardThreeLabel: UILabel!
    @IBOutlet weak var boardFourLabel: UILabel!
    @IBOutlet weak var boardFiveLabel: UILabel!
    @IBOutlet weak var boardSixLabel: UILabel!
    @IBOutlet weak var boardSevenLabel: UILabel!
    @IBOutlet weak var boardEightLabel: UILabel!
    @IBOutlet weak var boardNineLabel: UILabel!
    @IBOutlet weak var playerTurnLabel: UILabel!
    @IBOutlet weak var playerOneNameLabel: UILabel!
    @IBOutlet weak var playerTwoNameLabel: UILabel!
    
    var playerOne : Player?
    var playerTwo : Player?
    var playerOneWon = false
    var playerTwoWon = false
    var gameIsOver = false
    var playingTowardComputer = false //default
    var player1Turn = true
    let segueToPopUp = "segueToPopUp"
    let game = Game()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeGame()
        
        initBoard()
    }
    
    func initBoard () {
        game.addBoard(board: Board(rowAndColumn: 11))
        game.addBoard(board: Board(rowAndColumn: 12))
        game.addBoard(board: Board(rowAndColumn: 13))
        game.addBoard(board: Board(rowAndColumn: 21))
        game.addBoard(board: Board(rowAndColumn: 22))
        game.addBoard(board: Board(rowAndColumn: 23))
        game.addBoard(board: Board(rowAndColumn: 31))
        game.addBoard(board: Board(rowAndColumn: 32))
        game.addBoard(board: Board(rowAndColumn: 33))
    }
    
    func initializeGame () {
        if let playerOneName = playerOne?.name,
           let playerTwoName = playerTwo?.name {
            playerTurnLabel.text = "\(playerOneName)´s turn"
            playerOneNameLabel.text = playerOneName
            playerTwoNameLabel.text = playerTwoName
        }
        
        boardOneLabel.layer.borderWidth = 1.5
        boardTwoLabel.layer.borderWidth = 1.5
        boardThreeLabel.layer.borderWidth = 1.5
        boardFourLabel.layer.borderWidth = 1.5
        boardFiveLabel.layer.borderWidth = 1.5
        boardSixLabel.layer.borderWidth = 1.5
        boardSevenLabel.layer.borderWidth = 1.5
        boardEightLabel.layer.borderWidth = 1.5
        boardNineLabel.layer.borderWidth = 1.5
        
        if let uiImage = UIImage(named: "light_wood_background") {
            boardOneLabel.backgroundColor = UIColor(patternImage: uiImage)
            boardTwoLabel.backgroundColor = UIColor(patternImage: uiImage)
            boardThreeLabel.backgroundColor = UIColor(patternImage: uiImage)
            boardFourLabel.backgroundColor = UIColor(patternImage: uiImage)
            boardFiveLabel.backgroundColor = UIColor(patternImage: uiImage)
            boardSixLabel.backgroundColor = UIColor(patternImage: uiImage)
            boardSevenLabel.backgroundColor = UIColor(patternImage: uiImage)
            boardEightLabel.backgroundColor = UIColor(patternImage: uiImage)
            boardNineLabel.backgroundColor = UIColor(patternImage: uiImage)
        }
    }
    
    func computerClickBoard () {
        guard let playerTwo = playerTwo else {return}
        let playerTwoSymbol = String(playerTwo.symbol)
        
        switch game.randomEmptyBoard() {
        case 11:
            boardOneLabel.textColor = UIColor.red
            boardOneLabel.text = playerTwoSymbol
        case 12:
            boardTwoLabel.textColor = UIColor.red
            boardTwoLabel.text = playerTwoSymbol
        case 13:
            boardThreeLabel.textColor = UIColor.red
            boardThreeLabel.text = playerTwoSymbol
        case 21:
            boardFourLabel.textColor = UIColor.red
            boardFourLabel.text = playerTwoSymbol
        case 22:
            boardFiveLabel.textColor = UIColor.red
            boardFiveLabel.text = playerTwoSymbol
        case 23:
            boardSixLabel.textColor = UIColor.red
            boardSixLabel.text = playerTwoSymbol
        case 31:
            boardSevenLabel.textColor = UIColor.red
            boardSevenLabel.text = playerTwoSymbol
        case 32:
            boardEightLabel.textColor = UIColor.red
            boardEightLabel.text = playerTwoSymbol
        case 33:
            boardNineLabel.textColor = UIColor.red
            boardNineLabel.text = playerTwoSymbol
        default: break
        }
    }
    
    func setGreenBoardThreeInRow(symbol: Character) {
        let symbolStr = String(symbol)
        if boardOneLabel.text == symbolStr && boardTwoLabel.text == symbolStr && boardThreeLabel.text == symbolStr {
            boardOneLabel.backgroundColor = UIColor.green
            boardTwoLabel.backgroundColor = UIColor.green
            boardThreeLabel.backgroundColor = UIColor.green
        } else if boardOneLabel.text == symbolStr && boardFourLabel.text == symbolStr && boardSevenLabel.text == symbolStr {
            boardOneLabel.backgroundColor = UIColor.green
            boardFourLabel.backgroundColor = UIColor.green
            boardSevenLabel.backgroundColor = UIColor.green
        } else if boardOneLabel.text == symbolStr && boardFiveLabel.text == symbolStr && boardNineLabel.text == symbolStr {
            boardOneLabel.backgroundColor = UIColor.green
            boardFiveLabel.backgroundColor = UIColor.green
            boardNineLabel.backgroundColor = UIColor.green
        } else if boardFourLabel.text == symbolStr && boardFiveLabel.text == symbolStr && boardSixLabel.text == symbolStr {
            boardFourLabel.backgroundColor = UIColor.green
            boardFiveLabel.backgroundColor = UIColor.green
            boardSixLabel.backgroundColor = UIColor.green
        } else if boardSevenLabel.text == symbolStr && boardEightLabel.text == symbolStr && boardNineLabel.text == symbolStr {
            boardSevenLabel.backgroundColor = UIColor.green
            boardEightLabel.backgroundColor = UIColor.green
            boardNineLabel.backgroundColor = UIColor.green
        } else if boardTwoLabel.text == symbolStr && boardFiveLabel.text == symbolStr && boardEightLabel.text == symbolStr {
            boardTwoLabel.backgroundColor = UIColor.green
            boardFiveLabel.backgroundColor = UIColor.green
            boardEightLabel.backgroundColor = UIColor.green
        } else if boardThreeLabel.text == symbolStr && boardSixLabel.text == symbolStr && boardNineLabel.text == symbolStr {
            boardThreeLabel.backgroundColor = UIColor.green
            boardSixLabel.backgroundColor = UIColor.green
            boardNineLabel.backgroundColor = UIColor.green
        } else if boardThreeLabel.text == symbolStr && boardFiveLabel.text == symbolStr && boardSevenLabel.text == symbolStr {
            boardThreeLabel.backgroundColor = UIColor.green
            boardFiveLabel.backgroundColor = UIColor.green
            boardSevenLabel.backgroundColor = UIColor.green
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
            } else {
                destinationVC?.delegate = self
            }
        }
    }
    
    func checkIfPlayerWins () {
        guard let playerOneSymbol = playerOne?.symbol,
              let playerTwoSymbol = playerTwo?.symbol,
              let board1 = boardOneLabel.text,
              let board2 = boardTwoLabel.text,
              let board3 = boardThreeLabel.text,
              let board4 = boardFourLabel.text,
              let board5 = boardFiveLabel.text,
              let board6 = boardSixLabel.text,
              let board7 = boardSevenLabel.text,
              let board8 = boardEightLabel.text,
              let board9 = boardNineLabel.text else {return}

        
        let checkIfPlayerOneWins = game.checkIfThreeRow(playerSymbol: playerOneSymbol, label1: board1, label2: board2, label3: board3, label4: board4, label5: board5, label6: board6, label7: board7, label8: board8, label9: board9)
        
        let checkIfPlayerTwoWins = game.checkIfThreeRow(playerSymbol: playerTwoSymbol, label1: board1, label2: board2, label3: board3, label4: board4, label5: board5, label6: board6, label7: board7, label8: board8, label9: board9)
        
        if checkIfPlayerOneWins {
            playerOneWon = true
            gameIsOver = true
            setGreenBoardThreeInRow(symbol: playerOneSymbol)
            
            if let player1 = playerOne {
                game.increasePlayerScore(player: player1)
                if let player1Score = playerOne?.score {
                    playerOneScoreLabel.text = String (player1Score)
                }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.performSegue(withIdentifier: self.segueToPopUp, sender: self)
            }
            
        } else if checkIfPlayerTwoWins {
            playerTwoWon = true
            gameIsOver = true
            setGreenBoardThreeInRow(symbol: playerTwoSymbol)
            
            if let player2 = playerTwo {
                game.increasePlayerScore(player: player2)
                if let player2Score = playerTwo?.score {
                    playerTwoScoreLabel.text = String (player2Score)
                }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.performSegue(withIdentifier: self.segueToPopUp, sender: self)
            }
        }
    }
    
    func restartGameLayout () {
        initializeGame()
        boardOneLabel.text = ""
        boardTwoLabel.text = ""
        boardThreeLabel.text = ""
        boardFourLabel.text = ""
        boardFiveLabel.text = ""
        boardSixLabel.text = ""
        boardSevenLabel.text = ""
        boardEightLabel.text = ""
        boardNineLabel.text = ""
    }
    
    func delayComputerChooseBoard () {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            print("dator körs")
            self.player1Turn = true
            if self.gameIsOver == false {
                self.computerClickBoard()
                if let playerOneName = self.playerOne?.name {
                    self.playerTurnLabel.text = "\(playerOneName)´s turn"
                }
                self.checkIfPlayerWins()
                self.checkIfAllBoardsIsFilled()
            }
        }
    }
    
    func addToBoard (label : UILabel, board: Board ) {
        guard let playerOne = playerOne,
        let playerTwo = playerTwo else {return}
        
        if playingTowardComputer {
            if player1Turn {
                if game.checkContainsClickedBoards(clickedBoard: board) == false {
                    label.textColor = UIColor.blue
                    label.text = String(playerOne.symbol)
                    let playerTwoName = playerTwo.name
                    playerTurnLabel.text = "\(playerTwoName)´s turn"
                    game.addClickedBoard(board: board)
                    player1Turn = false
                    delayComputerChooseBoard()
                }
            }
        } else {
            if game.checkContainsClickedBoards(clickedBoard: board) == false {
                if player1Turn {
                    label.textColor = UIColor.blue
                    label.text = String(playerOne.symbol)
                    let playerTwoName = playerTwo.name
                    playerTurnLabel.text = "\(playerTwoName)´s turn"
                    game.addClickedBoard(board: board)
                    player1Turn = false
                    
                } else {
                    label.textColor = UIColor.red
                    label.text = String(playerTwo.symbol)
                    let playerOneName = playerOne.name
                    playerTurnLabel.text = "\(playerOneName)´s turn"
                    game.addClickedBoard(board: board)
                    player1Turn = true
                }
            }
        }
    }
    
    func checkIfAllBoardsIsFilled () {
        print(game.checkBoardIsNotEmpty)
        if game.checkIfAllBoardIsNotEmpty() && gameIsOver == false {
            print("inom checkIfAllBoards körs")
            gameIsOver = true
            performSegue(withIdentifier: segueToPopUp, sender: self)
        }
    }
    

    @IBAction func boardTapped(_ sender: UITapGestureRecognizer) {
        if let view = sender.view {
            let tag = view.tag
            
            if gameIsOver == false {
                if let label = self.view.viewWithTag(tag) as? UILabel {
                    addToBoard(label: label, board: Board(rowAndColumn: tag))
                    checkIfPlayerWins()
                    checkIfAllBoardsIsFilled()
                }
            }
        }
    }
}
