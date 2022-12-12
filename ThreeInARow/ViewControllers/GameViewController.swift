import UIKit

class GameViewController: UIViewController, CanReceive {
    func passDataBack(gameIsRestarted: Bool) {
        let _ = gameIsRestarted
        game.restartGame()
        restartLayout()
        if game.playingTowardsComputer {
            if game.firstTurn == Game.Turn.p2 {
                computerAddRandomBoard()
            }
        }
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
    let segueToPopUp = "segueToPopUp"
    let game = Game()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeLayout()
        game.initBoards()
        if let playerTwo = playerTwo {
            game.checkIfPlayingComputer(playerTwo: playerTwo)
        }
    }
    
    func initializeLayout () {
        if let playerOneName = playerOne?.name,
           let playerTwoName = playerTwo?.name {
            if game.firstTurn == Game.Turn.p1 {
                playerTurnLabel.text = "\(playerOneName)´s turn"
            } else if game.firstTurn == Game.Turn.p2 {
                playerTurnLabel.text = "\(playerTwoName)´s turn"
            }
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
    
    func computerAddRandomBoard () {
        guard let playerTwo = playerTwo else {return}
        let playerTwoSymbol = String(playerTwo.symbol)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            let tagRowAndColumn = self.game.randomEmptyBoard()
            
            // every label have a own tag e.g. 11 (row)+(column).
            // the func "randomEmptyBoard" returns int as (row)+(column) and finds a label using tag
            
            if self.game.gameover == false {
                if let view = self.view.viewWithTag(tagRowAndColumn) {
                    if let label = view as? UILabel {
                        label.textColor = UIColor.red
                        label.text = playerTwoSymbol
                    }
                }
                if let playerOneName = self.playerOne?.name {
                    self.playerTurnLabel.text = "\(playerOneName)´s turn"
                }
                self.checkIfPlayerWins()
                self.checkFullBoards()
            }
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
            if game.playerOneWin {
                destinationVC?.player = playerOne
                destinationVC?.delegate = self
            } else if game.playerTwoWin {
                destinationVC?.player = playerTwo
                destinationVC?.delegate = self
            } else {
                destinationVC?.delegate = self
            }
        }
    }
    
    func checkIfPlayerWins () {
        guard let playerOne = playerOne,
              let playerTwo = playerTwo,
              let board1 = boardOneLabel.text,
              let board2 = boardTwoLabel.text,
              let board3 = boardThreeLabel.text,
              let board4 = boardFourLabel.text,
              let board5 = boardFiveLabel.text,
              let board6 = boardSixLabel.text,
              let board7 = boardSevenLabel.text,
              let board8 = boardEightLabel.text,
              let board9 = boardNineLabel.text else {return}
        
        let checkIfPlayerOneWins = game.checkIfThreeRow(playerOne: playerOne, playerTwo: playerTwo, playerSymbol: playerOne.symbol, label1: board1, label2: board2, label3: board3, label4: board4, label5: board5, label6: board6, label7: board7, label8: board8, label9: board9)
        
        let checkIfPlayerTwoWins = game.checkIfThreeRow(playerOne: playerOne, playerTwo: playerTwo, playerSymbol: playerTwo.symbol, label1: board1, label2: board2, label3: board3, label4: board4, label5: board5, label6: board6, label7: board7, label8: board8, label9: board9)
        
        if checkIfPlayerOneWins {
            setGreenBoardThreeInRow(symbol: playerOne.symbol)
            game.increasePlayerScore(player: playerOne)
            playerOneScoreLabel.text = String (playerOne.score)
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.performSegue(withIdentifier: self.segueToPopUp, sender: self)
            }
            
        } else if checkIfPlayerTwoWins {
            setGreenBoardThreeInRow(symbol: playerTwo.symbol)
            game.increasePlayerScore(player: playerTwo)
            playerTwoScoreLabel.text = String (playerTwo.score)
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.performSegue(withIdentifier: self.segueToPopUp, sender: self)
            }
        }
    }
    
    func restartLayout () {
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
    
    func addToBoard (label : UILabel, board: Board ) {
        guard let playerOne = playerOne,
              let playerTwo = playerTwo else {return}
        
        if game.checkContainsClickedBoards(clickedBoard: board) == false {
            if game.playingTowardsComputer {
                if game.currentTurn == Game.Turn.p1 {
                    label.textColor = UIColor.blue
                    label.text = String(playerOne.symbol)
                    let playerTwoName = playerTwo.name
                    playerTurnLabel.text = "\(playerTwoName)´s turn"
                    game.makeTurn(board: board)
                    computerAddRandomBoard()
                }
            } else {
                if game.currentTurn == Game.Turn.p1 {
                    label.textColor = UIColor.blue
                    label.text = String(playerOne.symbol)
                    let playerTwoName = playerTwo.name
                    playerTurnLabel.text = "\(playerTwoName)´s turn"
                    game.makeTurn(board: board)
                } else if game.currentTurn == Game.Turn.p2 {
                    label.textColor = UIColor.red
                    label.text = String(playerTwo.symbol)
                    let playerOneName = playerOne.name
                    playerTurnLabel.text = "\(playerOneName)´s turn"
                    game.makeTurn(board: board)
                }
            }
        }
    }
    
    func checkFullBoards () {
        if game.checkIfAllBoardIsNotEmpty() {
            performSegue(withIdentifier: segueToPopUp, sender: self)
        }
    }
    
    @IBAction func boardTapped(_ sender: UITapGestureRecognizer) {
        if let view = sender.view {
            let tagRowAndColumn = view.tag
            
            // every label have own tag e.g. 11 (row)+(column) and finds a label using tag
            
            if game.gameover == false {
                if let label = self.view.viewWithTag(tagRowAndColumn) as? UILabel {
                    addToBoard(label: label, board: Board(rowAndColumn: tagRowAndColumn))
                    checkIfPlayerWins()
                    checkFullBoards()
                }
            }
        }
    }
}
