//
//  PopUpViewController.swift
//  ThreeInARow
//
//  Created by Elin Simonsson on 2022-11-30.
//

import UIKit

class PopUpViewController: UIViewController {
    
    @IBOutlet weak var resultLabel: UILabel!

    var player : Player?
    
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
}
