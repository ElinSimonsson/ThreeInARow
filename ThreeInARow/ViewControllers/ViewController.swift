//
//  ViewController.swift
//  ThreeInARow
//
//  Created by Elin Simonsson on 2022-12-05.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var onePlayerLabel: UILabel!
    
    @IBOutlet weak var twoPlayerLabel: UILabel!
    
    let segueToPlayerInfo = "twoPlayerSegueToPlayerInfo"
    let segueToGame = "onePlayerSegueToGame"
    let game = Game()

    override func viewDidLoad() {
        
        
        super.viewDidLoad()

        onePlayerLabel.layer.cornerRadius = 10
        twoPlayerLabel.layer.cornerRadius = 10
        onePlayerLabel.layer.masksToBounds = true
        twoPlayerLabel.layer.masksToBounds = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueToGame {
            let destinationVC = segue.destination as? GameViewController
            let playerOne = game.player(index: 0)
            let playerTwo = game.player(index: 1)
            destinationVC?.playerOne = playerOne
            destinationVC?.playerTwo = playerTwo
        }
    }
    
    @IBAction func handleTapOnePlayer(_ sender: UITapGestureRecognizer) {
       
        if game.countPlayers() > 0 {
                    game.deleteAllPlayers()
                }
        game.addPlayer(name: "Player 1", score: 0, symbol: "X")
        game.addPlayer(name: "Computer", score: 0, symbol: "O")
        performSegue(withIdentifier: segueToGame, sender: self)
    }
    
    @IBAction func handleTapTwoPlayer(_ sender: UITapGestureRecognizer) {
        performSegue(withIdentifier: segueToPlayerInfo, sender: self)
    }
    
    @IBAction func unwindToNumberOfPlayerVC (segue: UIStoryboardSegue) {
        
    }
}
