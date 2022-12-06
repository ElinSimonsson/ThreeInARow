//
//  NumbersOfPlayerViewController.swift
//  ThreeInARow
//
//  Created by Elin Simonsson on 2022-12-05.
//

import UIKit

class ViewController: UIViewController {
    
    let segueToPlayerInfo = "twoPlayerSegueToPlayerInfo"
    let segueToGame = "onePlayerSegueToGame"
    let game = Game()

    override func viewDidLoad() {
        
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueToGame {
            let destinationVC = segue.destination as? GameViewController
            let playerOne = game.player(index: 0)
            let playerTwo = game.player(index: 1)
            destinationVC?.playerOne = playerOne
            destinationVC?.playerTwo = playerTwo
            destinationVC?.playingTowardComputer = true
            
        }
    }
    
    @IBAction func handleTapOnePlayer(_ sender: UITapGestureRecognizer) {
       
        if game.count() > 0 {
                    game.deleteAllPlayers()
                }
                game.addPlayer(name: "Player 1", score: 0)
                game.addPlayer(name: "Computer", score: 0)
                performSegue(withIdentifier: segueToGame, sender: self)
    }
    
    @IBAction func handleTapTwoPlayer(_ sender: UITapGestureRecognizer) {
        
        performSegue(withIdentifier: segueToPlayerInfo, sender: self)
    }
    
    @IBAction func unwindToNumberOfPlayerVC (segue: UIStoryboardSegue) {
        
    }
}
