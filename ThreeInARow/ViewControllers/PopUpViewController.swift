//
//  PopUpViewController.swift
//  ThreeInARow
//
//  Created by Elin Simonsson on 2022-11-30.
//

import UIKit

protocol CanReceive {
    func passDataBack (gameIsRestarted: Bool)
}

class PopUpViewController: UIViewController {
    
    @IBOutlet weak var resultLabel: UILabel!

    var player : Player?
    var delegate: CanReceive?
    var playAgain: Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let player = (player ?? nil)
        
        if player != nil {
            if let winnerName = player?.name {
                resultLabel.text = "\(winnerName) won!"
            }
        } else {
            resultLabel.text = "It´s a tie!"
        }
                
    }
    
    @IBAction func playAgainBtn(_ sender: UIButton) {
       playAgain = true
        print("playAgain PopUp: \(playAgain)")
        if let sendBackData = playAgain {
            delegate?.passDataBack(gameIsRestarted: sendBackData)
            dismiss(animated: true, completion: nil)
            self.navigationController?.popViewController(animated: true)
        }
    }
}
