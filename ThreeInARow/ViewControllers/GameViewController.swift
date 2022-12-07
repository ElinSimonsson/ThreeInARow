import UIKit

class GameViewController: UIViewController, CanReceive {
    func passDataBack(gameIsRestarted: Bool) {
        let playAgain = gameIsRestarted
        game.clearClickedBoards()
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
        
        initializeLayout()
        
        for number in 1...9{
            game.addBoard(board: Board(numberOfBoard: number))
        }
    }
    
    func initializeLayout () {
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
        switch game.randomEmptyBoard() {
        case 1:
            boardOneLabel.textColor = UIColor.red
            boardOneLabel.text = playerTwo?.symbol
        case 2:
            boardTwoLabel.textColor = UIColor.red
            boardTwoLabel.text = playerTwo?.symbol
        case 3:
            boardThreeLabel.textColor = UIColor.red
            boardThreeLabel.text = playerTwo?.symbol
        case 4:
            boardFourLabel.textColor = UIColor.red
            boardFourLabel.text = playerTwo?.symbol
        case 5:
            boardFiveLabel.textColor = UIColor.red
            boardFiveLabel.text = playerTwo?.symbol
        case 6:
            boardSixLabel.textColor = UIColor.red
            boardSixLabel.text = playerTwo?.symbol
        case 7:
            boardSevenLabel.textColor = UIColor.red
            boardSevenLabel.text = playerTwo?.symbol
        case 8:
            boardEightLabel.textColor = UIColor.red
            boardEightLabel.text = playerTwo?.symbol
        case 9:
            boardNineLabel.textColor = UIColor.red
            boardNineLabel.text = playerTwo?.symbol
        default: break
        }
    }
    
    func checkWhichThreeBoardsIsInRow (symbol: String) -> Int {
        if boardOneLabel.text == symbol && boardTwoLabel.text == symbol && boardThreeLabel.text == symbol {
            return 123
        } else if boardOneLabel.text == symbol && boardFourLabel.text == symbol && boardSevenLabel.text == symbol {
            return 147
        } else if boardOneLabel.text == symbol && boardFiveLabel.text == symbol && boardNineLabel.text == symbol {
            return 159
        } else if boardFourLabel.text == symbol && boardFiveLabel.text == symbol && boardSixLabel.text == symbol {
            return 456
        } else if boardSevenLabel.text == symbol && boardEightLabel.text == symbol && boardNineLabel.text == symbol {
            return 789
        } else if boardTwoLabel.text == symbol && boardFiveLabel.text == symbol && boardEightLabel.text == symbol {
            return 258
        } else if boardThreeLabel.text == symbol && boardSixLabel.text == symbol && boardNineLabel.text == symbol {
            return 369
        } else if boardThreeLabel.text == symbol && boardFiveLabel.text == symbol && boardSevenLabel.text == symbol {
            return 357
        }
        return 0
    }
    
