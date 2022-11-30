//
//  PopUpViewController.swift
//  ThreeInARow
//
//  Created by Elin Simonsson on 2022-11-30.
//

import UIKit

class PopUpViewController: UIViewController {

    
    
    @IBOutlet weak var resultLabel: UILabel!
    var recevingData: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let result = (recevingData ?? "")
        
        resultLabel.text = result
        
        
    }
}
