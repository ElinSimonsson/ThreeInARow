//
//  PlayerInformationViewController.swift
//  ThreeInARow
//
//  Created by Elin Simonsson on 2022-12-02.
//

import UIKit

class PlayerInformationViewController: UIViewController {

    
    @IBOutlet weak var playerOneNameTextField: UITextField!
    @IBOutlet weak var playerTwoNameTextField: UITextField!
    
    let game = Game()
    var playerOneName = ""
    var playerTwoName = ""
    let playerOneDefaultName = "Player 1"
    let playerTwoDefaultName = "Player 2"
    let segueToGame = "segueToGame"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueToGame {
            
            let destinationVC = segue.destination as? ViewController
            let playerOne = game.player(index: 0)
            let playerTwo = game.player(index: 1)
            destinationVC?.playerOne = playerOne
            destinationVC?.playerTwo = playerTwo
            destinationVC?.playingTowardComputer = false
//            if segue.identifier == segueToPopUp {
//                let destinationVC = segue.destination as? PopUpViewController
//                if playerOneWon {
//                    let playerOne = game.player(index: 0)
//                    destinationVC?.player = playerOne
//                    playerOneWon = false
//                } else if playerTwoWon {
//                    let playerTwo = game.player(index: 1)
//                    destinationVC?.player = playerTwo
//                    playerTwoWon = false
//                }
//            }
        }
    }


    @IBAction func playBtnPressed(_ sender: UIButton) {
        
        if playerOneNameTextField.text == "" && playerTwoNameTextField.text == "" {
            playerOneName = playerOneDefaultName
            playerTwoName = playerTwoDefaultName
        } else if playerOneNameTextField.text != "" && playerTwoNameTextField.text != "" {
            playerOneName = playerOneNameTextField.text ?? playerOneDefaultName
            playerTwoName = playerTwoNameTextField.text ?? playerTwoDefaultName
        } else if playerOneNameTextField.text != "" && playerTwoNameTextField.text == "" {
            playerOneName = playerOneNameTextField.text ?? playerOneDefaultName
            playerTwoName = playerTwoDefaultName
        } else if playerOneNameTextField.text == "" && playerTwoNameTextField.text != "" {
            playerOneName = playerOneDefaultName
            playerTwoName = playerTwoNameTextField.text ?? playerTwoDefaultName
        }
        
        game.addPlayer(name: playerOneName, score: 0)
        game.addPlayer(name: playerTwoName, score: 0)
        
        performSegue(withIdentifier: segueToGame, sender: self)
        
        
        
    }
}