    func setLayoutWinning (playerSymbol: String) {
        let numbersOfBoardsIsInRow = checkWhichThreeBoardsIsInRow(symbol: playerSymbol)
        
        switch numbersOfBoardsIsInRow {
        case 123:
            boardOneLabel.backgroundColor = UIColor.green
            boardTwoLabel.backgroundColor = UIColor.green
            boardThreeLabel.backgroundColor = UIColor.green
        case 147:
            boardOneLabel.backgroundColor = UIColor.green
            boardFourLabel.backgroundColor = UIColor.green
            boardSevenLabel.backgroundColor = UIColor.green
        case 159:
            boardOneLabel.backgroundColor = UIColor.green
            boardFiveLabel.backgroundColor = UIColor.green
            boardNineLabel.backgroundColor = UIColor.green
        case 456:
            boardFourLabel.backgroundColor = UIColor.green
            boardFiveLabel.backgroundColor = UIColor.green
            boardSixLabel.backgroundColor = UIColor.green
        case 789:
            boardSevenLabel.backgroundColor = UIColor.green
            boardEightLabel.backgroundColor = UIColor.green
            boardNineLabel.backgroundColor = UIColor.green
        case 258:
            boardTwoLabel.backgroundColor = UIColor.green
            boardFiveLabel.backgroundColor = UIColor.green
            boardEightLabel.backgroundColor = UIColor.green
        case 369:
            boardThreeLabel.backgroundColor = UIColor.green
            boardSixLabel.backgroundColor = UIColor.green
            boardNineLabel.backgroundColor = UIColor.green
        case 357:
            boardThreeLabel.backgroundColor = UIColor.green
            boardFiveLabel.backgroundColor = UIColor.green
            boardSevenLabel.backgroundColor = UIColor.green
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
            } else {
                destinationVC?.delegate = self
            }
        }
    }
    
    func checkIfPlayerWins () {
        if let playerOneSymbol = playerOne?.symbol, let playerTwoSymbol = playerTwo?.symbol {
            let checkIfPlayerOneWins = game.checkIfThreeRow(playerSymbol: playerOneSymbol, label1: boardOneLabel, label2: boardTwoLabel, label3: boardThreeLabel, label4: boardFourLabel, label5: boardFiveLabel, label6: boardSixLabel, label7: boardSevenLabel, label8: boardEightLabel, label9: boardNineLabel)
            
            let checkIfPlayerTwoWins = game.checkIfThreeRow(playerSymbol: playerTwoSymbol, label1: boardOneLabel, label2: boardTwoLabel, label3: boardThreeLabel, label4: boardFourLabel, label5: boardFiveLabel, label6: boardSixLabel, label7: boardSevenLabel, label8: boardEightLabel, label9: boardNineLabel)
            
            if checkIfPlayerOneWins {
                playerOneWon = true
                gameIsOver = true
                setLayoutWinning(playerSymbol: playerOneSymbol)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self.performSegue(withIdentifier: self.segueToPopUp, sender: self)
                }
                
                if let player1 = playerOne {
                    game.increasePlayerScore(player: player1)
                    if let player1Score = playerOne?.score {
                        playerOneScoreLabel.text = String (player1Score)
                    }
                }
            } else if checkIfPlayerTwoWins {
                playerTwoWon = true
                gameIsOver = true
                setLayoutWinning(playerSymbol: playerTwoSymbol)
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self.performSegue(withIdentifier: self.segueToPopUp, sender: self)
                }
                
                if let player2 = playerTwo {
                    game.increasePlayerScore(player: player2)
                    if let player2Score = playerTwo?.score {
                        playerTwoScoreLabel.text = String (player2Score)
                    }
                }
            }
        }
    }
    
    func restartGameLayout () {
        initializeLayout()
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
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
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
    
    func boxClicked (label : UILabel, board: Board ) {
        if playingTowardComputer {
            if player1Turn {
                if game.checkContainsClickedBoards(clickedBoard: board) == false {
                    label.textColor = UIColor.blue
                    label.text = playerOne?.symbol
                    if let playerTwoName = playerTwo?.name {
                        playerTurnLabel.text = "\(playerTwoName)´s turn"
                    }
                    game.addClickedBoard(board: board)
                    player1Turn = false
                    delayComputerChooseBoard()
                }
            }
        } else {
            if game.checkContainsClickedBoards(clickedBoard: board) == false {
                if player1Turn {
                    label.textColor = UIColor.blue
                    label.text = playerOne?.symbol
                    if let playerTwoName = playerTwo?.name {
                        playerTurnLabel.text = "\(playerTwoName)´s turn"
                    }
                    game.addClickedBoard(board: board)
                    player1Turn = false
                    
                } else {
                    label.textColor = UIColor.red
                    label.text = playerTwo?.symbol
                    if let playerOneName = playerOne?.name {
                        playerTurnLabel.text = "\(playerOneName)´s turn"
                    }
                    game.addClickedBoard(board: board)
                    player1Turn = true
                }
            }
        }
    }
    
    func checkIfAllBoardsIsFilled () {
        if game.checkIfAllBoardIsNotEmpty() && gameIsOver == false {
            gameIsOver = true
            performSegue(withIdentifier: segueToPopUp, sender: self)
        }
    }
    
    @IBAction func boardOneTapped(_ sender: UITapGestureRecognizer) {
        if gameIsOver == false {
            let board1 = Board(numberOfBoard: 1)
            boxClicked(label: boardOneLabel, board: board1)
            checkIfPlayerWins()
            checkIfAllBoardsIsFilled()
        }
    }
    
    @IBAction func boardTwoTapped(_ sender: UITapGestureRecognizer) {
        if gameIsOver == false {
            let board2 = Board(numberOfBoard: 2)
            boxClicked(label: boardTwoLabel, board: board2)
            checkIfPlayerWins()
            checkIfAllBoardsIsFilled()
        }
    }
    
    @IBAction func boardThreeTapped(_ sender: UITapGestureRecognizer) {
        if gameIsOver == false {
            let board3 = Board(numberOfBoard: 3)
            boxClicked(label: boardThreeLabel, board: board3)
            checkIfPlayerWins()
            checkIfAllBoardsIsFilled()
        }
    }
    
    @IBAction func boardFourTapped(_ sender: UITapGestureRecognizer) {
        if gameIsOver == false {
            let board4 = Board(numberOfBoard: 4)
            boxClicked(label: boardFourLabel, board: board4)
            checkIfPlayerWins()
            checkIfAllBoardsIsFilled()
        }
    }
    
    @IBAction func boardFiveTapped(_ sender: UITapGestureRecognizer) {
        if gameIsOver == false {
            let board5 = Board(numberOfBoard: 5)
            boxClicked(label: boardFiveLabel, board: board5)
            checkIfPlayerWins()
            checkIfAllBoardsIsFilled()
        }
    }
    
    @IBAction func boardSixTapped(_ sender: UITapGestureRecognizer) {
        if gameIsOver == false {
            let board6 = Board(numberOfBoard: 6)
            boxClicked(label: boardSixLabel, board: board6)
            checkIfPlayerWins()
            checkIfAllBoardsIsFilled()
        }
    }
    
    @IBAction func boardSevenTapped(_ sender: UITapGestureRecognizer) {
        if gameIsOver == false {
            let board7 = Board(numberOfBoard: 7)
            boxClicked(label: boardSevenLabel, board: board7)
            checkIfPlayerWins()
            checkIfAllBoardsIsFilled()
        }
    }
    
    @IBAction func boardEightTapped(_ sender: UITapGestureRecognizer) {
        if gameIsOver == false {
            let board8 = Board(numberOfBoard: 8)
            boxClicked(label: boardEightLabel, board: board8)
            checkIfPlayerWins()
            checkIfAllBoardsIsFilled()
        }
    }
    
    @IBAction func boardNineTapped(_ sender: UITapGestureRecognizer) {
        if gameIsOver == false {
            let board9 = Board(numberOfBoard: 9)
            boxClicked(label: boardNineLabel, board: board9)
            checkIfPlayerWins()
            checkIfAllBoardsIsFilled()
        }
    }
}
