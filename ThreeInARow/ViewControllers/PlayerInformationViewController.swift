//
//  PlayerInformationViewController.swift
//  ThreeInARow
//
//  Created by Elin Simonsson on 2022-12-02.
//

import UIKit

class PlayerInformationViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
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
        
        self.scrollView.contentSize = CGSize(width: self.view.bounds.width, height: self.view.bounds.height)
//
//        scrollView.alwaysBounceVertical = true
//        scrollView.alwaysBounceHorizontal = false
        
      //  scrollView.contentSize = CGSize(width: view.frame.width, height: view.frame.height)
        
        playerOneNameTextField.delegate = self
        playerTwoNameTextField.delegate = self
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
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
    
    @IBAction func playBtnPressed(_ sender: UIButton) {
        
        if game.countPlayers() > 0 {
            game.deleteAllPlayers()
        }
        
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
        
        game.addPlayer(name: playerOneName, score: 0, symbol: "X")
        game.addPlayer(name: playerTwoName, score: 0, symbol: "O")
        performSegue(withIdentifier: segueToGame, sender: self)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField.tag {
        case 1:
            self.playerTwoNameTextField.becomeFirstResponder()
        case 2:
            self.playerTwoNameTextField.resignFirstResponder()
        default:
            break
        }
       
        return false
    }
    
}

