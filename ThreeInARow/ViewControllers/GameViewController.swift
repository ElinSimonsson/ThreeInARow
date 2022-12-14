import UIKit

class GameViewController: UIViewController, CallBack {
    
    
    @IBOutlet weak var playerOneScoreLabel: UILabel!
    @IBOutlet weak var playerTwoScoreLabel: UILabel!
    @IBOutlet weak var row1Label1: UILabel!
    @IBOutlet weak var row1Label2: UILabel!
    @IBOutlet weak var row1Label3: UILabel!
    @IBOutlet weak var row2Label1: UILabel!
    @IBOutlet weak var row2Label2: UILabel!
    @IBOutlet weak var row2Label3: UILabel!
    @IBOutlet weak var row3Label1: UILabel!
    @IBOutlet weak var row3Label2: UILabel!
    @IBOutlet weak var row3Label3: UILabel!
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
        game.initCells()
        if let playerTwo = playerTwo {
            game.checkIfPlayingComputer(playerTwo: playerTwo)
        }
    }
    
    func passDataBack(gameIsRestarted: Bool) {
        let _ = gameIsRestarted
        game.restartGame()
        restartLayout()
        if game.playingTowardsComputer {
            if game.firstTurn == Game.Turn.p2 {
                computerAddRandomCell()
            }
        }
    }
    
    func initializeLayout () {
        if let playerOneName = playerOne?.name,
           let playerTwoName = playerTwo?.name {
            if game.firstTurn == Game.Turn.p1 {
                playerTurnLabel.text =  playerOneName
            } else if game.firstTurn == Game.Turn.p2 {
                playerTurnLabel.text = playerTwoName
            }
            playerOneNameLabel.text = playerOneName
            playerTwoNameLabel.text = playerTwoName
        }
        
        row1Label1.layer.borderWidth = 1.5
        row1Label2.layer.borderWidth = 1.5
        row1Label3.layer.borderWidth = 1.5
        row2Label1.layer.borderWidth = 1.5
        row2Label2.layer.borderWidth = 1.5
        row2Label3.layer.borderWidth = 1.5
        row3Label1.layer.borderWidth = 1.5
        row3Label2.layer.borderWidth = 1.5
        row3Label3.layer.borderWidth = 1.5
        
        if let uiImage = UIImage(named: "light_wood_background") {
            row1Label1.backgroundColor = UIColor(patternImage: uiImage)
            row1Label2.backgroundColor = UIColor(patternImage: uiImage)
            row1Label3.backgroundColor = UIColor(patternImage: uiImage)
            row2Label1.backgroundColor = UIColor(patternImage: uiImage)
            row2Label2.backgroundColor = UIColor(patternImage: uiImage)
            row2Label3.backgroundColor = UIColor(patternImage: uiImage)
            row3Label1.backgroundColor = UIColor(patternImage: uiImage)
            row3Label2.backgroundColor = UIColor(patternImage: uiImage)
            row3Label3.backgroundColor = UIColor(patternImage: uiImage)
        }
    }
    
    func computerAddRandomCell () {
        guard let playerTwo = playerTwo else {return}
        let playerTwoSymbol = String(playerTwo.symbol)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            let tagRowAndColumn = self.game.randomEmptyCell()
            
            // every label have a own tag e.g. 11 (row)+(column).
            // the func "randomEmptyCell" returns int as (row)+(column) and finds a label using tag
            
            if self.game.gameover == false {
                if let view = self.view.viewWithTag(tagRowAndColumn) {
                    if let label = view as? UILabel {
                        label.textColor = UIColor.red
                        label.text = playerTwoSymbol
                    }
                }
                if let playerOneName = self.playerOne?.name {
                    self.playerTurnLabel.text = playerOneName
                }
                self.checkIfPlayerWins()
                self.checkFullBoard()
            }
        }
    }
    
    func findThreeInRowSetGreenBackground(symbol: Character) {
        let symbolStr = String(symbol)
        if row1Label1.text == symbolStr && row1Label2.text == symbolStr && row1Label3.text == symbolStr {
            row1Label1.backgroundColor = UIColor.green
            row1Label2.backgroundColor = UIColor.green
            row1Label3.backgroundColor = UIColor.green
        } else if row1Label1.text == symbolStr && row2Label1.text == symbolStr && row3Label1.text == symbolStr {
            row1Label1.backgroundColor = UIColor.green
            row2Label1.backgroundColor = UIColor.green
            row3Label1.backgroundColor = UIColor.green
        } else if row1Label1.text == symbolStr && row2Label2.text == symbolStr && row3Label3.text == symbolStr {
            row1Label1.backgroundColor = UIColor.green
            row2Label2.backgroundColor = UIColor.green
            row3Label3.backgroundColor = UIColor.green
        } else if row2Label1.text == symbolStr && row2Label2.text == symbolStr && row2Label3.text == symbolStr {
            row2Label1.backgroundColor = UIColor.green
            row2Label2.backgroundColor = UIColor.green
            row2Label3.backgroundColor = UIColor.green
        } else if row3Label1.text == symbolStr && row3Label2.text == symbolStr && row3Label3.text == symbolStr {
            row3Label1.backgroundColor = UIColor.green
            row3Label2.backgroundColor = UIColor.green
            row3Label3.backgroundColor = UIColor.green
        } else if row1Label2.text == symbolStr && row2Label2.text == symbolStr && row3Label2.text == symbolStr {
            row1Label2.backgroundColor = UIColor.green
            row2Label2.backgroundColor = UIColor.green
            row3Label2.backgroundColor = UIColor.green
        } else if row1Label3.text == symbolStr && row2Label3.text == symbolStr && row3Label3.text == symbolStr {
            row1Label3.backgroundColor = UIColor.green
            row2Label3.backgroundColor = UIColor.green
            row3Label3.backgroundColor = UIColor.green
        } else if row1Label3.text == symbolStr && row2Label2.text == symbolStr && row3Label1.text == symbolStr {
            row1Label3.backgroundColor = UIColor.green
            row2Label2.backgroundColor = UIColor.green
            row3Label1.backgroundColor = UIColor.green
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
              let row1Lab1 = row1Label1.text,
              let row1Lab2 = row1Label2.text,
              let row1Lab3 = row1Label3.text,
              let row2Lab1 = row2Label1.text,
              let row2Lab2 = row2Label2.text,
              let row2Lab3 = row2Label3.text,
              let row3Lab1 = row3Label1.text,
              let row3Lab2 = row3Label2.text,
              let row3Lab3 = row3Label3.text else {return}
        
        let checkIfPlayerOneWins = game.checkForWin(playerOne: playerOne, playerTwo: playerTwo, playerSymbol: playerOne.symbol, row1Lab1: row1Lab1, row1Lab2: row1Lab2, row1Lab3: row1Lab3, row2Lab1: row2Lab1, row2Lab2: row2Lab2, row2Lab3: row2Lab3, row3Lab1: row3Lab1, row3Lab2: row3Lab2, row3Lab3: row3Lab3)
        
        let checkIfPlayerTwoWins = game.checkForWin(playerOne: playerOne, playerTwo: playerTwo, playerSymbol: playerTwo.symbol, row1Lab1: row1Lab1, row1Lab2: row1Lab2, row1Lab3: row1Lab3, row2Lab1: row2Lab1, row2Lab2: row2Lab2, row2Lab3: row2Lab3, row3Lab1: row3Lab1, row3Lab2: row3Lab2, row3Lab3: row3Lab3)
        
        if checkIfPlayerOneWins {
            findThreeInRowSetGreenBackground(symbol: playerOne.symbol)
            game.increasePlayerScore(player: playerOne)
            playerTurnLabel.text = playerOne.name // explain why
            playerOneScoreLabel.text = String (playerOne.score)
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.performSegue(withIdentifier: self.segueToPopUp, sender: self)
            }
            
        } else if checkIfPlayerTwoWins {
            findThreeInRowSetGreenBackground(symbol: playerTwo.symbol)
            game.increasePlayerScore(player: playerTwo)
            playerTurnLabel.text = playerTwo.name // explain why
            playerTwoScoreLabel.text = String (playerTwo.score)
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.performSegue(withIdentifier: self.segueToPopUp, sender: self)
            }
        }
    }
    
    func restartLayout () {
        initializeLayout()
        row1Label1.text = ""
        row1Label2.text = ""
        row1Label3.text = ""
        row2Label1.text = ""
        row2Label2.text = ""
        row2Label3.text = ""
        row3Label1.text = ""
        row3Label2.text = ""
        row3Label3.text = ""
    }
    
    func addToBoard (label : UILabel, cell: Cell ) {
        guard let playerOne = playerOne,
              let playerTwo = playerTwo else {return}
        
        if game.checkContainsUsedCells(usedCell: cell) == false {
            if game.playingTowardsComputer {
                if game.currentTurn == Game.Turn.p1 {
                    label.textColor = UIColor.blue
                    label.text = String(playerOne.symbol)
                    let playerTwoName = playerTwo.name
                    playerTurnLabel.text = playerTwoName
                    game.makeTurn(cell: cell)
                    computerAddRandomCell()
                }
            } else {
                if game.currentTurn == Game.Turn.p1 {
                    label.textColor = UIColor.blue
                    label.text = String(playerOne.symbol)
                    let playerTwoName = playerTwo.name
                    playerTurnLabel.text = playerTwoName
                    game.makeTurn(cell: cell)
                } else if game.currentTurn == Game.Turn.p2 {
                    label.textColor = UIColor.red
                    label.text = String(playerTwo.symbol)
                    let playerOneName = playerOne.name
                    playerTurnLabel.text = playerOneName
                    game.makeTurn(cell: cell)
                }
            }
        }
    }
    
    func checkFullBoard () {
        if game.checkIfBoardIsNotEmpty() {
            performSegue(withIdentifier: segueToPopUp, sender: self)
        }
    }
    
    @IBAction func cellTapped(_ sender: UITapGestureRecognizer) {
        if let view = sender.view {
            let tagRowAndColumn = view.tag
            
            // every label have own tag e.g. 11 (row)+(column) and finds a label using tag
            
            if game.gameover == false {
                if let label = self.view.viewWithTag(tagRowAndColumn) as? UILabel {
                    addToBoard(label: label, cell: Cell(rowAndColumn: tagRowAndColumn))
                    checkIfPlayerWins()
                    checkFullBoard()
                }
            }
        }
    }
}
