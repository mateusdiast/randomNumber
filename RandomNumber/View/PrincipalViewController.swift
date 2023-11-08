//
//  ViewController.swift
//  RandomNumber
//
//  Created by mateusdias on 06/11/23.
//

import UIKit

class PrincipalViewController: UIViewController {

    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var numberTextField: UITextField!
    
    var numberOfTaps: Int = 0
    
    let principalViewModel = PrincipalViewModel()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func toTryBtnPressed(_ sender: UIButton) {
        principalViewModel.delegate = self
        numberOfTaps += 1
        principalViewModel.onLoadResult(numberValue: numberTextField.text ?? "0")
        if numberOfTaps == 3 {
            principalViewModel.onLoadAttempLimited(limitedNumberOfTapped: numberOfTaps)
        } 
        
        print(numberOfTaps)
    }
    
}

extension PrincipalViewController: PrincipalViewModelDelegate{
   
    func resultIsTrue(messenger: String) {
        resultLabel.text = messenger
        resultLabel.textColor = .green
    }
    
    func resultIsHigher(messenger: String) {
        resultLabel.text = messenger
        resultLabel.textColor = .red
        
    }
    
    func resultIsLower(messenger: String) {
        resultLabel.text = messenger
        resultLabel.textColor = .red

    }
    
    func attemptLimit(messenger: String) {
        let alertAttemptLimit = UIAlertController(title: "Attempt Limit", message: "Your limite is Over!", preferredStyle: UIAlertController.Style.alert)
        alertAttemptLimit.addAction(UIAlertAction(title: "Try again!", style: UIAlertAction.Style.default, handler: nil))
        self.present(alertAttemptLimit, animated: true, completion: nil)
        resultLabel.text = messenger
        resultLabel.textColor = .black

    }
    
    func typeAgain(messenger: String) {
        numberTextField.text = ""
        numberTextField.placeholder = messenger
    }
    
    func playAgain() {
        numberOfTaps = 0
        principalViewModel.randomNumber = Int.random(in: 0...10)
    }
    
}


